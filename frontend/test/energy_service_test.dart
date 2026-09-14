import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/core/services/energy_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('EnergyService', () {
    test('Default regenIntervalMinutes is 30 minutes', () {
      final service = EnergyService();
      expect(service.regenIntervalMinutes, 30);
      expect(service.maxEnergy, 20);
    });

    test('Regenerates 1 energy every 30 minutes', () async {
      final now = DateTime.now().millisecondsSinceEpoch;
      // 30 minutes elapsed in milliseconds
      final elapsedMs = 30 * 60 * 1000;

      SharedPreferences.setMockInitialValues({
        'quri_energy': 10,
        'quri_energy_last_used_at': now - elapsedMs,
      });

      final service = EnergyService();
      await service.init();

      expect(service.getCurrentEnergy(), 11);
    });

    test('getTimeToNextRegen returns correct remaining duration based on 30 minutes', () async {
      final now = DateTime.now().millisecondsSinceEpoch;
      // 10 minutes elapsed => 20 minutes remaining
      final elapsedMs = 10 * 60 * 1000;

      SharedPreferences.setMockInitialValues({
        'quri_energy': 15,
        'quri_energy_last_used_at': now - elapsedMs,
      });

      final service = EnergyService();
      await service.init();

      final remaining = service.getTimeToNextRegen();
      expect(remaining, isNotNull);
      // Remaining should be approximately 20 minutes (within a few seconds tolerance)
      expect(remaining!.inMinutes, closeTo(20, 1));
    });
  });
}
