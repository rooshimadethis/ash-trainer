import '../../../../infrastructure/services/ai_service.dart';
import '../../../shared/domain/repositories/workout_repository.dart';
import '../../../shared/domain/repositories/goal_repository.dart';
import '../../../../core/constants/prompts.dart';
import '../../../../core/constants/ai_schemas.dart';
import 'build_planning_context.dart';
import '../../../shared/domain/entities/ai/context_models.dart';
import '../../../../core/utils/training_plan_scheduler.dart';

class GenerateTrainingPlan {
  final BuildPlanningContext _contextBuilder;
  final AIService _aiService;
  final WorkoutRepository _workoutRepo;
  final GoalRepository _goalRepo;
  final TrainingPlanScheduler _scheduler;

  GenerateTrainingPlan(
    this._contextBuilder,
    this._aiService,
    this._workoutRepo,
    this._goalRepo,
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
      taskPrompt: mode == PlanningMode.repair
          ? AIPrompts.strategicRepairTask
          : AIPrompts.generatePlanTask,
      responseSchema: AISchemas.trainingPlan,
    );

    if (response.data == null) {
      throw Exception('Failed to generate plan');
    }

    // Log plan structure to verify three-tier approach
    // ignore: avoid_print
    print('📊 Plan Generation Summary (Three-Tier Approach):');
    // ignore: avoid_print
    print('  ✅ TIER 1 - Phases: ${response.data!.phases.length}');
    for (var phase in response.data!.phases) {
      // ignore: avoid_print
      print('    - ${phase.phaseType} (${phase.durationWeeks} weeks)');
    }
    // ignore: avoid_print
    print('  ✅ TIER 2 - Blocks: ${response.data!.blocks.length}');
    if (response.data!.blocks.isNotEmpty) {
      final firstPhaseId = response.data!.phases.first.id;
      final blocksInFirstPhase =
          response.data!.blocks.where((b) => b.phaseId == firstPhaseId).length;
      // ignore: avoid_print
      print('    - Blocks in first phase: $blocksInFirstPhase');
    }
    // ignore: avoid_print
    print('  ✅ TIER 3 - Workouts: ${response.data!.workouts.length}');
    if (response.data!.workouts.isNotEmpty &&
        response.data!.blocks.isNotEmpty) {
      final firstBlockId = response.data!.blocks.first.id;
      final secondBlockId =
          response.data!.blocks.length > 1 ? response.data!.blocks[1].id : null;
      final workoutsInFirstBlock = response.data!.workouts
          .where((w) => w.blockId == firstBlockId)
          .length;
      final workoutsInSecondBlock = secondBlockId != null
          ? response.data!.workouts
              .where((w) => w.blockId == secondBlockId)
              .length
          : 0;
      // ignore: avoid_print
      print('    - Workouts in Block 1: $workoutsInFirstBlock');
      // ignore: avoid_print
      print('    - Workouts in Block 2: $workoutsInSecondBlock');
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

    // 5. Save Rationale
    final rationale = response.data!.rationale;
    await _goalRepo.updateRationale(
      goalId: goalId,
      overallApproach: rationale.overallApproach,
      intensityDistribution: rationale.intensityDistribution,
      keyWorkouts: rationale.keyWorkouts,
      recoveryStrategy: rationale.recoveryStrategy,
    );
  }
}
