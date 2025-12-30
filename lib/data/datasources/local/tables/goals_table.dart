import 'package:drift/drift.dart';
import 'users_table.dart';

@DataClassName('GoalDTO')
class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  TextColumn get type => text()();
  TextColumn get name => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  // Goal specific fields
  RealColumn get targetDistance => real().nullable()();
  DateTimeColumn get targetDate => dateTime().nullable()();
  IntColumn get targetTime => integer().nullable()();
  IntColumn get currentBestTime => integer().nullable()();
  BoolColumn get isFirstTime => boolean().nullable()();
  TextColumn get eventName => text().nullable()();
  DateTimeColumn get eventDate => dateTime().nullable()();
  IntColumn get maintenanceFrequency => integer().nullable()();
  IntColumn get maintenanceDuration => integer().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();

  // Initial Context
  IntColumn get initialTrainingFrequency => integer().nullable()();
  RealColumn get initialWeeklyVolume => real().nullable()(); // In km
  TextColumn get runningPriority => text().nullable()();
  TextColumn get strengthPriority => text().nullable()();
  TextColumn get mobilityPriority => text().nullable()();

  // Progress metrics
  RealColumn get confidence => real().withDefault(const Constant(0.0))();
  RealColumn get adherenceScore => real().withDefault(const Constant(0.0))();
  RealColumn get qualityScore => real().withDefault(const Constant(0.0))();
  RealColumn get consistencyScore => real().withDefault(const Constant(0.0))();
  RealColumn get recoveryScore => real().withDefault(const Constant(0.0))();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
