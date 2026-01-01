import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ash_trainer/core/theme/text_styles.dart';
import 'package:ash_trainer/features/shared/presentation/widgets/ash_button.dart';
import 'package:ash_trainer/features/shared/presentation/widgets/ash_scaffold.dart';
import 'package:ash_trainer/features/goal_setup/presentation/providers/goal_setup_provider.dart';
import 'package:ash_trainer/features/goal_setup/presentation/screens/goal_type_selection_screen.dart';

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
              Center(
                child: Image.asset(
                  'assets/images/ash.png',
                  height: 120, // Increased size slightly for the character
                ),
              ),
              const SizedBox(height: 32),

              Text(
                'Hey there! I\'m Ash, your AI running coach 👋',
                style: AppTextStyles.h1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Value Propositions
              _buildValueProp(
                context: context,
                icon: Icons.auto_awesome,
                text: 'Personalized training plans that adapt to YOU',
              ),
              const SizedBox(height: 16),
              _buildValueProp(
                context: context,
                icon: Icons.school,
                text: 'Smart coaching that learns from every run',
              ),
              const SizedBox(height: 16),
              _buildValueProp(
                context: context,
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
                        builder: (_) => const GoalTypeSelectionScreen()),
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

  Widget _buildValueProp(
      {required BuildContext context,
      required IconData icon,
      required String text}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Theme.of(context).primaryColor, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyLarge,
          ),
        ),
      ],
    );
  }
}
