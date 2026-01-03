import 'package:drift/drift.dart';
import 'workouts_table.dart';

@DataClassName('StrengthExerciseDTO')
class StrengthExercises extends Table {
  TextColumn get id => text()();
  TextColumn get workoutId =>
      text().references(Workouts, #id, onDelete: KeyAction.cascade)();

  TextColumn get name => text()();
  IntColumn get sets => integer()();
  TextColumn get reps =>
      text()(); // String to allow ranges "8-12" or time "30s"
  IntColumn get rpe => integer()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MobilityModuleDTO')
class MobilityModules extends Table {
  TextColumn get id => text()();
  TextColumn get workoutId =>
      text().references(Workouts, #id, onDelete: KeyAction.cascade)();

  TextColumn get exerciseName => text()();
  TextColumn get targetJoint => text()();
  TextColumn get setupInstructions => text()();
  IntColumn get totalCycles => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MobilityPhaseDTO')
class MobilityPhases extends Table {
  TextColumn get id => text()();
  TextColumn get moduleId =>
      text().references(MobilityModules, #id, onDelete: KeyAction.cascade)();

  // 'Passive', 'PAILs', 'RAILs', 'Integration'
  TextColumn get phaseType => text()();

  IntColumn get durationSeconds => integer().nullable()();
  IntColumn get reps => integer().nullable()();
  IntColumn get holdTimeSeconds => integer().nullable()();

  // "Deep breathing", "70% Irradiation", etc.
  TextColumn get instruction => text().nullable()();

  // Intensity guidance (e.g., "Deep breathing", "Gentle stretch")
  TextColumn get intensityNotes => text().nullable()();

  // Irradiation/tension percentage for PAILs/RAILs phases (0-100)
  IntColumn get irradiationPct => integer().nullable()();

  // Additional notes (e.g., target joint override or other details)
  TextColumn get notes => text().nullable()();

  // Sorting order within the module
  IntColumn get sequenceOrder => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
