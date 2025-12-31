import 'dart:convert';
import 'package:drift/drift.dart';
import '../../features/shared/domain/entities/ai/conversation.dart';
import '../../features/shared/domain/entities/ai/context_models.dart';
import '../datasources/local/drift_database.dart';

// Conversation Mapper
extension ConversationDTOMapper on ConversationDTO {
  Conversation toEntity() {
    return Conversation(
      id: id,
      userId: userId.toString(),
      startedAt: startedAt,
      endedAt: endedAt,
      messageCount: messageCount,
    );
  }

  static ConversationsCompanion toCompanion(Conversation conversation) {
    return ConversationsCompanion(
      id: Value(conversation.id),
      userId: Value(int.parse(conversation.userId)),
      startedAt: Value(conversation.startedAt),
      endedAt: Value(conversation.endedAt),
      messageCount: Value(conversation.messageCount),
    );
  }
}

// Conversation Message Mapper
extension ConversationMessageDTOMapper on ConversationMessageDTO {
  ConversationMessage toEntity() {
    FunctionCall? parsedFunctionCall;
    if (functionCallName != null && functionCallArguments != null) {
      try {
        parsedFunctionCall = FunctionCall(
          name: functionCallName!,
          arguments: jsonDecode(functionCallArguments!) as Map<String, dynamic>,
        );
      } catch (e) {
        // Handle parse error or ignore
      }
    }

    return ConversationMessage(
      id: id,
      conversationId: conversationId,
      role: role,
      content: content,
      timestamp: timestamp,
      functionCall: parsedFunctionCall,
    );
  }

  static ConversationMessagesCompanion toCompanion(
      ConversationMessage message) {
    return ConversationMessagesCompanion(
      id: Value(message.id),
      conversationId: Value(message.conversationId),
      role: Value(message.role),
      content: Value(message.content),
      timestamp: Value(message.timestamp),
      functionCallName: Value(message.functionCall?.name),
      functionCallArguments: Value(message.functionCall != null
          ? jsonEncode(message.functionCall!.arguments)
          : null),
    );
  }
}

// Long Term Context Mapper
extension LongTermContextDTOMapper on LongTermContextDTO {
  LongTermContext toEntity() {
    return LongTermContext.fromJson(
        jsonDecode(contextJson) as Map<String, dynamic>);
  }

  static LongTermContextCompanion toCompanion({
    required LongTermContext context,
    required String id,
    required String userId,
    required String goalId,
  }) {
    return LongTermContextCompanion(
      id: Value(id),
      userId: Value(int.parse(userId)),
      goalId: Value(int.parse(goalId)),
      contextJson: Value(jsonEncode(context.toJson())),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    );
  }
}

// Medium Term Context Mapper
extension MediumTermContextDTOMapper on MediumTermContextDTO {
  MediumTermContext toEntity() {
    return MediumTermContext.fromJson(
        jsonDecode(contextJson) as Map<String, dynamic>);
  }

  static MediumTermContextCompanion toCompanion({
    required MediumTermContext context,
    required String id,
    required String userId,
  }) {
    return MediumTermContextCompanion(
      id: Value(id),
      userId: Value(int.parse(userId)),
      periodStart: Value(context.periodStart),
      periodEnd: Value(context.periodEnd),
      contextJson: Value(jsonEncode(context.toJson())),
      createdAt: Value(DateTime.now()),
    );
  }
}
