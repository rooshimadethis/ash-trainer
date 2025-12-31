import '../entities/ai/conversation.dart';

abstract class ConversationRepository {
  /// Creates a new conversation session
  Future<Conversation> createConversation(String userId);

  /// Gets a conversation by ID
  Future<Conversation?> getConversation(String id);

  /// Gets the current active conversation for user
  Future<Conversation?> getActiveConversation(String userId);

  /// Ends a conversation session
  Future<void> endConversation(String id);

  /// Saves a message to a conversation
  Future<ConversationMessage> saveMessage({
    required String conversationId,
    required String role,
    required String content,
    FunctionCall? functionCall,
  });

  /// Gets recent messages from a conversation
  Future<List<ConversationMessage>> getRecentMessages({
    required String conversationId,
    required int limit,
  });

  /// Deletes old conversations (cleanup)
  Future<void> deleteOldConversations({
    required DateTime before,
  });
}
