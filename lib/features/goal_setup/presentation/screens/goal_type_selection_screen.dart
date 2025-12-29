import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/domain/entities/goal.dart';
import '../../../shared/presentation/widgets/ash_button.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../../../shared/presentation/widgets/ash_selection_tile.dart';
import '../providers/goal_setup_provider.dart';
import 'goal_details_screen.dart';

class GoalTypeSelectionScreen extends ConsumerWidget {
  const GoalTypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(goalSetupProvider);
    final notifier = ref.read(goalSetupProvider.notifier);

    return AshScaffold(
      appBar: AppBar(
        title: const Text('New Goal'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'What\'s the dream?', // Updated text from docs
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
            AshButton(
              label: 'Next',
              onPressed: state.selectedGoalType != null
                  ? () {
                      notifier.nextStep();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const GoalDetailsScreen(),
                        ),
                      );
                    }
                  : () {},
            ),
            const SizedBox(height: 16),
          ],
        ),
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
