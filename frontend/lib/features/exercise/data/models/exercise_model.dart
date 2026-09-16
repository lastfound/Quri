/// Model data untuk soal latihan dan kurikulum level pada setiap unit.
class ExerciseQuestion {
  final String questionText;
  final String? visualPrompt;
  final String? audioPath;
  final List<String> options;
  final int correctOptionIndex;
  final String? explanation;

  const ExerciseQuestion({
    required this.questionText,
    this.visualPrompt,
    this.audioPath,
    required this.options,
    required this.correctOptionIndex,
    this.explanation,
  });
}

/// Model untuk satu level pembelajaran di dalam sebuah unit.
class ExerciseLevel {
  final int levelNumber;
  final String title;
  final String arabicSubtitle;
  final String description;
  final List<ExerciseQuestion> questions;
  final int xpReward;
  final String? badgeLabel;
  final int? timeLimitMinutes;

  const ExerciseLevel({
    required this.levelNumber,
    required this.title,
    required this.arabicSubtitle,
    required this.description,
    required this.questions,
    this.xpReward = 20,
    this.badgeLabel,
    this.timeLimitMinutes,
  });

  /// Menentukan apakah level ini merupakan Boss Level
  bool get isBoss =>
      badgeLabel?.toUpperCase().contains('BOSS') ?? false;

  /// Menentukan apakah level ini merupakan Checkpoint (Mini atau Mid)
  bool get isCheckpoint =>
      badgeLabel?.toUpperCase().contains('CHECKPOINT') ?? false;

  /// Batas waktu efektif dalam menit:
  /// Checkpoint = 15 menit, Boss = 17 menit, selain itu null (latihan biasa)
  int? get effectiveTimeLimitMinutes {
    if (timeLimitMinutes != null) return timeLimitMinutes;
    if (isBoss) return 17;
    if (isCheckpoint) return 15;
    return null;
  }
}
