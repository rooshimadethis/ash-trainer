import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_button.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../../../dashboard/presentation/screens/home_screen.dart';
import 'onboarding_feedback_screen.dart';

class OnboardingWorkoutScreen extends StatefulWidget {
  const OnboardingWorkoutScreen({super.key});

  @override
  State<OnboardingWorkoutScreen> createState() =>
      _OnboardingWorkoutScreenState();
}

class _OnboardingWorkoutScreenState extends State<OnboardingWorkoutScreen> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch()..start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  String _formatTime(int milliseconds) {
    final int seconds = (milliseconds / 1000).truncate();
    final int minutes = (seconds / 60).truncate();

    final String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    final String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return AshScaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Spacer(),
            Text(
              'Baseline Run',
              style: AppTextStyles.h2.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 48),
            Text(
              _formatTime(_stopwatch.elapsedMilliseconds),
              style: const TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Easy Pace (Zone 2)',
              style: TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const Spacer(),
            AshButton(
              label: 'Finish Workout',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => OnboardingFeedbackScreen(
                      duration: _stopwatch.elapsed,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Cancel
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
                );
              },
              child: Text(
                'Cancel',
                style: AppTextStyles.body.copyWith(color: Colors.red),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
