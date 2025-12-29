import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_button.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../providers/goal_setup_provider.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AshScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              // Logo
              const Center(
                child: Icon(
                  Icons.local_fire_department,
                  size: 80,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 32),

              Text(
                'Hey there! I\'m Ash, your AI running coach 👋',
                style: AppTextStyles.h1.copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Value Propositions
              _buildValueProp(
                icon: Icons.auto_awesome,
                text: 'Personalized training plans that adapt to YOU',
              ),
              const SizedBox(height: 16),
              _buildValueProp(
                icon: Icons.school,
                text: 'Smart coaching that learns from every run',
              ),
              const SizedBox(height: 16),
              _buildValueProp(
                icon: Icons.calendar_today,
                text: 'Your goals, your schedule, your pace',
              ),

              const Spacer(),

              AshButton(
                label: 'Let\'s do this!',
                onPressed: () {
                  ref.read(goalSetupProvider.notifier).nextStep();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const AvailabilityScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValueProp({required IconData icon, required String text}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyLarge
                .copyWith(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}

// Temporary Placeholder for Navigation
class AvailabilityScreen extends StatelessWidget {
  const AvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AshScaffold(
      appBar: AppBar(
        title: const Text('Availability'),
        backgroundColor: Colors.transparent,
      ),
      body: const Center(
          child: Text('Step 2: Availability Screen',
              style: TextStyle(color: Colors.white))),
    );
  }
}
