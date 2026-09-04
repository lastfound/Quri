import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';

void main() {
  testWidgets('App renders Quri home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: QuriApp()));
    await tester.pumpAndSettle();

    // Pastikan header Quri & modul belajar ter-render
    expect(find.text('Quri'), findsOneWidget);
    expect(find.text('Dasar Makharijul Huruf'), findsOneWidget);
  });
}
