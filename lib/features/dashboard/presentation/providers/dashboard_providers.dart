import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ash_trainer/features/shared/domain/entities/goal.dart';
import 'package:ash_trainer/data/providers/repository_providers.dart';

/// Provider for the currently active goal
final activeGoalProvider = FutureProvider<Goal?>((ref) async {
  final goalRepository = ref.watch(goalRepositoryProvider);
  return goalRepository.getActiveGoal();
});

/// Progress stats for the current goal
class GoalStats {
  final int totalWorkouts;
  final int completedWorkouts;
  final double progressPercentage;

  GoalStats({
    required this.totalWorkouts,
    required this.completedWorkouts,
    required this.progressPercentage,
  });
}

/// Provider for goal completion statistics
final goalStatsProvider = FutureProvider<GoalStats?>((ref) async {
  final activeGoal = await ref.watch(activeGoalProvider.future);
  if (activeGoal == null) return null;

  final workoutRepository = ref.watch(workoutRepositoryProvider);
  final workouts = await workoutRepository.getWorkoutsForGoal(activeGoal.id);

  if (workouts.isEmpty) {
    return GoalStats(
      totalWorkouts: 0,
      completedWorkouts: 0,
      progressPercentage: 0,
    );
  }

  final completed = workouts.where((w) => w.status == 'completed').length;

  return GoalStats(
    totalWorkouts: workouts.length,
    completedWorkouts: completed,
    progressPercentage: completed / workouts.length,
  );
});
