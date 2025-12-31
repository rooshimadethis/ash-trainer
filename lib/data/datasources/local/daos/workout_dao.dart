import 'package:drift/drift.dart';
import '../drift_database.dart';
import '../tables/workouts_table.dart';

part 'workout_dao.g.dart';

@DriftAccessor(tables: [Workouts])
class WorkoutDao extends DatabaseAccessor<AppDatabase> with _$WorkoutDaoMixin {
  WorkoutDao(super.db);

  Future<List<WorkoutDTO>> getWorkoutsForDateRange(
      DateTime start, DateTime end) {
    return (select(workouts)
          ..where(
              (t) => t.scheduledDate.isBetween(Variable(start), Variable(end)))
          ..orderBy([(t) => OrderingTerm(expression: t.scheduledDate)]))
        .get();
  }

  Future<WorkoutDTO?> getWorkoutById(String id) {
    return (select(workouts)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<void> insertWorkout(Insertable<WorkoutDTO> workout) {
    return into(workouts).insert(workout, mode: InsertMode.replace);
  }

  Future<void> updateWorkout(Insertable<WorkoutDTO> workout) {
    return update(workouts).replace(workout);
  }

  Future<void> batchInsertWorkouts(List<Insertable<WorkoutDTO>> list) {
    return batch((batch) {
      batch.insertAll(workouts, list, mode: InsertMode.replace);
    });
  }

  Future<void> deleteWorkoutsForGoal(int goalId) {
    return (delete(workouts)..where((t) => t.goalId.equals(goalId))).go();
  }

  Future<({double distance, int duration})> getStatsForBlock(
      String blockId) async {
    final distanceQuery = selectOnly(workouts)
      ..addColumns([workouts.actualDistance.sum()])
      ..where(workouts.blockId.equals(blockId) &
          workouts.status.equals('completed'));

    final durationQuery = selectOnly(workouts)
      ..addColumns([workouts.actualDuration.sum()])
      ..where(workouts.blockId.equals(blockId) &
          workouts.status.equals('completed'));

    final distanceResult = await distanceQuery.getSingle();
    final durationResult = await durationQuery.getSingle();

    return (
      distance: distanceResult.read(workouts.actualDistance.sum()) ?? 0.0,
      duration: durationResult.read(workouts.actualDuration.sum()) ?? 0,
    );
  }
}
