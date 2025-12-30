import 'package:uuid/uuid.dart';
import '../../features/shared/domain/entities/ai/conversation.dart';
import '../../features/shared/domain/repositories/conversation_repository.dart';
import '../datasources/local/daos/conversation_dao.dart';
import '../models/ai_mappers.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  final ConversationDao _dao;

  ConversationRepositoryImpl(this._dao);

  @override
  Future<Conversation> createConversation(String userId) async {
    final id = const Uuid().v4();
    final now = DateTime.now();
    final conversation = Conversation(
      id: id,
      userId: userId,
      startedAt: now,
      messageCount: 0,
    );

    await _dao.createConversation(
      ConversationDTOMapper.toCompanion(conversation),
    );

    return conversation;
  }

  @override
  Future<Conversation?> getConversation(String id) async {
    final dto = await _dao.getConversation(id);
    return dto?.toEntity();
  }

  @override
  Future<Conversation?> getActiveConversation(String userId) async {
    // Basic verification that userId is numeric string, handle parsing
    final userIdInt = int.tryParse(userId);
    if (userIdInt == null) return null;

    final dto = await _dao.getActiveConversation(userIdInt);
    return dto?.toEntity();
  }

  @override
  Future<void> endConversation(String id) async {
    await _dao.endConversation(id, DateTime.now());
  }

  @override
  Future<ConversationMessage> saveMessage({
    required String conversationId,
    required String role,
    required String content,
    FunctionCall? functionCall,
  }) async {
    final id = const Uuid().v4();
    final message = ConversationMessage(
      id: id,
      conversationId: conversationId,
      role: role,
      content: content,
      timestamp: DateTime.now(),
      functionCall: functionCall,
    );

    await _dao.saveMessage(ConversationMessageDTOMapper.toCompanion(message));

    // Update message count in conversation
    // I'll fetch conversion to get current count + 1.
    final conv = await _dao.getConversation(conversationId);
    if (conv != null) {
      await _dao.updateMessageCount(conversationId, conv.messageCount + 1);
    }

    return message;
  }

  @override
  Future<List<ConversationMessage>> getRecentMessages({
    required String conversationId,
    required int limit,
  }) async {
    final dtos = await _dao.getRecentMessages(conversationId, limit);
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<void> deleteOldConversations({required DateTime before}) async {
    await _dao.deleteOldConversations(before);
  }
}
