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
}
