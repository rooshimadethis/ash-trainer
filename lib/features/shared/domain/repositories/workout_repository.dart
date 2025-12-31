import '../entities/training/workout.dart';
import '../entities/training/phase.dart';
import '../entities/training/training_block.dart';

abstract class WorkoutRepository {
  /// Get workouts within a specific date range
  Future<List<Workout>> getWorkoutsForDateRange({
    required DateTime startDate,
    required DateTime endDate,
  });

  /// Watch workouts within a specific date range (reactive)
  Stream<List<Workout>> watchWorkoutsForDateRange({
    required DateTime startDate,
    required DateTime endDate,
  });

  /// Get training blocks within a specific date range
  Future<List<TrainingBlock>> getBlocksForDateRange({
    required DateTime startDate,
    required DateTime endDate,
  });

  /// Get a single workout by ID
  Future<Workout?> getWorkout(String id);

  /// Watch a single workout by ID
  Stream<Workout?> watchWorkout(String id);

  /// Save a newly generated training plan (batch insert)
  Future<void> saveFullTrainingPlan({
    required List<Phase> phases,
    required List<TrainingBlock> blocks,
    required List<Workout> workouts,
  });

  /// Save or update a single workout
  Future<void> saveWorkout(Workout workout);

  /// Log a completed workout (update status, actuals)
  Future<void> logWorkout(Workout workout);

  /// Unmark a workout as complete and clear actuals
  Future<void> unlogWorkout(String workoutId);

  /// Delete workouts for a specific goal (e.g. before regenerating)
  Future<void> deleteWorkoutsForGoal(String goalId);

  /// Get all workouts for a specific goal
  Future<List<Workout>> getWorkoutsForGoal(String goalId);
}
