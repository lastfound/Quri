import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

/// Mengelola sistem energi dengan regenerasi otomatis.
///
/// - Energi maksimal: [maxEnergy] (default 20).
/// - Setiap [regenIntervalMinutes] menit (default 60 = 1 jam), 1 energi pulih.
/// - State disimpan ke SharedPreferences agar bertahan saat app ditutup.
class EnergyService {
  static const String _keyEnergy = 'quri_energy';
  static const String _keyLastUsedAt = 'quri_energy_last_used_at';

  final int maxEnergy;
  final int regenIntervalMinutes;

  late SharedPreferences _prefs;

  EnergyService({
    this.maxEnergy = 20,
    this.regenIntervalMinutes = 60,
  });

  /// Inisialisasi — harus dipanggil sebelum menggunakan service.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Mengambil energi saat ini, sudah diperhitungkan regenerasi waktu.
  int getCurrentEnergy() {
    final stored = _prefs.getInt(_keyEnergy) ?? maxEnergy;
    if (stored >= maxEnergy) return maxEnergy;

    final lastUsedMs = _prefs.getInt(_keyLastUsedAt);
    if (lastUsedMs == null) return stored;

    final elapsed = DateTime.now().millisecondsSinceEpoch - lastUsedMs;
    final regenIntervalMs = regenIntervalMinutes * 60 * 1000;
    final regained = elapsed ~/ regenIntervalMs;

    if (regained <= 0) return stored;

    final newEnergy = (stored + regained).clamp(0, maxEnergy);

    // Simpan energi baru & sesuaikan timestamp agar sisa waktu tidak hilang
    _prefs.setInt(_keyEnergy, newEnergy);
    if (newEnergy >= maxEnergy) {
      _prefs.remove(_keyLastUsedAt);
    } else {
      // Geser timestamp maju sesuai jumlah regenerasi yang sudah dihitung
      final newLastUsed = lastUsedMs + (regained * regenIntervalMs);
      _prefs.setInt(_keyLastUsedAt, newLastUsed);
    }

    return newEnergy;
  }

  /// Kurangi energi sebesar [amount]. Mengembalikan energi tersisa.
  int consumeEnergy({int amount = 1}) {
    final current = getCurrentEnergy();
    final newEnergy = (current - amount).clamp(0, maxEnergy);

    _prefs.setInt(_keyEnergy, newEnergy);

    // Simpan timestamp jika belum ada (pertama kali berkurang dari penuh)
    if (newEnergy < maxEnergy && _prefs.getInt(_keyLastUsedAt) == null) {
      _prefs.setInt(
          _keyLastUsedAt, DateTime.now().millisecondsSinceEpoch);
    }
    // Jika sebelumnya sudah penuh, mulai timer baru
    if (current >= maxEnergy && newEnergy < maxEnergy) {
      _prefs.setInt(
          _keyLastUsedAt, DateTime.now().millisecondsSinceEpoch);
    }

    return newEnergy;
  }

  /// Set energi secara langsung (misal dari callback).
  void setEnergy(int value) {
    final clamped = value.clamp(0, maxEnergy);
    _prefs.setInt(_keyEnergy, clamped);

    if (clamped >= maxEnergy) {
      _prefs.remove(_keyLastUsedAt);
    } else if (_prefs.getInt(_keyLastUsedAt) == null) {
      _prefs.setInt(
          _keyLastUsedAt, DateTime.now().millisecondsSinceEpoch);
    }
  }

  /// Durasi tersisa hingga energi berikutnya pulih.
  /// Mengembalikan `null` jika energi sudah penuh.
  Duration? getTimeToNextRegen() {
    final current = getCurrentEnergy();
    if (current >= maxEnergy) return null;

    final lastUsedMs = _prefs.getInt(_keyLastUsedAt);
    if (lastUsedMs == null) return null;

    final regenIntervalMs = regenIntervalMinutes * 60 * 1000;
    final elapsed = DateTime.now().millisecondsSinceEpoch - lastUsedMs;
    final remaining = regenIntervalMs - (elapsed % regenIntervalMs);

    return Duration(milliseconds: remaining);
  }

  /// Durasi total hingga energi penuh kembali.
  /// Mengembalikan `null` jika sudah penuh.
  Duration? getTimeToFullEnergy() {
    final current = getCurrentEnergy();
    if (current >= maxEnergy) return null;

    final remaining = getTimeToNextRegen();
    if (remaining == null) return null;

    final slotsNeeded = maxEnergy - current - 1; // -1 karena slot pertama dihitung dari remaining
    final fullMs = remaining.inMilliseconds +
        (slotsNeeded * regenIntervalMinutes * 60 * 1000);

    return Duration(milliseconds: fullMs);
  }
}
