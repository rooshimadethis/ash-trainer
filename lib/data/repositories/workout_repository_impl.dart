import '../../features/shared/domain/entities/training/workout.dart';
import '../../features/shared/domain/entities/training/phase.dart';
import '../../features/shared/domain/entities/training/training_block.dart';
import '../../features/shared/domain/repositories/workout_repository.dart';
import '../datasources/local/daos/workout_dao.dart';
import '../datasources/local/daos/training_plan_dao.dart';
import '../models/workout_mapper.dart';
import '../models/phase_mapper.dart';
import '../models/training_block_mapper.dart';

import '../datasources/local/drift_database.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutDao _workoutDao;
  final TrainingPlanDao _trainingPlanDao;

  WorkoutRepositoryImpl(this._workoutDao, this._trainingPlanDao);

  @override
  Future<List<Workout>> getWorkoutsForDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final dtos = await _workoutDao.getWorkoutsForDateRange(startDate, endDate);
    return _hydrateWorkouts(dtos);
  }

  @override
  Stream<List<Workout>> watchWorkoutsForDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return _workoutDao
        .watchWorkoutsForDateRange(startDate, endDate)
        .asyncMap((dtos) => _hydrateWorkouts(dtos));
  }

  @override
  Future<List<TrainingBlock>> getBlocksForDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final dtos = await _trainingPlanDao.getBlocksForDateRange(
      startDate: startDate,
      endDate: endDate,
    );
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<Workout?> getWorkout(String id) async {
    final dto = await _workoutDao.getWorkoutById(id);
    if (dto == null) return null;

    final strengthDtos = await _workoutDao.getStrengthExercises(id);
    final mobilityData = await _workoutDao.getMobilityDetails(id);

    return dto.toEntity(
      strengthExercises: strengthDtos.map((d) => d.toEntity()).toList(),
      mobilitySequence: mobilityData.entries.map((e) {
        return e.key.toEntity(e.value);
      }).toList(),
    );
  }

  @override
  Stream<Workout?> watchWorkout(String id) {
    return _workoutDao.watchWorkoutById(id).asyncMap((dto) async {
      if (dto == null) return null;

      final strengthDtos = await _workoutDao.getStrengthExercises(id);
      final mobilityData = await _workoutDao.getMobilityDetails(id);

      return dto.toEntity(
        strengthExercises: strengthDtos.map((d) => d.toEntity()).toList(),
        mobilitySequence: mobilityData.entries.map((e) {
          return e.key.toEntity(e.value);
        }).toList(),
      );
    });
  }

  @override
  Future<void> saveWorkout(Workout workout) async {
    await _workoutDao.transaction(() async {
      await _workoutDao.insertWorkout(workout.toCompanion());

      if (workout.strengthExercises != null) {
        await _workoutDao.replaceStrengthExercises(
          workout.id,
          workout.strengthExercises!.map((e) => e.toCompanion()).toList(),
        );
      }

      if (workout.mobilitySequence != null) {
        final modules = <MobilityModulesCompanion>[];
        final phases = <MobilityPhasesCompanion>[];

        for (var mod in workout.mobilitySequence!) {
          modules.add(mod.toCompanion());
          phases.addAll(mod.phases.map((p) => p.toCompanion()));
        }

        await _workoutDao.replaceMobilityDetails(workout.id, modules, phases);
      }
    });
  }

  @override
  Future<void> logWorkout(Workout workout) async {
    await _workoutDao.transaction(() async {
      // 1. Update the workout itself
      await _workoutDao.updateWorkout(workout.toCompanion());

      // 2. Recalculate Parent Stats
      if (workout.blockId != null) {
        await _recalculateParentStats(workout.blockId!);
      }
    });
  }

  @override
  Future<void> batchUpdateWorkouts(List<Workout> workouts) async {
    await _workoutDao.transaction(() async {
      for (final workout in workouts) {
        await _workoutDao.updateWorkout(workout.toCompanion());
      }
    });
  }

  @override
  Future<void> unlogWorkout(String workoutId) async {
    await _workoutDao.transaction(() async {
      final dto = await _workoutDao.getWorkoutById(workoutId);
      if (dto == null) return;

      final workout = dto.toEntity();

      // 1. Reset the workout
      final updatedWorkout = workout.copyWith(
        status: 'planned',
        actualDuration: 0,
        actualDistance: 0.0,
        actualPace: null,
        rpe: null,
        completedAt: null,
      );
      await _workoutDao.updateWorkout(updatedWorkout.toCompanion());

      // 2. Recalculate Parent Stats
      if (workout.blockId != null) {
        await _recalculateParentStats(workout.blockId!);
      }
    });
  }

  /// Centralized logic to recalculate stats for a block and its parent phase.
  /// Should be called within a database transaction.
  Future<void> _recalculateParentStats(String blockId) async {
    // 1. Recalculate and update Block stats
    final blockStats = await _workoutDao.getStatsForBlock(blockId);
    await _trainingPlanDao.updateBlockStats(
      blockId,
      blockStats.distance,
      blockStats.duration,
    );

    // 2. Find the parent Phase ID
    final blockDto = await _trainingPlanDao.getBlockById(blockId);
    if (blockDto == null) return;

    // 3. Recalculate and update Phase stats
    final phaseStats =
        await _trainingPlanDao.getStatsForPhase(blockDto.phaseId);
    await _trainingPlanDao.updatePhaseStats(
      blockDto.phaseId,
      phaseStats.distance,
      phaseStats.duration,
    );
  }

  @override
  Future<void> saveFullTrainingPlan({
    required List<Phase> phases,
    required List<TrainingBlock> blocks,
    required List<Workout> workouts,
  }) async {
    final phaseCompanions = phases.map((p) => p.toCompanion()).toList();
    final blockCompanions = blocks.map((b) => b.toCompanion()).toList();
    final workoutCompanions = workouts.map((w) => w.toCompanion()).toList();

    await _trainingPlanDao.insertPhases(phaseCompanions);
    await _trainingPlanDao.insertBlocks(blockCompanions);
    await _workoutDao.batchInsertWorkouts(workoutCompanions);

    // Save details for each workout
    for (var w in workouts) {
      if (w.strengthExercises != null) {
        await _workoutDao.replaceStrengthExercises(
          w.id,
          w.strengthExercises!.map((e) => e.toCompanion()).toList(),
        );
      }

      if (w.mobilitySequence != null) {
        final modules = <MobilityModulesCompanion>[];
        final phases = <MobilityPhasesCompanion>[];

        for (var mod in w.mobilitySequence!) {
          modules.add(mod.toCompanion());
          phases.addAll(mod.phases.map((p) => p.toCompanion()));
        }

        await _workoutDao.replaceMobilityDetails(w.id, modules, phases);
      }
    }
  }

  @override
  Future<void> deleteWorkoutsForGoal(String goalId) async {
    final gId = int.parse(goalId);
    // Delete in order: workouts -> blocks -> phases
    await _workoutDao.deleteWorkoutsForGoal(gId);
    await _trainingPlanDao.deleteBlocksForGoal(gId);
    await _trainingPlanDao.deletePhasesForGoal(gId);
  }

  @override
  Future<List<Workout>> getWorkoutsForGoal(String goalId) async {
    final dtos = await _workoutDao.getWorkoutsForGoal(int.parse(goalId));
    return _hydrateWorkouts(dtos);
  }

  @override
  Future<int> getConsecutiveMissedDays(String goalId) async {
    final gId = int.parse(goalId);
    final lastCompleted = await _workoutDao.getLastCompletedWorkoutDate(gId);
    if (lastCompleted == null) return 0; // Assume new plan if no history

    // If last completed was yesterday, diff is 1. Missed days = 0.
    // If last completed was 2 days ago, diff is 2. Missed days = 1.
    final diff = DateTime.now().difference(lastCompleted).inDays;
    return (diff - 1).clamp(0, 9999);
  }

  @override
  Future<DateTime?> getLastScheduledWorkoutDate(String goalId) {
    return _workoutDao.getLastScheduledWorkoutDate(int.parse(goalId));
  }

  @override
  Future<void> deleteFutureWorkouts(
      {required String goalId, required DateTime fromDate}) {
    return _workoutDao.deleteFutureWorkouts(int.parse(goalId), fromDate);
  }

  /// Helper method to batch-load workout details for multiple workouts.
  /// This prevents N+1 query problems when loading workout lists.
  Future<List<Workout>> _hydrateWorkouts(List<WorkoutDTO> dtos) async {
    if (dtos.isEmpty) return [];

    final workoutIds = dtos.map((dto) => dto.id).toList();

    // Batch load all details
    final strengthMap =
        await _workoutDao.getStrengthExercisesForWorkouts(workoutIds);
    final mobilityMap =
        await _workoutDao.getMobilityDetailsForWorkouts(workoutIds);

    // Map DTOs to entities with their details
    return dtos.map((dto) {
      final strengthDtos = strengthMap[dto.id] ?? [];
      final mobilityData = mobilityMap[dto.id] ?? {};

      return dto.toEntity(
        strengthExercises: strengthDtos.map((d) => d.toEntity()).toList(),
        mobilitySequence: mobilityData.entries.map((e) {
          return e.key.toEntity(e.value);
        }).toList(),
      );
    }).toList();
  }
}
