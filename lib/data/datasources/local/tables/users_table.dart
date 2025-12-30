import 'package:drift/drift.dart';

@DataClassName('UserDTO')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get age => integer().nullable()();
  TextColumn get gender => text().nullable()();
  RealColumn get weight => real().nullable()(); // Always stored in KG
  TextColumn get preferredWeightUnit =>
      text().withDefault(const Constant('kg'))(); // UI display preference
  RealColumn get height => real().nullable()(); // Always stored in CM
  TextColumn get preferredHeightUnit =>
      text().withDefault(const Constant('cm'))(); // UI display preference
  TextColumn get availableDays => text()(); // JSON array
  TextColumn get constraints => text().nullable()();
  BoolColumn get healthPermissionsGranted =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
