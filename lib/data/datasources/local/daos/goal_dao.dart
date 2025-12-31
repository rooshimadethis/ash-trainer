import 'package:drift/drift.dart';
import '../drift_database.dart';
import '../tables/goals_table.dart';

part 'goal_dao.g.dart';

@DriftAccessor(tables: [Goals])
class GoalDao extends DatabaseAccessor<AppDatabase> with _$GoalDaoMixin {
  GoalDao(super.db);

  Future<GoalDTO?> getGoalById(int id) =>
      (select(goals)..where((g) => g.id.equals(id))).getSingleOrNull();

  Future<List<GoalDTO>> getAllGoals() => select(goals).get();

  Future<GoalDTO?> getActiveGoal() =>
      (select(goals)..where((g) => g.isActive.equals(true))).getSingleOrNull();

  Future<int> insertGoal(Insertable<GoalDTO> goal) => into(goals).insert(goal);

  Future<bool> updateGoal(Insertable<GoalDTO> goal) =>
      update(goals).replace(goal);

  Future<void> deactivateGoal(int id) {
    return (update(goals)..where((g) => g.id.equals(id))).write(
      const GoalsCompanion(isActive: Value(false)),
    );
  }

  Future<int> deleteGoal(int id) =>
      (delete(goals)..where((g) => g.id.equals(id))).go();

  Future<void> updateRationale({
    required int goalId,
    required String overallApproach,
    required String intensityDistribution,
    required String keyWorkouts,
    required String recoveryStrategy,
  }) {
    return (update(goals)..where((g) => g.id.equals(goalId))).write(
      GoalsCompanion(
        rationaleOverallApproach: Value(overallApproach),
        rationaleIntensityDistribution: Value(intensityDistribution),
        rationaleKeyWorkouts: Value(keyWorkouts),
        rationaleRecoveryStrategy: Value(recoveryStrategy),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
