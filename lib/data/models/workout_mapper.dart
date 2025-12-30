import 'package:drift/drift.dart';
import '../datasources/local/drift_database.dart';
import '../../features/shared/domain/entities/workout.dart';

extension WorkoutDTOMapper on WorkoutDTO {
  Workout toEntity() {
    return Workout(
      id: id,
      userId: userId.toString(),
      goalId: goalId.toString(),
      mesocycleId: mesocycleId,
      microcycleId: microcycleId,
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
      mesocycleId: Value(mesocycleId),
      microcycleId: Value(microcycleId),
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
      completedAt: Value(completedAt),
    );
  }
}
