import 'package:drift/drift.dart';
import 'conversations_table.dart';

@DataClassName('ConversationMessageDTO')
class ConversationMessages extends Table {
  TextColumn get id => text()(); // UUID
  TextColumn get conversationId => text().references(Conversations, #id)();
  TextColumn get role => text()(); // 'user' or 'assistant'
  TextColumn get content => text()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get functionCallName => text().nullable()();
  TextColumn get functionCallArguments => text().nullable()(); // JSON

  @override
  Set<Column> get primaryKey => {id};
}
