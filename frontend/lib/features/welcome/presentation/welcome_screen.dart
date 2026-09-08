import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/features/welcome/presentation/welcome_start_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  static const _mascotImageUrl =
      'https://lh3.googleusercontent.com/aida-public/AB6AXuCY2g0rBIlRrQHQH_SAdx-Onmn4ZWhpbwrTl_XjuG6EwQ-IvA_HrxEoJTFXaA1JgUpol5k2Jmw5YGFmWMp2-vqCTEGU36hF8V_EW8fwGQ6SqEb8olHv1GGLIUOGCSVqbKnD35UFvRp_0007TImrpooMm5UqMp7EC27OI2WK5BVHPyxZSdzHCcrjyvCDn5il1PgzDAbM7RH2bZp1NeM1bBeZl5x0kpZBGl4A_XwphbK3H3c6NIR5cog4MtfeQ2rH3cr2t4k';

  late final AnimationController _bounceController;
  late final Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _bounce = Tween<double>(begin: 0, end: -6).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.welcomeBackground,
      body: Container(
        color: AppColors.welcomeBackground,
        child: CustomPaint(
          painter: _DotGridPainter(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  const Spacer(flex: 2),

                  // --- Top area: greeting bubble + mascot ---
                  AnimatedBuilder(
                    animation: _bounce,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(0, _bounce.value),
                      child: child,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: AppColors.primary, width: 2),
                        boxShadow: AppColors.hardShadow(),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('👋', style: TextStyle(fontSize: 22)),
                          SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              "Assalamu'alaikum! Hai, aku Quri!",
                              style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 144,
                    height: 144,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surfaceContainerLowest,
                      border: Border.all(color: AppColors.primary, width: 2),
                      boxShadow: AppColors.hardShadow(),
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

                  const Spacer(flex: 3),

                  // --- Bottom area: CTA buttons ---
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const WelcomeStartScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: AppColors.primary, width: 2),
                          boxShadow: AppColors.hardShadow(),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'MULAI SEKARANG',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                color: AppColors.onPrimary,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward,
                                color: AppColors.onPrimary),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () {
                        // TODO: arahkan ke halaman login
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: AppColors.primary, width: 2),
                          boxShadow: AppColors.hardShadow(),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sudah punya akun?',
                              style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Masuk',
                              style: TextStyle(
                                fontFamily: 'BeVietnamPro',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // --- Footer: feature badges ---
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: const [
                      _FeatureBadge(icon: Icons.bolt, label: 'AI Evaluasi'),
                      _FeatureBadge(
                        icon: Icons.menu_book,
                        label: '100% Gratis Dasar',
                      ),
                      _FeatureBadge(
                        icon: Icons.sports_esports,
                        label: 'Playful Game',
                      ),
                    ],
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

/// Badge kecil di footer, contoh: "⚡ AI Evaluasi".
class _FeatureBadge extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureBadge({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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

/// Background krem dengan pola titik-titik (dot grid).
class _DotGridPainter extends CustomPainter {
  const _DotGridPainter();

  static const double spacing = 20;
  static const double dotRadius = 1;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.welcomeDotGrid;
    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DotGridPainter oldDelegate) => false;
}