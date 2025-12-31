import 'package:drift/drift.dart';

@DataClassName('PhaseDTO')
class Phases extends Table {
  TextColumn get id => text()();
  IntColumn get goalId => integer()(); // FK to Goals
  IntColumn get phaseNumber => integer()();
  TextColumn get phaseType => text()();
  IntColumn get durationWeeks => integer()();
  TextColumn get targetWeeklyVolume => text()();
  TextColumn get targetWeeklyDuration => text()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get description => text().nullable()();

  // Stats
  RealColumn get actualDistance => real().withDefault(const Constant(0.0))();
  IntColumn get actualDuration => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
