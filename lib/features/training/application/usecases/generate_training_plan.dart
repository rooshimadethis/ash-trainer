import '../../../../infrastructure/services/ai_service.dart';
import '../../../shared/domain/repositories/workout_repository.dart';
import '../../../../core/constants/prompts.dart';
import '../../../../core/constants/ai_schemas.dart';
import 'build_plan_generation_context.dart';
import '../../../../core/utils/training_plan_scheduler.dart';

class GenerateTrainingPlan {
  final BuildPlanGenerationContext _contextBuilder;
  final AIService _aiService;
  final WorkoutRepository _workoutRepo;
  final TrainingPlanScheduler _scheduler;

  GenerateTrainingPlan(
    this._contextBuilder,
    this._aiService,
    this._workoutRepo,
    this._scheduler,
  );

  Future<void> execute({
    required String goalId,
    required String userId,
    DateTime? startDate,
  }) async {
    // 1. Build Context
    final context = await _contextBuilder.execute(goalId: goalId);

    // 2. Call AI Service
    final response = await _aiService.generatePlan(
      context: context,
      systemPrompt: AIPrompts.ashPersona,
      taskPrompt: AIPrompts.generatePlanTask,
      responseSchema: AISchemas.trainingPlan,
    );

    if (response.data == null) {
      throw Exception('Failed to generate plan');
    }

    // 3. Hydrate Plan (Convert Skeletons to Real Dates)
    final hydrationResult = _scheduler.hydratePlan(
      plan: response.data!,
      startDate: startDate ?? DateTime.now(),
      userId: userId,
      goalId: goalId,
    );

    // 4. Save Plan
    await _workoutRepo.saveFullTrainingPlan(
      phases: hydrationResult.phases,
      blocks: hydrationResult.blocks,
      workouts: hydrationResult.workouts,
    );
  }
}
