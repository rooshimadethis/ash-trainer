import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required String userId,
    required DateTime startedAt,
    DateTime? endedAt,
    required int messageCount,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}

@freezed
class ConversationMessage with _$ConversationMessage {
  const factory ConversationMessage({
    required String id,
    required String conversationId,
    required String role, // 'user' or 'assistant'
    required String content,
    required DateTime timestamp,
    FunctionCall? functionCall,
  }) = _ConversationMessage;

  factory ConversationMessage.fromJson(Map<String, dynamic> json) =>
      _$ConversationMessageFromJson(json);
}

@freezed
class FunctionCall with _$FunctionCall {
  const factory FunctionCall({
    required String name,
    required Map<String, dynamic> arguments,
  }) = _FunctionCall;

  factory FunctionCall.fromJson(Map<String, dynamic> json) =>
      _$FunctionCallFromJson(json);
}
