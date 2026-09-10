import 'package:flutter/material.dart';

/// Kartu/tombol bergaya "chunky 3D": ada shadow solid di bawah yang
/// hilang + kontennya turun saat ditekan, khas desain tactile Quri.
class ChunkyPressable extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;
  final Color shadowColor;
  final BorderRadius borderRadius;
  final double shadowOffset;
  final VoidCallback? onTap;

  const ChunkyPressable({
    super.key,
    required this.child,
    required this.backgroundColor,
    required this.borderColor,
    required this.shadowColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.shadowOffset = 4,
    this.onTap,
  });

  @override
  State<ChunkyPressable> createState() => _ChunkyPressableState();
}

class _ChunkyPressableState extends State<ChunkyPressable> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onTap == null) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final disabled = widget.onTap == null;

    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 90),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(
          0,
          _pressed ? widget.shadowOffset : 0,
          0,
        ),
        decoration: BoxDecoration(
          color: disabled
              ? widget.backgroundColor.withValues(alpha: 0.5)
              : widget.backgroundColor,
          borderRadius: widget.borderRadius,
          border: Border.all(color: widget.borderColor, width: 2),
          boxShadow: _pressed || disabled
              ? []
              : [
                  BoxShadow(
                    color: widget.shadowColor,
                    offset: Offset(0, widget.shadowOffset),
                    blurRadius: 0,
                  ),
                ],
        ),
        child: widget.child,
      ),
    );
  }
}