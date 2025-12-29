import 'package:drift/drift.dart';

@DataClassName('UserDTO')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get availableDays => text()(); // JSON array
  TextColumn get constraints => text().nullable()();
  BoolColumn get healthPermissionsGranted =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
