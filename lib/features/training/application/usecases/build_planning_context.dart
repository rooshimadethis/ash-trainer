import 'package:ash_trainer/features/shared/domain/repositories/user_repository.dart';
import 'package:ash_trainer/features/shared/domain/repositories/goal_repository.dart';
import 'package:ash_trainer/features/shared/domain/repositories/workout_repository.dart';
import 'package:ash_trainer/features/shared/domain/entities/ai/context_models.dart';
import 'build_plan_philosophy.dart';

class BuildPlanningContext {
  final UserRepository _userRepo;
  final GoalRepository _goalRepo;
  final WorkoutRepository _workoutRepo;

  BuildPlanningContext(
    this._userRepo,
    this._goalRepo,
    this._workoutRepo,
  );

  Future<PlanGenerationContext> execute({
    required String goalId,
    required PlanningMode mode,
  }) async {
    final user = await _userRepo.getCurrentUser();
    if (user == null) throw Exception('User not found');

    final goal = await _goalRepo.getGoal(goalId);

    // 1. Determine Lookback Window (Token Optimization)
    Duration historyDuration;
    int missedDays = 0;

    switch (mode) {
      case PlanningMode.initial:
        // 45 days: Establish baseline fitness/consistency for new plan
        historyDuration = const Duration(days: 45);
        break;

      case PlanningMode.extend:
        // 30 days: Recent trend is sufficient to maintain progression
        historyDuration = const Duration(days: 30);
        break;

      case PlanningMode.repair:
        // Dynamic: Look back enough to cover the break + 2 weeks of training
        // This ensures we always see "pre-injury" fitness levels.
        missedDays = await _workoutRepo.getConsecutiveMissedDays(goalId);
        // Cap history to reasonable amount to avoid token overflow?
        // For now, raw logic: missed + 14 days
        historyDuration = Duration(days: missedDays + 14);
        break;
    }

    final historyWorkouts = await _workoutRepo.getWorkoutsForDateRange(
      startDate: DateTime.now().subtract(historyDuration),
      endDate: DateTime.now(),
    );

    // 2. Mode-Specific Instructions & Start Date
    String instruction;
    DateTime startDate;

    switch (mode) {
      case PlanningMode.initial:
        startDate = DateTime.now();
        instruction = "Create a full plan from scratch.";
        break;

      case PlanningMode.extend:
        final lastDate = await _workoutRepo.getLastScheduledWorkoutDate(goalId);
        // Start day after the last scheduled workout
        startDate = (lastDate ?? DateTime.now()).add(const Duration(days: 1));
        instruction =
            "Extend existing plan. Last workout was on ${lastDate?.toIso8601String().split('T')[0] ?? 'N/A'}. Maintain progression.";
        break;

      case PlanningMode.repair:
        startDate = DateTime.now().add(const Duration(days: 1));
        instruction =
            "User missed $missedDays days. Create a 'Return to Training' bridge block starting tomorrow.";
        break;
    }

    // 3. Current Metrics (for Philosophy) - Calculated from LAST 7 DAYS
    // Same logic as before to guide philosophy intensity
    final last7Days = DateTime.now().subtract(const Duration(days: 7));
    final recentWorkouts = historyWorkouts
        .where((w) =>
            w.scheduledDate.isAfter(last7Days) &&
            w.status ==
                'completed') // Assuming 'completed' string check or enum?
        // Entity status is usually enum or string. Let's check logic.
        // Workout entity status is usually checked via enum helper or string match.
        // In existing code it was: w.status == 'completed' (it was likely string in Drift or DTO mapped).
        // Let's assume Entity uses String or Enum.
        // Checking Workout definition: required String status. It's a string.
        .toList();

    final currentVolume = recentWorkouts.isEmpty
        ? goal.initialWeeklyVolume
        : recentWorkouts
            .map((w) =>
                w.actualDistance ?? w.plannedDistance ?? 0.0) // Prefer actuals
            .fold(0.0, (sum, distance) => sum + distance);

    final philosophy = buildPlanPhilosophy(
      goal: goal,
      weeklyVolume: currentVolume ?? goal.initialWeeklyVolume ?? 20.0,
    );

    // 4. Build Context
    return PlanGenerationContext(
      user: UserContext.fromEntity(user),
      goal: GoalContext.fromEntity(goal,
          includeBaseline: mode == PlanningMode.initial),
      trainingHistory: historyWorkouts
          .map((w) => WorkoutSummary.fromEntity(w, DateTime.now()))
          .toList(),
      config: PlanningConfig(
        mode: mode,
        startDate: startDate,
        instruction: instruction,
      ),
      philosophy: philosophy,
    );
  }
}
