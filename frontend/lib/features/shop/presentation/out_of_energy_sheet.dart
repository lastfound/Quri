import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/features/shop/presentation/shop_screen.dart';

/// Layar "Energi Harian Habis" — muncul sebagai modal bottom sheet
/// ketika pemain kehabisan energi saat akan memulai atau sedang latihan.
///
/// Menyediakan dua opsi:
/// 1. Tunggu Isi Ulang — dengan countdown timer.
/// 2. Buka Dengan Energi Dari Paket Premium — navigasi ke [ShopScreen].
class OutOfEnergySheet extends StatelessWidget {
  /// Countdown teks sampai energi berikutnya tersedia (mis. "28:45").
  /// Jika null, timer tidak ditampilkan.
  final String? countdownText;

  /// Dipanggil ketika user memilih "Tunggu Isi Ulang".
  final VoidCallback? onWait;

  const OutOfEnergySheet({
    super.key,
    this.countdownText,
    this.onWait,
  });

  /// Tampilkan sebagai modal bottom sheet dari luar.
  static Future<void> show(
    BuildContext context, {
    String? countdownText,
    VoidCallback? onWait,
  }) {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => OutOfEnergySheet(
        countdownText: countdownText,
        onWait: onWait,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        20,
        24,
        MediaQuery.of(context).padding.bottom + 28,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(color: AppColors.outlineDark, width: 2.5),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 24),

          // Battery / energy icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.energyYellow.withValues(alpha: 0.12),
              shape: BoxShape.circle,
              border: Border.all(
                  color: AppColors.energyYellow, width: 2),
            ),
            child: const Icon(
              Icons.battery_0_bar_rounded,
              color: AppColors.energyYellow,
              size: 34,
            ),
          ),
          const SizedBox(height: 16),

          // Title
          const Text(
            'Energi Harian Kamu Habis!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppColors.outlineDark,
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          const Text(
            'Istirahat sejenak agar ingatan hafalanmu makin\nkuat, atau isi ulang energimu untuk lanjut belajar.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 28),

          // ── Button 1: Tunggu Isi Ulang ──
          _OutlineButton(
            onPressed: () {
              Navigator.of(context).pop();
              onWait?.call();
            },
            borderColor: AppColors.energyYellow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.access_time_rounded,
                    color: AppColors.outlineDark, size: 18),
                const SizedBox(width: 8),
                Text(
                  countdownText != null && countdownText!.isNotEmpty
                      ? 'Tunggu Isi Ulang ($countdownText)'
                      : 'Tunggu Isi Ulang',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.outlineDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ── Button 2: Isi Ulang dengan Quri (navigasi ke ShopScreen) ──
          _FilledButton(
            backgroundColor: AppColors.teal,
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ShopScreen()),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bolt_rounded,
                    color: Colors.white, size: 20),
                SizedBox(width: 6),
                Text(
                  'Isi Ulang dengan Quri',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ── Button 3: Buka Premium ──
          _FilledButton(
            backgroundColor: AppColors.goldPremium,
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ShopScreen()),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.workspace_premium_rounded,
                    color: AppColors.outlineDark, size: 20),
                SizedBox(width: 6),
                Text(
                  'Buka Unlimited Energi dengan Paket Premium',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.outlineDark,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helper widgets
// ─────────────────────────────────────────────────────────────────────────────

class _OutlineButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color borderColor;
  final Widget child;

  const _OutlineButton({
    required this.onPressed,
    required this.borderColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: borderColor, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: child,
      ),
    );
  }
}

class _FilledButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Widget child;

  const _FilledButton({
    required this.onPressed,
    required this.backgroundColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(
                color: AppColors.outlineDark, width: 2),
          ),
        ),
        child: child,
      ),
    );
  }
}
