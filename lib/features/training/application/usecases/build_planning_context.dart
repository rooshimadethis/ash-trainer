import 'package:ash_trainer/features/shared/domain/repositories/user_repository.dart';
import 'package:ash_trainer/features/shared/domain/repositories/goal_repository.dart';
import 'package:ash_trainer/features/shared/domain/repositories/workout_repository.dart';
import 'package:ash_trainer/features/shared/domain/entities/ai/context_models.dart';
import 'package:ash_trainer/features/shared/domain/repositories/time_off_repository.dart';
import 'build_plan_philosophy.dart';

class BuildPlanningContext {
  final UserRepository _userRepo;
  final GoalRepository _goalRepo;
  final WorkoutRepository _workoutRepo;
  final TimeOffRepository _timeOffRepo;

  BuildPlanningContext(
    this._userRepo,
    this._goalRepo,
    this._workoutRepo,
    this._timeOffRepo,
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
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (mode) {
      case PlanningMode.initial:
        historyDuration = const Duration(days: 45);
        break;

      case PlanningMode.extend:
        historyDuration = const Duration(days: 30);
        break;

      case PlanningMode.repair:
        missedDays = await _workoutRepo.getConsecutiveMissedDays(goalId);
        historyDuration = Duration(days: missedDays + 14);
        break;

      case PlanningMode.adjust:
        historyDuration = const Duration(days: 30);
        break;
    }

    final historyWorkouts = await _workoutRepo.getWorkoutsForDateRange(
      startDate: today.subtract(historyDuration),
      endDate: now, // End at current time to include today's progress
    );

    // 1.5 Fetch scheduled Time Off
    final timeOffEntries = await _timeOffRepo.getAllTimeOffs();
    final scheduledTimeOff = timeOffEntries
        .map((e) => TimeOffContext(
              startDate: DateTime(
                  e.startDate.year, e.startDate.month, e.startDate.day),
              endDate: DateTime(e.endDate.year, e.endDate.month, e.endDate.day),
              reason: e.reason,
            ))
        .toList();

    // 2. Mode-Specific Instructions & Start Date
    String instruction;
    DateTime startDate;

    switch (mode) {
      case PlanningMode.initial:
        startDate = today;
        instruction = "Create a full plan from scratch.";
        break;

      case PlanningMode.extend:
        final lastDate = await _workoutRepo.getLastScheduledWorkoutDate(goalId);
        startDate = (lastDate ?? today).add(const Duration(days: 1));
        // Normalize to start of day
        startDate = DateTime(startDate.year, startDate.month, startDate.day);
        instruction =
            "Extend existing plan. Last workout was on ${lastDate?.toIso8601String().split('T')[0] ?? 'N/A'}. Maintain progression.";
        break;

      case PlanningMode.repair:
        startDate = today.add(const Duration(days: 1));
        instruction =
            "User missed $missedDays days. Create a 'Return to Training' bridge block starting tomorrow.";
        break;

      case PlanningMode.adjust:
        final hasTimeOffToday = scheduledTimeOff.any(
            (t) => !t.startDate.isAfter(today) && !t.endDate.isBefore(today));
        startDate =
            hasTimeOffToday ? today : today.add(const Duration(days: 1));

        // Simplified instruction - the AI gets explicit timing from scheduledTimeOff structure
        instruction = scheduledTimeOff.isNotEmpty
            ? "Adjust plan to accommodate scheduled time off. Taper volume before breaks and ramp safely after."
            : "User schedule has changed. Re-plan from ${hasTimeOffToday ? 'today' : 'tomorrow'} onwards.";
        break;
    }

    // 3. Current Metrics (for Philosophy) - Calculated from LAST 7 DAYS
    final last7Days = today.subtract(const Duration(days: 7));
    final recentWorkouts = historyWorkouts
        .where((w) =>
            w.scheduledDate.isAfter(last7Days) && w.status == 'completed')
        .toList();

    final currentVolume = recentWorkouts.isEmpty
        ? goal.initialWeeklyVolume
        : recentWorkouts
            .map((w) => w.actualDistance ?? w.plannedDistance ?? 0.0)
            .fold(0.0, (sum, distance) => sum + distance);

    final philosophy = buildPlanPhilosophy(
      goal: goal,
      weeklyVolume: currentVolume ?? goal.initialWeeklyVolume ?? 20.0,
    );

    // 4. Fetch Future Plan (for Adjust/Repair Context)
    List<WorkoutSummary> futurePlan = [];
    if (mode == PlanningMode.adjust || mode == PlanningMode.repair) {
      final futureWorkouts = await _workoutRepo.getWorkoutsForDateRange(
        startDate: startDate,
        endDate: startDate.add(const Duration(days: 30)),
      );
      futurePlan = futureWorkouts
          .map((w) => WorkoutSummary.fromEntity(w, DateTime.now()))
          .toList();
    }

    // 5. Build Context
    return PlanGenerationContext(
      user: UserContext.fromEntity(user),
      goal: GoalContext.fromEntity(goal,
          includeBaseline: mode == PlanningMode.initial),
      trainingHistory: historyWorkouts
          .map((w) => WorkoutSummary.fromEntity(w, DateTime.now()))
          .toList(),
      futurePlan: futurePlan,
      scheduledTimeOff: scheduledTimeOff,
      config: PlanningConfig(
        mode: mode,
        startDate: startDate,
        upcomingWeekdays: List.generate(28, (index) {
          final date = startDate.add(Duration(days: index));
          // Manual weekday mapping to avoid dependency on intl for now if not present,
          // or use simple switch. Dart DateTime.weekday is 1=Mon, 7=Sun.
          const days = [
            'Monday',
            'Tuesday',
            'Wednesday',
            'Thursday',
            'Friday',
            'Saturday',
            'Sunday'
          ];
          return days[date.weekday - 1];
        }),
        instruction: instruction,
      ),
      philosophy: philosophy,
    );
  }
}
