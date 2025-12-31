import 'package:drift/drift.dart';
import '../datasources/local/drift_database.dart';
import '../../features/shared/domain/entities/training/workout.dart';

extension WorkoutDTOMapper on WorkoutDTO {
  Workout toEntity() {
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
      completedAt: completedAt,
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
      completedAt: Value(completedAt),
    );
  }
}
