import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';

class GamificationHeader extends StatelessWidget implements PreferredSizeWidget {
  final int streak;
  final int gems;
  final int hearts;

  const GamificationHeader({
    super.key,
    this.streak = 3,
    this.gems = 150,
    this.hearts = 5,
  });

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 1.5),
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
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.auto_stories,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Quri',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),

          // Stat Badges
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
              const SizedBox(width: 8),

              // ❤️ Hearts
              _StatBadge(
                icon: Icons.favorite_rounded,
                iconColor: AppColors.heartRed,
                value: '$hearts',
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
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
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
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
