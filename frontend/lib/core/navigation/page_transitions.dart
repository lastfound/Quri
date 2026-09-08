import 'package:flutter/material.dart';

/// Builder transisi halaman global dengan efek geser halus (slide) + fade.
class SmoothPageTransitionsBuilder extends PageTransitionsBuilder {
  const SmoothPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    final secondaryCurvedAnimation = CurvedAnimation(
      parent: secondaryAnimation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    // Halaman baru masuk dari kanan dengan sedikit fade
    final inTransition = SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(curvedAnimation),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.3, end: 1.0).animate(curvedAnimation),
        child: child,
      ),
    );

    // Halaman yang sedang aktif sedikit bergeser ke kiri dan memudar saat halaman baru masuk
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(-0.25, 0.0),
      ).animate(secondaryCurvedAnimation),
      child: inTransition,
    );
  }
}

/// Arah pergeseran untuk [AppPageRoute].
enum SlideDirection {
  fromRight,
  fromLeft,
  fromBottom,
  fadeScale,
}

/// Custom Route Builder untuk transisi halaman yang fleksibel dan mulus.
class AppPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final SlideDirection direction;
  final Duration transitionDurationCustom;

  AppPageRoute({
    required this.page,
    this.direction = SlideDirection.fromRight,
    this.transitionDurationCustom = const Duration(milliseconds: 320),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: transitionDurationCustom,
          reverseTransitionDuration: transitionDurationCustom,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );

            if (direction == SlideDirection.fadeScale) {
              return FadeTransition(
                opacity: curvedAnimation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.94, end: 1.0)
                      .animate(curvedAnimation),
                  child: child,
                ),
              );
            }

            Offset beginOffset;
            switch (direction) {
              case SlideDirection.fromBottom:
                beginOffset = const Offset(0.0, 1.0);
                break;
              case SlideDirection.fromLeft:
                beginOffset = const Offset(-1.0, 0.0);
                break;
              case SlideDirection.fromRight:
              default:
                beginOffset = const Offset(1.0, 0.0);
                break;
            }

            final slideIn = SlideTransition(
              position: Tween<Offset>(
                begin: beginOffset,
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.2, end: 1.0)
                    .animate(curvedAnimation),
                child: child,
              ),
            );

            // Efek parallax mundur untuk halaman sebelumnya
            final secondaryCurved = CurvedAnimation(
              parent: secondaryAnimation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );

            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(-0.2, 0.0),
              ).animate(secondaryCurved),
              child: slideIn,
            );
          },
        );
}
