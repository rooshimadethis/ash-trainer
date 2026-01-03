import '../../features/shared/domain/entities/ai/context_models.dart';
import '../../features/shared/domain/entities/ai/ai_types.dart';
import '../../features/shared/domain/entities/ai/training_plan_response.dart';
import '../../features/shared/domain/entities/training/workout.dart';

/// AI service for plan generation, coaching, and adjustments
abstract class AIService {
  /// Generate a complete training plan
  /// Uses PlanGenerationContext built by BuildPlanGenerationContext use case
  Future<AIResponse<TrainingPlan>> generatePlan({
    required PlanGenerationContext context,
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> responseSchema,
  });

  /// Adjust a single workout based on user feedback
  /// Uses context built by BuildWorkoutAdjustmentContext use case
  Future<AIResponse<Workout>> adjustWorkout({
    required Workout plannedWorkout,
    required String userFeedback,
    required ShortTermContext context,
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> responseSchema,
  });

  /// Reschedule workouts within/across micro/mesocycles
  /// Uses context built by BuildRescheduleContext use case
  Future<AIResponse<List<Workout>>> rescheduleWorkouts({
    required List<String> workoutIds,
    required String reason,
    required ShortTermContext context,
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> responseSchema,
  });
}

class AIProcessingException implements Exception {
  final String message;
  final String? rawResponse;

  AIProcessingException(this.message, {this.rawResponse});

  @override
  String toString() => 'AIProcessingException: $message';
}
