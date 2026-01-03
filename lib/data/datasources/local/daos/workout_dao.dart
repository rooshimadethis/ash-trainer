import 'package:drift/drift.dart';
import '../drift_database.dart';
import '../tables/workouts_table.dart';
import '../tables/workout_details_tables.dart';

part 'workout_dao.g.dart';

@DriftAccessor(
    tables: [Workouts, StrengthExercises, MobilityModules, MobilityPhases])
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

  Stream<List<WorkoutDTO>> watchWorkoutsForDateRange(
      DateTime start, DateTime end) {
    return (select(workouts)
          ..where(
              (t) => t.scheduledDate.isBetween(Variable(start), Variable(end)))
          ..orderBy([(t) => OrderingTerm(expression: t.scheduledDate)]))
        .watch();
  }

  Future<WorkoutDTO?> getWorkoutById(String id) {
    return (select(workouts)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Stream<WorkoutDTO?> watchWorkoutById(String id) {
    return (select(workouts)..where((t) => t.id.equals(id)))
        .watchSingleOrNull();
  }

  Stream<List<WorkoutDTO>> watchWorkoutsForGoal(int goalId) {
    return (select(workouts)..where((t) => t.goalId.equals(goalId))).watch();
  }

  Future<List<WorkoutDTO>> getWorkoutsForGoal(int goalId) {
    return (select(workouts)..where((t) => t.goalId.equals(goalId))).get();
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

  Future<int> deleteWorkout(String id) {
    return (delete(workouts)..where((t) => t.id.equals(id))).go();
  }

  Future<DateTime?> getLastScheduledWorkoutDate(int goalId) {
    return (select(workouts)
          ..where((t) => t.goalId.equals(goalId))
          ..orderBy([
            (t) => OrderingTerm(
                expression: t.scheduledDate, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .map((t) => t.scheduledDate)
        .getSingleOrNull();
  }

  Future<void> deleteFutureWorkouts(int goalId, DateTime fromDate) {
    return (delete(workouts)
          ..where((t) =>
              t.goalId.equals(goalId) &
              t.scheduledDate.isBiggerThan(Variable(fromDate))))
        .go();
  }

  Future<DateTime?> getLastCompletedWorkoutDate(int goalId) {
    return (select(workouts)
          ..where((t) => t.goalId.equals(goalId) & t.status.equals('completed'))
          ..orderBy([
            (t) => OrderingTerm(
                expression: t.scheduledDate, mode: OrderingMode.desc)
          ])
          ..limit(1))
        .map((t) => t.scheduledDate)
        .getSingleOrNull();
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

  // --- Strength & Mobility Helpers ---

  Future<List<StrengthExerciseDTO>> getStrengthExercises(String workoutId) {
    return (select(strengthExercises)
          ..where((t) => t.workoutId.equals(workoutId)))
        .get();
  }

  Future<void> replaceStrengthExercises(
      String workoutId, List<Insertable<StrengthExerciseDTO>> exercises) async {
    return transaction(() async {
      await (delete(strengthExercises)
            ..where((t) => t.workoutId.equals(workoutId)))
          .go();
      await batch((batch) {
        batch.insertAll(strengthExercises, exercises);
      });
    });
  }

  Future<Map<MobilityModuleDTO, List<MobilityPhaseDTO>>> getMobilityDetails(
      String workoutId) async {
    final modules = await (select(mobilityModules)
          ..where((t) => t.workoutId.equals(workoutId)))
        .get();

    if (modules.isEmpty) return {};

    final moduleIds = modules.map((m) => m.id).toList();
    final phases = await (select(mobilityPhases)
          ..where((t) => t.moduleId.isIn(moduleIds))
          ..orderBy([(t) => OrderingTerm(expression: t.sequenceOrder)]))
        .get();

    final result = <MobilityModuleDTO, List<MobilityPhaseDTO>>{};
    for (var mod in modules) {
      result[mod] = phases.where((p) => p.moduleId == mod.id).toList();
    }
    return result;
  }

  Future<void> replaceMobilityDetails(
      String workoutId,
      List<Insertable<MobilityModuleDTO>> modules,
      List<Insertable<MobilityPhaseDTO>> phases) async {
    return transaction(() async {
      // Cascade delete should handle phases if we delete modules, but let's be safe/explicit if needed.
      // Actually Drift foreign keys with cascade will handle it if enabled.
      // But we must fetch existing module IDs to delete phases?
      // Or just delete modules by workoutID.
      // "TextColumn get workoutId => text().references(Workouts, #id, onDelete: KeyAction.cascade)();"
      // Wait, MobilityModules refers to Workouts. Phases refer to Modules.
      // Deleting a Workout deletes its Modules. Deleting a Module deletes its Phases.
      // But here we are just REPLACING the content for an existing workout.

      // 1. Delete existing modules for this workout (Phases will cascade delete)
      await (delete(mobilityModules)
            ..where((t) => t.workoutId.equals(workoutId)))
          .go();

      // 2. Insert new
      await batch((batch) {
        batch.insertAll(mobilityModules, modules);
        batch.insertAll(mobilityPhases, phases);
      });
    });
  }

  // --- Batch Loading for Performance ---

  /// Load strength exercises for multiple workouts at once.
  /// Returns a map of workoutId to List of StrengthExerciseDTO.
  Future<Map<String, List<StrengthExerciseDTO>>>
      getStrengthExercisesForWorkouts(List<String> workoutIds) async {
    if (workoutIds.isEmpty) return {};

    final exercises = await (select(strengthExercises)
          ..where((t) => t.workoutId.isIn(workoutIds)))
        .get();

    // Group by workoutId
    final result = <String, List<StrengthExerciseDTO>>{};
    for (var exercise in exercises) {
      result.putIfAbsent(exercise.workoutId, () => []).add(exercise);
    }
    return result;
  }

  /// Load mobility details for multiple workouts at once.
  /// Returns a map of workoutId to Map of MobilityModuleDTO to List of MobilityPhaseDTO.
  Future<Map<String, Map<MobilityModuleDTO, List<MobilityPhaseDTO>>>>
      getMobilityDetailsForWorkouts(List<String> workoutIds) async {
    if (workoutIds.isEmpty) return {};

    // 1. Load all modules for these workouts
    final modules = await (select(mobilityModules)
          ..where((t) => t.workoutId.isIn(workoutIds)))
        .get();

    if (modules.isEmpty) return {};

    // 2. Load all phases for these modules
    final moduleIds = modules.map((m) => m.id).toList();
    final phases = await (select(mobilityPhases)
          ..where((t) => t.moduleId.isIn(moduleIds))
          ..orderBy([(t) => OrderingTerm(expression: t.sequenceOrder)]))
        .get();

    // 3. Group phases by moduleId
    final phasesByModule = <String, List<MobilityPhaseDTO>>{};
    for (var phase in phases) {
      phasesByModule.putIfAbsent(phase.moduleId, () => []).add(phase);
    }

    // 4. Group modules by workoutId, with their phases
    final result = <String, Map<MobilityModuleDTO, List<MobilityPhaseDTO>>>{};
    for (var module in modules) {
      final workoutMap = result.putIfAbsent(module.workoutId, () => {});
      workoutMap[module] = phasesByModule[module.id] ?? [];
    }

    return result;
  }
}
