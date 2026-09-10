import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/core/theme/unit_theme.dart';
import 'package:frontend/features/exercise/data/models/exercise_model.dart';
import 'widgets/chunky_pressable.dart';

/// Halaman soal latihan di dalam pelajaran.
///
/// Menggunakan [PageView] internal agar transisi antar-soal terjadi
/// instan dan mulus (seperti Duolingo) tanpa jeda pergantian rute.
/// Warna otomatis mengikuti [unitNumber] lewat [UnitTheme].
class ExerciseQuestionScreen extends StatefulWidget {
  /// Daftar soal untuk level ini.
  final List<ExerciseQuestion> questions;

  /// Judul level (ditampilkan di banner atas).
  final String levelTitle;

  /// Nomor unit aktif — menentukan tema warna (1–6).
  final int unitNumber;

  /// XP reward saat menyelesaikan seluruh soal.
  final int xpReward;

  final int streak;
  final int gems;
  final int energy;
  final int energyMax;

  final VoidCallback? onClose;
  final ValueChanged<int>? onEnergyChanged;

  /// Dipanggil saat seluruh soal selesai, membawa jumlah jawaban benar.
  final void Function(int correctCount, int totalCount)? onCompleted;

  const ExerciseQuestionScreen({
    super.key,
    required this.questions,
    this.levelTitle = 'Latihan',
    this.unitNumber = 1,
    this.xpReward = 20,
    this.streak = 0,
    this.gems = 50,
    this.energy = 20,
    this.energyMax = 20,
    this.onClose,
    this.onEnergyChanged,
    this.onCompleted,
  });

  @override
  State<ExerciseQuestionScreen> createState() =>
      _ExerciseQuestionScreenState();
}

class _ExerciseQuestionScreenState extends State<ExerciseQuestionScreen> {
  late final PageController _pageController;
  late final List<ExerciseQuestion> _shuffledQuestions;
  late final List<int?> _selectedAnswers;
  late int _currentEnergy;
  int _currentStep = 0;
  double _prevProgress = 0.0;
  int _correctCount = 0;

  /// Status feedback per soal: null = belum dijawab, true = benar, false = salah.
  bool? _currentFeedback;
  bool _isProcessingAnswer = false;
  Timer? _autoAdvanceTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentEnergy = widget.energy;

    // Acak posisi pilihan ganda agar jawaban benar tidak selalu di opsi pertama (A)
    final random = Random();
    _shuffledQuestions = widget.questions.map((q) {
      final originalCorrect = q.options[q.correctOptionIndex];
      final shuffledOptions = List<String>.from(q.options)..shuffle(random);
      final newCorrectIndex = shuffledOptions.indexOf(originalCorrect);
      return ExerciseQuestion(
        questionText: q.questionText,
        visualPrompt: q.visualPrompt,
        audioPath: q.audioPath,
        options: shuffledOptions,
        correctOptionIndex: newCorrectIndex,
      );
    }).toList();

    _selectedAnswers = List<int?>.filled(_shuffledQuestions.length, null);
  }

  @override
  void dispose() {
    _autoAdvanceTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  /// Dialog saat energi pemain habis (0).
  void _showOutOfEnergyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.outlineDark, width: 2),
        ),
        title: const Row(
          children: [
            Icon(Icons.bolt_rounded, color: AppColors.energyYellow, size: 28),
            SizedBox(width: 8),
            Text(
              'Energi Habis!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: AppColors.outlineDark,
              ),
            ),
          ],
        ),
        content: const Text(
          'Energi kamu sudah habis (0/20). Istirahat sejenak atau kembali ke beranda untuk mengisi energi.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text(
              'Kembali ke Beranda',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.teal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Dipanggil langsung ketika pengguna mengetuk salah satu opsi jawaban.
  void _onOptionSelected(int questionIndex, int selectedIndex) {
    if (_isProcessingAnswer || _currentFeedback != null) return;

    // Cek ketersediaan energi
    if (_currentEnergy <= 0) {
      _showOutOfEnergyDialog();
      return;
    }

    final question = _shuffledQuestions[questionIndex];
    final isCorrect = selectedIndex == question.correctOptionIndex;

    setState(() {
      _currentEnergy = (_currentEnergy - 1).clamp(0, widget.energyMax);
      _isProcessingAnswer = true;
      _selectedAnswers[questionIndex] = selectedIndex;
      _currentFeedback = isCorrect;
      if (isCorrect) {
        _correctCount++;
      }
    });

    // Notifikasi perubahan energi ke parent (misal HomeScreen)
    widget.onEnergyChanged?.call(_currentEnergy);

    // Otomatis lanjut ke soal berikutnya:
    // Jika benar: jeda 800ms
    // Jika salah: jeda 1800ms agar sempat melihat jawaban yang benar (hijau) & salah (merah)
    final delayMs = isCorrect ? 800 : 1800;
    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = Timer(Duration(milliseconds: delayMs), () {
      if (mounted && _isProcessingAnswer) {
        _advanceNext();
      }
    });
  }

  void _advanceNext() {
    _autoAdvanceTimer?.cancel();
    _autoAdvanceTimer = null;
    _isProcessingAnswer = false;
    _handleNext();
  }

  void _handleNext() {
    if (_currentStep < _shuffledQuestions.length - 1) {
      setState(() {
        _prevProgress = (_currentStep + 1) / _shuffledQuestions.length;
        _currentStep++;
        _currentFeedback = null;
        _isProcessingAnswer = false;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOutCubic,
      );
    } else {
      // Selesai → tampilkan hasil
      _showResultModal();
    }
  }

  void _showResultModal() {
    final unitTheme = UnitTheme.getTheme(widget.unitNumber);
    final total = _shuffledQuestions.length;
    final percent = (_correctCount / total * 100).round();
    final passed = percent >= 70;

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
              // Icon hasil
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (passed ? unitTheme.primary : AppColors.heartRed)
                      .withValues(alpha: 0.15),
                  border: Border.all(
                    color: passed ? unitTheme.primary : AppColors.heartRed,
                    width: 2,
                  ),
                ),
                child: Icon(
                  passed
                      ? Icons.emoji_events_rounded
                      : Icons.refresh_rounded,
                  size: 38,
                  color: passed ? unitTheme.primary : AppColors.heartRed,
                ),
              ),
              const SizedBox(height: 16),

              Text(
                passed ? 'Level Selesai! 🎉' : 'Coba Lagi! 💪',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.outlineDark,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                'Kamu menjawab $_correctCount dari $total soal dengan benar ($percent%)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.outlineDark.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 12),

              if (passed) ...[
                // XP reward
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: unitTheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: unitTheme.primary, width: 1.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.stars_rounded,
                          color: AppColors.starGold, size: 22),
                      const SizedBox(width: 8),
                      Text(
                        '+${widget.xpReward} XP',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: unitTheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Tombol aksi
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(modalContext).pop();
                    if (passed) {
                      widget.onCompleted?.call(_correctCount, total);
                      Navigator.of(context).pop();
                    } else {
                      // Reset dan mulai ulang
                      setState(() {
                        _currentStep = 0;
                        _correctCount = 0;
                        _currentFeedback = null;
                        _prevProgress = 0.0;
                        _selectedAnswers.fillRange(
                            0, _selectedAnswers.length, null);
                      });
                      _pageController.jumpToPage(0);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        passed ? unitTheme.primary : AppColors.heartRed,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                      side: const BorderSide(
                        color: AppColors.outlineDark,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    passed ? 'LANJUT' : 'ULANGI LEVEL',
                    style: const TextStyle(
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
    final unitTheme = UnitTheme.getTheme(widget.unitNumber);
    final targetProgress = (_currentStep + 1) / _shuffledQuestions.length;
    final isLastStep = _currentStep == _shuffledQuestions.length - 1;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.welcomeBackground,
        body: SafeArea(
          child: Column(
            children: [
              // --- Header: close + progress + stats ---
              _buildHeader(unitTheme, targetProgress),

              // --- Content: PageView soal ---
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _shuffledQuestions.length,
                  itemBuilder: (context, questionIndex) {
                    final question = _shuffledQuestions[questionIndex];
                    return SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                      child: _buildQuestionCard(
                          unitTheme, question, questionIndex),
                    );
                  },
                ),
              ),

              // --- Bottom: feedback bar + CTA ---
              _buildBottomSection(unitTheme, isLastStep),
            ],
          ),
        ),
      ),
    );
  }

  /// Header: close button + animated progress bar + stat badges.
  Widget _buildHeader(UnitTheme unitTheme, double targetProgress) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Row(
            children: [
              // Close button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () => _showExitConfirmation(unitTheme),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.outlineDark.withValues(alpha: 0.2),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(Icons.close,
                        color: AppColors.outlineDark, size: 20),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Animated progress bar
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
                        backgroundColor:
                            AppColors.quizCardBorder.withValues(alpha: 0.4),
                        valueColor:
                            AlwaysStoppedAnimation(unitTheme.primary),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),

              // Counter
              Text(
                '${_currentStep + 1}/${_shuffledQuestions.length}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.outlineDark.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),

        // Stat badges row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _StatBadge(
                icon: Icons.local_fire_department_rounded,
                iconColor: AppColors.streakOrange,
                value: '${widget.streak}',
              ),
              const SizedBox(width: 8),
              _StatBadge(
                icon: Icons.diamond_rounded,
                iconColor: AppColors.gemBlue,
                value: '${widget.gems}',
              ),
              const SizedBox(width: 8),
              _StatBadge(
                icon: Icons.bolt_rounded,
                iconColor: AppColors.energyYellow,
                value: '$_currentEnergy/${widget.energyMax}',
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Kartu soal: pertanyaan, prompt Arab (opsional), opsi jawaban.
  Widget _buildQuestionCard(
      UnitTheme unitTheme, ExerciseQuestion question, int questionIndex) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.quizCardBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outlineDark, width: 2),
        boxShadow: AppColors.solidShadow(offset: 4),
      ),
      child: Column(
        children: [
          // Teks pertanyaan
          Text(
            question.questionText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              height: 1.3,
              color: AppColors.outlineDark,
            ),
          ),

          // Prompt huruf Arab (jika ada)
          if (question.visualPrompt != null) ...[
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28),
              decoration: BoxDecoration(
                color: AppColors.welcomeBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.outlineDark, width: 2),
              ),
              child: Center(
                child: Text(
                  question.visualPrompt!,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 56,
                    height: 1,
                    fontWeight: FontWeight.bold,
                    color: unitTheme.primary,
                  ),
                ),
              ),
            ),
          ],

          const SizedBox(height: 20),

          // Opsi jawaban
          ...List.generate(question.options.length, (index) {
            final selected = _selectedAnswers[questionIndex] == index;
            final bool showCorrect = _currentFeedback != null &&
                index == question.correctOptionIndex;
            final bool showWrong = _currentFeedback == false &&
                selected &&
                index != question.correctOptionIndex;

            Color bgColor;
            Color borderColor;
            Color shadowColor;
            Color textColor;

            if (showCorrect) {
              bgColor = const Color(0xFF22C55E);
              borderColor = const Color(0xFF15803D);
              shadowColor = const Color(0xFF15803D);
              textColor = Colors.white;
            } else if (showWrong) {
              bgColor = AppColors.heartRed;
              borderColor = const Color(0xFF991B1B);
              shadowColor = const Color(0xFF991B1B);
              textColor = Colors.white;
            } else if (selected && _currentFeedback == null) {
              bgColor = unitTheme.primary;
              borderColor = unitTheme.dark;
              shadowColor = unitTheme.dark;
              textColor = Colors.white;
            } else {
              bgColor = AppColors.welcomeBackground;
              borderColor = AppColors.quizCardBorder;
              shadowColor = AppColors.quizCardBorder;
              textColor = AppColors.outlineDark;
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: ChunkyPressable(
                backgroundColor: bgColor,
                borderColor: borderColor,
                shadowColor: shadowColor,
                borderRadius: BorderRadius.circular(20),
                onTap: _currentFeedback != null
                    ? null // Sudah dijawab, abaikan tap tambahan
                    : () => _onOptionSelected(questionIndex, index),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Radio/check indicator
                      Container(
                        width: 24,
                        height: 24,
                        margin: const EdgeInsets.only(top: 2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (selected || showCorrect)
                              ? Colors.white.withValues(alpha: 0.2)
                              : Colors.transparent,
                          border: Border.all(
                            color: (selected || showCorrect || showWrong)
                                ? Colors.white
                                : AppColors.quizRadioBorder,
                            width: 2,
                          ),
                        ),
                        child: showCorrect
                            ? const Icon(Icons.check,
                                size: 16, color: Colors.white)
                            : showWrong
                                ? const Icon(Icons.close,
                                    size: 16, color: Colors.white)
                                : selected
                                    ? const Icon(Icons.check,
                                        size: 16, color: Colors.white)
                                    : null,
                      ),
                      const SizedBox(width: 14),

                      // Option text
                      Expanded(
                        child: Text(
                          question.options[index],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Bottom section: banner feedback saat jawaban dipilih (tanpa tombol periksa jawaban).
  Widget _buildBottomSection(UnitTheme unitTheme, bool isLastStep) {
    if (_currentFeedback == null) {
      return const SizedBox(height: 20);
    }

    final isCorrect = _currentFeedback == true;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
      decoration: BoxDecoration(
        color: isCorrect
            ? const Color(0xFFDCFCE7)
            : const Color(0xFFFEE2E2),
        border: Border(
          top: BorderSide(
            color: isCorrect
                ? const Color(0xFF16A34A)
                : const Color(0xFFDC2626),
            width: 2,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCorrect
                    ? const Color(0xFF16A34A)
                    : const Color(0xFFDC2626),
              ),
              child: Icon(
                isCorrect ? Icons.check : Icons.close,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isCorrect ? 'Benar! Luar biasa 🎉' : 'Jawaban Kurang Tepat',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: isCorrect
                          ? const Color(0xFF15803D)
                          : const Color(0xFF991B1B),
                    ),
                  ),
                  if (!isCorrect)
                    const Text(
                      'Jawaban benar telah ditandai hijau',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFB91C1C),
                      ),
                    ),
                ],
              ),
            ),
            // Tombol cepat jika ingin langsung lanjut tanpa menunggu jeda
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: _advanceNext,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isCorrect
                        ? const Color(0xFF16A34A)
                        : const Color(0xFFDC2626),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isLastStep ? 'Hasil' : 'Lanjut',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward_rounded,
                          size: 16, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Dialog konfirmasi keluar.
  void _showExitConfirmation(UnitTheme unitTheme) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.outlineDark, width: 2),
        ),
        title: const Text(
          'Keluar dari latihan?',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: AppColors.outlineDark,
          ),
        ),
        content: const Text(
          'Progresmu di level ini akan hilang.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Lanjut Belajar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: unitTheme.primary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (widget.onClose != null) {
                widget.onClose!();
              } else {
                Navigator.of(context).pop();
              }
            },
            child: const Text(
              'Keluar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.heartRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Stat badge — konsisten dengan [GamificationHeader].
class _StatBadge extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;

  const _StatBadge({
    required this.icon,
    required this.iconColor,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outlineDark, width: 1.5),
        boxShadow: AppColors.solidShadow(offset: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: AppColors.outlineDark,
            ),
          ),
        ],
      ),
    );
  }
}