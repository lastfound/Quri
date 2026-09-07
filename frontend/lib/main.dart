import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/theme/app_colors.dart';
import 'package:frontend/features/welcome/presentation/welcome_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: QuriApp(),
    ),
  );
}

class QuriApp extends StatelessWidget {
  const QuriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quri - Belajar Qur\'an',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
        fontFamily: 'sans-serif',
      ),
      home: const WelcomeScreen(),
    );
  }
}