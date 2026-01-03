import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart' as gemini;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../features/shared/domain/entities/ai/context_models.dart';
import '../../features/shared/domain/entities/ai/ai_types.dart';
import '../../features/shared/domain/entities/ai/training_plan_response.dart';
import '../../features/shared/domain/entities/training/workout.dart';
import '../../features/shared/domain/entities/ai/conversation.dart';
import '../../core/constants/ai_constants.dart';
import '../../core/config/ai_config.dart';
import '../../core/utils/logger.dart';
import 'ai_service.dart';

class AIServiceImpl implements AIService {
  late final gemini.GenerativeModel _model;
  final String _apiKey;

  AIServiceImpl({String? apiKey})
      : _apiKey = apiKey ?? dotenv.env[AIConstants.apiKeyEnv] ?? '' {
    if (_apiKey.isEmpty) {
      throw Exception(
          'Gemini API Key not found. Please set ${AIConstants.apiKeyEnv} in .env file.');
    }
    _model = gemini.GenerativeModel(
      model: AIConstants.modelName,
      apiKey: _apiKey,
    );
  }

  // --- Plan Generation ---

  @override
  Future<AIResponse<TrainingPlan>> generatePlan({
    required PlanGenerationContext context,
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> responseSchema,
  }) async {
    final prompt = _buildPrompt(
      systemPrompt: systemPrompt,
      taskPrompt: taskPrompt,
      context: PlanGenerationContext.activeToJson(context),
    );

    final content = [gemini.Content.text(prompt)];

    // DEBUG: Log Request
    AppLogger.i('--- AI REQUEST (Generate Plan) ---');
    AppLogger.i(prompt);

    final schema = _mapJsonSchemaToSdkSchema(responseSchema);

    final response = await _model.generateContent(
      content,
      generationConfig: gemini.GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: schema,
        temperature: AIConfig.getConfig(AITaskType.planGeneration).temperature,
        topK: AIConfig.getConfig(AITaskType.planGeneration).topK,
        topP: AIConfig.getConfig(AITaskType.planGeneration).topP,
        maxOutputTokens:
            AIConfig.getConfig(AITaskType.planGeneration).maxOutputTokens,
      ),
    );

    if (response.text == null) {
      throw Exception('Empty response from AI');
    }

    // DEBUG: Log raw response to console before parsing
    AppLogger.i('--- RAW AI RESPONSE (Pre-Parsing) ---');
    AppLogger.i(response.text!);

    dynamic json;
    try {
      json = _parseJson(response.text!); // Now returns dynamic

      // Safety check for Plan: should be a Map
      if (json is! Map<String, dynamic>) {
        throw Exception(
            'Expected JSON object for Training Plan, got ${json.runtimeType}');
      }

      final plan = TrainingPlan.fromJson(json);

      return AIResponse(
        data: plan,
        text: response.text,
        functionCall: null,
        tokensUsed: response.usageMetadata?.totalTokenCount ?? 0,
        timestamp: DateTime.now(),
      );
    } catch (e, stack) {
      AppLogger.e('AI Processing Error', error: e, stackTrace: stack);
      throw AIProcessingException(e.toString(), rawResponse: response.text);
    }
  }

  // --- Workout Adjustment ---

  @override
  Future<AIResponse<Workout>> adjustWorkout({
    required Workout plannedWorkout,
    required String userFeedback,
    required ShortTermContext context,
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> responseSchema,
  }) async {
    final contextMap = context.toJson();
    contextMap['planned_workout'] = plannedWorkout.toJson();
    contextMap['user_feedback'] = userFeedback;

    final prompt = _buildPrompt(
      systemPrompt: systemPrompt,
      taskPrompt: taskPrompt,
      context: contextMap,
    );

    final content = [gemini.Content.text(prompt)];

    // DEBUG: Log Request
    AppLogger.i('--- AI REQUEST (Adjust Workout) ---');
    AppLogger.i(prompt);

    final schema = _mapJsonSchemaToSdkSchema(responseSchema);

    final response = await _model.generateContent(
      content,
      generationConfig: gemini.GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: schema,
        temperature:
            AIConfig.getConfig(AITaskType.workoutAdjustment).temperature,
        topK: AIConfig.getConfig(AITaskType.workoutAdjustment).topK,
        topP: AIConfig.getConfig(AITaskType.workoutAdjustment).topP,
        maxOutputTokens:
            AIConfig.getConfig(AITaskType.workoutAdjustment).maxOutputTokens,
      ),
    );

    if (response.text == null) {
      throw Exception('Empty response from AI');
    }

    // DEBUG: Log Raw Response
    AppLogger.i('--- AI RESPONSE (Adjust Workout) ---');
    AppLogger.i(response.text!);

    final json = _parseJson(response.text!);

    if (json is! Map<String, dynamic>) {
      throw Exception(
          'Expected JSON object for Workout, got ${json.runtimeType}');
    }

    final workout = Workout.fromJson(json);

    return AIResponse(
      data: workout,
      text: null,
      functionCall: null,
      tokensUsed: response.usageMetadata?.totalTokenCount ?? 0,
      timestamp: DateTime.now(),
    );
  }

  // --- Rescheduling ---

  @override
  Future<AIResponse<List<Workout>>> rescheduleWorkouts({
    required List<String> workoutIds,
    required String reason,
    required ShortTermContext context,
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> responseSchema,
  }) async {
    final contextMap = context.toJson();
    contextMap['workout_ids_to_reschedule'] = workoutIds;
    contextMap['reschedule_reason'] = reason;

    final prompt = _buildPrompt(
      systemPrompt: systemPrompt,
      taskPrompt: taskPrompt,
      context: contextMap,
    );

    final content = [gemini.Content.text(prompt)];

    // DEBUG: Log Request
    AppLogger.i('--- AI REQUEST (Reschedule Workouts) ---');
    AppLogger.i(prompt);

    final schema = _mapJsonSchemaToSdkSchema(responseSchema);

    final response = await _model.generateContent(
      content,
      generationConfig: gemini.GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: schema,
        temperature: AIConfig.getConfig(AITaskType.rescheduling).temperature,
        topK: AIConfig.getConfig(AITaskType.rescheduling).topK,
        topP: AIConfig.getConfig(AITaskType.rescheduling).topP,
        maxOutputTokens:
            AIConfig.getConfig(AITaskType.rescheduling).maxOutputTokens,
      ),
    );

    if (response.text == null) {
      throw Exception('Empty response from AI');
    }

    // DEBUG: Log Raw Response
    AppLogger.i('--- AI RESPONSE (Reschedule Workouts) ---');
    AppLogger.i(response.text!);

    final json = _parseJson(response.text!);

    List<dynamic> list;
    if (json is List) {
      list = json;
    } else if (json is Map && json.containsKey('workouts')) {
      list = json['workouts'] as List;
    } else {
      list = [];
    }

    final workouts =
        list.map((e) => Workout.fromJson(e as Map<String, dynamic>)).toList();

    return AIResponse(
      data: workouts,
      text: null,
      functionCall: null,
      tokensUsed: response.usageMetadata?.totalTokenCount ?? 0,
      timestamp: DateTime.now(),
    );
  }

  // --- Coaching Chat ---

  @override
  Future<AIResponse<String>> chat({
    required String userMessage,
    required CoachingChatContext context,
    required String systemPrompt,
    required String taskPrompt,
  }) async {
    final history = _buildChatHistory(context.shortTerm.conversationHistory);
    final systemInstruction =
        _buildSystemInstruction(systemPrompt, taskPrompt, context.toJson());

    // We use a fresh model instance to set systemInstruction for the session
    final sessionModel = gemini.GenerativeModel(
      model: AIConstants.modelName,
      apiKey: _apiKey,
      systemInstruction: gemini.Content.system(systemInstruction),
      generationConfig: AIConfig.getConfig(AITaskType.chat),
    );

    // We don't reuse chat session objects as we are stateless
    final chatSession = sessionModel.startChat(history: history);

    // DEBUG: Log Request
    AppLogger.i('--- AI REQUEST (Chat) ---');
    AppLogger.i('User: $userMessage');
    AppLogger.i('System Instruction: $systemInstruction');

    final response =
        await chatSession.sendMessage(gemini.Content.text(userMessage));

    // DEBUG: Log Response
    AppLogger.i('--- AI RESPONSE (Chat) ---');
    AppLogger.i(response.text ?? '[No Text]');

    return AIResponse(
      data: response.text ?? '',
      text: response.text,
      functionCall: null,
      tokensUsed: response.usageMetadata?.totalTokenCount ?? 0,
      timestamp: DateTime.now(),
    );
  }

  @override
  Stream<AIResponse<String>> chatStream({
    required String userMessage,
    required CoachingChatContext context,
    required String systemPrompt,
    required String taskPrompt,
  }) async* {
    final history = _buildChatHistory(context.shortTerm.conversationHistory);
    final systemInstruction =
        _buildSystemInstruction(systemPrompt, taskPrompt, context.toJson());

    final sessionModel = gemini.GenerativeModel(
      model: AIConstants.modelName,
      apiKey: _apiKey,
      systemInstruction: gemini.Content.system(systemInstruction),
      generationConfig: AIConfig.getConfig(AITaskType.chat),
    );

    final chatSession = sessionModel.startChat(history: history);

    final responseStream =
        chatSession.sendMessageStream(gemini.Content.text(userMessage));

    await for (final chunk in responseStream) {
      yield AIResponse(
        data: chunk.text ?? '',
        text: chunk.text,
        functionCall: null,
        tokensUsed: 0,
        timestamp: DateTime.now(),
      );
    }
  }

  // --- Function Calling ---

  @override
  Future<AIResponse<String>> chatWithTools({
    required String userMessage,
    required CoachingChatContext context,
    required String systemPrompt,
    required String taskPrompt,
    required List<FunctionDeclaration> tools,
  }) async {
    final sdkTools = tools.map((t) {
      return gemini.Tool(functionDeclarations: [
        gemini.FunctionDeclaration(
          t.name,
          t.description,
          _mapJsonSchemaToSdkSchema(t.parameters),
        ),
      ]);
    }).toList();

    final history = _buildChatHistory(context.shortTerm.conversationHistory);
    final systemInstruction =
        _buildSystemInstruction(systemPrompt, taskPrompt, context.toJson());

    final sessionModel = gemini.GenerativeModel(
      model: AIConstants.modelName,
      apiKey: _apiKey,
      systemInstruction: gemini.Content.system(systemInstruction),
      tools: sdkTools,
      generationConfig: AIConfig.getConfig(AITaskType.functionCall),
    );

    final chatSession = sessionModel.startChat(history: history);
    // DEBUG: Log Request
    AppLogger.i('--- AI REQUEST (Chat w/ Tools) ---');
    AppLogger.i('User: $userMessage');
    AppLogger.i('Tools: ${tools.map((t) => t.name).join(', ')}');

    final response =
        await chatSession.sendMessage(gemini.Content.text(userMessage));

    // DEBUG: Log Response
    AppLogger.i('--- AI RESPONSE (Chat w/ Tools) ---');
    AppLogger.i(response.text ?? '[No Text]');
    if (response.functionCalls.isNotEmpty) {
      AppLogger.i(
          'Function Call: ${response.functionCalls.first.name}(${response.functionCalls.first.args})');
    }

    // Check for function call
    final functionCalls = response.functionCalls;
    FunctionCall? domainFunctionCall;

    if (functionCalls.isNotEmpty) {
      final call = functionCalls.first;
      domainFunctionCall = FunctionCall(
        name: call.name,
        arguments: call.args,
      );
    }

    return AIResponse(
      data: response.text ?? '',
      text: response.text,
      functionCall: domainFunctionCall,
      tokensUsed: response.usageMetadata?.totalTokenCount ?? 0,
      timestamp: DateTime.now(),
    );
  }

  @override
  Stream<AIResponse<String>> chatStreamWithTools({
    required String userMessage,
    required CoachingChatContext context,
    required String systemPrompt,
    required String taskPrompt,
    required List<FunctionDeclaration> tools,
  }) async* {
    final sdkTools = tools.map((t) {
      return gemini.Tool(functionDeclarations: [
        gemini.FunctionDeclaration(
          t.name,
          t.description,
          _mapJsonSchemaToSdkSchema(t.parameters),
        ),
      ]);
    }).toList();

    final history = _buildChatHistory(context.shortTerm.conversationHistory);
    final systemInstruction =
        _buildSystemInstruction(systemPrompt, taskPrompt, context.toJson());

    final sessionModel = gemini.GenerativeModel(
      model: AIConstants.modelName,
      apiKey: _apiKey,
      systemInstruction: gemini.Content.system(systemInstruction),
      tools: sdkTools,
      generationConfig: AIConfig.getConfig(AITaskType.functionCall),
    );

    final chatSession = sessionModel.startChat(history: history);
    final stream =
        chatSession.sendMessageStream(gemini.Content.text(userMessage));

    await for (final chunk in stream) {
      FunctionCall? domainFunctionCall;
      if (chunk.functionCalls.isNotEmpty) {
        final call = chunk.functionCalls.first;
        domainFunctionCall = FunctionCall(
          name: call.name,
          arguments: call.args,
        );
      }

      yield AIResponse(
        data: chunk.text ?? '',
        text: chunk.text,
        functionCall: domainFunctionCall,
        tokensUsed: 0,
        timestamp: DateTime.now(),
      );
    }
  }

  // --- Helpers ---

  String _buildPrompt({
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> context,
  }) {
    return '''
System: $systemPrompt

Context:
${jsonEncode(context)}

Task: $taskPrompt
''';
  }

  List<gemini.Content> _buildChatHistory(List<ConversationMessage> messages) {
    return messages.map((m) {
      if (m.role == 'user') {
        return gemini.Content.text(m.content);
      } else {
        return gemini.Content.model([gemini.TextPart(m.content)]);
      }
    }).toList();
  }

  String _buildSystemInstruction(
      String systemPrompt, String taskPrompt, Map<String, dynamic> context) {
    return '''
$systemPrompt

$taskPrompt

Current User Context:
${jsonEncode(context)}
''';
  }

  dynamic _parseJson(String text) {
    var cleanText = text.trim();
    if (cleanText.startsWith('```json')) {
      cleanText = cleanText.substring(7);
    }
    if (cleanText.startsWith('```')) {
      cleanText = cleanText.substring(3);
    }
    if (cleanText.endsWith('```')) {
      cleanText = cleanText.substring(0, cleanText.length - 3);
    }
    return jsonDecode(cleanText);
  }

  gemini.Schema _mapJsonSchemaToSdkSchema(Map<String, dynamic> jsonSchema) {
    final type = jsonSchema['type'] as String?;
    final description = jsonSchema['description'] as String?;
    final requiredList = (jsonSchema['required'] as List?)?.cast<String>();

    if (type == 'object') {
      final properties =
          jsonSchema['properties'] as Map<String, dynamic>? ?? {};

      final schemaProps = properties.map((key, value) {
        return MapEntry(
            key, _mapJsonSchemaToSdkSchema(value as Map<String, dynamic>));
      });

      return gemini.Schema.object(
        properties: schemaProps,
        description: description,
        nullable: false,
        requiredProperties: requiredList,
      );
    } else if (type == 'array') {
      final items = jsonSchema['items'] as Map<String, dynamic>?;
      return gemini.Schema.array(
        items: items != null
            ? _mapJsonSchemaToSdkSchema(items)
            : gemini.Schema.string(),
        description: description,
      );
    } else if (type == 'string') {
      if (jsonSchema['enum'] != null) {
        return gemini.Schema.enumString(
            enumValues:
                (jsonSchema['enum'] as List).map((e) => e.toString()).toList(),
            description: description);
      }
      return gemini.Schema.string(description: description);
    } else if (type == 'integer') {
      return gemini.Schema.integer(description: description);
    } else if (type == 'number') {
      return gemini.Schema.number(description: description);
    } else if (type == 'boolean') {
      return gemini.Schema.boolean(description: description);
    }

    return gemini.Schema.string(description: description);
  }
}
