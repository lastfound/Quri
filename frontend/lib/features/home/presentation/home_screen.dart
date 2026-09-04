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
      'offset': 0.0,
      'description': 'Mengenal makhraj huruf Al-Halq (tenggorokan terdalam)',
      'xp': 15,
    },
    {
      'title': 'Huruf Alif & Ba',
      'arabic': 'ا - ب',
      'status': NodeStatus.completed,
      'offset': -50.0,
      'description': 'Makhraj huruf bibir & rongga mulut',
      'xp': 15,
    },
    {
      'title': 'Huruf Ta & Tsa',
      'arabic': 'ت - ث',
      'status': NodeStatus.active,
      'offset': 45.0,
      'description': 'Makhraj ujung lidah bertemu gigi seri',
      'xp': 20,
    },
    {
      'title': 'Huruf Jim & Kha',
      'arabic': 'ج - ح',
      'status': NodeStatus.locked,
      'offset': -35.0,
      'description': 'Tengah lidah & tengah tenggorokan',
      'xp': 20,
    },
    {
      'title': 'Harakat Fathah',
      'arabic': 'َـ',
      'status': NodeStatus.locked,
      'offset': 0.0,
      'description': 'Tanda baca vokal terbuka (A)',
      'xp': 25,
    },
    {
      'title': 'Harakat Kasrah',
      'arabic': 'ِـ',
      'status': NodeStatus.locked,
      'offset': 40.0,
      'description': 'Tanda baca vokal miring (I)',
      'xp': 25,
    },
  ];

  void _showLessonDialog(BuildContext context, Map<String, dynamic> lesson) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
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
                  color: AppColors.primary,
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
                        backgroundColor: AppColors.primary,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
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
      backgroundColor: AppColors.background,
      appBar: const GamificationHeader(
        streak: 5,
        gems: 320,
        hearts: 5,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 28),
        children: [
          // Banner Modul Saat Ini
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'MODUL 1',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Dasar Makharijul Huruf',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.menu_book_rounded, color: Colors.white, size: 20),
                      SizedBox(width: 6),
                      Text(
                        'Panduan',
                        style: TextStyle(
                          color: Colors.white,
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
          const SizedBox(height: 24),

          // Peta Belajar (Daftar Node)
          ..._lessons.map((lesson) {
            return LearningNode(
              title: lesson['title'],
              arabicSubtitle: lesson['arabic'],
              status: lesson['status'],
              horizontalOffset: lesson['offset'],
              onTap: () => _showLessonDialog(context, lesson),
            );
          }),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentNavIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primaryLight,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.auto_stories_outlined),
            selectedIcon: Icon(Icons.auto_stories, color: AppColors.primary),
            label: 'Belajar',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center, color: AppColors.primary),
            label: 'Latihan',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            selectedIcon: Icon(Icons.emoji_events, color: AppColors.primary),
            label: 'Peringkat',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: AppColors.primary),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
