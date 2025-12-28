import 'package:ash_trainer/features/onboarding/presentation/screens/onboarding_pages.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  void _nextPage() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _finish() {
    Navigator.of(context).pop(); // Back to main menu
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      physics:
          const NeverScrollableScrollPhysics(), // Disable swipe to enforce flow
      children: [
        WelcomeScreen(onNext: _nextPage),
        FitnessLevelScreen(onNext: _nextPage),
        GoalSettingScreen(onNext: _nextPage),
        TrainingPreferencesScreen(onNext: _nextPage),
        PillarPrioritizationScreen(onNext: _nextPage),
        PlanGenerationScreen(onNext: _nextPage),
        PlanReviewScreen(onNext: _nextPage),
        FirstWorkoutReadyScreen(onFinish: _finish),
      ],
    );
  }
}
