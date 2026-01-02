import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ash_trainer/core/theme/text_styles.dart';
import 'package:ash_trainer/core/theme/colors.dart';
import 'package:ash_trainer/features/shared/presentation/widgets/ash_button.dart';
import 'package:ash_trainer/features/shared/presentation/widgets/ash_scaffold.dart';
import 'package:ash_trainer/features/shared/presentation/widgets/ash_card.dart';
import 'package:ash_trainer/features/goal_setup/presentation/providers/goal_setup_provider.dart';
import 'package:ash_trainer/features/goal_setup/presentation/screens/goal_type_selection_screen.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AshScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              // Mascot Container with a subtle glow
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).primaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/ash_red_panda.png',
                      height: 180,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              Column(
                children: [
                  Text(
                    "I'M ASH",
                    style: AppTextStyles.labelLarge.copyWith(
                      color: Theme.of(context).primaryColor,
                      letterSpacing: 4.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your Personal\nRunning Mascot',
                    style: AppTextStyles.h1.copyWith(
                      fontSize: 36,
                      height: 1.1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Value Propositions in stylized cards
              _buildValueProp(
                context,
                icon: Icons.auto_awesome_rounded,
                title: 'Adaptive Plans',
                description:
                    'Tailored to your life, schedule, and performance.',
              ),
              const SizedBox(height: 16),
              _buildValueProp(
                context,
                icon: Icons.insights_rounded,
                title: 'Smart Insights',
                description: 'I learn from every run to keep you on track.',
              ),
              const SizedBox(height: 16),
              _buildValueProp(
                context,
                icon: Icons.emoji_events_rounded,
                title: 'Goal Focused',
                description: 'From 5Ks to Marathons, we crush them together.',
              ),

              const Spacer(flex: 2),

              AshButton(
                label: "LET'S GET RUNNING",
                onPressed: () {
                  ref.read(goalSetupProvider.notifier).nextStep();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => const GoalTypeSelectionScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValueProp(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return AshCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.h4.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textMuted,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
