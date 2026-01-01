import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/unit_converter.dart';
import '../../../shared/presentation/widgets/ash_button.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../shared/domain/entities/goal.dart';
import '../../../../data/providers/repository_providers.dart';
import '../providers/goal_setup_provider.dart';
import 'first_workout_prompt_screen.dart';
import '../../../../core/constants/workout_types.dart';
import '../../../shared/presentation/providers/user_provider.dart';

final week1WorkoutsProvider =
    FutureProvider.autoDispose<List<Workout>>((ref) async {
  final repo = ref.watch(workoutRepositoryProvider);
  final now = DateTime.now();
  return repo.getWorkoutsForDateRange(
    startDate: DateTime(now.year, now.month, now.day),
    endDate:
        DateTime(now.year, now.month, now.day).add(const Duration(days: 7)),
  );
});

final activeGoalProvider = FutureProvider.autoDispose<Goal>((ref) async {
  final repo = ref.watch(goalRepositoryProvider);
  final goal = await repo.getActiveGoal();
  if (goal == null) throw Exception('No active goal found');
  return goal;
});

class PlanReviewScreen extends ConsumerWidget {
  const PlanReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutsAsync = ref.watch(week1WorkoutsProvider);

    return AshScaffold(
      appBar: AppBar(
          title: const Text('Your Plan'), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Ready! 🎉', style: AppTextStyles.h2),
                    const SizedBox(height: 24),
                    Consumer(builder: (context, ref, _) {
                      final goalAsync = ref.watch(activeGoalProvider);
                      return goalAsync.maybeWhen(
                        data: (goal) => _RationaleSection(goal: goal),
                        orElse: () => const SizedBox.shrink(),
                      );
                    }),
                    Text('Week 1 Preview', style: AppTextStyles.h3),
                    const SizedBox(height: 12),
                    workoutsAsync.when(
                      data: (workouts) {
                        if (workouts.isEmpty) {
                          return Center(
                              child: Text('No workouts found',
                                  style: AppTextStyles.bodyLarge));
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: workouts.length,
                          itemBuilder: (context, index) {
                            final workout = workouts[index];
                            return _WorkoutTile(workout: workout);
                          },
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Center(
                          child: Text('Error: $err',
                              style: const TextStyle(color: Colors.red))),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            AshButton(
              label: 'Looks Good!',
              onPressed: () {
                ref.read(goalSetupProvider.notifier).nextStep();
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => const FirstWorkoutPromptScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _WorkoutTile extends ConsumerWidget {
  final Workout workout;

  const _WorkoutTile({required this.workout});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dayFormat = DateFormat('E');
    final day = dayFormat.format(workout.scheduledDate);
    final color = WorkoutTypes.getColor(workout.type);
    final isRun = [
      WorkoutTypes.easyRun,
      WorkoutTypes.tempo,
      WorkoutTypes.intervals,
      WorkoutTypes.longRun
    ].contains(workout.type);

    // Get user's preferred distance unit
    final preferredUnit = ref.watch(preferredDistanceUnitProvider);

    final distance = (isRun &&
            workout.plannedDistance != null &&
            workout.plannedDistance! > 0)
        ? UnitConverter.formatDistance(
            UnitConverter.convertDistanceFromKm(
                workout.plannedDistance!, preferredUnit),
            preferredUnit)
        : (workout.plannedDuration > 0
            ? '${(workout.plannedDuration / 60).toStringAsFixed(0)} min'
            : null);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Row(
        children: [
          SizedBox(
              width: 40,
              child: Text(day,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(workout.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                if (distance != null)
                  Text(distance, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(WorkoutTypes.getDisplayName(workout.type).toUpperCase(),
                style: TextStyle(fontSize: 10, color: color)),
          ),
        ],
      ),
    );
  }
}

class _RationaleSection extends StatelessWidget {
  final Goal goal;

  const _RationaleSection({required this.goal});

  @override
  Widget build(BuildContext context) {
    if (goal.rationaleOverallApproach == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.lightbulb_outline,
                color: AppColors.accentBlue, size: 20),
            const SizedBox(width: 8),
            Text('The Strategy',
                style: AppTextStyles.h3.copyWith(color: AppColors.accentBlue)),
          ],
        ),
        const SizedBox(height: 12),
        _buildRationaleCard(context, 'Overall Approach',
            goal.rationaleOverallApproach, Icons.flag),
        _buildRationaleCard(context, 'Intensity Distribution',
            goal.rationaleIntensityDistribution, Icons.bar_chart),
        _buildRationaleCard(
            context, 'Key Workouts', goal.rationaleKeyWorkouts, Icons.star),
        _buildRationaleCard(context, 'Recovery Strategy',
            goal.rationaleRecoveryStrategy, Icons.battery_charging_full),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildRationaleCard(
      BuildContext context, String label, String? content, IconData icon) {
    if (content == null) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Text(label.toUpperCase(),
                  style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0)),
            ],
          ),
          const SizedBox(height: 8),
          Text(content, style: const TextStyle(fontSize: 13, height: 1.4)),
        ],
      ),
    );
  }
}
