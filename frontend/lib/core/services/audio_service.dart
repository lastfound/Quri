import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:just_audio/just_audio.dart';

/// Asset audio default untuk efek suara (SFX) di dalam aplikasi.
class AppAudioAssets {
  /// Daftar kandidat ekstensi untuk suara jawaban benar (.mp3, .mpeg, .wav, .m4a)
  static const List<String> correctCandidates = [
    'assets/audio/correct.mp3',
    'assets/audio/correct.mpeg',
    'assets/audio/correct.wav',
    'assets/audio/correct.m4a',
  ];

  /// Daftar kandidat ekstensi untuk suara jawaban salah (.mp3, .mpeg, .wav, .m4a)
  static const List<String> wrongCandidates = [
    'assets/audio/wrong.mp3',
    'assets/audio/wrong.mpeg',
    'assets/audio/wrong.wav',
    'assets/audio/wrong.m4a',
  ];

  /// Daftar kandidat ekstensi untuk suara level complete
  static const List<String> levelCompleteCandidates = [
    'assets/audio/level_complete.mp3',
    'assets/audio/level_complete.mpeg',
    'assets/audio/level_complete.wav',
    'assets/audio/level_complete.m4a',
  ];
}

/// Service untuk memutar efek suara (SFX) dan audio pembelajaran.
///
/// Mendukung format MPEG (.mpeg / .mp3), WAV (.wav), dan M4A (.m4a).
/// Sudah dilengkapi penanganan error (try-catch) sehingga aplikasi TIDAK akan crash
/// meskipun file audio belum dimasukkan atau format berbeda.
class AudioService {
  AudioService._internal();
  static final AudioService instance = AudioService._internal();

  AudioPlayer? _sfxPlayer;

  /// Mengatur apakah efek suara aktif atau tidak
  bool isSoundEnabled = true;

  String? _resolvedCorrectPath;
  String? _resolvedWrongPath;
  String? _resolvedLevelCompletePath;

  AudioPlayer get _player {
    _sfxPlayer ??= AudioPlayer();
    return _sfxPlayer!;
  }

  /// Mencari file asset yang tersedia dari daftar kandidat ekstensi.
  Future<String?> _resolveAssetPath(List<String> candidates) async {
    for (final path in candidates) {
      try {
        await rootBundle.load(path);
        return path;
      } catch (_) {
        // Abaikan jika ekstensi ini tidak ada, lanjutkan ke kandidat berikutnya
      }
    }
    return null;
  }

  /// Memutar efek suara saat pengguna menjawab soal dengan BENAR.
  /// Otomatis mendeteksi `correct.mp3`, `correct.mpeg`, `correct.wav`, atau `correct.m4a`.
  Future<void> playCorrectSound({String? customPath}) async {
    if (customPath != null) {
      await playSound(customPath);
      return;
    }

    _resolvedCorrectPath ??= await _resolveAssetPath(AppAudioAssets.correctCandidates);
    if (_resolvedCorrectPath != null) {
      await playSound(_resolvedCorrectPath!);
    } else {
      debugPrint(
        '💡 [AudioService] File suara jawaban benar (correct.mp3 / correct.mpeg) belum ditemukan di folder assets/audio/.',
      );
    }
  }

  /// Memutar efek suara saat pengguna menjawab soal dengan SALAH.
  /// Otomatis mendeteksi `wrong.mp3`, `wrong.mpeg`, `wrong.wav`, atau `wrong.m4a`.
  Future<void> playWrongSound({String? customPath}) async {
    if (customPath != null) {
      await playSound(customPath);
      return;
    }

    _resolvedWrongPath ??= await _resolveAssetPath(AppAudioAssets.wrongCandidates);
    if (_resolvedWrongPath != null) {
      await playSound(_resolvedWrongPath!);
    } else {
      debugPrint(
        '💡 [AudioService] File suara jawaban salah (wrong.mp3 / wrong.mpeg) belum ditemukan di folder assets/audio/.',
      );
    }
  }

  /// Memutar efek suara saat berhasil menyelesaikan level kuis.
  Future<void> playLevelCompleteSound({String? customPath}) async {
    if (customPath != null) {
      await playSound(customPath);
      return;
    }

    _resolvedLevelCompletePath ??=
        await _resolveAssetPath(AppAudioAssets.levelCompleteCandidates);
    if (_resolvedLevelCompletePath != null) {
      await playSound(_resolvedLevelCompletePath!);
    } else {
      debugPrint(
        '💡 [AudioService] File level complete (level_complete.mp3 / .mpeg) belum ditemukan di folder assets/audio/.',
      );
    }
  }

  /// Memutar file audio dari assets secara aman.
  Future<void> playSound(String assetPath) async {
    if (!isSoundEnabled) return;

    try {
      final player = _player;
      await player.stop();
      await player.setAsset(assetPath);
      await player.seek(Duration.zero);
      await player.play();
    } catch (e) {
      debugPrint(
        '💡 [AudioService] Error saat memutar audio "$assetPath": $e',
      );
    }
  }

  /// Membersihkan resource audio player ketika tidak lagi digunakan.
  Future<void> dispose() async {
    await _sfxPlayer?.dispose();
    _sfxPlayer = null;
  }
}
