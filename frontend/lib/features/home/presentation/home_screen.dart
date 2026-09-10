import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/unit_theme.dart';
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
    _configureLessonsForUnit();
  }

  void _configureLessonsForUnit() {
    // Setiap unit mulai dari awal: pelajaran 1 (index 0) aktif, sisanya terkunci
    for (int i = 0; i < _lessons.length; i++) {
      if (i == 0) {
        _lessons[i]['status'] = NodeStatus.active;
        _lessons[i]['stars'] = 0;
      } else {
        _lessons[i]['status'] = NodeStatus.locked;
        _lessons[i]['stars'] = 0;
      }
    }
  }

  // Data Jalur Belajar Dummy (Akan diganti dari Backend nanti)
  final List<Map<String, dynamic>> _lessons = [
    {
      'title': 'Huruf Tenggorokan',
      'arabic': 'ء - هـ',
      'status': NodeStatus.active,
      'variant': NodeVariant.normal,
      'offset': 0.0,
      'description': 'Mengenal makhraj huruf Al-Halq (tenggorokan terdalam)',
      'xp': 15,
      'stars': 0,
    },
    {
      'title': 'Huruf Alif & Ba',
      'arabic': 'ا - ب',
      'status': NodeStatus.locked,
      'variant': NodeVariant.normal,
      'offset': -120.0,
      'description': 'Makhraj huruf bibir & rongga mulut',
      'xp': 15,
      'stars': 0,
    },
    {
      'title': 'Pemahaman Makna & Tadabbur',
      'arabic': 'تدبر',
      'status': NodeStatus.locked,
      'variant': NodeVariant.premium,
      'offset': 0.0,
      'description': 'Side quest premium: memahami makna & tadabbur ayat',
      'xp': 30,
      'stars': 0,
      'badgeLabel': 'PREMIUM',
      'sideNoteText': 'Side Quest: Pemahaman Makna & Tadabbur',
      'sideNoteAlign': SideNoteAlign.left,
    },
    {
      'title': 'Huruf Ta & Tsa',
      'arabic': 'ت - ث',
      'status': NodeStatus.locked,
      'variant': NodeVariant.normal,
      'offset': 120.0,
      'description': 'Makhraj ujung lidah bertemu gigi seri',
      'xp': 20,
      'stars': 0,
    },
    {
      'title': 'Huruf Jim & Kha',
      'arabic': 'ج - ح',
      'status': NodeStatus.locked,
      'variant': NodeVariant.normal,
      'offset': 0.0,
      'description': 'Tengah lidah & tengah tenggorokan',
      'xp': 20,
      'stars': 0,
    },
    {
      'title': 'Modul Spesial: AI Makhraj Pro',
      'arabic': 'AI Pro',
      'status': NodeStatus.locked,
      'variant': NodeVariant.premium,
      'offset': -120.0,
      'description': 'Latihan makhraj dengan koreksi suara berbasis AI',
      'xp': 40,
      'badgeLabel': 'BONUS',
      'sideNoteText': 'Modul Spesial: AI Makhraj Pro',
      'sideNoteAlign': SideNoteAlign.right,
    },
    {
      'title': 'Harakat Fathah',
      'arabic': 'َـ',
      'status': NodeStatus.locked,
      'variant': NodeVariant.normal,
      'offset': 0.0,
      'description': 'Tanda baca vokal terbuka (A)',
      'xp': 25,
    },
    {
      'title': 'Peti Harta Karun',
      'arabic': '🎁',
      'status': NodeStatus.locked,
      'variant': NodeVariant.treasure,
      'offset': 120.0,
      'description': 'Buka setelah menyelesaikan Unit 1',
      'xp': 50,
    },
  ];

  void _showLessonDialog(
      BuildContext context, Map<String, dynamic> lesson, UnitTheme unitTheme) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
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
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: unitTheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                lesson['title'],
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
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Memulai latihan: ${lesson['title']}!'),
                        backgroundColor: unitTheme.primary,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: unitTheme.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(
                          color: AppColors.outlineDark, width: 2),
                    ),
                  ),
                  child: const Text(
                    'MULAI BELAJAR',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
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

  @override
  Widget build(BuildContext context) {
    final unitTheme = UnitTheme.getTheme(widget.startingUnit);

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
                    border: Border.all(color: AppColors.outlineDark, width: 2),
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

          // Peta Belajar (Daftar Node)
          ..._lessons.map((lesson) {
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
