import 'package:flutter/material.dart';

/// Widget pembungkus untuk animasi masuk (entrance animation) bertahap (*staggered*).
/// Elemen akan meluncur halus dari arah offset dan memudar masuk (fade in).
class FadeInSlide extends StatefulWidget {
  final Widget child;

  /// Jeda waktu sebelum animasi dimulai (misal: 100ms, 200ms, dst).
  final Duration delay;

  /// Durasi animasi berjalan.
  final Duration duration;

  /// Posisi awal sebelum elemen berada di posisi normal (default meluncur dari bawah sedikit).
  final Offset beginOffset;

  /// Kurva easing animasi.
  final Curve curve;

  /// Apakah menyertakan efek scale sedikit (misal dari 0.95 ke 1.0) agar terasa tactile & pop.
  final bool withScale;

  const FadeInSlide({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 400),
    this.beginOffset = const Offset(0.0, 0.25),
    this.curve = Curves.easeOutCubic,
    this.withScale = false,
  });

  @override
  State<FadeInSlide> createState() => _FadeInSlideState();
}

class _FadeInSlideState extends State<FadeInSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double>? _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final curved = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
    _slideAnimation = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(curved);

    if (widget.withScale) {
      _scaleAnimation = Tween<double>(begin: 0.94, end: 1.0).animate(curved);
    } else {
      _scaleAnimation = null;
    }

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget animated = SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: widget.child,
      ),
    );

    if (_scaleAnimation != null) {
      animated = ScaleTransition(
        scale: _scaleAnimation!,
        child: animated,
      );
    }

    return animated;
  }
}
