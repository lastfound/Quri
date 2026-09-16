import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/unit_theme.dart';
import 'package:frontend/features/exercise/data/unit_1_curriculum.dart';
import 'package:frontend/features/exercise/presentation/exercise_question_screen.dart';
import 'package:frontend/features/profile/presentation/profile_screen.dart';
import 'package:frontend/features/rank/presentation/rank_screen.dart';
import 'package:frontend/features/shop/presentation/shop_screen.dart';
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
  }

  /// Membangun data lessons dari kurikulum Unit 1 + status unlock.
  List<Map<String, dynamic>> _buildLessons() {
    final levels = Unit1Curriculum.levels;
    final List<Map<String, dynamic>> lessons = [];

    // Pola offset zigzag: Checkpoint dan Boss selalu terpusat (0.0), materi normal meliuk lembut (-55.0 / 55.0)
    const offsets = [
      0.0,   // Level 1: Alif & Ba
      -55.0, // Level 2: Ta & Tsa
      55.0,  // Level 3: Jim, Ha, Kho
      0.0,   // Level 4: Mini-Review & Checkpoint (CENTERED)
      -55.0, // Level 5: Dal, Dzal, Ro, Zai
      55.0,  // Level 6: Sin & Syin
      -55.0, // Level 7: Sad & Dhod
      0.0,   // Level 8: Mid-Unit Checkpoint (CENTERED)
      55.0,  // Level 9: Tho, Zho, 'Ain, Ghoin
      -55.0, // Level 10: Fa, Qof, Kaf
      55.0,  // Level 11: Lam, Mim, Nun, Wawu
      -55.0, // Level 12: Ha, Hamzah, Ya
      0.0,   // Level 13: Boss Level Unit 1 (CENTERED)
    ];

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
        if (level.isBoss) {
          variant = NodeVariant.treasure;
        } else {
          variant = NodeVariant.premium;
        }
      }

      final offset = (i < offsets.length)
          ? offsets[i]
          : (level.isCheckpoint || level.isBoss ? 0.0 : ((i % 2 == 1) ? -55.0 : 55.0));

      lessons.add({
        'levelIndex': i,
        'title': level.title,
        'arabic': level.arabicSubtitle,
        'status': status,
        'variant': variant,
        'offset': offset,
        'description': level.description,
        'xp': level.xpReward,
        'stars': _starsByLevel[i],
        'badgeLabel': level.badgeLabel,
        'timeLimitMinutes': level.effectiveTimeLimitMinutes,
        'isExam': level.effectiveTimeLimitMinutes != null,
        'isBoss': level.isBoss,
        'isCheckpoint': level.isCheckpoint,
      });
    }

    return lessons;
  }

  void _showLessonDialog(
      BuildContext context, Map<String, dynamic> lesson, UnitTheme unitTheme) {
    final isLocked = lesson['status'] == NodeStatus.locked;
    final bool isExam = lesson['isExam'] == true;
    final int? timeLimit = lesson['timeLimitMinutes'];
    final bool isBoss = lesson['isBoss'] == true;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(28)),
            border: Border(
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

              // Badge tipe modul (Ujian vs Latihan)
              if (isExam)
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: isBoss ? const Color(0xFFFEF3C7) : const Color(0xFFE0F2FE),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isBoss ? const Color(0xFFB45309) : const Color(0xFF0284C7),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isBoss ? Icons.military_tech_rounded : Icons.timer_outlined,
                        size: 15,
                        color: isBoss ? const Color(0xFFB45309) : const Color(0xFF0369A1),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        isBoss ? 'UJIAN BOSS LEVEL' : 'UJIAN CHECKPOINT',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: isBoss ? const Color(0xFFB45309) : const Color(0xFF0369A1),
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),

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
              const SizedBox(height: 14),

              // Info XP dan Batas Waktu jika ujian
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
                  if (isExam && timeLimit != null) ...[
                    const SizedBox(width: 16),
                    const Icon(Icons.timer_outlined,
                        color: Color(0xFF0284C7), size: 20),
                    const SizedBox(width: 5),
                    Text(
                      'Waktu: $timeLimit Menit',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0369A1),
                      ),
                    ),
                  ],
                ],
              ),

              // Banner peringatan ujian berwaktu
              if (isExam && timeLimit != null && !isLocked) ...[
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFFBBF24), width: 1.5),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline_rounded,
                          size: 18, color: Color(0xFFB45309)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Ujian ini memiliki batas waktu $timeLimit menit. Pastikan kamu siap sebelum mulai!',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF92400E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

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
                    backgroundColor: isExam ? (isBoss ? AppColors.goldDark : unitTheme.primary) : unitTheme.primary,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!isLocked && isExam) ...[
                        const Icon(Icons.timer_outlined, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        isLocked
                            ? '🔒 TERKUNCI'
                            : (isExam ? 'MULAI UJIAN ($timeLimit MNT)' : 'MULAI BELAJAR'),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: isLocked ? AppColors.lockedGrayBorder : Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
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
    final int levelIndex = lesson['levelIndex'];
    final level = Unit1Curriculum.levels[levelIndex];

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ExerciseQuestionScreen(
          questions: level.questions,
          levelTitle: level.title,
          unitNumber: 1,
          xpReward: level.xpReward,
          timeLimitMinutes: level.effectiveTimeLimitMinutes,
          isExam: level.effectiveTimeLimitMinutes != null,
          streak: 0,
          gems: 50,
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
      appBar: const GamificationHeader(
        streak: 0,
        gems: 50,
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
              timeLimitMinutes: lesson['timeLimitMinutes'],
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
            if (index == 2) {
              // Rank → buka RankScreen (Leaderboard)
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const RankScreen()),
              );
              return;
            }
            if (index == 3) {
              // Shop → buka ShopScreen
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ShopScreen()),
              );
              return;
            }
            if (index == 4) {
              // Profile → buka ProfileScreen
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
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
