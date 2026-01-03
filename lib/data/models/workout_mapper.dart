import 'package:drift/drift.dart';
import '../datasources/local/drift_database.dart';
import '../../features/shared/domain/entities/training/workout.dart';
import '../../features/shared/domain/entities/training/strength_exercise.dart';
import '../../features/shared/domain/entities/training/mobility_module.dart';

extension WorkoutDTOMapper on WorkoutDTO {
  Workout toEntity({
    List<StrengthExercise>? strengthExercises,
    List<MobilityModule>? mobilitySequence,
  }) {
    return Workout(
      id: id,
      userId: userId.toString(),
      goalId: goalId.toString(),
      phaseId: phaseId,
      blockId: blockId,
      scheduledDate: scheduledDate,
      type: type,
      name: name,
      plannedDuration: plannedDuration,
      plannedDistance: plannedDistance,
      intensity: intensity,
      description: description,
      status: status,
      actualDuration: actualDuration,
      actualDistance: actualDistance,
      actualPace: actualPace,
      rpe: rpe,
      syncedFrom: syncedFrom,
      isKey: isKey,
      completedAt: completedAt,
      strengthExercises: strengthExercises,
      mobilitySequence: mobilitySequence,
    );
  }
}

extension StrengthExerciseDTOMapper on StrengthExerciseDTO {
  StrengthExercise toEntity() {
    return StrengthExercise(
      id: id,
      workoutId: workoutId,
      name: name,
      sets: sets,
      reps: reps,
      rpe: rpe,
      notes: notes,
    );
  }
}

extension MobilityModuleDTOMapper on MobilityModuleDTO {
  MobilityModule toEntity(List<MobilityPhaseDTO> phases) {
    return MobilityModule(
      id: id,
      workoutId: workoutId,
      exerciseName: exerciseName,
      targetJoint: targetJoint,
      setupInstructions: setupInstructions,
      totalCycles: totalCycles,
      phases: phases.map((p) => p.toEntity()).toList(),
    );
  }
}

extension MobilityPhaseDTOMapper on MobilityPhaseDTO {
  MobilityPhase toEntity() {
    return MobilityPhase(
      id: id,
      moduleId: moduleId,
      phaseType: phaseType,
      durationSeconds: durationSeconds,
      reps: reps,
      holdTimeSeconds: holdTimeSeconds,
      instruction: instruction,
      intensityNotes: intensityNotes,
      irradiationPct: irradiationPct,
      notes: notes,
      sequenceOrder: sequenceOrder,
    );
  }
}

extension WorkoutMapper on Workout {
  WorkoutsCompanion toCompanion() {
    return WorkoutsCompanion.insert(
      id: id,
      userId: int.parse(userId),
      goalId: int.parse(goalId),
      phaseId: Value(phaseId),
      blockId: Value(blockId),
      scheduledDate: scheduledDate,
      type: type,
      name: name,
      plannedDuration: plannedDuration,
      plannedDistance: Value(plannedDistance),
      intensity: Value(intensity),
      description: Value(description),
      status: status,
      actualDuration: Value(actualDuration),
      actualDistance: Value(actualDistance),
      actualPace: Value(actualPace),
      rpe: Value(rpe),
      syncedFrom: Value(syncedFrom),
      isKey: Value(isKey),
      completedAt: Value(completedAt),
    );
  }
}

extension StrengthExerciseMapper on StrengthExercise {
  StrengthExercisesCompanion toCompanion() {
    return StrengthExercisesCompanion.insert(
      id: id,
      workoutId: workoutId,
      name: name,
      sets: sets,
      reps: reps,
      rpe: rpe,
      notes: Value(notes),
    );
  }
}

extension MobilityModuleMapper on MobilityModule {
  MobilityModulesCompanion toCompanion() {
    return MobilityModulesCompanion.insert(
      id: id,
      workoutId: workoutId,
      exerciseName: exerciseName,
      targetJoint: targetJoint,
      setupInstructions: setupInstructions,
      totalCycles: totalCycles,
    );
  }
}

extension MobilityPhaseMapper on MobilityPhase {
  MobilityPhasesCompanion toCompanion() {
    return MobilityPhasesCompanion.insert(
      id: id,
      moduleId: moduleId,
      phaseType: phaseType,
      durationSeconds: Value(durationSeconds),
      reps: Value(reps),
      holdTimeSeconds: Value(holdTimeSeconds),
      instruction: Value(instruction),
      intensityNotes: Value(intensityNotes),
      irradiationPct: Value(irradiationPct),
      notes: Value(notes),
      sequenceOrder: sequenceOrder,
    );
  }
}
