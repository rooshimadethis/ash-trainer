import 'package:uuid/uuid.dart';
import '../../../../infrastructure/services/ai_service.dart';
import '../../../shared/domain/repositories/workout_repository.dart';
import '../../../../core/constants/prompts.dart';
import '../../../../core/constants/ai_schemas.dart';
import 'build_plan_generation_context.dart';
import '../../../shared/domain/entities/ai/training_plan_response.dart';

class GenerateTrainingPlan {
  final BuildPlanGenerationContext _contextBuilder;
  final AIService _aiService;
  final WorkoutRepository _workoutRepo;

  GenerateTrainingPlan(
    this._contextBuilder,
    this._aiService,
    this._workoutRepo,
  );

  Future<TrainingPlan> execute({
    required String goalId,
    required String userId,
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

    // AI returns a plan with placeholder IDs. We need to process it.
    // However, the AI Service returns a TrainingPlan entity directly.
    // It has immutable fields. We likely need to reconstruct it with valid IDs
    // before saving, or save it and let the Repository handle IDs.
    // Usually, use cases enforce business rules (like assigning IDs).

    if (response.data == null) {
      throw Exception('Failed to generate plan');
    }

    final rawPlan = response.data!;

    // 3. Post-Process: Assign UUIDs and link to Goal/User
    // We need to map placeholder IDs to real UUIDs to ensure referential integrity
    // if mesocycles/microcycles are referenced by workouts.

    final mesocycleIdMap = <String, String>{};
    final microcycleIdMap = <String, String>{};

    final processedMesocycles = rawPlan.mesocycles.map((m) {
      final newId = const Uuid().v4();
      mesocycleIdMap[m.id] = newId; // Map AI ID to new UUID
      return m.copyWith(id: newId);
    }).toList();

    final processedMicrocycles = rawPlan.microcycles.map((m) {
      final newId = const Uuid().v4();
      microcycleIdMap[m.id] = newId;
      return m.copyWith(id: newId);
    }).toList();

    final processedWorkouts = rawPlan.workouts.map((w) {
      // Resolve meso/micro references
      final newMesoId =
          w.mesocycleId != null ? mesocycleIdMap[w.mesocycleId] : null;
      final newMicroId =
          w.microcycleId != null ? microcycleIdMap[w.microcycleId] : null;

      return w.copyWith(
        id: const Uuid().v4(),
        userId: userId,
        goalId: goalId,
        mesocycleId: newMesoId,
        microcycleId: newMicroId,
        status: 'planned', // Enforce status
      );
    }).toList();

    final validPlan = rawPlan.copyWith(
      mesocycles: processedMesocycles,
      microcycles: processedMicrocycles,
      workouts: processedWorkouts,
    );

    // 4. Save Plan
    await _workoutRepo.saveTrainingPlan(validPlan);

    return validPlan;
  }
}
