import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/unit_theme.dart';
import 'package:frontend/core/widgets/fade_in_slide.dart';
import 'package:frontend/features/home/presentation/home_screen.dart';

/// Model untuk satu pilihan jawaban pada tes penempatan.
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

/// Model untuk satu pertanyaan pada tes penempatan.
class PlacementQuestion {
  final String question;
  final String subtitle;
  final IconData mascotIcon;
  final List<PlacementOption> options;

  const PlacementQuestion({
    required this.question,
    required this.subtitle,
    this.mascotIcon = Icons.eco_rounded,
    required this.options,
  });
}

/// Model hasil evaluasi penempatan unit berdasarkan jawaban tes.
class PlacementResult {
  final int unitNumber;
  final String unitTitle;
  final String unitSubtitle;
  final String description;
  final String dailyGoalText;

  const PlacementResult({
    required this.unitNumber,
    required this.unitTitle,
    required this.unitSubtitle,
    required this.description,
    required this.dailyGoalText,
  });
}

/// Halaman tes penempatan (placement test) terpadu.
///
/// Menggunakan [PageView] internal agar transisi antar-pertanyaan
/// terjadi instan dan mulus (seperti Duolingo) tanpa jeda pergantian rute
/// ataupun reload halaman.
class PlacementTestQuestionScreen extends StatefulWidget {
  final List<PlacementQuestion>? questions;
  final int initialStep;

  /// Dipanggil setiap kali satu soal dijawab dan tombol "Lanjut" ditekan.
  final void Function(int step, int selectedIndex)? onStepAnswered;

  /// Kompatibilitas mundur untuk pemanggilan lama
  final void Function(int selectedIndex)? onNext;

  /// Dipanggil saat seluruh soal selesai dijawab.
  final void Function(List<int> selectedAnswers)? onCompleted;

  const PlacementTestQuestionScreen({
    super.key,
    this.questions,
    this.initialStep = 0,
    this.onStepAnswered,
    this.onNext,
    this.onCompleted,
  });

  @override
  State<PlacementTestQuestionScreen> createState() =>
      _PlacementTestQuestionScreenState();
}

class _PlacementTestQuestionScreenState
    extends State<PlacementTestQuestionScreen> {
  static const List<PlacementQuestion> _defaultQuestions = [
    // --- Soal 1: Sumber Informasi ---
    PlacementQuestion(
      question: 'Dari mana kamu mengetahui tentang Quri?',
      subtitle: 'Bantu kami mengetahui bagaimana kamu menemukan aplikasi ini.',
      mascotIcon: Icons.campaign_rounded,
      options: [
        PlacementOption(
          icon: Icons.public_rounded,
          label: 'Media Sosial (TikTok, Instagram, dll)',
        ),
        PlacementOption(
          icon: Icons.people_rounded,
          label: 'Teman atau Keluarga',
        ),
        PlacementOption(
          icon: Icons.travel_explore_rounded,
          label: 'Google / Play Store',
        ),
        PlacementOption(
          icon: Icons.school_rounded,
          label: 'Rekomendasi Guru / Ustadz',
        ),
        PlacementOption(
          icon: Icons.more_horiz_rounded,
          label: 'Lainnya',
        ),
      ],
    ),
    // --- Soal 2: Tingkat Kemampuan ---
    PlacementQuestion(
      question: "Seberapa jauh kemampuan membaca Al-Qur'an kamu saat ini?",
      subtitle: 'Pilih salah satu level yang paling menggambarkan kondisimu.',
      mascotIcon: Icons.eco_rounded,
      options: [
        PlacementOption(
          icon: Icons.eco_rounded,
          label: 'Belum kenal huruf hijaiyah sama sekali',
        ),
        PlacementOption(
          icon: Icons.spellcheck_rounded,
          label: 'Hafal huruf, belum bisa harakat & sambung',
        ),
        PlacementOption(
          icon: Icons.import_contacts_rounded,
          label: 'Bisa harakat dasar, belum lancar tanwin & sukun',
        ),
        PlacementOption(
          icon: Icons.graphic_eq_rounded,
          label: 'Bisa sukun & tanwin, belum lancar tasydid & mad',
        ),
        PlacementOption(
          icon: Icons.menu_book_rounded,
          label: 'Lancar baca kata, ingin belajar tajwid dasar (nun/mim mati)',
        ),
        PlacementOption(
          icon: Icons.workspace_premium_rounded,
          label:
              'Paham tajwid dasar, ingin tajwid lanjutan & kelancaran mushaf',
          iconBackgroundColor: AppColors.placementPremiumIconBg,
          iconColor: AppColors.tertiary,
        ),
      ],
    ),
    // --- Soal 3: Tujuan Belajar ---
    PlacementQuestion(
      question: 'Apa tujuan utama kamu belajar di Quri?',
      subtitle: 'Pilih salah satu agar kami bisa menyesuaikan materinya.',
      mascotIcon: Icons.flag_rounded,
      options: [
        PlacementOption(
          icon: Icons.auto_stories_rounded,
          label: "Bisa membaca Al-Qur'an dengan benar",
        ),
        PlacementOption(
          icon: Icons.graphic_eq_rounded,
          label: 'Memperbaiki bacaan & tajwid',
        ),
        PlacementOption(
          icon: Icons.groups_rounded,
          label: 'Mempersiapkan diri mengajarkan anak',
        ),
        PlacementOption(
          icon: Icons.mosque_rounded,
          label: 'Menjadikan rutinitas ibadah harian',
        ),
      ],
    ),
    // --- Soal 4: Target Harian ---
    PlacementQuestion(
      question: 'Berapa target waktu belajarmu setiap hari?',
      subtitle:
          'Konsistensi sedikit setiap hari lebih baik daripada banyak sekaligus.',
      mascotIcon: Icons.timer_rounded,
      options: [
        PlacementOption(
          icon: Icons.coffee_rounded,
          label: '5 menit / hari (Santai & konsisten)',
        ),
        PlacementOption(
          icon: Icons.directions_walk_rounded,
          label: '10 menit / hari (Cepat terbiasa)',
        ),
        PlacementOption(
          icon: Icons.directions_run_rounded,
          label: '15 menit / hari (Fokus & bertahap)',
        ),
        PlacementOption(
          icon: Icons.bolt_rounded,
          label: '20+ menit / hari (Komitmen tinggi)',
        ),
      ],
    ),
  ];

  late final List<PlacementQuestion> _questions;
  late final PageController _pageController;
  late final List<int?> _selectedAnswers;
  late int _currentStep;
  late double _prevProgress;

  @override
  void initState() {
    super.initState();
    _questions = widget.questions ?? _defaultQuestions;
    _currentStep = widget.initialStep.clamp(0, _questions.length - 1);
    _pageController = PageController(initialPage: _currentStep);
    _selectedAnswers = List<int?>.filled(_questions.length, null);
    _prevProgress = _currentStep / _questions.length;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleNext() {
    final selectedIdx = _selectedAnswers[_currentStep];
    if (selectedIdx == null) return;

    // Panggil callbacks
    widget.onStepAnswered?.call(_currentStep, selectedIdx);
    if (_currentStep == 0) {
      widget.onNext?.call(selectedIdx);
    }

    if (_currentStep < _questions.length - 1) {
      // Pindah ke soal berikutnya dengan animasi halus
      setState(() {
        _prevProgress = (_currentStep + 1) / _questions.length;
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOutCubic,
      );
    } else {
      // Selesai seluruh soal -> hitung hasil & tampilkan modal unit
      final result = _calculateResult(_selectedAnswers);
      _showResultModal(result);
    }
  }

  /// Menentukan unit pembelajaran awal dan target belajar berdasarkan jawaban.
  PlacementResult _calculateResult(List<int?> answers) {
    // Soal 2: Tingkat Kemampuan (Index 1)
    final abilityIndex = answers.length > 1 ? (answers[1] ?? 0) : 0;

    // Soal 4: Target Harian (Index 3)
    final goalIndex = answers.length > 3 ? (answers[3] ?? 1) : 1;
    final goalTexts = [
      '5 menit / hari',
      '10 menit / hari',
      '15 menit / hari',
      '20+ menit / hari',
    ];
    final dailyGoal = goalTexts[goalIndex.clamp(0, goalTexts.length - 1)];

    switch (abilityIndex) {
      case 1:
        return PlacementResult(
          unitNumber: 2,
          unitTitle: 'Unit 2: Harakat Dasar & Sambung Huruf',
          unitSubtitle: 'Fathah, kasrah, dhammah & bentuk sambung',
          description:
              'Bagus! Kamu sudah mengenal huruf hijaiyah. Kami menempatkanmu langsung di pembelajaran tanda baca harakat dan cara menyambung huruf.',
          dailyGoalText: dailyGoal,
        );
      case 2:
        return PlacementResult(
          unitNumber: 3,
          unitTitle: 'Unit 3: Tanwin & Sukun (Mati)',
          unitSubtitle: 'Tanda baca tanwin & huruf mati (sukun)',
          description:
              'Mantap! Kamu sudah memahami harakat dasar dan sambung huruf. Sekarang saatnya menguasai tanda tanwin dan cara membaca huruf sukun (mati).',
          dailyGoalText: dailyGoal,
        );
      case 3:
        return PlacementResult(
          unitNumber: 4,
          unitTitle: 'Unit 4: Tasydid & Mad (Bacaan Panjang)',
          unitSubtitle: 'Huruf bertasydid & ketukan mad dasar',
          description:
              'Hebat! Pemahaman dasarmu sudah baik. Di unit ini kamu akan memperdalam bacaan bertasydid dan aturan panjang-pendek bacaan (mad).',
          dailyGoalText: dailyGoal,
        );
      case 4:
        return PlacementResult(
          unitNumber: 5,
          unitTitle: 'Unit 5: Hukum Tajwid Dasar (Nun/Mim Mati & Ghunnah)',
          unitSubtitle: 'Hukum nun/mim sukun, ghunnah & ikhfa/idgham',
          description:
              'Luar biasa! Bacaanmu sudah mengalir. Kamu siap mendalami kaidah tajwid penting seperti nun/mim sukun, idgham, ikhfa, dan ghunnah agar semakin tartil.',
          dailyGoalText: dailyGoal,
        );
      case 5:
        return PlacementResult(
          unitNumber: 6,
          unitTitle: 'Unit 6: Tajwid Lanjutan & Kelancaran Mushaf',
          unitSubtitle: 'Waqaf, makhraj fasih & tilawah mushaf',
          description:
              'Istimewa! Kamu sudah menguasai tajwid dasar. Sekarang fokus pada kesempurnaan makhraj presisi, waqaf/ibtida, dan kelancaran membaca mushaf utuh.',
          dailyGoalText: dailyGoal,
        );
      case 0:
      default:
        return PlacementResult(
          unitNumber: 1,
          unitTitle: 'Unit 1: Huruf Hijaiyah Tunggal',
          unitSubtitle: 'Mengenal & melafalkan 29 huruf hijaiyah',
          description:
              'Awal yang tepat! Kita akan mulai dari nol: mengenali bentuk dan pelafalan huruf hijaiyah satu per satu dengan santai dan mudah dipahami.',
          dailyGoalText: dailyGoal,
        );
    }
  }

  /// Menampilkan popup kartu hasil penempatan sebelum masuk ke Home.
  void _showResultModal(PlacementResult result) {
    final unitTheme = UnitTheme.getTheme(result.unitNumber);

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 36),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            border: Border(
              top: BorderSide(color: AppColors.outlineDark, width: 2.5),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Badge Icon Trophy bertema Unit
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: unitTheme.primary.withValues(alpha: 0.15),
                  border: Border.all(color: unitTheme.primary, width: 2),
                ),
                child: Icon(
                  Icons.workspace_premium_rounded,
                  size: 38,
                  color: unitTheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Hasil Tes Penempatan',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.outlineDark,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Berdasarkan jawabanmu, kamu siap memulai dari:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.outlineDark.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 20),

              // Kartu Hasil Unit (Tema Warna Dinamis Sesuai Unit)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: unitTheme.primary,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.outlineDark, width: 2),
                  boxShadow: AppColors.solidShadow(offset: 4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: unitTheme.accent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'UNIT ${result.unitNumber}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: unitTheme.dark,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              size: 16,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              result.dailyGoalText,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      result.unitTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      result.unitSubtitle,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: unitTheme.accent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      result.description,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.45,
                        color: Colors.white.withValues(alpha: 0.92),
                      ),
                    ),
                  ],
                ),
              ),
              if (result.unitNumber > 1) ...[
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(14),
                    border:
                        Border.all(color: const Color(0xFFD97706), width: 1.5),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline_rounded,
                          size: 20, color: Color(0xFFD97706)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Materi Unit 1 (13 level) telah siap dipelajari! Sembari kurikulum unit lanjutan disiapkan, yuk mantapkan pemahamanmu dari Unit 1.',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF92400E),
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),

              // Tombol Mulai Belajar
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    final answers = _selectedAnswers.whereType<int>().toList();
                    widget.onCompleted?.call(answers);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(
                          startingUnit: 1,
                        ),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: unitTheme.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                      side: const BorderSide(
                        color: AppColors.outlineDark,
                        width: 2,
                      ),
                    ),
                  ),
                  child: const Text(
                    'MULAI BELAJAR',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final targetProgress = (_currentStep + 1) / _questions.length;
    final isAnswerSelected = _selectedAnswers[_currentStep] != null;
    final isLastStep = _currentStep == _questions.length - 1;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.welcomeBackground,
        body: SafeArea(
          child: Column(
            children: [
              // --- Header: Animated Progress Bar ---
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                          begin: _prevProgress,
                          end: targetProgress,
                        ),
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOutCubic,
                        builder: (context, animatedValue, child) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              value: animatedValue,
                              minHeight: 10,
                              backgroundColor: AppColors.placementBorder
                                  .withValues(alpha: 0.1),
                              valueColor: const AlwaysStoppedAnimation(
                                AppColors.placementActive,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${_currentStep + 1}/${_questions.length}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.placementBorder.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),

              // --- Content: Smooth PageView for questions ---
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _questions.length,
                  itemBuilder: (context, questionIndex) {
                    final question = _questions[questionIndex];
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          _MascotIcon(icon: question.mascotIcon),
                          const SizedBox(height: 16),
                          Text(
                            question.question,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              height: 1.25,
                              fontWeight: FontWeight.w800,
                              color: AppColors.placementBorder,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            question.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.placementBorder
                                  .withValues(alpha: 0.7),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ...List.generate(question.options.length, (optIndex) {
                            final option = question.options[optIndex];
                            final selected =
                                _selectedAnswers[questionIndex] == optIndex;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _OptionCard(
                                option: option,
                                selected: selected,
                                onTap: () {
                                  setState(() {
                                    _selectedAnswers[questionIndex] = optIndex;
                                  });
                                },
                              ),
                            );
                          }),
                          const SizedBox(height: 16),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // --- Bottom CTA ---
              FadeInSlide(
                delay: const Duration(milliseconds: 150),
                beginOffset: const Offset(0.0, 0.25),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: isAnswerSelected ? _handleNext : null,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: isAnswerSelected
                              ? AppColors.placementActive
                              : AppColors.placementActive
                                  .withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: AppColors.placementBorder,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            isLastStep ? 'Selesai' : 'Lanjut',
                            style: const TextStyle(
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
      ),
    );
  }
}

/// Ikon maskot bulat.
class _MascotIcon extends StatelessWidget {
  final IconData icon;

  const _MascotIcon({required this.icon});

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
      child: Icon(
        icon,
        size: 44,
        color: AppColors.placementActive,
      ),
    );
  }
}

/// Kartu pilihan opsi jawaban.
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
