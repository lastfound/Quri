import 'package:flutter/material.dart';

/// Palet warna aplikasi Quri (Islami Modern + Tactile/Retro Playful Theme).
class AppColors {
  AppColors._();

  // Brand / Primary Colors (Islamic Deep Green & Emerald)
  static const Color primary = Color(0xFF005245);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryDark = Color(0xFF00382E);
  static const Color primaryLight = Color(0xFFD1FAE5);
  static const Color primaryContainer = Color(0xFF1F6B5C);
  static const Color onPrimaryContainer = Color(0xFFA0E9D6);

  // Secondary
  static const Color secondary = Color(0xFF3C6842);
  static const Color secondaryContainer = Color(0xFFBDEFBE);
  static const Color onSecondaryContainer = Color(0xFF426E47);

  // Tertiary
  static const Color tertiary = Color(0xFF755B00);
  static const Color tertiaryContainer = Color(0xFFCEA72C);

  // Surface & Background
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerHigh = Color(0xFFE2E9EC);
  static const Color onSurface = Color(0xFF161D1F);
  static const Color onSurfaceVariant = Color(0xFF3F4946);
  static const Color outline = Color(0xFF6F7975);

  // Gamification Status Colors
  static const Color streakOrange = Color(0xFFF97316);  // 🔥 Api Streak
  static const Color gemBlue = Color(0xFF0EA5E9);       // 💎 Permata
  static const Color heartRed = Color(0xFFEF4444);      // ❤️ Nyawa/Heart
  static const Color starGold = Color(0xFFFBBF24);      // ⭐ Bintang XP
  static const Color energyYellow = Color(0xFFF59E0B);  // ⚡ Energi / Petir

  // Node Path Colors
  static const Color nodeCompleted = Color(0xFF10B981);
  static const Color nodeActive = Color(0xFF005245);
  static const Color nodeLocked = Color(0xFFCBD5E1);

  // Text Colors
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);

  // Card Borders & Shadows
  static const Color border = Color(0xFFE2E8F0);

  // Error
  static const Color error = Color(0xFFBA1A1A);

  // Warna khusus halaman Welcome (background krem + pola titik)
  static const Color welcomeBackground = Color(0xFFF5F1E8);
  static const Color welcomeDotGrid = Color(0xFFD3CEC4);

  /// Shadow "hard/tactile" khas desain: offset 4,4 tanpa blur,
  /// warna primary dengan opacity rendah.
  static List<BoxShadow> hardShadow({Color? color}) => [
        BoxShadow(
          color: (color ?? primary).withValues(alpha: 0.12),
          offset: const Offset(4, 4),
          blurRadius: 0,
        ),
      ];

  // =====================================================================
  // ===== "Learn Path" design (tactile/retro, dipakai di HomeScreen) =====
  // Ditambahkan khusus untuk mengikuti desain Learn Path (header, node,
  // unit card bergaya outline tebal + shadow solid). Tidak mengubah
  // warna-warna di atas yang sudah dipakai fitur lain.
  // =====================================================================

  static const Color cream = Color(0xFFF5F1E8);

  static const Color teal = Color(0xFF1F6B5C);
  static const Color tealDark = Color(0xFF134A3E);
  static const Color tealLight = Color(0xFF349B86);

  static const Color gold = Color(0xFFC9A227);
  static const Color goldDark = Color(0xFF9A7A1B);
  static const Color goldPremium = Color(0xFFD4AF37);

  static const Color mint = Color(0xFFA8E6CF);
  static const Color grayMedium = Color(0xFFA3B1AC);
  static const Color lockedGray = Color(0xFFE5E7EB);
  static const Color lockedGrayBorder = Color(0xFF9CA3AF);

  /// Warna outline/border tebal khas gaya tactile (hampir hitam).
  static const Color outlineDark = Color(0xFF0B2B25);

  /// Shadow "solid" (flat, tanpa blur) khas tombol & node di desain ini.
  static List<BoxShadow> solidShadow({double offset = 4, Color? color}) => [
        BoxShadow(
          color: color ?? outlineDark,
          offset: Offset(0, offset),
          blurRadius: 0,
        ),
      ];
}