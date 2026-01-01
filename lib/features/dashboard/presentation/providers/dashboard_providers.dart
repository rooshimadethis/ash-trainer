import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ash_trainer/features/shared/domain/entities/goal.dart';
import 'package:ash_trainer/data/providers/repository_providers.dart';
import '../../../shared/domain/services/health_service.dart';
import '../../../../infrastructure/providers/service_providers.dart';

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

/// Provider for workouts detected from external sources (Results from Health Connect) for TODAY
final todaysExternalWorkoutsProvider =
    FutureProvider<List<ExternalWorkout>>((ref) async {
  final healthService = ref.watch(healthServiceProvider);

  // Verify permissions first to avoid errors or prompting unexpectedly
  if (!await healthService.hasPermissions()) {
    // Optional: we can return empty, or try to request?
    // For auto-detect, best to be silent if no permissions.
    return [];
  }

  return healthService.fetchTodaysWorkouts();
});
