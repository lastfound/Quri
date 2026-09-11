import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/core/services/energy_service.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/unit_theme.dart';
import 'package:frontend/features/exercise/data/unit_1_curriculum.dart';
import 'package:frontend/features/exercise/presentation/exercise_question_screen.dart';
import 'package:frontend/features/shop/presentation/shop_screen.dart';
import 'package:frontend/features/shop/presentation/out_of_energy_sheet.dart';
import 'widgets/gamification_header.dart';
import 'widgets/learning_node.dart';

class HomeScreen extends StatefulWidget {
  final int startingUnit;
  final String? startingUnitTitle;
  final String? startingUnitSubtitle;

  const HomeScreen({
    super.key,
    this.startingUnit = 1,
    this.startingUnitTitle,
    this.startingUnitSubtitle,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  /// Track level terakhir yang sudah di-unlock untuk Unit 1 (0-indexed).
  int _unlockedUpTo = 0;

  /// Energi pengguna — dikelola oleh [EnergyService].
  final EnergyService _energyService = EnergyService();
  int _energy = 20;
  static const int _maxEnergy = 20;
  String _energyTimerText = '';
  Timer? _energyTickTimer;
  bool _energyServiceReady = false;

  /// Track stars per level untuk Unit 1 (0 = belum selesai, 1-3 = sesuai performa).
  late List<int> _starsByLevel;

  String _getUnitTitle(int unit) {
    switch (unit) {
      case 2:
        return 'Unit 2: Harakat Dasar & Sambung Huruf';
      case 3:
        return 'Unit 3: Tanwin & Sukun (Mati)';
      case 4:
        return 'Unit 4: Tasydid & Mad (Bacaan Panjang)';
      case 5:
        return 'Unit 5: Hukum Tajwid Dasar (Nun/Mim Mati & Ghunnah)';
      case 6:
        return 'Unit 6: Tajwid Lanjutan & Kelancaran Mushaf';
      default:
        return 'Unit 1: Huruf Hijaiyah Tunggal';
    }
  }

  String _getUnitSubtitle(int unit) {
    switch (unit) {
      case 2:
        return 'Fathah, kasrah, dhammah & bentuk sambung';
      case 3:
        return 'Tanda baca tanwin & huruf mati (sukun)';
      case 4:
        return 'Huruf bertasydid & ketukan mad dasar';
      case 5:
        return 'Hukum nun/mim sukun, ghunnah & ikhfa/idgham';
      case 6:
        return 'Waqaf, makhraj fasih & tilawah mushaf';
      default:
        return 'Mengenal & melafalkan 29 huruf hijaiyah';
    }
  }

  @override
  void initState() {
    super.initState();
    _starsByLevel = List<int>.filled(Unit1Curriculum.levels.length, 0);
    _initEnergyService();
  }

  @override
  void dispose() {
    _energyTickTimer?.cancel();
    super.dispose();
  }

  Future<void> _initEnergyService() async {
    await _energyService.init();
    _energyServiceReady = true;
    _refreshEnergy();
    // Tick setiap detik agar countdown terlihat hidup
    _energyTickTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) _refreshEnergy();
    });
  }

  void _refreshEnergy() {
    if (!_energyServiceReady) return;
    final current = _energyService.getCurrentEnergy();
    final remaining = _energyService.getTimeToNextRegen();

    String timerText = '';
    if (current < _maxEnergy && remaining != null) {
      final totalSec = remaining.inSeconds;
      final m = (totalSec ~/ 60).toString().padLeft(2, '0');
      final s = (totalSec % 60).toString().padLeft(2, '0');
      timerText = '$m:$s';
    }

    if (_energy != current || _energyTimerText != timerText) {
      setState(() {
        _energy = current;
        _energyTimerText = timerText;
      });
    }
  }

  /// Membangun data lessons dari kurikulum Unit 1 + status unlock.
  List<Map<String, dynamic>> _buildLessons() {
    final levels = Unit1Curriculum.levels;
    final List<Map<String, dynamic>> lessons = [];

    // Pola zigzag offset untuk variasi visual
    final offsets = [0.0, -100.0, 0.0, 100.0, 0.0, -100.0, 0.0, 100.0, 0.0, -100.0, 0.0, 100.0, 0.0];

    for (int i = 0; i < levels.length; i++) {
      final level = levels[i];
      NodeStatus status;
      if (i < _unlockedUpTo) {
        status = NodeStatus.completed;
      } else if (i == _unlockedUpTo) {
        status = NodeStatus.active;
      } else {
        status = NodeStatus.locked;
      }

      // Tentukan variant berdasarkan badge
      NodeVariant variant = NodeVariant.normal;
      if (level.badgeLabel != null) {
        if (level.badgeLabel == 'BOSS LEVEL') {
          variant = NodeVariant.treasure;
        } else {
          variant = NodeVariant.premium;
        }
      }

      lessons.add({
        'levelIndex': i,
        'title': level.title,
        'arabic': level.arabicSubtitle,
        'status': status,
        'variant': variant,
        'offset': offsets[i % offsets.length],
        'description': level.description,
        'xp': level.xpReward,
        'stars': _starsByLevel[i],
        'badgeLabel': level.badgeLabel,
        if (level.badgeLabel != null) ...{
          'sideNoteText': level.title,
          'sideNoteAlign':
              i.isEven ? SideNoteAlign.left : SideNoteAlign.right,
        },
      });
    }

    return lessons;
  }

  void _showLessonDialog(
      BuildContext context, Map<String, dynamic> lesson, UnitTheme unitTheme) {
    final isLocked = lesson['status'] == NodeStatus.locked;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(28)),
            border: const Border(
              top: BorderSide(color: AppColors.outlineDark, width: 2),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                lesson['arabic'],
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: isLocked
                      ? AppColors.lockedGrayBorder
                      : unitTheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                lesson['title'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                lesson['description'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.stars_rounded,
                      color: AppColors.starGold, size: 22),
                  const SizedBox(width: 6),
                  Text(
                    '+${lesson['xp']} XP Hadiah',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              if (isLocked) ...[
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.lockedGray,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.lock_rounded,
                          size: 16, color: AppColors.lockedGrayBorder),
                      SizedBox(width: 6),
                      Text(
                        'Selesaikan level sebelumnya untuk membuka',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lockedGrayBorder,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isLocked
                      ? null
                      : () {
                          Navigator.pop(ctx);
                          _navigateToExercise(lesson);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: unitTheme.primary,
                    disabledBackgroundColor: AppColors.lockedGray,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: isLocked
                            ? AppColors.lockedGrayBorder
                            : AppColors.outlineDark,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    isLocked ? '🔒 TERKUNCI' : 'MULAI BELAJAR',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: isLocked ? AppColors.lockedGrayBorder : Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  /// Navigasi ke ExerciseQuestionScreen dengan data soal dari kurikulum Unit 1.
  void _navigateToExercise(Map<String, dynamic> lesson) {
    if (_energy <= 0) {
      OutOfEnergySheet.show(
        context,
        countdownText: _energyTimerText,
      );
      return;
    }

    final int levelIndex = lesson['levelIndex'];
    final level = Unit1Curriculum.levels[levelIndex];

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ExerciseQuestionScreen(
          questions: level.questions,
          levelTitle: level.title,
          unitNumber: 1,
          xpReward: level.xpReward,
          streak: 0,
          gems: 50,
          energy: _energy,
          energyMax: _maxEnergy,
          onEnergyChanged: (newEnergy) {
            _energyService.setEnergy(newEnergy);
            _refreshEnergy();
          },
          onCompleted: (correctCount, totalCount) {
            // Hitung bintang berdasarkan persentase benar
            final percent = correctCount / totalCount * 100;
            int stars = 1;
            if (percent >= 90) {
              stars = 3;
            } else if (percent >= 80) {
              stars = 2;
            }

            setState(() {
              _starsByLevel[levelIndex] = stars;
              // Unlock level berikutnya jika belum
              if (levelIndex >= _unlockedUpTo &&
                  levelIndex + 1 < Unit1Curriculum.levels.length) {
                _unlockedUpTo = levelIndex + 1;
              }
            });

            // Tampilkan snackbar selamat
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '🎉 ${level.title} selesai! +${level.xpReward} XP ($stars⭐)',
                  ),
                  backgroundColor:
                      UnitTheme.getTheme(1).primary,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  /// Menampilkan modal daftar unit pembelajaran.
  void _showUnitSelectorModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            border: Border(
              top: BorderSide(color: AppColors.outlineDark, width: 2.5),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Daftar Unit',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Saat ini materi dan level yang siap baru Unit 1',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: 6,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, idx) {
                    final unitNum = idx + 1;
                    final theme = UnitTheme.getTheme(unitNum);
                    final isUnit1 = unitNum == 1;

                    return InkWell(
                      onTap: () {
                        Navigator.pop(ctx);
                        if (!isUnit1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Unit $unitNum belum ada materi. Saat ini materi yang sudah ada hanya Unit 1.',
                              ),
                              backgroundColor: AppColors.textPrimary,
                            ),
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isUnit1
                              ? theme.lightSurface
                              : const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isUnit1
                                ? theme.primary
                                : AppColors.border,
                            width: isUnit1 ? 2.5 : 1.5,
                          ),
                          boxShadow: isUnit1
                              ? AppColors.solidShadow(
                                  offset: 3,
                                  color: theme.dark.withValues(alpha: 0.3),
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: isUnit1
                                    ? theme.primary
                                    : AppColors.lockedGray,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isUnit1
                                      ? AppColors.outlineDark
                                      : AppColors.lockedGrayBorder,
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '$unitNum',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: isUnit1
                                        ? Colors.white
                                        : AppColors.lockedGrayBorder,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _getUnitTitle(unitNum),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: isUnit1
                                          ? theme.dark
                                          : AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _getUnitSubtitle(unitNum),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isUnit1
                                          ? AppColors.textSecondary
                                          : AppColors.grayMedium,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isUnit1
                                          ? const Color(0xFFE8F5E9)
                                          : const Color(0xFFF3F4F6),
                                      borderRadius:
                                          BorderRadius.circular(6),
                                      border: Border.all(
                                        color: isUnit1
                                            ? const Color(0xFF4CAF50)
                                            : AppColors.border,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      isUnit1
                                          ? '✓ 13 LEVEL TERSEDIA (AKTIF)'
                                          : 'BELUM ADA MATERI',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        color: isUnit1
                                            ? const Color(0xFF2E7D32)
                                            : AppColors.grayMedium,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isUnit1)
                              Icon(Icons.check_circle_rounded,
                                  color: theme.primary, size: 24)
                            else
                              const Icon(Icons.lock_rounded,
                                  color: AppColors.grayMedium, size: 20),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Kurikulum dan materi saat ini HANYA ada di Unit 1
    final unitTheme = UnitTheme.getTheme(1);
    final lessons = _buildLessons();

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: GamificationHeader(
        streak: 0,
        gems: 50,
        energy: _energy,
        energyMax: _maxEnergy,
        energyTimerText: _energyTimerText,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          // Banner Modul Unit 1
          InkWell(
            onTap: () => _showUnitSelectorModal(context),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: unitTheme.primary,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.outlineDark, width: 2),
                boxShadow: AppColors.solidShadow(),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getUnitTitle(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getUnitSubtitle(1),
                          style: TextStyle(
                            color: unitTheme.accent,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: AppColors.outlineDark, width: 2),
                      boxShadow: AppColors.solidShadow(offset: 2),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.list_rounded,
                            color: unitTheme.primary, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          'Daftar Unit',
                          style: TextStyle(
                            color: unitTheme.primary,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Peta Belajar Unit 1 (13 Level Kurikulum Lengkap Huruf Hijaiyah Tunggal)
          ...lessons.map((lesson) {
            return LearningNode(
              title: lesson['title'],
              arabicSubtitle: lesson['arabic'],
              status: lesson['status'],
              variant: lesson['variant'] ?? NodeVariant.normal,
              horizontalOffset: lesson['offset'],
              stars: lesson['stars'] ?? 0,
              badgeLabel: lesson['badgeLabel'],
              sideNoteText: lesson['sideNoteText'],
              sideNoteAlign: lesson['sideNoteAlign'] ?? SideNoteAlign.left,
              activeColor: unitTheme.primary,
              accentColor: unitTheme.accent,
              onTap: () => _showLessonDialog(context, lesson, unitTheme),
            );
          }),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: AppColors.outlineDark, width: 2),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _currentNavIndex,
          onDestinationSelected: (index) {
            if (index == 3) {
              // Shop → buka ShopScreen
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ShopScreen()),
              );
              return;
            }
            setState(() {
              _currentNavIndex = index;
            });
          },
          backgroundColor: Colors.white,
          indicatorColor: unitTheme.primary.withValues(alpha: 0.18),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.auto_stories_outlined,
                  color: AppColors.grayMedium),
              selectedIcon:
                  Icon(Icons.auto_stories, color: unitTheme.primary),
              label: 'Belajar',
            ),
            NavigationDestination(
              icon: const Icon(Icons.flag_outlined,
                  color: AppColors.grayMedium),
              selectedIcon: Icon(Icons.flag, color: unitTheme.primary),
              label: 'Quests',
            ),
            NavigationDestination(
              icon: const Icon(Icons.bar_chart_outlined,
                  color: AppColors.grayMedium),
              selectedIcon:
                  Icon(Icons.bar_chart, color: unitTheme.primary),
              label: 'Ranks',
            ),
            NavigationDestination(
              icon: const Icon(Icons.storefront_outlined,
                  color: AppColors.grayMedium),
              selectedIcon:
                  Icon(Icons.storefront, color: unitTheme.primary),
              label: 'Shop',
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline,
                  color: AppColors.grayMedium),
              selectedIcon: Icon(Icons.person, color: unitTheme.primary),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
