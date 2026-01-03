import 'package:freezed_annotation/freezed_annotation.dart';
import 'conversation.dart';
export 'conversation.dart';

part 'ai_types.freezed.dart';
part 'ai_types.g.dart';

@freezed
class AIRequest with _$AIRequest {
  const factory AIRequest({
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> context,
    Map<String, dynamic>? responseSchema,
    List<FunctionDeclaration>? tools,
  }) = _AIRequest;

  factory AIRequest.fromJson(Map<String, dynamic> json) =>
      _$AIRequestFromJson(json);
}

@freezed
class AIResponse<T> with _$AIResponse<T> {
  const factory AIResponse({
    T? data,
    String? text,
    FunctionCall? functionCall,
    required int tokensUsed,
    double? totalCost,
    required DateTime timestamp,
  }) = _AIResponse;

  // Note: Freezed generic generics might be tricky with fromJson,
  // usually we implement manual fromJson or use specific subclasses.
  // For simplicity, I might rely on manual parsing in the Service layer
  // and just use this as a data holder.
  // I won't generate fromJson for the generic class to avoid issues.
}

@freezed
class FunctionDeclaration with _$FunctionDeclaration {
  const factory FunctionDeclaration({
    required String name,
    required String description,
    required Map<String, dynamic> parameters,
  }) = _FunctionDeclaration;

  factory FunctionDeclaration.fromJson(Map<String, dynamic> json) =>
      _$FunctionDeclarationFromJson(json);
}
