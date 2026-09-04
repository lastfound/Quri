import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';

enum NodeStatus { completed, active, locked }

class LearningNode extends StatelessWidget {
  final String title;
  final String arabicSubtitle;
  final NodeStatus status;
  final double horizontalOffset;
  final VoidCallback onTap;

  const LearningNode({
    super.key,
    required this.title,
    required this.arabicSubtitle,
    required this.status,
    this.horizontalOffset = 0.0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color baseColor;
    Color shadowColor;
    IconData icon;

    switch (status) {
      case NodeStatus.completed:
        baseColor = AppColors.starGold;
        shadowColor = const Color(0xFFD97706);
        icon = Icons.check_rounded;
        break;
      case NodeStatus.active:
        baseColor = AppColors.primary;
        shadowColor = AppColors.primaryDark;
        icon = Icons.play_arrow_rounded;
        break;
      case NodeStatus.locked:
        baseColor = AppColors.nodeLocked;
        shadowColor = const Color(0xFF94A3B8);
        icon = Icons.lock_rounded;
        break;
    }

    return Transform.translate(
      offset: Offset(horizontalOffset, 0),
      child: Column(
        children: [
          // Label Terapung jika status Aktif ("MULAI")
          if (status == NodeStatus.active)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                'MULAI',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 11,
                  letterSpacing: 1.2,
                ),
              ),
            ),

          // Tombol Bulat 3D Bergaya Gamifikasi
          GestureDetector(
            onTap: status != NodeStatus.locked ? onTap : null,
            child: Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: baseColor,
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    offset: const Offset(0, 6),
                    blurRadius: 0,
                  ),
                  BoxShadow(
                    color: baseColor.withValues(alpha: 0.25),
                    offset: const Offset(0, 8),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 38,
                  color: status == NodeStatus.locked
                      ? Colors.white70
                      : Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Label Judul & Huruf Arab
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: status == NodeStatus.locked
                  ? AppColors.textMuted
                  : AppColors.textPrimary,
            ),
          ),
          Text(
            arabicSubtitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: status == NodeStatus.locked
                  ? AppColors.textMuted
                  : AppColors.primary,
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
