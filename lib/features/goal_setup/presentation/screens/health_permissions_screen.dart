import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_button.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../providers/goal_setup_provider.dart';
import 'plan_generation_screen.dart';

class HealthPermissionsScreen extends ConsumerWidget {
  const HealthPermissionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AshScaffold(
      // Step 7
      appBar: AppBar(
          title: const Text('Connect Health'),
          backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.favorite, size: 80, color: Colors.redAccent),
            const SizedBox(height: 32),
            Text('Connect to Apple Health',
                style: AppTextStyles.h2, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Text(
              'Allow Ash to read your runs, heart rate, and sleep data to optimize your training automatically.',
              style: AppTextStyles.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            AshButton(
              label: 'Grant Permissions',
              icon: Icons.check_circle_outline,
              onPressed: () {
                ref.read(goalSetupProvider.notifier).setHealthPermissions(true);
                // In real app, trigger native dialog here
                _next(context, ref);
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                ref
                    .read(goalSetupProvider.notifier)
                    .setHealthPermissions(false);
                _next(context, ref);
              },
              child: Text('Skip for now',
                  style: AppTextStyles.body
                      .copyWith(color: AppColors.textSecondary)),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _next(BuildContext context, WidgetRef ref) {
    ref.read(goalSetupProvider.notifier).nextStep();
    ref.read(goalSetupProvider.notifier).submitGoal(); // Trigger generation
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PlanGenerationScreen()),
    );
  }
}
