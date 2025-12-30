import 'package:drift/drift.dart';
import 'users_table.dart';
import 'goals_table.dart';

@DataClassName('LongTermContextDTO')
class LongTermContext extends Table {
  TextColumn get id => text()(); // UUID
  IntColumn get userId => integer().references(Users, #id)();
  IntColumn get goalId => integer().references(Goals, #id)();
  TextColumn get contextJson => text()(); // Serialized LongTermContext
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
