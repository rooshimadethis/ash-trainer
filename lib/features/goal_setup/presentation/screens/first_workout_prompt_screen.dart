import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_button.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../../../shared/presentation/widgets/ash_card.dart';
import '../../../dashboard/presentation/screens/home_screen.dart';
import 'onboarding_workout_screen.dart';

class FirstWorkoutPromptScreen extends StatelessWidget {
  const FirstWorkoutPromptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AshScaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            const Icon(Icons.flash_on, size: 80, color: AppColors.primary),
            const SizedBox(height: 32),
            Text('One last thing...',
                style: AppTextStyles.h2, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Text(
              'Let\'s do a quick baseline run to establish your pace.',
              style: AppTextStyles.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            AshCard(
              child: Column(
                children: [
                  Text('Baseline Run', style: AppTextStyles.h3),
                  const SizedBox(height: 8),
                  const Text('20 Minutes • Easy Pace (Zone 2)',
                      style: TextStyle(color: AppColors.textSecondary)),
                ],
              ),
            ),
            const Spacer(),
            AshButton(
              label: 'Lets Run!',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (_) => const OnboardingWorkoutScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (route) => false,
                );
              },
              child: Text('I\'ll do it later',
                  style: AppTextStyles.body
                      .copyWith(color: AppColors.textSecondary)),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
