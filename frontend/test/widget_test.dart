import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';

void main() {
  testWidgets('App renders Quri welcome screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: QuriApp()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Pastikan teks Quri ter-render di welcome screen
    expect(find.textContaining('Quri'), findsWidgets);

    await tester.pumpWidget(const SizedBox());
  });
}
