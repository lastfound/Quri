import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';

/// Tema warna unik per unit pembelajaran (Unit 1 s/d Unit 6).
class UnitTheme {
  final int unitNumber;
  final Color primary;
  final Color dark;
  final Color accent;
  final Color lightSurface;

  const UnitTheme({
    required this.unitNumber,
    required this.primary,
    required this.dark,
    required this.accent,
    required this.lightSurface,
  });

  /// Mengambil konfigurasi tema berdasarkan nomor unit.
  static UnitTheme getTheme(int unit) {
    switch (unit) {
      case 2:
        // Unit 2: Ocean Blue (Dominasi Biru)
        return const UnitTheme(
          unitNumber: 2,
          primary: Color(0xFF1D6FBE),
          dark: Color(0xFF124B82),
          accent: Color(0xFFBAE6FD),
          lightSurface: Color(0xFFF0F7FF),
        );
      case 3:
        // Unit 3: Warm Tangerine / Amber (Dominasi Oranye / Amber)
        return const UnitTheme(
          unitNumber: 3,
          primary: Color(0xFFD97706),
          dark: Color(0xFF92400E),
          accent: Color(0xFFFDE68A),
          lightSurface: Color(0xFFFFFBEB),
        );
      case 4:
        // Unit 4: Royal Violet / Deep Purple (Dominasi Ungu)
        return const UnitTheme(
          unitNumber: 4,
          primary: Color(0xFF7C3AED),
          dark: Color(0xFF5B21B6),
          accent: Color(0xFFDDD6FE),
          lightSurface: Color(0xFFF7F5FF),
        );
      case 5:
        // Unit 5: Ruby Crimson / Coral Rose (Dominasi Merah / Rose)
        return const UnitTheme(
          unitNumber: 5,
          primary: Color(0xFFD94663),
          dark: Color(0xFF9F1239),
          accent: Color(0xFFFECDD3),
          lightSurface: Color(0xFFFFF5F7),
        );
      case 6:
        // Unit 6: Imperial Gold / Bronze (Dominasi Emas / Bronze Mewah)
        return const UnitTheme(
          unitNumber: 6,
          primary: Color(0xFFB4831B),
          dark: Color(0xFF78550B),
          accent: Color(0xFFFEEBC8),
          lightSurface: Color(0xFFFFFDF5),
        );
      case 1:
      default:
        // Unit 1: Forest Emerald / Islamic Teal (Dominasi Hijau)
        return const UnitTheme(
          unitNumber: 1,
          primary: AppColors.teal,
          dark: AppColors.tealDark,
          accent: AppColors.mint,
          lightSurface: Color(0xFFF0FDF4),
        );
    }
  }
}
