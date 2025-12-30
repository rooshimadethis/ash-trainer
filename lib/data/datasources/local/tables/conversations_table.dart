import 'package:drift/drift.dart';
import 'users_table.dart';

@DataClassName('ConversationDTO')
class Conversations extends Table {
  TextColumn get id => text()(); // UUID
  IntColumn get userId => integer().references(Users, #id)();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  IntColumn get messageCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
