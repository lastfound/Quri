import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';

class GamificationHeader extends StatelessWidget implements PreferredSizeWidget {
  final int streak;
  final int gems;

  const GamificationHeader({
    super.key,
    this.streak = 3,
    this.gems = 150,
  });

  @override
  Size get preferredSize => const Size.fromHeight(68);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 10,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.outlineDark, width: 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo Quri Mini
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.outlineDark, width: 2),
                  boxShadow: AppColors.solidShadow(offset: 2),
                ),
                child: const Icon(
                  Icons.auto_stories,
                  color: AppColors.teal,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Quri',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.teal,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),

          // Stat Badges (Streak & Gems)
          Row(
            children: [
              // 🔥 Streak
              _StatBadge(
                icon: Icons.local_fire_department_rounded,
                iconColor: AppColors.streakOrange,
                value: '$streak',
              ),
              const SizedBox(width: 8),

              // 💎 Gems
              _StatBadge(
                icon: Icons.diamond_rounded,
                iconColor: AppColors.gemBlue,
                value: '$gems',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;

  const _StatBadge({
    required this.icon,
    required this.iconColor,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outlineDark, width: 1.5),
        boxShadow: AppColors.solidShadow(offset: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: AppColors.outlineDark,
            ),
          ),
        ],
      ),
    );
  }
}
