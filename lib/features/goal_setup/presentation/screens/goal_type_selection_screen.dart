import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/domain/entities/goal.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../../../shared/presentation/widgets/ash_selection_tile.dart';
import '../providers/goal_setup_provider.dart';
import '../widgets/onboarding_navigation.dart';
import '../widgets/onboarding_progress.dart';
import 'goal_details_screen.dart';

class GoalTypeSelectionScreen extends ConsumerWidget {
  const GoalTypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(goalSetupProvider);
    final notifier = ref.read(goalSetupProvider.notifier);

    return AshScaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12), // Space for top progress
                const OnboardingProgress(
                  currentStep: 1,
                  label: 'Goal Selection',
                ),
                const SizedBox(height: 24),
                Text(
                  'What\'s the dream?',
                  style: AppTextStyles.h2,
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose what we are chasing together.',
                  style: AppTextStyles.bodyLarge,
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 120),
                    children: [
                      _buildOption(
                        context,
                        notifier,
                        state.selectedGoalType,
                        GoalType.distanceMilestone,
                        'Distance Milestone',
                        'Conquer a new distance 🎯',
                        Icons.flag,
                      ),
                      const SizedBox(height: 12),
                      _buildOption(
                        context,
                        notifier,
                        state.selectedGoalType,
                        GoalType.timePerformance,
                        'Time Performance',
                        'Get faster ⚡',
                        Icons.timer,
                      ),
                      const SizedBox(height: 12),
                      _buildOption(
                        context,
                        notifier,
                        state.selectedGoalType,
                        GoalType.event,
                        'Event',
                        'Race day ready 🏁',
                        Icons.calendar_month,
                      ),
                      const SizedBox(height: 12),
                      _buildOption(
                        context,
                        notifier,
                        state.selectedGoalType,
                        GoalType.maintenance,
                        'Maintenance',
                        'Stay consistent 🔄',
                        Icons.repeat,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: OnboardingNavigation(
              onNext: state.selectedGoalType != null
                  ? () {
                      notifier.nextStep();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const GoalDetailsScreen(),
                        ),
                      );
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context,
    GoalSetupNotifier notifier,
    GoalType? currentSelection,
    GoalType value,
    String title,
    String subtitle,
    IconData icon,
  ) {
    final isSelected = currentSelection == value;
    return AshSelectionTile(
      title: title,
      subtitle: subtitle,
      leading: Icon(icon, color: AppColors.white),
      isSelected: isSelected,
      onTap: () => notifier.setGoalType(value),
    );
  }
}
