import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/widgets/fade_in_slide.dart';
import 'package:frontend/features/placement_test/presentation/placement_test_question_screen.dart';

/// Halaman kedua onboarding — muncul setelah user menekan "MULAI SEKARANG"
/// di WelcomeScreen. User memilih antara ikut tes penempatan, langsung
/// mulai dari Pelajaran 1, atau lanjut membaca Al-Qur'an.
class WelcomeStartScreen extends StatelessWidget {
  const WelcomeStartScreen({super.key});

  static const _mascotImageUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuAhmMBz3cEPsdrsL2Y6kvNgVRdDIUcRj6TjGkhrOCxlY_cKcAFQL7bL0hdowGw8Vdtl0PIdD5Yi-aSwrby0ZKiXM2DV9aXu91snbKZOXXrCINYhdQbqteLtC59XkyXQnDl_NNvjCXT2XmkGr-9PH3rOlrteMLXGxnoTnwErPtRsIGzbO_QDNFBJ0sNLELqOLUxyhL1BlOpmwtDWTjR0VBjA7riUB-ApSiSNeDspU8TycDCoXPOw4NjNg86rLs7H4YlD03o';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.welcomeBackground,
      body: Container(
        color: AppColors.welcomeBackground,
        child: CustomPaint(
          painter: _DotGridPainter(),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  // --- Top: mascot + wordmark ---
                  FadeInSlide(
                    delay: const Duration(milliseconds: 60),
                    withScale: true,
                    child: Column(
                      children: [
                        Container(
                          width: 128,
                          height: 128,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.surfaceContainerLowest,
                            border:
                                Border.all(color: AppColors.primary, width: 2),
                          ),
                          child: ClipOval(
                            child: Image.network(
                              _mascotImageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.pets,
                                      size: 48, color: AppColors.primary),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const _OutlinedWordmark(text: 'Quri'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // --- Middle: white info card ---
                  FadeInSlide(
                    delay: const Duration(milliseconds: 150),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: AppColors.primary, width: 2),
                        boxShadow: AppColors.hardShadow(),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            'Pilih Langkah Belajarmu',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              height: 1.25,
                              color: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Sesuaikan dengan kemampuanmu saat ini agar materi pembelajaran lebih terarah.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'BeVietnamPro',
                              fontSize: 15,
                              height: 1.5,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // --- Bottom: CTA buttons ---
                  FadeInSlide(
                    delay: const Duration(milliseconds: 240),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(999),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  PlacementTestQuestionScreen(
                                onNext: (selectedIndex) {
                                  // TODO: simpan jawaban & lanjut ke soal 2/3
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(999),
                            border:
                                Border.all(color: AppColors.primary, width: 2),
                            boxShadow: AppColors.hardShadow(),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.track_changes_rounded,
                                      color: AppColors.onPrimary, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'IKUTI TES PENEMPATAN',
                                    style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                      color: AppColors.onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Cari tahu materi yang sesuai dengan kemampuanmu',
                                style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontSize: 12,
                                  color:
                                      AppColors.onPrimary.withValues(alpha: 0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  FadeInSlide(
                    delay: const Duration(milliseconds: 320),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(999),
                        onTap: () {
                          // TODO: arahkan ke mode membaca Al-Qur'an (Mushaf / Surah List)
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(999),
                            border:
                                Border.all(color: AppColors.primary, width: 2),
                            boxShadow: AppColors.hardShadow(),
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.auto_stories_rounded,
                                      color: AppColors.primary, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'LANJUT MEMBACA AL-QUR\'AN',
                                    style: TextStyle(
                                      fontFamily: 'BeVietnamPro',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Untuk yang sudah bisa membaca dan ingin tilawah',
                                style: TextStyle(
                                  fontFamily: 'BeVietnamPro',
                                  fontSize: 12,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // --- Footer: feature badges ---
                  const FadeInSlide(
                    delay: Duration(milliseconds: 400),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _FeatureBadge(
                          icon: Icons.mic_none_rounded,
                          label: 'Koreksi Suara',
                        ),
                        _FeatureBadge(
                          icon: Icons.menu_book_outlined,
                          label: 'Panduan Tajwid',
                        ),
                        _FeatureBadge(
                          icon: Icons.check_circle_outline_rounded,
                          label: 'Latihan Terarah',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Wordmark "Quri" dengan efek outline (stroke) khas desain.
class _OutlinedWordmark extends StatelessWidget {
  final String text;

  const _OutlinedWordmark({required this.text});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontFamily: 'PlusJakartaSans',
      fontSize: 56,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.5,
    );

    return Stack(
      children: [
        Text(
          text,
          style: style.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3
              ..color = AppColors.primary,
          ),
        ),
        Text(
          text,
          style: style.copyWith(color: AppColors.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _FeatureBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.secondaryContainer,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.onSecondaryContainer),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'BeVietnamPro',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

class _DotGridPainter extends CustomPainter {
  static const double _spacing = 20;
  static const double _dotRadius = 1;

  const _DotGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.welcomeDotGrid;
    for (double y = 0; y < size.height; y += _spacing) {
      for (double x = 0; x < size.width; x += _spacing) {
        canvas.drawCircle(Offset(x, y), _dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotGridPainter oldDelegate) => false;
}