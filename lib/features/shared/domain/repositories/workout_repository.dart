import '../entities/workout.dart';
import '../entities/ai/training_plan_response.dart';

abstract class WorkoutRepository {
  /// Get workouts within a specific date range
  Future<List<Workout>> getWorkoutsForDateRange({
    required DateTime startDate,
    required DateTime endDate,
  });

  /// Get a single workout by ID
  Future<Workout?> getWorkout(String id);

  /// Save a newly generated training plan (batch insert)
  Future<void> saveTrainingPlan(TrainingPlan plan);

  /// Save or update a single workout
  Future<void> saveWorkout(Workout workout);

  /// Log a completed workout (update status, actuals)
  Future<void> logWorkout(Workout workout);

  /// Delete workouts for a specific goal (e.g. before regenerating)
  Future<void> deleteWorkoutsForGoal(String goalId);
}
