import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:frontend/core/services/energy_service.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/widgets/fade_in_slide.dart';
import 'package:frontend/features/shop/presentation/shop_screen.dart';

/// Layar "Energi Harian Habis" — muncul sebagai modal bottom sheet
/// ketika pemain kehabisan energi saat akan memulai atau sedang latihan.
///
/// Fitur:
/// 1. Ikon petir animated dengan pengisian (vertical fill) disesuaikan dengan cooldown energi.
/// 2. Countdown timer real-time sinkron dengan [EnergyService].
/// 3. Status dinamis: ketika full (100%) vs dalam cooldown (charging).
/// 4. Opsi aksi: Tunggu isi ulang, Isi ulang dengan Quri (shop), atau Paket Premium.
class OutOfEnergySheet extends StatefulWidget {
  /// Countdown teks awal sampai energi berikutnya tersedia (mis. "28:45").
  final String? countdownText;

  /// Dipanggil ketika user memilih "Tunggu Isi Ulang" / "Lanjut Belajar".
  final VoidCallback? onWait;

  /// Service energi opsional jika parent sudah memiliki instance aktif.
  final EnergyService? energyService;

  /// Energi saat ini (opsional).
  final int? currentEnergy;

  /// Energi maksimum (opsional, default 20).
  final int? maxEnergy;

  const OutOfEnergySheet({
    super.key,
    this.countdownText,
    this.onWait,
    this.energyService,
    this.currentEnergy,
    this.maxEnergy,
  });

  /// Tampilkan sebagai modal bottom sheet dari luar.
  static Future<void> show(
    BuildContext context, {
    String? countdownText,
    VoidCallback? onWait,
    EnergyService? energyService,
    int? currentEnergy,
    int? maxEnergy,
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
        energyService: energyService,
        currentEnergy: currentEnergy,
        maxEnergy: maxEnergy,
      ),
    );
  }

  @override
  State<OutOfEnergySheet> createState() => _OutOfEnergySheetState();
}

class _OutOfEnergySheetState extends State<OutOfEnergySheet>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  late final AnimationController _entranceController;
  late final Animation<double> _entranceAnimation;

  late final AnimationController _shimmerController;

  EnergyService? _energyService;
  Timer? _cooldownTimer;
  bool _isDisposed = false;

  bool _isFull = false;
  double _targetProgress = 0.0;
  String _countdownText = '';

  @override
  void initState() {
    super.initState();

    // 1. Animasi pulsing breathing glow saat charging
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.07).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // 2. Animasi entrance pengisian petir dari 0 ke target cooldown
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _entranceAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );

    // 3. Shimmer / spark twinkles
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();

    // Inisialisasi progress awal dari widget parameter jika ada
    _initInitialState();

    // Sinkronisasi dengan EnergyService
    _setupEnergyService();

    // Jalankan animasi entrance
    _entranceController.forward(from: 0.0);
  }

  void _initInitialState() {
    final cur = widget.currentEnergy;
    final max = widget.maxEnergy ?? 20;

    if (cur != null && cur >= max) {
      _isFull = true;
      _targetProgress = 1.0;
      _countdownText = '';
      return;
    }

    _countdownText = widget.countdownText ?? '';
    if (_countdownText.isNotEmpty) {
      final parts = _countdownText.split(':');
      if (parts.length == 2) {
        final m = int.tryParse(parts[0]) ?? 0;
        final s = int.tryParse(parts[1]) ?? 0;
        final remainingSec = m * 60 + s;
        const totalSec = 60 * 60; // default 60 menit
        final elapsed = (totalSec - remainingSec).clamp(0, totalSec);
        _targetProgress = (elapsed / totalSec).clamp(0.0, 1.0);
      }
    }
  }

  Future<void> _setupEnergyService() async {
    if (widget.energyService != null) {
      _energyService = widget.energyService;
    } else {
      final service = EnergyService();
      await service.init();
      if (!mounted || _isDisposed) return;
      if (widget.currentEnergy != null) {
        service.setEnergy(widget.currentEnergy!);
      }
      _energyService = service;
    }

    if (!mounted || _isDisposed) return;
    _refreshEnergy();

    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && !_isDisposed) _refreshEnergy();
    });
  }

  void _refreshEnergy() {
    if (_isDisposed || !mounted) return;
    final service = _energyService;
    if (service == null) return;

    final current = service.getCurrentEnergy();
    final max = service.maxEnergy;
    final remaining = service.getTimeToNextRegen();
    final totalMs = service.regenIntervalMinutes * 60 * 1000;

    if (current >= max) {
      if (!_isFull || _targetProgress != 1.0) {
        setState(() {
          _isFull = true;
          _targetProgress = 1.0;
          _countdownText = '';
        });
      }
    } else if (remaining != null) {
      final remainingMs = remaining.inMilliseconds;
      final elapsedMs = (totalMs - remainingMs).clamp(0, totalMs);
      final p = (elapsedMs / totalMs).clamp(0.0, 1.0);

      final totalSec = remaining.inSeconds;
      final m = (totalSec ~/ 60).toString().padLeft(2, '0');
      final s = (totalSec % 60).toString().padLeft(2, '0');
      final newText = '$m:$s';

      if (_isFull || (_targetProgress - p).abs() > 0.001 || _countdownText != newText) {
        setState(() {
          _isFull = false;
          _targetProgress = p;
          _countdownText = newText;
        });
      }
    } else {
      // Belum ada cooldown timestamp (baru saja 0)
      if (_isFull || _targetProgress != 0.0) {
        setState(() {
          _isFull = false;
          _targetProgress = 0.0;
        });
      }
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _cooldownTimer?.cancel();
    _pulseController.dispose();
    _entranceController.dispose();
    _shimmerController.dispose();
    super.dispose();
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
          const SizedBox(height: 22),

          // ── Lightning bolt icon dengan animasi terisi sesuai cooldown ──
          FadeInSlide(
            delay: const Duration(milliseconds: 100),
            withScale: true,
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _pulseAnimation,
                _entranceAnimation,
                _shimmerController,
              ]),
              builder: (context, _) {
                final displayProgress = _isFull
                    ? 1.0
                    : (_targetProgress * _entranceAnimation.value).clamp(0.0, 1.0);

                return _LightningBoltEnergyView(
                  progress: displayProgress,
                  isFull: _isFull,
                  pulseScale: _pulseAnimation.value,
                  shimmerValue: _shimmerController.value,
                );
              },
            ),
          ),
          const SizedBox(height: 14),

          // ── Badge status cooldown / persentase ──
          FadeInSlide(
            delay: const Duration(milliseconds: 200),
            child: AnimatedBuilder(
              animation: _entranceAnimation,
              builder: (context, _) {
                final displayProgress = _isFull
                    ? 1.0
                    : (_targetProgress * _entranceAnimation.value).clamp(0.0, 1.0);

                final percent = (displayProgress * 100).toInt().clamp(0, 100);

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: _isFull
                        ? AppColors.nodeCompleted.withValues(alpha: 0.12)
                        : AppColors.energyYellow.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _isFull
                          ? AppColors.nodeCompleted
                          : AppColors.energyYellow,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _isFull
                            ? Icons.check_circle_rounded
                            : Icons.bolt_rounded,
                        size: 16,
                        color: _isFull
                            ? AppColors.nodeCompleted
                            : AppColors.energyYellow,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _isFull
                            ? 'Energi Sudah Terisi Penuh!'
                            : (_countdownText.isNotEmpty
                                ? 'Isi ulang +1: $_countdownText  •  $percent%'
                                : (widget.countdownText != null && widget.countdownText!.isNotEmpty
                                    ? 'Isi ulang +1: ${widget.countdownText}  •  $percent%'
                                    : 'Sedang mengisi ulang  •  $percent%')),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: _isFull
                              ? AppColors.nodeCompleted
                              : AppColors.outlineDark,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 14),

          // Title
          FadeInSlide(
            delay: const Duration(milliseconds: 260),
            child: Text(
              _isFull
                  ? 'Energi Kamu Sudah Penuh!'
                  : 'Energi Harian Kamu Habis!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.outlineDark,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          FadeInSlide(
            delay: const Duration(milliseconds: 320),
            child: Text(
              _isFull
                  ? 'Semua energi hafalanmu sudah siap digunakan.\nYuk lanjutkan petualangan belajarmu!'
                  : 'Istirahat sejenak agar ingatan hafalanmu makin\nkuat, atau isi ulang energimu untuk lanjut belajar.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 26),

          // ── Button 1: Tunggu Isi Ulang / Lanjut Belajar ──
          FadeInSlide(
            delay: const Duration(milliseconds: 400),
            beginOffset: const Offset(0.0, 0.3),
            child: _isFull
                ? _FilledButton(
                    backgroundColor: AppColors.nodeCompleted,
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onWait?.call();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_arrow_rounded,
                            color: Colors.white, size: 22),
                        SizedBox(width: 8),
                        Text(
                          'Lanjut Belajar Sekarang',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                : _OutlineButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onWait?.call();
                    },
                    borderColor: AppColors.energyYellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.access_time_rounded,
                            color: AppColors.outlineDark, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          _countdownText.isNotEmpty
                              ? 'Tunggu Isi Ulang ($_countdownText)'
                              : (widget.countdownText != null &&
                                      widget.countdownText!.isNotEmpty
                                  ? 'Tunggu Isi Ulang (${widget.countdownText})'
                                  : 'Tunggu Isi Ulang'),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppColors.outlineDark,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          const SizedBox(height: 12),

          // ── Button 2: Isi Ulang dengan Quri (navigasi ke ShopScreen) ──
          FadeInSlide(
            delay: const Duration(milliseconds: 480),
            beginOffset: const Offset(0.0, 0.3),
            child: _FilledButton(
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
          ),
          const SizedBox(height: 12),

          // ── Button 3: Buka Unlimited Energi dengan Paket Premium ──
          FadeInSlide(
            delay: const Duration(milliseconds: 560),
            beginOffset: const Offset(0.0, 0.3),
            child: _FilledButton(
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
                  Flexible(
                    child: Text(
                      'Buka Unlimited Energi dengan Paket Premium',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: AppColors.outlineDark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Lightning bolt energy view dengan circular cooldown ring & vertical fill
// ─────────────────────────────────────────────────────────────────────────────

class _LightningBoltEnergyView extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final bool isFull;
  final double pulseScale;
  final double shimmerValue;

  const _LightningBoltEnergyView({
    required this.progress,
    required this.isFull,
    required this.pulseScale,
    required this.shimmerValue,
  });

  @override
  Widget build(BuildContext context) {
    const double containerSize = 84;
    const double iconSize = 52;

    final baseColor = isFull ? AppColors.nodeCompleted : AppColors.energyYellow;

    return ScaleTransition(
      scale: AlwaysStoppedAnimation(pulseScale),
      child: Container(
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(
          color: baseColor.withValues(alpha: 0.10),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: baseColor.withValues(alpha: isFull ? 0.25 : 0.18),
              blurRadius: 16,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Circular cooldown progress ring
            Positioned.fill(
              child: CustomPaint(
                painter: _CircularCooldownPainter(
                  progress: progress,
                  isFull: isFull,
                  activeColor: baseColor,
                ),
              ),
            ),

            // Petir (Lightning Bolt)
            SizedBox(
              width: iconSize,
              height: iconSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 1. Background empty bolt (transparan/redup)
                  Icon(
                    Icons.bolt_rounded,
                    size: iconSize,
                    color: AppColors.energyYellow.withValues(alpha: 0.22),
                  ),

                  // 2. Filled bolt: terisi dari bawah ke atas sesuai progress cooldown
                  if (progress > 0.0)
                    ClipRect(
                      clipper: _VerticalFillClipper(progress),
                      child: ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: isFull
                                ? const [
                                    Color(0xFF059669),
                                    Color(0xFF10B981),
                                    Color(0xFF6EE7B7),
                                  ]
                                : const [
                                    Color(0xFFFF8F00), // Amber tebal
                                    Color(0xFFFFC107), // Energy yellow
                                    Color(0xFFFFF9C4), // Puncak terang
                                  ],
                          ).createShader(bounds);
                        },
                        child: const Icon(
                          Icons.bolt_rounded,
                          size: iconSize,
                          color: Colors.white,
                        ),
                      ),
                    ),

                  // 3. Efek garis gelombang energi (meniscus / charge line) di batas pengisian
                  if (progress > 0.03 && progress < 0.98)
                    Positioned(
                      top: (iconSize * (1.0 - progress)).clamp(0.0, iconSize - 3),
                      left: 10,
                      right: 10,
                      child: Container(
                        height: 2.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          gradient: const LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white,
                              Color(0xFFFFF59D),
                              Colors.transparent,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFFE082).withValues(alpha: 0.9),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // 4. Floating micro sparks saat dalam proses pengisian
            if (!isFull && progress > 0.0)
              Positioned(
                right: 12 + 3 * math.sin(shimmerValue * 2 * math.pi),
                top: 10 + 2 * math.cos(shimmerValue * 2 * math.pi),
                child: Opacity(
                  opacity: 0.5 + 0.5 * math.sin(shimmerValue * 2 * math.pi).abs(),
                  child: const Icon(
                    Icons.auto_awesome,
                    size: 11,
                    color: AppColors.energyYellow,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Clipper untuk memotong icon petir secara vertikal dari bawah ke atas
// ─────────────────────────────────────────────────────────────────────────────

class _VerticalFillClipper extends CustomClipper<Rect> {
  final double progress; // 0.0 s/d 1.0

  const _VerticalFillClipper(this.progress);

  @override
  Rect getClip(Size size) {
    final clamped = progress.clamp(0.0, 1.0);
    final top = size.height * (1.0 - clamped);
    return Rect.fromLTRB(0, top, size.width, size.height);
  }

  @override
  bool shouldReclip(_VerticalFillClipper oldClipper) =>
      oldClipper.progress != progress;
}

// ─────────────────────────────────────────────────────────────────────────────
// Painter untuk circular cooldown ring di sekeliling ikon petir
// ─────────────────────────────────────────────────────────────────────────────

class _CircularCooldownPainter extends CustomPainter {
  final double progress;
  final bool isFull;
  final Color activeColor;

  const _CircularCooldownPainter({
    required this.progress,
    required this.isFull,
    required this.activeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 4.5;

    // Lingkaran track belakang
    final trackPaint = Paint()
      ..color = activeColor.withValues(alpha: 0.16)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;
    canvas.drawCircle(center, radius, trackPaint);

    // Arc pengisian sesuai progress cooldown
    if (progress > 0.0) {
      final clamped = progress.clamp(0.0, 1.0);
      final sweepAngle = 2 * math.pi * clamped;

      final progressPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round;

      if (isFull) {
        progressPaint.color = activeColor;
      } else {
        progressPaint.shader = SweepGradient(
          startAngle: -math.pi / 2,
          endAngle: 3 * math.pi / 2,
          colors: const [
            Color(0xFFFFB300),
            Color(0xFFFF8F00),
            Color(0xFFFFD54F),
            Color(0xFFFFB300),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      }

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_CircularCooldownPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.isFull != isFull ||
        oldDelegate.activeColor != activeColor;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helper buttons
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
