import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/features/shop/presentation/out_of_energy_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('OutOfEnergySheet renders lightning bolt icon and cooldown',
      (WidgetTester tester) async {
    // 31 minutes and 15 seconds elapsed => 28:45 remaining out of 60 mins
    final now = DateTime.now().millisecondsSinceEpoch;
    final elapsedMs = (31 * 60 + 15) * 1000;
    SharedPreferences.setMockInitialValues({
      'quri_energy': 0,
      'quri_energy_last_used_at': now - elapsedMs,
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: OutOfEnergySheet(
            countdownText: '28:45',
            currentEnergy: 0,
            maxEnergy: 20,
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Verify Title
    expect(find.text('Energi Harian Kamu Habis!'), findsOneWidget);

    // Verify Petir (Icons.bolt_rounded) is rendered
    expect(find.byIcon(Icons.bolt_rounded), findsWidgets);

    // Verify countdown text (28:44 or 28:45)
    expect(find.textContaining('28:4'), findsWidgets);

    // Verify action buttons
    expect(find.textContaining('Tunggu Isi Ulang'), findsOneWidget);
    expect(find.text('Isi Ulang dengan Quri'), findsOneWidget);
    expect(
      find.text('Buka Unlimited Energi dengan Paket Premium'),
      findsOneWidget,
    );

    // Dispose
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('OutOfEnergySheet renders full state when energy is full',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      'quri_energy': 20,
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: OutOfEnergySheet(
            currentEnergy: 20,
            maxEnergy: 20,
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Verify Title when full
    expect(find.text('Energi Kamu Sudah Penuh!'), findsOneWidget);
    expect(find.text('Energi Sudah Terisi Penuh!'), findsOneWidget);
    expect(find.text('Lanjut Belajar Sekarang'), findsOneWidget);

    // Dispose
    await tester.pumpWidget(const SizedBox());
  });
}
