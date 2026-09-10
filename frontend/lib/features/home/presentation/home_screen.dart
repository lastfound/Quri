import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/unit_theme.dart';
import 'package:frontend/features/exercise/data/unit_1_curriculum.dart';
import 'package:frontend/features/exercise/presentation/exercise_question_screen.dart';
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

  /// Track level terakhir yang sudah di-unlock (0-indexed).
  int _unlockedUpTo = 0;

  /// Track stars per level (0 = belum selesai, 1-3 = sesuai performa).
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
  }

  /// Membangun data lessons dari kurikulum + status unlock.
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

  /// Navigasi ke ExerciseQuestionScreen dengan data soal dari kurikulum.
  void _navigateToExercise(Map<String, dynamic> lesson) {
    final int levelIndex = lesson['levelIndex'];
    final level = Unit1Curriculum.levels[levelIndex];

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ExerciseQuestionScreen(
          questions: level.questions,
          levelTitle: level.title,
          unitNumber: widget.startingUnit,
          xpReward: level.xpReward,
          streak: widget.startingUnit > 1 ? 3 : 0,
          gems: widget.startingUnit > 1 ? 150 : 50,
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
                      UnitTheme.getTheme(widget.startingUnit).primary,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unitTheme = UnitTheme.getTheme(widget.startingUnit);
    final lessons = _buildLessons();

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: GamificationHeader(
        streak: widget.startingUnit > 1 ? 3 : 0,
        gems: widget.startingUnit > 1 ? 150 : 50,
        energy: 20,
        energyMax: 20,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          // Banner Modul Saat Ini (Mengikuti Warna Tema Unit)
          Container(
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
                        widget.startingUnitTitle ??
                            _getUnitTitle(widget.startingUnit),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.startingUnitSubtitle ??
                            _getUnitSubtitle(widget.startingUnit),
                        style: TextStyle(
                          color: unitTheme.accent,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: AppColors.outlineDark, width: 2),
                    boxShadow: AppColors.solidShadow(offset: 2),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.menu_book_rounded,
                          color: unitTheme.primary, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        'Guide',
                        style: TextStyle(
                          color: unitTheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Peta Belajar (Daftar Node dari Kurikulum)
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
