import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';

enum NodeStatus { completed, active, locked }

enum NodeVariant { normal, premium, treasure }

enum SideNoteAlign { left, right }

class LearningNode extends StatelessWidget {
  final String title;
  final String arabicSubtitle;
  final NodeStatus status;
  final NodeVariant variant;
  final double horizontalOffset;
  final int stars;
  final String? badgeLabel;
  final String? sideNoteText;
  final SideNoteAlign sideNoteAlign;
  final VoidCallback onTap;

  const LearningNode({
    super.key,
    required this.title,
    required this.arabicSubtitle,
    required this.status,
    this.variant = NodeVariant.normal,
    this.horizontalOffset = 0.0,
    this.stars = 0,
    this.badgeLabel,
    this.sideNoteText,
    this.sideNoteAlign = SideNoteAlign.left,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color baseColor;
    Widget iconWidget;

    // Menentukan tampilan visual sesuai status dan varian node
    switch (status) {
      case NodeStatus.completed:
        if (variant == NodeVariant.premium) {
          baseColor = AppColors.goldPremium;
          iconWidget = const Icon(Icons.star_rounded, size: 38, color: Colors.white);
        } else {
          baseColor = AppColors.gold;
          iconWidget = const Icon(Icons.check_rounded, size: 38, color: Colors.white);
        }
        break;

      case NodeStatus.active:
        if (variant == NodeVariant.premium) {
          baseColor = AppColors.goldPremium;
          iconWidget = const Icon(Icons.auto_awesome_rounded, size: 36, color: Colors.white);
        } else {
          baseColor = AppColors.teal;
          iconWidget = const Icon(Icons.play_arrow_rounded, size: 40, color: Colors.white);
        }
        break;

      case NodeStatus.locked:
        baseColor = AppColors.lockedGray;
        if (variant == NodeVariant.treasure) {
          iconWidget = const Text('🎁', style: TextStyle(fontSize: 34));
        } else {
          iconWidget = const Icon(Icons.lock_rounded, size: 32, color: AppColors.lockedGrayBorder);
        }
        break;
    }

    final bool isLocked = status == NodeStatus.locked;
    final bool isTreasure = variant == NodeVariant.treasure;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Transform.translate(
        offset: Offset(horizontalOffset, 0),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Konten Utama Node (Tombol, Bintang, Judul, Huruf Arab)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Floating Label jika status AKTIF ("MULAI")
                if (status == NodeStatus.active)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      color: variant == NodeVariant.premium ? AppColors.goldDark : AppColors.teal,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.outlineDark, width: 2),
                      boxShadow: AppColors.solidShadow(offset: 3),
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

                // Tombol Node Tactile 3D
                GestureDetector(
                  onTap: !isLocked ? onTap : null,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 78,
                        height: 78,
                        decoration: BoxDecoration(
                          shape: isTreasure ? BoxShape.rectangle : BoxShape.circle,
                          borderRadius: isTreasure ? BorderRadius.circular(22) : null,
                          color: baseColor,
                          border: Border.all(color: AppColors.outlineDark, width: 2.5),
                          boxShadow: AppColors.solidShadow(offset: 6),
                        ),
                        child: Center(child: iconWidget),
                      ),

                      // Badge Label (PREMIUM / BONUS) di pojok atas node
                      if (badgeLabel != null)
                        Positioned(
                          top: -8,
                          right: -10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: badgeLabel == 'PREMIUM'
                                  ? AppColors.gold
                                  : AppColors.mint,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.outlineDark, width: 1.5),
                              boxShadow: AppColors.solidShadow(offset: 2),
                            ),
                            child: Text(
                              badgeLabel!,
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                color: AppColors.outlineDark,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Rating Bintang (jika ada stars > 0)
                if (stars > 0)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(3, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.5),
                          child: Icon(
                            Icons.star_rounded,
                            size: 16,
                            color: index < stars ? AppColors.gold : AppColors.lockedGrayBorder,
                          ),
                        );
                      }),
                    ),
                  ),

                // Label Judul Modul
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isLocked ? AppColors.grayMedium : AppColors.outlineDark,
                  ),
                ),

                // Subtitle Huruf Arab
                Text(
                  arabicSubtitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isLocked ? AppColors.grayMedium : AppColors.teal,
                  ),
                ),
              ],
            ),

            // Side Note Card (Side Quest Callout / Info Spesial)
            if (sideNoteText != null)
              Positioned(
                left: sideNoteAlign == SideNoteAlign.left ? -165 : 95,
                child: Container(
                  width: 145,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.outlineDark, width: 2),
                    boxShadow: AppColors.solidShadow(offset: 3),
                  ),
                  child: Text(
                    sideNoteText!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: AppColors.outlineDark,
                      height: 1.25,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
