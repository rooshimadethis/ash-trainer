import 'package:drift/drift.dart';
import '../drift_database.dart';
import '../tables/phases_table.dart';
import '../tables/training_blocks_table.dart';

part 'training_plan_dao.g.dart';

@DriftAccessor(tables: [Phases, TrainingBlocks])
class TrainingPlanDao extends DatabaseAccessor<AppDatabase>
    with _$TrainingPlanDaoMixin {
  TrainingPlanDao(super.db);

  Future<void> insertPhases(List<PhasesCompanion> rows) =>
      batch((batch) => batch.insertAll(phases, rows));

  Future<void> insertBlocks(List<TrainingBlocksCompanion> rows) =>
      batch((batch) => batch.insertAll(trainingBlocks, rows));

  Future<void> deletePhasesForGoal(int goalId) {
    return (delete(phases)..where((t) => t.goalId.equals(goalId))).go();
  }

  Future<void> clearFuturePhases(int goalId, DateTime fromDate) async {
    // 1. Delete phases that start strictly in the future
    await (delete(phases)
          ..where((t) =>
              t.goalId.equals(goalId) &
              t.startDate.isBiggerOrEqualValue(fromDate)))
        .go();

    // 2. Clip phases that overlap
    await (update(phases)
          ..where((t) =>
              t.goalId.equals(goalId) &
              t.startDate.isSmallerThanValue(fromDate) &
              t.endDate.isBiggerOrEqualValue(fromDate)))
        .write(PhasesCompanion(
      endDate: Value(fromDate.subtract(const Duration(days: 1))),
    ));
  }

  Future<void> deleteBlocksForGoal(int goalId) async {
    final phaseIds = await (select(phases)
          ..where((t) => t.goalId.equals(goalId)))
        .map((row) => row.id)
        .get();

    if (phaseIds.isNotEmpty) {
      await (delete(trainingBlocks)..where((t) => t.phaseId.isIn(phaseIds)))
          .go();
    }
  }

  Future<void> clearFutureBlocks(int goalId, DateTime fromDate) async {
    final phaseIds = await (select(phases)
          ..where((t) => t.goalId.equals(goalId)))
        .map((row) => row.id)
        .get();

    if (phaseIds.isEmpty) return;

    // 1. Delete blocks that start in the future
    await (delete(trainingBlocks)
          ..where((t) =>
              t.phaseId.isIn(phaseIds) &
              t.startDate.isBiggerOrEqualValue(fromDate)))
        .go();

    // 2. Clip blocks that overlap
    await (update(trainingBlocks)
          ..where((t) =>
              t.phaseId.isIn(phaseIds) &
              t.startDate.isSmallerThanValue(fromDate) &
              t.endDate.isBiggerOrEqualValue(fromDate)))
        .write(TrainingBlocksCompanion(
      endDate: Value(fromDate.subtract(const Duration(days: 1))),
    ));
  }

  Future<TrainingBlockDTO?> getBlockById(String id) {
    return (select(trainingBlocks)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// Get training blocks that overlap with the given date range.
  Future<List<TrainingBlockDTO>> getBlocksForDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return (select(trainingBlocks)
          ..where((t) {
            // Block overlaps if:
            // block.startDate <= range.endDate AND block.endDate >= range.startDate
            return t.startDate.isSmallerOrEqualValue(endDate) &
                t.endDate.isBiggerOrEqualValue(startDate);
          })
          ..orderBy([(t) => OrderingTerm(expression: t.startDate)]))
        .get();
  }

  Stream<List<TrainingBlockDTO>> watchBlocksForDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return (select(trainingBlocks)
          ..where((t) {
            return t.startDate.isSmallerOrEqualValue(endDate) &
                t.endDate.isBiggerOrEqualValue(startDate);
          })
          ..orderBy([(t) => OrderingTerm(expression: t.startDate)]))
        .watch();
  }

  Future<void> updateBlockStats(String blockId, double distance, int duration) {
    return (update(trainingBlocks)..where((t) => t.id.equals(blockId)))
        .write(TrainingBlocksCompanion(
      actualDistance: Value(distance),
      actualDuration: Value(duration),
    ));
  }

  Future<void> updatePhaseStats(String phaseId, double distance, int duration) {
    return (update(phases)..where((t) => t.id.equals(phaseId)))
        .write(PhasesCompanion(
      actualDistance: Value(distance),
      actualDuration: Value(duration),
    ));
  }

  Future<({double distance, int duration})> getStatsForPhase(
      String phaseId) async {
    final distanceQuery = selectOnly(trainingBlocks)
      ..addColumns([trainingBlocks.actualDistance.sum()])
      ..where(trainingBlocks.phaseId.equals(phaseId));

    final durationQuery = selectOnly(trainingBlocks)
      ..addColumns([trainingBlocks.actualDuration.sum()])
      ..where(trainingBlocks.phaseId.equals(phaseId));

    final distanceResult = await distanceQuery.getSingle();
    final durationResult = await durationQuery.getSingle();

    return (
      distance: distanceResult.read(trainingBlocks.actualDistance.sum()) ?? 0.0,
      duration: durationResult.read(trainingBlocks.actualDuration.sum()) ?? 0,
    );
  }
}
