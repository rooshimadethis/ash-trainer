import '../../../../infrastructure/services/ai_service.dart';
import '../../../shared/domain/repositories/workout_repository.dart';
import '../../../../core/constants/prompts.dart';
import '../../../../core/constants/ai_schemas.dart';
import 'build_planning_context.dart';
import '../../../shared/domain/entities/ai/context_models.dart';
import '../../../../core/utils/training_plan_scheduler.dart';

class GenerateTrainingPlan {
  final BuildPlanningContext _contextBuilder;
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
    PlanningMode mode = PlanningMode.initial,
    DateTime? startDate, // Optional override, though builder handles defaults
  }) async {
    // 1. Build Context
    final context = await _contextBuilder.execute(
      goalId: goalId,
      mode: mode,
    );

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
    // Use the start date determined by the Planning Config (smart logic)
    // or fallback to the override if provided (though builder usually rules)
    final planStartDate = startDate ?? context.config.startDate;

    final hydrationResult = _scheduler.hydratePlan(
      plan: response.data!,
      startDate: planStartDate,
      userId: userId,
      goalId: goalId,
    );

    // 4. Save Plan
    // If Repair, we might need to clear future workouts first?
    // The builder determines the start date for the new block.
    // Ideally, we clear anything overlapping or future from that date.
    if (mode == PlanningMode.repair) {
      await _workoutRepo.deleteFutureWorkouts(
          goalId: goalId, fromDate: planStartDate);
    }

    await _workoutRepo.saveFullTrainingPlan(
      phases: hydrationResult.phases,
      blocks: hydrationResult.blocks,
      workouts: hydrationResult.workouts,
    );
  }
}
