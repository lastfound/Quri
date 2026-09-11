import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';

/// Layar pilihan paket langganan premium Quri.
/// Menampilkan tiga tier: Gratis, Quri Booster, dan Quri Pro.
class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded,
              color: AppColors.outlineDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Premium',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.outlineDark,
          ),
        ),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(height: 2, thickness: 2, color: AppColors.outlineDark),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header icon
            Center(
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.goldPremium.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: AppColors.goldPremium, width: 2),
                  boxShadow: AppColors.solidShadow(
                      offset: 4, color: AppColors.goldDark),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: AppColors.goldPremium,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Title
            const Text(
              'Pilih Paket Belajar\nKamu',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: AppColors.teal,
                height: 1.15,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Investasi akhirat yang fleksibel sesuai\nkebutuhan belajarmu.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 28),

            // ── GRATIS PLAN ──
            _PlanCard(
              badge: null,
              badgeColor: Colors.transparent,
              badgeFg: Colors.transparent,
              title: 'GRATIS',
              price: 'Rp 0',
              priceSuffix: '/bulan',
              features: const [
                _PlanFeature(
                  text: 'Maksimal 20 Energi Harian',
                  available: false,
                ),
                _PlanFeature(
                  text: 'Waktu Isi Ulang Normal (1 Energi / 30 Menit)',
                  available: false,
                ),
                _PlanFeature(
                  text: 'Akses Seluruh Materi Dasar',
                  available: false,
                ),
              ],
              buttonText: 'Paket Saat Ini',
              buttonEnabled: false,
              onPressed: null,
              cardColor: Colors.white,
              accentColor: AppColors.textSecondary,
              titleColor: AppColors.outlineDark,
            ),
            const SizedBox(height: 16),

            // ── QURI BOOSTER ──
            _PlanCard(
              badge: 'HEMAT & EFISIEN',
              badgeColor: AppColors.teal,
              badgeFg: Colors.white,
              title: 'QURI BOOSTER',
              price: 'Rp 19k',
              priceSuffix: '/ bulan',
              features: const [
                _PlanFeature(
                  text: 'Kapasitas Energi 2x Lipat (40 Energi)',
                  available: true,
                ),
                _PlanFeature(
                  text: 'Kecepatan Isi Ulang Energi 2x Lebih Cepat (1 Energi / 15 Menit)',
                  available: true,
                ),
                _PlanFeature(text: 'Bebas Iklan 100%', available: true),
                _PlanFeature(
                    text: 'Pengenal Makhraj Dasar', available: true),
              ],
              buttonText: 'Pilih Quri Booster',
              buttonEnabled: true,
              onPressed: () => _showComingSoon(context),
              cardColor: const Color(0xFFF7FBF8),
              accentColor: AppColors.teal,
              titleColor: AppColors.teal,
            ),
            const SizedBox(height: 16),

            // ── QURI PRO ──
            _PlanCard(
              badge: 'PALING POPULER / UNLIMITED',
              badgeColor: AppColors.goldPremium,
              badgeFg: AppColors.outlineDark,
              title: 'QURI PRO',
              price: 'Rp 49k',
              priceSuffix: '/ bulan',
              features: const [
                _PlanFeature(
                  text: 'ENERGI TAK TERBATAS (Unlimited Energy)',
                  available: true,
                  bold: true,
                  icon: Icons.bolt_rounded,
                  iconColor: AppColors.energyYellow,
                ),
                _PlanFeature(
                    text: 'Koreksi AI Makhraj Canggih & Real-time',
                    available: true),
                _PlanFeature(
                    text: 'Mode Offline (Unduh Materi)', available: true),
                _PlanFeature(
                    text: 'Lencana & Profil Emas Khusus', available: true),
                _PlanFeature(
                    text: 'Prioritas Dukungan Pembelajaran', available: true),
              ],
              buttonText: 'Upgrade ke Quri Pro',
              buttonEnabled: true,
              onPressed: () => _showComingSoon(context),
              cardColor: AppColors.teal,
              accentColor: AppColors.goldPremium,
              titleColor: AppColors.goldPremium,
              darkMode: true,
            ),
            const SizedBox(height: 24),

            // Footer note
            const Text(
              'Bisa dibatalkan kapan saja. Bebas komitmen.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🚀 Fitur premium segera hadir! Terima kasih.'),
        backgroundColor: AppColors.teal,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Plan Card Widget
// ─────────────────────────────────────────────────────────────────────────────

class _PlanCard extends StatelessWidget {
  final String? badge;
  final Color badgeColor;
  final Color badgeFg;
  final String title;
  final String price;
  final String priceSuffix;
  final List<_PlanFeature> features;
  final String buttonText;
  final bool buttonEnabled;
  final VoidCallback? onPressed;
  final Color cardColor;
  final Color accentColor;
  final Color titleColor;
  final bool darkMode;

  const _PlanCard({
    required this.badge,
    required this.badgeColor,
    required this.badgeFg,
    required this.title,
    required this.price,
    required this.priceSuffix,
    required this.features,
    required this.buttonText,
    required this.buttonEnabled,
    required this.onPressed,
    required this.cardColor,
    required this.accentColor,
    required this.titleColor,
    this.darkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = darkMode ? Colors.white : AppColors.outlineDark;
    final subTextColor = darkMode
        ? Colors.white.withValues(alpha: 0.75)
        : AppColors.textSecondary;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outlineDark, width: 2),
        boxShadow: AppColors.solidShadow(offset: 5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Badge (if any)
          if (badge != null)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18)),
              ),
              child: Text(
                badge!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: badgeFg,
                  letterSpacing: 0.8,
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: titleColor,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),

                // Price row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      priceSuffix,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: subTextColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Feature list
                ...features.map((f) => _FeatureRow(
                      feature: f,
                      darkMode: darkMode,
                      accentColor: accentColor,
                    )),

                const SizedBox(height: 20),

                // CTA button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: buttonEnabled ? onPressed : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonEnabled
                          ? (darkMode ? accentColor : accentColor)
                          : AppColors.lockedGray,
                      disabledBackgroundColor: AppColors.lockedGray,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                          color: buttonEnabled
                              ? AppColors.outlineDark
                              : AppColors.lockedGrayBorder,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: buttonEnabled
                            ? (darkMode
                                ? AppColors.outlineDark
                                : Colors.white)
                            : AppColors.lockedGrayBorder,
                        letterSpacing: 0.3,
                      ),
                    ),
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

// ─────────────────────────────────────────────────────────────────────────────
// Feature Row
// ─────────────────────────────────────────────────────────────────────────────

class _PlanFeature {
  final String text;
  final bool available;
  final bool bold;
  final IconData? icon;
  final Color? iconColor;

  const _PlanFeature({
    required this.text,
    required this.available,
    this.bold = false,
    this.icon,
    this.iconColor,
  });
}

class _FeatureRow extends StatelessWidget {
  final _PlanFeature feature;
  final bool darkMode;
  final Color accentColor;

  const _FeatureRow({
    required this.feature,
    required this.darkMode,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = darkMode ? Colors.white : AppColors.textPrimary;
    final mutedColor = darkMode
        ? Colors.white.withValues(alpha: 0.55)
        : AppColors.textSecondary;

    Widget leadingIcon;
    if (feature.icon != null) {
      leadingIcon = Icon(feature.icon!, color: feature.iconColor, size: 20);
    } else if (feature.available) {
      leadingIcon = Icon(Icons.check_circle_rounded,
          color: darkMode ? AppColors.goldPremium : accentColor, size: 20);
    } else {
      leadingIcon = Icon(Icons.radio_button_unchecked_rounded,
          color: mutedColor, size: 20);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          leadingIcon,
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              feature.text,
              style: TextStyle(
                fontSize: 14,
                fontWeight:
                    feature.bold ? FontWeight.w800 : FontWeight.w500,
                color: feature.available ? textColor : mutedColor,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
