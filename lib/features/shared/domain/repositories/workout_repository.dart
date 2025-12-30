import '../entities/training/workout.dart';
import '../entities/training/phase.dart';
import '../entities/training/training_block.dart';

abstract class WorkoutRepository {
  /// Get workouts within a specific date range
  Future<List<Workout>> getWorkoutsForDateRange({
    required DateTime startDate,
    required DateTime endDate,
  });

  /// Get a single workout by ID
  Future<Workout?> getWorkout(String id);

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

  /// Delete workouts for a specific goal (e.g. before regenerating)
  Future<void> deleteWorkoutsForGoal(String goalId);
}
