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
  final int? timeLimitMinutes;
  final String? sideNoteText;
  final SideNoteAlign sideNoteAlign;
  final Color? activeColor;
  final Color? accentColor;
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
    this.timeLimitMinutes,
    this.sideNoteText,
    this.sideNoteAlign = SideNoteAlign.left,
    this.activeColor,
    this.accentColor,
    required this.onTap,
  });

  bool get _isBoss =>
      badgeLabel?.toUpperCase().contains('BOSS') ?? false;

  bool get _isCheckpoint =>
      badgeLabel?.toUpperCase().contains('CHECKPOINT') ?? false;

  @override
  Widget build(BuildContext context) {
    Color baseColor;
    Widget iconWidget;

    // Menentukan tampilan visual sesuai status dan varian node
    switch (status) {
      case NodeStatus.completed:
        if (_isBoss) {
          baseColor = AppColors.goldPremium;
          iconWidget = const Icon(Icons.emoji_events_rounded, size: 40, color: Colors.white);
        } else if (_isCheckpoint) {
          baseColor = activeColor ?? AppColors.teal;
          iconWidget = const Icon(Icons.verified_rounded, size: 38, color: Colors.white);
        } else if (variant == NodeVariant.premium) {
          baseColor = AppColors.goldPremium;
          iconWidget = const Icon(Icons.star_rounded, size: 38, color: Colors.white);
        } else {
          baseColor = AppColors.gold;
          iconWidget = const Icon(Icons.check_rounded, size: 38, color: Colors.white);
        }
        break;

      case NodeStatus.active:
        if (_isBoss) {
          baseColor = AppColors.goldDark;
          iconWidget = const Icon(Icons.military_tech_rounded, size: 42, color: Colors.white);
        } else if (_isCheckpoint) {
          baseColor = activeColor ?? AppColors.teal;
          iconWidget = const Icon(Icons.quiz_rounded, size: 38, color: Colors.white);
        } else if (variant == NodeVariant.premium) {
          baseColor = AppColors.goldPremium;
          iconWidget = const Icon(Icons.auto_awesome_rounded, size: 36, color: Colors.white);
        } else {
          baseColor = activeColor ?? AppColors.teal;
          iconWidget = const Icon(Icons.play_arrow_rounded, size: 40, color: Colors.white);
        }
        break;

      case NodeStatus.locked:
        baseColor = AppColors.lockedGray;
        if (_isBoss) {
          iconWidget = const Icon(Icons.lock_clock_rounded, size: 34, color: AppColors.lockedGrayBorder);
        } else if (variant == NodeVariant.treasure) {
          iconWidget = const Text('🎁', style: TextStyle(fontSize: 34));
        } else {
          iconWidget = const Icon(Icons.lock_rounded, size: 32, color: AppColors.lockedGrayBorder);
        }
        break;
    }

    final bool isLocked = status == NodeStatus.locked;
    final bool isTreasure = variant == NodeVariant.treasure;

    // Teks floating label saat node aktif
    String activeLabelText = 'MULAI';
    if (_isBoss) {
      activeLabelText = 'MULAI BOSS';
    } else if (_isCheckpoint) {
      activeLabelText = 'MULAI UJIAN';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Transform.translate(
        offset: Offset(horizontalOffset, 0),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Konten Utama Node (Tombol, Bintang, Badge Milestone, Judul, Huruf Arab)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Floating Label jika status AKTIF ("MULAI" / "MULAI UJIAN")
                if (status == NodeStatus.active)
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: _isBoss
                          ? AppColors.goldDark
                          : (_isCheckpoint
                              ? (activeColor ?? AppColors.teal)
                              : (variant == NodeVariant.premium
                                  ? AppColors.goldDark
                                  : (activeColor ?? AppColors.teal))),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.outlineDark, width: 2),
                      boxShadow: AppColors.solidShadow(offset: 3),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_isCheckpoint || _isBoss) ...[
                          const Icon(Icons.timer_outlined, size: 13, color: Colors.white),
                          const SizedBox(width: 4),
                        ],
                        Text(
                          activeLabelText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 11,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Tombol Node Tactile 3D
                GestureDetector(
                  onTap: !isLocked ? onTap : null,
                  child: Container(
                    width: _isBoss ? 84 : 78,
                    height: _isBoss ? 84 : 78,
                    decoration: BoxDecoration(
                      shape: isTreasure ? BoxShape.rectangle : BoxShape.circle,
                      borderRadius: isTreasure ? BorderRadius.circular(22) : null,
                      color: baseColor,
                      border: Border.all(
                        color: _isBoss ? const Color(0xFF78350F) : AppColors.outlineDark,
                        width: _isBoss ? 3 : 2.5,
                      ),
                      boxShadow: AppColors.solidShadow(
                        offset: 6,
                        color: _isBoss
                            ? const Color(0xFF78350F).withValues(alpha: 0.5)
                            : AppColors.outlineDark.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Center(child: iconWidget),
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

                // Badge Milestone / Ujian yang rapi (tidak menabrak tombol)
                if (badgeLabel != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: _isBoss
                          ? const Color(0xFFFEF3C7)
                          : (_isCheckpoint
                              ? const Color(0xFFE0F2FE)
                              : (accentColor ?? AppColors.mint)),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _isBoss
                            ? const Color(0xFFB45309)
                            : (_isCheckpoint
                                ? const Color(0xFF0284C7)
                                : AppColors.outlineDark),
                        width: 1.5,
                      ),
                      boxShadow: AppColors.solidShadow(offset: 2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isBoss
                              ? Icons.military_tech_rounded
                              : (_isCheckpoint
                                  ? Icons.timer_outlined
                                  : Icons.star_rounded),
                          size: 13,
                          color: _isBoss
                              ? const Color(0xFFB45309)
                              : (_isCheckpoint
                                  ? const Color(0xFF0369A1)
                                  : AppColors.outlineDark),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          timeLimitMinutes != null
                              ? '$badgeLabel • $timeLimitMinutes MNT'
                              : badgeLabel!,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: _isBoss
                                ? const Color(0xFFB45309)
                                : (_isCheckpoint
                                    ? const Color(0xFF0369A1)
                                    : AppColors.outlineDark),
                            letterSpacing: 0.6,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Label Judul Modul
                Text(
                  title,
                  textAlign: TextAlign.center,
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
                    color: isLocked ? AppColors.grayMedium : (activeColor ?? AppColors.teal),
                  ),
                ),
              ],
            ),

            // Side Note Card (Side Quest Callout / Info Tambahan jika ada)
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
