import 'package:ash_trainer/features/shared/domain/repositories/user_repository.dart';
import 'package:ash_trainer/features/shared/domain/repositories/goal_repository.dart';
import 'package:ash_trainer/features/shared/domain/repositories/workout_repository.dart';
import 'package:ash_trainer/features/shared/domain/repositories/conversation_repository.dart';
import 'package:ash_trainer/features/shared/domain/repositories/context_repository.dart';
import 'package:ash_trainer/features/shared/domain/entities/ai/context_models.dart';
import 'package:ash_trainer/features/shared/domain/entities/goal.dart';
import 'package:ash_trainer/features/shared/domain/entities/user.dart';

class BuildCoachingChatContext {
  final UserRepository _userRepo;
  final GoalRepository _goalRepo;
  final WorkoutRepository _workoutRepo;
  final ConversationRepository _conversationRepo;
  final ContextRepository _contextRepo;

  BuildCoachingChatContext(
    this._userRepo,
    this._goalRepo,
    this._workoutRepo,
    this._conversationRepo,
    this._contextRepo,
  );

  Future<CoachingChatContext> execute({
    required String userId,
    required String conversationId,
  }) async {
    final user = await _userRepo.getCurrentUser();
    if (user == null) throw Exception('User not found');

    final List<Goal> goals = await _goalRepo.getGoals();
    if (goals.isEmpty) throw Exception('No goals found');
    Goal activeGoal;
    try {
      activeGoal = goals.firstWhere((g) => g.isActive);
    } catch (_) {
      activeGoal = goals.first;
    }

    // 1. Long Term Context
    var longTerm = await _contextRepo.getLongTermContext(userId, activeGoal.id);
    if (longTerm == null) {
      longTerm = _buildLongTerm(user, activeGoal);
      await _contextRepo.saveLongTermContext(longTerm, userId, activeGoal.id);
    }

    // 2. Medium Term Context
    var mediumTerm = await _contextRepo.getMediumTermContext(userId);
    if (mediumTerm == null ||
        await _contextRepo.needsMediumTermRegeneration(userId)) {
      mediumTerm = await _buildMediumTerm(user);
      await _contextRepo.saveMediumTermContext(mediumTerm, userId);
    }

    // 3. Short Term Context
    final shortTerm = await _buildShortTerm(conversationId);

    return CoachingChatContext(
      longTerm: longTerm,
      mediumTerm: mediumTerm,
      shortTerm: shortTerm,
    );
  }

  LongTermContext _buildLongTerm(User user, Goal goal) {
    return LongTermContext(
      user: UserContext(
        age: user.age ?? 30,
        gender: user.gender ?? 'unknown',
        availableDays: user.availableDays,
        timeConstraints: {},
        injuryHistory: [],
        // Note: For coaching chat, we don't have current metrics readily available
        // These would need to be calculated from workout history if needed
      ),
      goal: GoalContext(
        type: goal.type.name,
        target: goal.name,
        deadline: goal.targetDate ??
            goal.endDate ??
            DateTime.now().add(const Duration(days: 90)),
        confidence: goal.confidence,
        specialInstructions: [],
      ),
      trainingPhilosophy: 'Balanced approach focusing on consistency.',
      overallAdherence: goal.adherenceScore,
      raceDays: goal.eventDate != null ? [goal.eventDate!] : [],
    );
  }

  Future<MediumTermContext> _buildMediumTerm(User user) async {
    // Need to fetch stats. For now return empty-ish.
    final now = DateTime.now();
    return MediumTermContext(
      periodStart: now.subtract(const Duration(days: 14)),
      periodEnd: now,
      workoutsCompleted: 0,
      workoutsPlanned: 0,
      adherenceRate: 0.0,
      averageRPE: 0.0,
      totalDistance: 0.0,
      concerns: [],
      achievements: [],
    );
  }

  Future<ShortTermContext> _buildShortTerm(String conversationId) async {
    final now = DateTime.now();

    // Upcoming workouts (next 7 days)
    final upcomingWorkouts = await _workoutRepo.getWorkoutsForDateRange(
      startDate: now,
      endDate: now.add(const Duration(days: 7)),
    );

    // Identify today's workout
    final today = DateTime(now.year, now.month, now.day);

    // Actually safe check
    final hasTodayWorkout =
        upcomingWorkouts.any((w) => isSameDate(w.scheduledDate, today));
    final todayWorkoutSummary = hasTodayWorkout
        ? _toSummary(upcomingWorkouts
            .firstWhere((w) => isSameDate(w.scheduledDate, today)))
        : null;

    final messages = await _conversationRepo.getRecentMessages(
      conversationId: conversationId,
      limit: 20,
    );

    return ShortTermContext(
      currentDate: now,
      todayWorkout: todayWorkoutSummary,
      next7Days: upcomingWorkouts.map((w) => _toSummary(w)).toList(),
      conversationHistory: messages.reversed.toList(),
      currentPainLevel: null,
      sleepQuality: null,
      weather: null,
    );
  }

  WorkoutSummary _toSummary(dynamic w) {
    return WorkoutSummary(
      date: w.scheduledDate,
      type: w.type,
      duration: w.actualDuration ?? w.plannedDuration,
      distance: w.actualDistance ?? w.plannedDistance,
      rpe: w.rpe,
      completed: w.status == 'completed',
    );
  }

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
