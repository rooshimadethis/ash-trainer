import 'package:drift/drift.dart';

@DataClassName('TrainingBlockDTO')
class TrainingBlocks extends Table {
  TextColumn get id => text()();
  TextColumn get phaseId => text()(); // FK to Phases
  IntColumn get blockNumber => integer()();
  TextColumn get intent => text()();
  IntColumn get durationDays => integer()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
