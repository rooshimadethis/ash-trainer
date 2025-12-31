import 'package:ash_trainer/features/shared/domain/repositories/workout_repository.dart';
import '../../../../infrastructure/services/ai_service.dart';
// import 'build_plan_generation_context.dart';

class AdjustWorkout {
  // final WorkoutRepository _workoutRepo;
  // final AIService _aiService;

  AdjustWorkout(WorkoutRepository workoutRepo, AIService aiService);

  Future<void> execute({
    required String workoutId,
    required String userFeedback,
  }) async {
    // 1. Fetch workout
    // 2. Build adjustment context
    // 3. Call AI adjustWorkout
    // 4. Update workout
  }
}
