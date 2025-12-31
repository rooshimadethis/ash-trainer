import 'package:drift/drift.dart';
import '../datasources/local/drift_database.dart';
import '../../features/shared/domain/entities/training/phase.dart';

extension PhaseMapper on Phase {
  PhasesCompanion toCompanion() {
    return PhasesCompanion.insert(
      id: id,
      goalId: int.parse(goalId),
      phaseNumber: phaseNumber,
      phaseType: phaseType,
      durationWeeks: durationWeeks,
      targetWeeklyVolume: targetWeeklyVolume,
      targetWeeklyDuration: targetWeeklyDuration,
      startDate: Value(startDate),
      endDate: Value(endDate),
      description: Value(description),
      actualDistance: Value(actualDistance),
      actualDuration: Value(actualDuration),
    );
  }
}

extension PhaseDTOMapper on PhaseDTO {
  Phase toEntity() {
    return Phase(
      id: id,
      goalId: goalId.toString(),
      phaseNumber: phaseNumber,
      phaseType: phaseType,
      durationWeeks: durationWeeks,
      targetWeeklyVolume: targetWeeklyVolume,
      targetWeeklyDuration: targetWeeklyDuration,
      startDate: startDate,
      endDate: endDate,
      description: description,
      actualDistance: actualDistance,
      actualDuration: actualDuration,
    );
  }
}
