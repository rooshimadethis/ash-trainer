import 'package:drift/drift.dart';
import 'users_table.dart';

@DataClassName('MediumTermContextDTO')
class MediumTermContext extends Table {
  TextColumn get id => text()(); // UUID
  IntColumn get userId => integer().references(Users, #id)();
  DateTimeColumn get periodStart => dateTime()();
  DateTimeColumn get periodEnd => dateTime()();
  TextColumn get contextJson => text()(); // Serialized MediumTermContext
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
