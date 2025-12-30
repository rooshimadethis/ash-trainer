import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../providers/goal_setup_provider.dart';
import '../widgets/onboarding_navigation.dart';
import '../widgets/onboarding_progress.dart';
import 'plan_generation_screen.dart';

class HealthPermissionsScreen extends ConsumerWidget {
  const HealthPermissionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AshScaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                const OnboardingProgress(
                  currentStep: 6,
                  totalSteps: 6,
                  label: 'Connect Health',
                ),
                const SizedBox(height: 32),
                const Icon(
                  Icons.favorite,
                  size: 80,
                  color: Color(0xFFEF4444), // Tailwind red-500
                ),
                const SizedBox(height: 32),
                Text(
                  'Let\'s connect your health data',
                  style: AppTextStyles.h2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Allow Ash to read your runs, heart rate, and sleep data to optimize your training automatically.',
                  style: AppTextStyles.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                _buildBenefitRow(Icons.auto_awesome, 'No manual logging'),
                const SizedBox(height: 12),
                _buildBenefitRow(
                    Icons.speed, 'Track heart rate, pace & distance'),
                const SizedBox(height: 12),
                _buildBenefitRow(Icons.bed, 'Monitor recovery from sleep'),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: OnboardingNavigation(
              nextLabel: 'Connect Health',
              onNext: () {
                ref.read(goalSetupProvider.notifier).setHealthPermissions(true);
                _next(context, ref);
              },
              onBack: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.accentOrange),
        const SizedBox(width: 12),
        Text(
          text,
          style:
              AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  void _next(BuildContext context, WidgetRef ref) {
    ref.read(goalSetupProvider.notifier).nextStep();
    ref.read(goalSetupProvider.notifier).submitGoal();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PlanGenerationScreen()),
    );
  }
}
