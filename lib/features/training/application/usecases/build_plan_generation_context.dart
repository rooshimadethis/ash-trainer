import 'package:ash_trainer/features/shared/domain/repositories/user_repository.dart';
import 'package:ash_trainer/features/shared/domain/repositories/goal_repository.dart';
import 'package:ash_trainer/features/shared/domain/repositories/workout_repository.dart';
import 'package:ash_trainer/features/shared/domain/entities/ai/context_models.dart';
import 'package:ash_trainer/features/shared/domain/entities/goal.dart';

class BuildPlanGenerationContext {
  final UserRepository _userRepo;
  final GoalRepository _goalRepo;
  final WorkoutRepository _workoutRepo;

  BuildPlanGenerationContext(
    this._userRepo,
    this._goalRepo,
    this._workoutRepo,
  );

  Future<PlanGenerationContext> execute({required String goalId}) async {
    final user = await _userRepo.getCurrentUser();
    if (user == null) {
      throw Exception('User not found'); // Should handle better
    }

    final goal = await _goalRepo.getGoal(goalId);

    // Fetch last 4 weeks of training history
    final historyStartDate = DateTime.now().subtract(const Duration(days: 28));
    final historyWorkouts = await _workoutRepo.getWorkoutsForDateRange(
      startDate: historyStartDate,
      endDate: DateTime.now(),
    );

    // Map Workouts to WorkoutSummary
    final trainingHistory = historyWorkouts.map((w) {
      return WorkoutSummary(
        date: w.scheduledDate,
        type: w.type,
        duration: w.actualDuration ?? w.plannedDuration,
        distance: w.actualDistance ?? w.plannedDistance,
        rpe: w.rpe,
        completed: w.status == 'completed',
      );
    }).toList();

    // Construct UserContext
    // Logic for experienceLevel is placeholder for now
    final userContext = UserContext(
      age: user.age ?? 30,
      gender: user.gender ?? 'unknown',
      experienceLevel: 'Intermediate', // Inference logic to be added
      availableDays: user.availableDays,
      timeConstraints: {}, // Not yet in User entity
      injuryHistory: [], // Not yet available
      weeklyMileageBase: 20.0, // Inference logic needed
    );

    // Construct GoalContext
    final goalContext = GoalContext(
      type: goal.type.name,
      target: _formatGoalTarget(goal),
      deadline: goal.targetDate ??
          goal.eventDate ??
          goal.endDate ??
          DateTime.now().add(const Duration(days: 90)),
      confidence: goal.confidence,
      specialInstructions: [], // Can populate based on user prefs or logic
      currentPace: _formatPace(goal.currentBestTime),
    );

    return PlanGenerationContext(
      user: userContext,
      goal: goalContext,
      trainingHistory: trainingHistory,
      trainingPhilosophy: _getTrainingPhilosophy(goal.type),
    );
  }

  String _formatGoalTarget(Goal goal) {
    if (goal.targetDistance != null) return 'Run ${goal.targetDistance}km';
    if (goal.targetTime != null) return 'Run in ${goal.targetTime} seconds';
    if (goal.eventName != null) return 'Train for ${goal.eventName}';
    return 'Maintain fitness';
  }

  String? _formatPace(int? seconds) {
    if (seconds == null) return null;
    // Placeholder formatting
    return '$seconds seconds';
  }

  String _getTrainingPhilosophy(GoalType type) {
    switch (type) {
      case GoalType.distanceMilestone:
        return 'Focus on gradual volume increase. Pyramidal intensity distribution: 80% easy, 20% moderate.';
      case GoalType.timePerformance:
        return 'Focus on speed development mixed with aerobic base. Polarized training: 80% easy, 20% hard intervals.';
      case GoalType.event:
        return 'Periodized training peaking at event date. Includes specific race-pace work.';
      case GoalType.maintenance:
        return 'Consistent frequency, moderate volume to preserve adaptations without burnout.';
    }
  }
}
