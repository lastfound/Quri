import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'widgets/gamification_header.dart';
import 'widgets/learning_node.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  // Data Jalur Belajar Dummy (Akan diganti dari Backend nanti)
  final List<Map<String, dynamic>> _lessons = [
    {
      'title': 'Huruf Tenggorokan',
      'arabic': 'ء - هـ',
      'status': NodeStatus.completed,
      'variant': NodeVariant.normal,
      'offset': 0.0,
      'description': 'Mengenal makhraj huruf Al-Halq (tenggorokan terdalam)',
      'xp': 15,
      'stars': 3,
    },
    {
      'title': 'Huruf Alif & Ba',
      'arabic': 'ا - ب',
      'status': NodeStatus.completed,
      'variant': NodeVariant.normal,
      'offset': -120.0,
      'description': 'Makhraj huruf bibir & rongga mulut',
      'xp': 15,
      'stars': 3,
    },
    {
      'title': 'Pemahaman Makna & Tadabbur',
      'arabic': 'تدبر',
      'status': NodeStatus.completed,
      'variant': NodeVariant.premium,
      'offset': 0.0,
      'description': 'Side quest premium: memahami makna & tadabbur ayat',
      'xp': 30,
      'stars': 3,
      'badgeLabel': 'PREMIUM',
      'sideNoteText': 'Side Quest: Pemahaman Makna & Tadabbur',
      'sideNoteAlign': SideNoteAlign.left,
    },
    {
      'title': 'Huruf Ta & Tsa',
      'arabic': 'ت - ث',
      'status': NodeStatus.active,
      'variant': NodeVariant.normal,
      'offset': 120.0,
      'description': 'Makhraj ujung lidah bertemu gigi seri',
      'xp': 20,
    },
    {
      'title': 'Huruf Jim & Kha',
      'arabic': 'ج - ح',
      'status': NodeStatus.locked,
      'variant': NodeVariant.normal,
      'offset': 0.0,
      'description': 'Tengah lidah & tengah tenggorokan',
      'xp': 20,
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

  void _showLessonDialog(BuildContext context, Map<String, dynamic> lesson) {
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
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppColors.teal,
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
                  const Icon(Icons.stars_rounded, color: AppColors.starGold, size: 22),
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
                        backgroundColor: AppColors.teal,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.teal,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: AppColors.outlineDark, width: 2),
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
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: const GamificationHeader(
        streak: 12,
        gems: 500,
        energy: 14,
        energyMax: 20,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          // Banner Modul Saat Ini
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.teal,
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
                        'Unit 1: Mengenal Huruf',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Master your first letters',
                        style: TextStyle(
                          color: AppColors.mint,
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
                      const Icon(Icons.menu_book_rounded,
                          color: AppColors.teal, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        'Guide',
                        style: TextStyle(
                          color: AppColors.teal,
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
              onTap: () => _showLessonDialog(context, lesson),
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
          indicatorColor: AppColors.tealLight.withValues(alpha: 0.2),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.auto_stories_outlined, color: AppColors.grayMedium),
              selectedIcon: Icon(Icons.auto_stories, color: AppColors.teal),
              label: 'Belajar',
            ),
            NavigationDestination(
              icon: Icon(Icons.flag_outlined, color: AppColors.grayMedium),
              selectedIcon: Icon(Icons.flag, color: AppColors.teal),
              label: 'Quests',
            ),
            NavigationDestination(
              icon: Icon(Icons.bar_chart_outlined, color: AppColors.grayMedium),
              selectedIcon: Icon(Icons.bar_chart, color: AppColors.teal),
              label: 'Ranks',
            ),
            NavigationDestination(
              icon: Icon(Icons.storefront_outlined, color: AppColors.grayMedium),
              selectedIcon: Icon(Icons.storefront, color: AppColors.teal),
              label: 'Shop',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline, color: AppColors.grayMedium),
              selectedIcon: Icon(Icons.person, color: AppColors.teal),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}