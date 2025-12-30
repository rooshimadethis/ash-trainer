import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/providers/repository_providers.dart';
import '../../../../infrastructure/providers/service_providers.dart';
import '../../application/usecases/build_plan_generation_context.dart';
import '../../application/usecases/generate_training_plan.dart';
import '../../application/usecases/reschedule_workouts.dart';
import '../../application/usecases/adjust_workout.dart';

final buildPlanGenerationContextProvider =
    Provider<BuildPlanGenerationContext>((ref) {
  return BuildPlanGenerationContext(
    ref.watch(userRepositoryProvider),
    ref.watch(goalRepositoryProvider),
    ref.watch(workoutRepositoryProvider),
  );
});

final generateTrainingPlanProvider = Provider<GenerateTrainingPlan>((ref) {
  return GenerateTrainingPlan(
    ref.watch(buildPlanGenerationContextProvider),
    ref.watch(aiServiceProvider),
    ref.watch(workoutRepositoryProvider),
  );
});

final rescheduleWorkoutsProvider = Provider<RescheduleWorkouts>((ref) {
  return RescheduleWorkouts(
    ref.watch(workoutRepositoryProvider),
    ref.watch(aiServiceProvider),
  );
});

final adjustWorkoutProvider = Provider<AdjustWorkout>((ref) {
  return AdjustWorkout(
    ref.watch(workoutRepositoryProvider),
    ref.watch(aiServiceProvider),
  );
});
