import 'package:drift/drift.dart';
import '../datasources/local/drift_database.dart';
import '../../features/shared/domain/entities/goal.dart';

extension GoalDTOMapper on GoalDTO {
  Goal toEntity() {
    return Goal(
      id: id.toString(),
      userId: userId.toString(),
      type: GoalType.values.firstWhere((e) => e.toString() == type),
      name: name,
      isActive: isActive,
      targetDistance: targetDistance,
      targetDate: targetDate,
      targetTime: targetTime,
      currentBestTime: currentBestTime,
      isFirstTime: isFirstTime,
      eventName: eventName,
      eventDate: eventDate,
      maintenanceFrequency: maintenanceFrequency,
      maintenanceDuration: maintenanceDuration,
      endDate: endDate,
      initialTrainingFrequency: initialTrainingFrequency,
      initialWeeklyVolume: initialWeeklyVolume,
      runningPriority: runningPriority,
      strengthPriority: strengthPriority,
      mobilityPriority: mobilityPriority,
      confidence: confidence,
      adherenceScore: adherenceScore,
      qualityScore: qualityScore,
      consistencyScore: consistencyScore,
      recoveryScore: recoveryScore,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension GoalMapper on Goal {
  GoalsCompanion toCompanion() {
    return GoalsCompanion.insert(
      id: Value.absentIfNull(int.tryParse(id)),
      userId: int.parse(userId),
      type: type.toString(),
      name: name,
      isActive: Value(isActive),
      targetDistance: Value(targetDistance),
      targetDate: Value(targetDate),
      targetTime: Value(targetTime),
      currentBestTime: Value(currentBestTime),
      isFirstTime: Value(isFirstTime),
      eventName: Value(eventName),
      eventDate: Value(eventDate),
      maintenanceFrequency: Value(maintenanceFrequency),
      maintenanceDuration: Value(maintenanceDuration),
      endDate: Value(endDate),
      initialTrainingFrequency: Value(initialTrainingFrequency),
      initialWeeklyVolume: Value(initialWeeklyVolume),
      runningPriority: Value(runningPriority),
      strengthPriority: Value(strengthPriority),
      mobilityPriority: Value(mobilityPriority),
      confidence: Value(confidence),
      adherenceScore: Value(adherenceScore),
      qualityScore: Value(qualityScore),
      consistencyScore: Value(consistencyScore),
      recoveryScore: Value(recoveryScore),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
