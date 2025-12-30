import 'package:drift/drift.dart';
import '../drift_database.dart';
import '../tables/conversations_table.dart';
import '../tables/conversation_messages_table.dart';

part 'conversation_dao.g.dart';

@DriftAccessor(tables: [Conversations, ConversationMessages])
class ConversationDao extends DatabaseAccessor<AppDatabase>
    with _$ConversationDaoMixin {
  ConversationDao(super.db);

  Future<void> createConversation(Insertable<ConversationDTO> conversation) =>
      into(conversations).insert(conversation);

  Future<ConversationDTO?> getConversation(String id) =>
      (select(conversations)..where((c) => c.id.equals(id))).getSingleOrNull();

  Future<ConversationDTO?> getActiveConversation(int userId) {
    return (select(conversations)
          ..where((c) => c.userId.equals(userId) & c.endedAt.isNull()))
        .getSingleOrNull();
  }

  Future<void> endConversation(String id, DateTime endedAt) {
    return (update(conversations)..where((c) => c.id.equals(id))).write(
      ConversationsCompanion(endedAt: Value(endedAt)),
    );
  }

  Future<void> saveMessage(Insertable<ConversationMessageDTO> message) =>
      into(conversationMessages).insert(message);

  Future<List<ConversationMessageDTO>> getRecentMessages(
      String conversationId, int limit) {
    return (select(conversationMessages)
          ..where((m) => m.conversationId.equals(conversationId))
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc),
          ])
          ..limit(limit))
        .get();
  }

  Future<void> deleteOldConversations(DateTime before) {
    return (delete(conversations)
          ..where((c) => c.startedAt.isSmallerThanValue(before)))
        .go();
  }

  Future<void> updateMessageCount(String id, int count) {
    return (update(conversations)..where((c) => c.id.equals(id))).write(
      ConversationsCompanion(messageCount: Value(count)),
    );
  }
}
