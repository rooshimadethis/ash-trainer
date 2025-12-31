import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/providers/repository_providers.dart';
import '../../../../infrastructure/providers/service_providers.dart';
import '../../application/usecases/build_planning_context.dart';
import '../../application/usecases/generate_training_plan.dart';
import '../../application/usecases/reschedule_workouts.dart';
import '../../application/usecases/adjust_workout.dart';
import '../../application/usecases/apply_reschedule_matrix.dart';
import '../../../../core/utils/training_plan_scheduler.dart';
import '../../../../core/utils/grid_optimizer.dart';

final buildPlanningContextProvider = Provider<BuildPlanningContext>((ref) {
  return BuildPlanningContext(
    ref.watch(userRepositoryProvider),
    ref.watch(goalRepositoryProvider),
    ref.watch(workoutRepositoryProvider),
  );
});

final generateTrainingPlanProvider = Provider<GenerateTrainingPlan>((ref) {
  return GenerateTrainingPlan(
    ref.watch(buildPlanningContextProvider),
    ref.watch(aiServiceProvider),
    ref.watch(workoutRepositoryProvider),
    TrainingPlanScheduler(),
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

final gridOptimizerProvider = Provider<GridOptimizer>((ref) {
  return GridOptimizer();
});

final applyRescheduleMatrixProvider = Provider<ApplyRescheduleMatrix>((ref) {
  return ApplyRescheduleMatrix(
    ref.watch(workoutRepositoryProvider),
    ref.watch(gridOptimizerProvider),
  );
});
