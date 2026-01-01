import '../../features/shared/domain/entities/goal.dart';
import '../../features/shared/domain/repositories/goal_repository.dart';
import '../datasources/local/daos/goal_dao.dart';
import '../models/goal_mapper.dart';

class GoalRepositoryImpl implements GoalRepository {
  final GoalDao _dao;

  GoalRepositoryImpl(this._dao);

  @override
  Future<Goal> createGoal(Goal goal) async {
    final companion = goal.toCompanion();
    final id = await _dao.insertGoal(companion);

    final createdDto = await _dao.getGoalById(id);
    if (createdDto == null) throw Exception('Failed to create goal');
    return createdDto.toEntity();
  }

  @override
  Future<Goal> getGoal(String id) async {
    final dto = await _dao.getGoalById(int.parse(id));
    if (dto == null) throw Exception('Goal not found');
    return dto.toEntity();
  }

  @override
  Future<List<Goal>> getGoals() async {
    final dtos = await _dao.getAllGoals();
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<Goal?> getActiveGoal() async {
    final dto = await _dao.getActiveGoal();
    return dto?.toEntity();
  }

  @override
  Future<void> updateGoal(Goal goal) async {
    // Convert entity to companion logic isn't strictly necessary for updates if we have the full object,
    // but using replace(DTO) is standard.
    // Need to reconstitute the DTO from the entity.
    // Mappers should probably support Entity -> DTO as well.
    // Let's check goal_mapper.dart... it only had toCompanion for now.
    // Actually, Drift's update(table).replace(Insertable) works with Companions too if the ID is set!

    final companion = goal.toCompanion();
    // Ensure ID is present for update
    if (!companion.id.present) {
      throw Exception('Cannot update goal without ID');
    }

    await _dao.updateGoal(companion);
  }

  @override
  Future<void> updateConfidence({
    required String goalId,
    required double confidence,
    required double adherenceScore,
    required double qualityScore,
    required double consistencyScore,
    required double recoveryScore,
  }) async {
    // Better to use a specific DAO method or partial update companion
    // Assuming we want to do a partial update:
    // We can't easily do partial updates via repository interface if we don't have the whole object,
    // unless we fetch -> modify -> save, or use a custom DAO query.
    // Given the parameters, let's fetch -> modify -> save for safety.

    final id = int.parse(goalId);
    final dto = await _dao.getGoalById(id);
    if (dto != null) {
      final updatedDto = dto.copyWith(
        confidence: confidence,
        adherenceScore: adherenceScore,
        qualityScore: qualityScore,
        consistencyScore: consistencyScore,
        recoveryScore: recoveryScore,
      );
      await _dao.updateGoal(updatedDto);
    }
  }

  @override
  Future<void> updateRationale({
    required String goalId,
    required String overallApproach,
    required String intensityDistribution,
    required String keyWorkouts,
    required String recoveryStrategy,
  }) async {
    await _dao.updateRationale(
      goalId: int.parse(goalId),
      overallApproach: overallApproach,
      intensityDistribution: intensityDistribution,
      keyWorkouts: keyWorkouts,
      recoveryStrategy: recoveryStrategy,
    );
  }

  @override
  Future<void> deactivateGoal(String goalId) async {
    await _dao.deactivateGoal(int.parse(goalId));
  }

  @override
  Future<void> deleteGoal(String goalId) async {
    await _dao.deleteGoal(int.parse(goalId));
  }
}
