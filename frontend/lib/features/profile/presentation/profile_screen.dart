import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1E8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.outlineDark, width: 1.5),
                color: const Color(0xFFD7EFE6),
              ),
              child: const Icon(Icons.person_rounded, size: 20, color: AppColors.teal),
            ),
            const SizedBox(width: 10),
            const Text(
              'Quri',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.teal),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF5EC),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.teal, width: 1.5),
            ),
            child: const Text(
              'Premium',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.teal),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
        child: Column(
          children: [
            _ProfileCard(),
            const SizedBox(height: 16),
            const _StatCard(
              icon: Icons.star_border_rounded,
              iconColor: AppColors.starGold,
              value: '1,240',
              label: 'TOTAL XP',
            ),
            const SizedBox(height: 16),
            const _StatCard(
              icon: Icons.local_fire_department_outlined,
              iconColor: AppColors.streakOrange,
              value: '7 Hari',
              label: 'STREAK',
            ),
            const SizedBox(height: 16),
            const _ProgressCard(
              icon: Icons.menu_book_outlined,
              iconColor: AppColors.teal,
              iconBgColor: Color(0xFFD7EFE6),
              percent: 0.80,
              label: 'MAHIR TAJWID',
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
      ),
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE5E7EB), width: 3),
              color: const Color(0xFFD7EFE6),
            ),
            child: const Icon(Icons.person_rounded, size: 52, color: AppColors.teal),
          ),
          const SizedBox(height: 16),
          const Text(
            'Ahmad',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          const Text(
            'Dedicated Learner',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFD0E8E0), width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.workspace_premium_rounded, color: AppColors.teal, size: 18),
                const SizedBox(width: 6),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Level 12 : ',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.teal),
                      ),
                      TextSpan(
                        text: 'Intermediate',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.teal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 36),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: iconColor),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final double percent;
  final String label;

  const _ProgressCard({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.percent,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final percentText = '${(percent * 100).round()}%';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
      ),
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(height: 14),
          Text(
            percentText,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: iconColor),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 10,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: AlwaysStoppedAnimation<Color>(iconColor),
            ),
          ),
        ],
      ),
    );
  }
}