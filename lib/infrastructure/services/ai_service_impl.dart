import 'dart:convert';
import 'package:firebase_ai/firebase_ai.dart';

import '../../features/shared/domain/entities/ai/context_models.dart';
import '../../features/shared/domain/entities/ai/ai_types.dart';
import '../../features/shared/domain/entities/ai/training_plan_response.dart';
import '../../features/shared/domain/entities/training/workout.dart';
import '../../core/constants/ai_constants.dart';
import '../../core/config/ai_config.dart';
import '../../core/utils/logger.dart';
import 'ai_service.dart';

class AIServiceImpl implements AIService {
  late final GenerativeModel _model;

  AIServiceImpl() {
    _model = FirebaseAI.googleAI().generativeModel(
      model: AIConstants.modelName,
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

    final content = [Content.text(prompt)];

    // DEBUG: Log Request
    AppLogger.i('--- AI REQUEST (Generate Plan) ---');
    AppLogger.i('SYSTEM PROMPT: $systemPrompt');
    AppLogger.i('CONTEXT:');
    AppLogger.i(const JsonEncoder.withIndent('  ')
        .convert(PlanGenerationContext.activeToJson(context)));
    AppLogger.i('TASK PROMPT: $taskPrompt');
    AppLogger.i('--- END AI REQUEST ---');

    final schema = _mapJsonSchemaToSdkSchema(responseSchema);

    final response = await _model.generateContent(
      content,
      generationConfig: GenerationConfig(
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

    // DEBUG: Log detailed usage metadata
    double? totalCost;
    if (response.usageMetadata != null) {
      final usage = response.usageMetadata!;
      totalCost = _calculateCost(usage);

      AppLogger.i('--- AI USAGE METADATA ---');
      AppLogger.i('Total tokens: ${usage.totalTokenCount}');
      AppLogger.i('Total cost: \$${totalCost.toStringAsFixed(6)}');
      AppLogger.i('--- END USAGE METADATA ---');
    }

    // DEBUG: Log finish reason
    if (response.candidates.isNotEmpty) {
      final finishReason = response.candidates.first.finishReason;
      AppLogger.i('Finish reason: ${finishReason?.name ?? "UNKNOWN"}');
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
        totalCost: totalCost,
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

    final content = [Content.text(prompt)];

    // DEBUG: Log Request
    AppLogger.i('--- AI REQUEST (Adjust Workout) ---');
    AppLogger.i('CONTEXT:');
    AppLogger.i(const JsonEncoder.withIndent('  ').convert(contextMap));
    AppLogger.i('TASK PROMPT: $taskPrompt');

    final schema = _mapJsonSchemaToSdkSchema(responseSchema);

    final response = await _model.generateContent(
      content,
      generationConfig: GenerationConfig(
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
      totalCost: response.usageMetadata != null
          ? _calculateCost(response.usageMetadata!)
          : null,
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

    final content = [Content.text(prompt)];

    // DEBUG: Log Request
    AppLogger.i('--- AI REQUEST (Reschedule Workouts) ---');
    AppLogger.i('CONTEXT:');
    AppLogger.i(const JsonEncoder.withIndent('  ').convert(contextMap));
    AppLogger.i('TASK PROMPT: $taskPrompt');

    final schema = _mapJsonSchemaToSdkSchema(responseSchema);

    final response = await _model.generateContent(
      content,
      generationConfig: GenerationConfig(
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
      totalCost: response.usageMetadata != null
          ? _calculateCost(response.usageMetadata!)
          : null,
      timestamp: DateTime.now(),
    );
  }

  double _calculateCost(UsageMetadata usage) {
    final promptTokens = usage.promptTokenCount ?? 0;
    final responseTokens = usage.candidatesTokenCount ?? 0;

    // Gemini 3.0 Flash pricing (as of Jan 2026)
    const inputCostPerMillion = 0.50;
    const outputCostPerMillion = 3.00;

    final inputCost = (promptTokens / 1000000) * inputCostPerMillion;
    final outputCost = (responseTokens / 1000000) * outputCostPerMillion;
    var totalCost = inputCost + outputCost;

    // Check for thinking tokens (Gemini 3.0 feature)
    try {
      final usageReflection = usage as dynamic;
      final thinkingTokens = usageReflection.thoughtsTokenCount as int?;
      if (thinkingTokens != null && thinkingTokens > 0) {
        final thinkingCost = (thinkingTokens / 1000000) * outputCostPerMillion;
        totalCost += thinkingCost;
      }
    } catch (_) {}

    return totalCost;
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

  Schema _mapJsonSchemaToSdkSchema(Map<String, dynamic> jsonSchema) {
    final type = jsonSchema['type'] as String?;
    final description = jsonSchema['description'] as String?;

    if (type == 'object') {
      final properties =
          jsonSchema['properties'] as Map<String, dynamic>? ?? {};

      final schemaProps = properties.map((key, value) {
        return MapEntry(
            key, _mapJsonSchemaToSdkSchema(value as Map<String, dynamic>));
      });

      return Schema.object(
        properties: schemaProps,
        description: description,
        nullable: false,
      );
    } else if (type == 'array') {
      final items = jsonSchema['items'] as Map<String, dynamic>?;
      return Schema.array(
        items:
            items != null ? _mapJsonSchemaToSdkSchema(items) : Schema.string(),
        description: description,
      );
    } else if (type == 'string') {
      if (jsonSchema['enum'] != null) {
        return Schema.enumString(
            enumValues:
                (jsonSchema['enum'] as List).map((e) => e.toString()).toList(),
            description: description);
      }
      return Schema.string(description: description);
    } else if (type == 'integer') {
      return Schema.integer(description: description);
    } else if (type == 'number') {
      return Schema.number(description: description);
    } else if (type == 'boolean') {
      return Schema.boolean(description: description);
    }

    return Schema.string(description: description);
  }
}
