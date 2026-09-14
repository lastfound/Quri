import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/features/exercise/data/models/exercise_model.dart';
import 'package:frontend/features/exercise/presentation/exercise_question_screen.dart';
import 'package:frontend/features/home/presentation/widgets/gamification_header.dart';
import 'package:frontend/features/shop/presentation/shop_screen.dart';

void main() {
  testWidgets('GamificationHeader renders streak and gems without energy',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: GamificationHeader(
            streak: 5,
            gems: 250,
          ),
        ),
      ),
    );

    // Verify streak and gems are shown
    expect(find.text('5'), findsOneWidget);
    expect(find.text('250'), findsOneWidget);
    expect(find.byIcon(Icons.local_fire_department_rounded), findsOneWidget);
    expect(find.byIcon(Icons.diamond_rounded), findsOneWidget);

    // Verify no bolt / energy icon is rendered in the header
    expect(find.byIcon(Icons.bolt_rounded), findsNothing);
  });

  testWidgets('ShopScreen shows free basic practice and paid Quran memorization & murojaah',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ShopScreen(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // Verify plans exist
    expect(find.text('LATIHAN DASAR'), findsOneWidget);
    expect(find.text('QURI HAFIZ'), findsOneWidget);
    expect(find.text('QURI PRO'), findsOneWidget);

    // Verify free basic practice messaging
    expect(find.textContaining('Latihan Interaktif Bebas Tanpa Batas'), findsOneWidget);

    // Verify paid features focus on Menghafal and Murojaah
    expect(find.textContaining('Menghafal Al-Qur\'an'), findsWidgets);
    expect(find.textContaining('Memurojaah Al-Qur\'an'), findsWidgets);
  });

  testWidgets('ExerciseQuestionScreen allows free answering without energy check',
      (WidgetTester tester) async {
    final questions = [
      const ExerciseQuestion(
        questionText: 'Huruf apakah ini?',
        visualPrompt: 'ب',
        options: ['Ba', 'Ta', 'Jim'],
        correctOptionIndex: 0,
      ),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: ExerciseQuestionScreen(
          questions: questions,
          streak: 2,
          gems: 80,
        ),
      ),
    );
    await tester.pump();

    // Verify question rendered
    expect(find.text('Huruf apakah ini?'), findsOneWidget);
    expect(find.text('Ba'), findsOneWidget);

    // Answer the question
    await tester.tap(find.text('Ba'));
    await tester.pump();

    // Feedback should show correct answer immediately
    expect(find.textContaining('Benar!'), findsOneWidget);
  });
}
