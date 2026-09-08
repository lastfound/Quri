import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/widgets/fade_in_slide.dart';

/// Satu pilihan jawaban di layar tes penempatan.
class PlacementOption {
  final IconData icon;
  final Color iconBackgroundColor;
  final Color iconColor;
  final String label;

  const PlacementOption({
    required this.icon,
    required this.label,
    this.iconBackgroundColor = AppColors.placementOptionIconBg,
    this.iconColor = AppColors.placementActive,
  });
}

/// Halaman soal tes penempatan (placement test).
///
/// Dibuat reusable (bukan cuma soal ke-1) — tinggal isi [question],
/// [options], [currentStep], dan [totalSteps] untuk soal berikutnya.
class PlacementTestQuestionScreen extends StatefulWidget {
  final String question;
  final String subtitle;
  final List<PlacementOption> options;
  final int currentStep;
  final int totalSteps;

  /// Dipanggil saat tombol "Lanjut" ditekan, membawa index opsi terpilih.
  final void Function(int selectedIndex)? onNext;

  static const List<PlacementOption> _defaultOptions = [
    PlacementOption(
      icon: Icons.eco_rounded,
      label: 'Belum bisa sama sekali',
    ),
    PlacementOption(
      icon: Icons.import_contacts_rounded,
      label: 'Bisa dikit-dikit',
    ),
    PlacementOption(
      icon: Icons.menu_book_rounded,
      label: 'Sudah lumayan lancar',
    ),
    PlacementOption(
      icon: Icons.workspace_premium_rounded,
      label: 'Sudah lancar, mau perdalam tajwid',
      iconBackgroundColor: AppColors.placementPremiumIconBg,
      iconColor: AppColors.tertiary,
    ),
  ];

  const PlacementTestQuestionScreen({
    super.key,
    this.question = "Seberapa jauh kemampuan membaca Al-Qur'an kamu saat ini?",
    this.subtitle = 'Pilih salah satu level yang paling menggambarkan kondisimu.',
    this.options = _defaultOptions,
    this.currentStep = 1,
    this.totalSteps = 3,
    this.onNext,
  });

  @override
  State<PlacementTestQuestionScreen> createState() =>
      _PlacementTestQuestionScreenState();
}

class _PlacementTestQuestionScreenState
    extends State<PlacementTestQuestionScreen> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final progress = widget.currentStep / widget.totalSteps;

    return Scaffold(
      backgroundColor: AppColors.welcomeBackground,
      body: SafeArea(
        child: Column(
          children: [
            // --- Header: back button + progress bar ---
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
              child: Row(
                children: [
                  _BackButton(onTap: () => Navigator.of(context).maybePop()),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor:
                            AppColors.placementBorder.withValues(alpha: 0.1),
                        valueColor: const AlwaysStoppedAnimation(
                          AppColors.placementActive,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${widget.currentStep}/${widget.totalSteps}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.placementBorder.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),

            // --- Scrollable content ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    FadeInSlide(
                      delay: const Duration(milliseconds: 60),
                      withScale: true,
                      child: _MascotIcon(),
                    ),
                    const SizedBox(height: 16),
                    FadeInSlide(
                      delay: const Duration(milliseconds: 140),
                      child: Column(
                        children: [
                          Text(
                            widget.question,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 26,
                              height: 1.25,
                              fontWeight: FontWeight.w800,
                              color: AppColors.placementBorder,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.placementBorder
                                  .withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    ...List.generate(widget.options.length, (index) {
                      final option = widget.options[index];
                      final selected = _selectedIndex == index;
                      return FadeInSlide(
                        delay: Duration(milliseconds: 200 + index * 60),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _OptionCard(
                            option: option,
                            selected: selected,
                            onTap: () => setState(() => _selectedIndex = index),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // --- Bottom CTA ---
            FadeInSlide(
              delay: const Duration(milliseconds: 440),
              beginOffset: const Offset(0.0, 0.35),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(999),
                    onTap: _selectedIndex == null
                        ? null
                        : () => widget.onNext?.call(_selectedIndex!),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: _selectedIndex == null
                            ? AppColors.placementActive.withValues(alpha: 0.4)
                            : AppColors.placementActive,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: AppColors.placementBorder,
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Lanjut',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.8),
            border: Border.all(
              color: AppColors.placementBorder.withValues(alpha: 0.15),
            ),
          ),
          child: const Icon(
            Icons.arrow_back,
            size: 20,
            color: AppColors.placementBorder,
          ),
        ),
      ),
    );
  }
}

/// Ikon maskot bulat. Disederhanakan jadi ikon daun di dalam lingkaran —
/// ganti dengan asset SVG/PNG maskot asli kamu kalau sudah tersedia.
class _MascotIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.placementMascotBg,
        border: Border.all(color: AppColors.placementBorder, width: 2),
      ),
      child: const Icon(
        Icons.eco_rounded,
        size: 44,
        color: AppColors.placementActive,
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final PlacementOption option;
  final bool selected;
  final VoidCallback onTap;

  const _OptionCard({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: selected ? AppColors.placementActive : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.placementBorder, width: 2),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected
                      ? Colors.white.withValues(alpha: 0.2)
                      : option.iconBackgroundColor,
                ),
                child: Icon(
                  option.icon,
                  size: 20,
                  color: selected ? Colors.white : option.iconColor,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  option.label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: selected ? FontWeight.bold : FontWeight.w600,
                    color: selected ? Colors.white : AppColors.placementBorder,
                  ),
                ),
              ),
              if (selected)
                const Icon(Icons.check_circle, color: Colors.white, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}