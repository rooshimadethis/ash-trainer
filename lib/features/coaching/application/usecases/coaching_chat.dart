import 'package:ash_trainer/features/shared/domain/entities/ai/ai_types.dart';
import 'package:ash_trainer/features/shared/domain/entities/ai/conversation.dart';
import '../../../../infrastructure/services/ai_service.dart';
import '../../../../core/constants/prompts.dart';
import 'build_coaching_chat_context.dart';
import '../../../training/application/usecases/reschedule_workouts.dart';
import '../../../training/application/usecases/adjust_workout.dart';

class CoachingChat {
  final BuildCoachingChatContext _contextBuilder;
  final AIService _aiService;
  final RescheduleWorkouts _rescheduleUseCase;
  final AdjustWorkout _adjustUseCase;

  CoachingChat(
    this._contextBuilder,
    this._aiService,
    this._rescheduleUseCase,
    this._adjustUseCase,
  );

  static const _tools = [
    FunctionDeclaration(
      name: 'reschedule_workouts',
      description:
          'Move workouts to different dates. Use when user has conflicts or wants to change schedule.',
      parameters: {
        'type': 'object',
        'properties': {
          'workout_ids': {
            'type': 'array',
            'items': {'type': 'string'},
            'description': 'IDs of workouts to reschedule'
          },
          'new_dates': {
            'type': 'array',
            'items': {'type': 'string', 'format': 'date'}, // ISO 8601
            'description': 'New dates for the workouts'
          },
          'reason': {'type': 'string'}
        },
        'required': ['workout_ids', 'reason']
      },
    ),
    FunctionDeclaration(
      name: 'adjust_workout',
      description:
          'Modify a single workout based on feedback (pain, fatigue, etc).',
      parameters: {
        'type': 'object',
        'properties': {
          'workout_id': {'type': 'string'},
          'user_feedback': {'type': 'string'}
        },
        'required': ['workout_id', 'user_feedback']
      },
    ),
  ];

  Future<String> execute({
    required String userId,
    required String conversationId,
    required String userMessage,
  }) async {
    final context = await _contextBuilder.execute(
      userId: userId,
      conversationId: conversationId,
    );

    final response = await _aiService.chatWithTools(
      userMessage: userMessage,
      context: context,
      systemPrompt: AIPrompts.ashPersona,
      taskPrompt: AIPrompts.coachingChatTask,
      tools: _tools,
    );

    if (response.functionCall != null) {
      return await _executeFunctionCall(response.functionCall!);
    } else {
      return response.text ?? "I'm not sure how to respond to that.";
    }
  }

  Future<String> _executeFunctionCall(FunctionCall call) async {
    try {
      switch (call.name) {
        case 'reschedule_workouts':
          final workoutIds =
              List<String>.from(call.arguments['workout_ids'] ?? []);
          final newDatesRaw =
              List<String>.from(call.arguments['new_dates'] ?? []);
          final newDates = newDatesRaw.map((d) => DateTime.parse(d)).toList();
          final reason = call.arguments['reason'] as String;

          await _rescheduleUseCase.execute(
            workoutIds: workoutIds,
            newDates: newDates,
            reason: reason,
          );
          return "I've rescheduled your workouts based on your request.";

        case 'adjust_workout':
          final workoutId = call.arguments['workout_id'] as String;
          final feedback = call.arguments['user_feedback'] as String;

          await _adjustUseCase.execute(
            workoutId: workoutId,
            userFeedback: feedback,
          );
          return "I've adjusted the workout to better match your current state.";

        default:
          return "I tried to perform an action but couldn't find the right tool.";
      }
    } catch (e) {
      return "I encountered an error while trying to help: $e";
    }
  }
}
