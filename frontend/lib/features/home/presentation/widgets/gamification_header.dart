import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';

class GamificationHeader extends StatelessWidget implements PreferredSizeWidget {
  final int streak;
  final int gems;
  final int? energy;
  final int? energyMax;
  final int hearts;
  final int? heartsMax;

  /// Teks countdown timer untuk regenerasi energi (misal "54:32").
  /// Jika null atau kosong, tidak ditampilkan.
  final String? energyTimerText;

  const GamificationHeader({
    super.key,
    this.streak = 3,
    this.gems = 150,
    this.energy,
    this.energyMax,
    this.hearts = 5,
    this.heartsMax,
    this.energyTimerText,
  });

  int get currentEnergy => energy ?? hearts;
  int? get maxEnergy => energyMax ?? heartsMax;

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

              // ⚡ Energi (Petir) + timer countdown
              _EnergyBadge(
                energy: currentEnergy,
                maxEnergy: maxEnergy,
                timerText: energyTimerText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Badge khusus energi — menampilkan timer countdown jika energi belum penuh.
class _EnergyBadge extends StatelessWidget {
  final int energy;
  final int? maxEnergy;
  final String? timerText;

  const _EnergyBadge({
    required this.energy,
    this.maxEnergy,
    this.timerText,
  });

  @override
  Widget build(BuildContext context) {
    final bool showTimer = timerText != null && timerText!.isNotEmpty;
    final bool isFull = maxEnergy != null && energy >= maxEnergy!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: !isFull ? AppColors.energyYellow : AppColors.outlineDark,
          width: 1.5,
        ),
        boxShadow: AppColors.solidShadow(offset: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.bolt_rounded,
            color: AppColors.energyYellow,
            size: 18,
          ),
          const SizedBox(width: 4),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                maxEnergy != null ? '$energy/$maxEnergy' : '$energy',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.outlineDark,
                ),
              ),
              if (showTimer && !isFull)
                Text(
                  timerText!,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: AppColors.energyYellow.withValues(alpha: 0.85),
                    height: 1.1,
                  ),
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
