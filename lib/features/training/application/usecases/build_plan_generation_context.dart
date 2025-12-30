import 'package:ash_trainer/features/shared/domain/repositories/user_repository.dart';
import 'package:ash_trainer/features/shared/domain/repositories/goal_repository.dart';
import 'package:ash_trainer/features/shared/domain/repositories/workout_repository.dart';
import 'package:ash_trainer/features/shared/domain/entities/ai/context_models.dart';
import 'package:ash_trainer/features/shared/domain/entities/goal.dart';
import 'build_plan_philosophy.dart';

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

    // Calculate current training metrics from last 7 days
    final last7Days = DateTime.now().subtract(const Duration(days: 7));
    final recentWorkouts = trainingHistory
        .where((w) => w.date.isAfter(last7Days) && w.completed)
        .toList();

    final currentFrequency = recentWorkouts.isEmpty
        ? goal.initialTrainingFrequency
        : recentWorkouts.length;

    final currentVolume = recentWorkouts.isEmpty
        ? goal.initialWeeklyVolume
        : recentWorkouts
            .map((w) => w.distance ?? 0.0)
            .fold(0.0, (sum, distance) => sum + distance);

    // Construct UserContext
    final userContext = UserContext(
      age: user.age ?? 30,
      gender: user.gender ?? 'unknown',
      availableDays: user.availableDays,
      timeConstraints: {}, // Not yet in User entity
      injuryHistory: [], // Not yet available
      // Current training metrics (from form on first plan, calculated from history on subsequent)
      weeklyTrainingFrequency: currentFrequency,
      weeklyVolume: currentVolume,
    );

    // Calculate timeline
    final deadline = goal.targetDate ??
        goal.eventDate ??
        goal.endDate ??
        DateTime.now().add(const Duration(days: 90));
    final daysUntilGoal = deadline.difference(DateTime.now()).inDays;

    // Construct GoalContext
    final goalContext = GoalContext(
      type: goal.type.name,
      target: _formatGoalTarget(goal),
      deadline: deadline,
      specialInstructions: [], // Can populate based on user prefs or logic
      currentPace: _formatPace(goal.currentBestTime),
      isFirstTime: goal.isFirstTime,
      // Timeline calculations
      daysUntilGoal: daysUntilGoal,
      // Goal-specific parameters
      currentBestTime: goal.currentBestTime,
      eventName: goal.eventName,
      // Pillar priorities (goal-specific training focus)
      runningPriority: goal.runningPriority,
      strengthPriority: goal.strengthPriority,
      mobilityPriority: goal.mobilityPriority,
    );

    return PlanGenerationContext(
      user: userContext,
      goal: goalContext,
      trainingHistory: trainingHistory,
      philosophy: buildPlanPhilosophy(
        goal: goal,
        weeklyVolume: currentVolume ?? goal.initialWeeklyVolume ?? 20.0,
      ),
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
}
