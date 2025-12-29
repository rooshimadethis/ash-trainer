import '../entities/goal.dart';

abstract class GoalRepository {
  /// Creates a new goal
  Future<Goal> createGoal(Goal goal);

  /// Gets a goal by ID
  Future<Goal> getGoal(String id);

  /// Gets all goals
  Future<List<Goal>> getGoals();

  /// Gets the currently active goal
  Future<Goal?> getActiveGoal();

  /// Updates a goal
  Future<void> updateGoal(Goal goal);

  /// Updates confidence scores
  Future<void> updateConfidence({
    required String goalId,
    required double confidence,
    required double adherenceScore,
    required double qualityScore,
    required double consistencyScore,
    required double recoveryScore,
  });

  /// Deactivates a goal
  Future<void> deactivateGoal(String goalId);

  /// Deletes a goal
  Future<void> deleteGoal(String goalId);
}
