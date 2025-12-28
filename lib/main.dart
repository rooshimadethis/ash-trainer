import 'package:ash_trainer/features/daily_loop/presentation/screens/daily_dashboard_screen.dart';
import 'package:ash_trainer/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AshTrainerApp());
}

class AshTrainerApp extends StatelessWidget {
  const AshTrainerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ash Trainer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E88E5)),
        useMaterial3: true,
      ),
      home: const MockupSelectorScreen(),
    );
  }
}

class MockupSelectorScreen extends StatelessWidget {
  const MockupSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ash Trainer Mockups')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnboardingScreen(),
                  ),
                );
              },
              child: const Text('Start Onboarding Flow'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DailyDashboardScreen(),
                  ),
                );
              },
              child: const Text('View Daily Training Loop'),
            ),
          ],
        ),
      ),
    );
  }
}
