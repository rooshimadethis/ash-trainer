import '../../features/shared/domain/entities/ai/training_plan_response.dart';
import '../../features/shared/domain/entities/workout.dart';
import '../../features/shared/domain/repositories/workout_repository.dart';
import '../datasources/local/daos/workout_dao.dart';
import '../models/workout_mapper.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutDao _dao;

  WorkoutRepositoryImpl(this._dao);

  @override
  Future<List<Workout>> getWorkoutsForDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final dtos = await _dao.getWorkoutsForDateRange(startDate, endDate);
    return dtos.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<Workout?> getWorkout(String id) async {
    final dto = await _dao.getWorkoutById(id);
    return dto?.toEntity();
  }

  @override
  Future<void> saveWorkout(Workout workout) async {
    await _dao.insertWorkout(workout.toCompanion());
  }

  @override
  Future<void> logWorkout(Workout workout) async {
    // Assuming log implies update
    await _dao.updateWorkout(workout.toCompanion());
  }

  @override
  Future<void> saveTrainingPlan(TrainingPlan plan) async {
    // We currently only save the workouts.
    // Mesocycles/Microcycles storage can be added later if needed.
    final companions = plan.workouts.map((w) => w.toCompanion()).toList();
    await _dao.batchInsertWorkouts(companions);
  }

  @override
  Future<void> deleteWorkoutsForGoal(String goalId) async {
    await _dao.deleteWorkoutsForGoal(int.parse(goalId));
  }
}
