import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_button.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../../../shared/presentation/widgets/ash_card.dart';
import '../../../shared/domain/entities/workout.dart';
import '../../../../data/providers/repository_providers.dart';
import '../providers/goal_setup_provider.dart';
import 'first_workout_prompt_screen.dart';

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
            Text('Week 1 Ready! 🎉', style: AppTextStyles.h2),
            const SizedBox(height: 16),
            AshCard(
              child: Column(children: [
                Text('Confidence: ${(85.0).toStringAsFixed(0)}%',
                    style: AppTextStyles.h1.copyWith(color: AppColors.primary)),
                Text('Goal Probability', style: AppTextStyles.bodyMedium),
              ]),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: workoutsAsync.when(
                data: (workouts) {
                  if (workouts.isEmpty) {
                    return Center(
                        child: Text('No workouts found',
                            style: AppTextStyles.bodyLarge));
                  }
                  return ListView.builder(
                    itemCount: workouts.length,
                    itemBuilder: (context, index) {
                      final workout = workouts[index];
                      return _WorkoutTile(workout: workout);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(
                    child: Text('Error: $err',
                        style: const TextStyle(color: Colors.red))),
              ),
            ),
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

class _WorkoutTile extends StatelessWidget {
  final Workout workout;

  const _WorkoutTile({required this.workout});

  @override
  Widget build(BuildContext context) {
    final dayFormat = DateFormat('E');
    final day = dayFormat.format(workout.scheduledDate);

    // Simple logic for display
    final isRest = workout.type.toLowerCase() == 'rest';
    final distance = workout.plannedDistance != null
        ? '${workout.plannedDistance} km'
        : (workout.plannedDuration > 0
            ? '${(workout.plannedDuration / 60).toStringAsFixed(0)} min'
            : null);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceHighlight,
        borderRadius: BorderRadius.circular(12),
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
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                if (distance != null)
                  Text(distance,
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isRest
                  ? Colors.grey.withValues(alpha: 0.2)
                  : AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(workout.type.toUpperCase(),
                style: TextStyle(
                    fontSize: 10,
                    color: isRest ? Colors.grey : AppColors.primary)),
          ),
        ],
      ),
    );
  }
}
