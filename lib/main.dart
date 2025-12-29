import 'package:ash_trainer/features/goal_setup/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ash_trainer/core/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: AshTrainerApp()));
}

class AshTrainerApp extends StatelessWidget {
  const AshTrainerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ash Trainer',
      theme: AppTheme.darkTheme,
      home: const WelcomeScreen(),
    );
  }
}
