import 'package:drift/drift.dart';

@DataClassName('TimeOffDTO')
class TimeOffs extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  TextColumn get reason => text().nullable()(); // e.g., "vacation", "sick"
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
