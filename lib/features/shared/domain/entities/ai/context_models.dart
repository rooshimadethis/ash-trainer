import 'package:freezed_annotation/freezed_annotation.dart';
import 'conversation.dart';
import '../user.dart';
import '../goal.dart';
import '../training/workout.dart';

part 'context_models.freezed.dart';
part 'context_models.g.dart';

@freezed
class PlanGenerationContext with _$PlanGenerationContext {
  const factory PlanGenerationContext({
    required UserContext user,
    required GoalContext goal,
    required List<WorkoutSummary> trainingHistory,
    required List<WorkoutSummary> futurePlan, // Original plan for reference
    required List<TimeOffContext> scheduledTimeOff,
    required PlanningConfig config,
    required PlanGenerationPhilosophy philosophy,
  }) = _PlanGenerationContext;

  factory PlanGenerationContext.fromJson(Map<String, dynamic> json) =>
      _$PlanGenerationContextFromJson(json);

  // Custom toJson for token optimization
  static Map<String, dynamic> activeToJson(PlanGenerationContext instance) {
    return {
      'user': UserContext.activeToJson(instance.user),
      'goal': GoalContext.activeToJson(instance.goal),
      'trainingHistory': instance.trainingHistory
          .map((w) => WorkoutSummary.activeToJson(w))
          .toList(),
      'futurePlan': instance.futurePlan
          .map((w) => WorkoutSummary.activeToJson(w))
          .toList(),
      'scheduledTimeOff': instance.scheduledTimeOff.map((t) {
        return {
          'startDate': t.startDate.toIso8601String().split('T')[0],
          'endDate': t.endDate.toIso8601String().split('T')[0],
          if (t.reason != null) 'reason': t.reason,
        };
      }).toList(),
      'config': {
        ...instance.config.toJson(),
        'startDate': instance.config.startDate.toIso8601String().split('T')[0],
      },
      'philosophy': instance.philosophy.toJson(),
    };
  }
}

enum PlanningMode {
  initial, // Start from scratch
  extend, // Append to existing plan
  repair, // Overwrite future due to missed days
  adjust, // Re-plan due to schedule changes (e.g. Time Off)
}

@freezed
class PlanningConfig with _$PlanningConfig {
  const factory PlanningConfig({
    required PlanningMode mode,
    required DateTime startDate,
    required List<String>
        upcomingWeekdays, // Lookup list for AI (Index 0 = Day 1)
    required String instruction,
  }) = _PlanningConfig;

  factory PlanningConfig.fromJson(Map<String, dynamic> json) =>
      _$PlanningConfigFromJson(json);
}

@freezed
class PlanGenerationPhilosophy with _$PlanGenerationPhilosophy {
  const factory PlanGenerationPhilosophy({
    // RUNNING GUIDANCE
    required IntensityStrategy intensityStrategy,
    required Map<String, double> intensityBreakdown,
    required double maxWeeklyVolumeIncrease, // 0.10 = max 10% increase
    required int minWeeksBetweenRecovery, // 3 = at least 3 weeks
    required int maxWeeksBetweenRecovery, // 5 = at most 5 weeks
    required double recoveryVolumeReduction, // 0.25 = 25% reduction
    required List<String> pillarConstraints,
    TaperGuidance? taperGuidance,
    required String trainingFocus,
    required String workoutStyle,
    required String flexibilityLevel,

    // STRENGTH GUIDANCE (Phase 1 - MVP)
    required StrengthGuidance strengthGuidance,

    // MOBILITY GUIDANCE (Phase 1 - MVP)
    required MobilityGuidance mobilityGuidance,
  }) = _PlanGenerationPhilosophy;

  factory PlanGenerationPhilosophy.fromJson(Map<String, dynamic> json) =>
      _$PlanGenerationPhilosophyFromJson(json);
}

enum IntensityStrategy { pyramidal, polarized, maintenance }

@freezed
class TaperGuidance with _$TaperGuidance {
  const factory TaperGuidance({
    required String strategy, // "progressive_volume_reduction"
    required int minDurationDays,
    required int maxDurationDays,
    required bool maintainIntensity,
  }) = _TaperGuidance;

  factory TaperGuidance.fromJson(Map<String, dynamic> json) =>
      _$TaperGuidanceFromJson(json);
}

@freezed
class StrengthGuidance with _$StrengthGuidance {
  const factory StrengthGuidance({
    required int weeklyFrequency, // 1-4 based on priority
    required int sessionDurationMinutes, // 10-20 for Phase 1
    required int setsPerExercise, // 2-3 based on priority
    required String repRange, // "8-12" or "30-45s" for core
  }) = _StrengthGuidance;

  factory StrengthGuidance.fromJson(Map<String, dynamic> json) =>
      _$StrengthGuidanceFromJson(json);
}

@freezed
class MobilityGuidance with _$MobilityGuidance {
  const factory MobilityGuidance({
    required int weeklyFrequency, // 2-7 based on priority
    required int sessionDurationMinutes, // 10-30 based on priority
    required List<String>
        sessionTypes, // ["active_pre_run", "passive_post_run", "recovery_deep"]
    required List<String>
        focusAreas, // ["hip_mobility", "ankle_mobility", "thoracic_spine", "hamstrings"]
    required bool increaseDuringTaper, // true for event goals
  }) = _MobilityGuidance;

  factory MobilityGuidance.fromJson(Map<String, dynamic> json) =>
      _$MobilityGuidanceFromJson(json);
}

@freezed
class UserContext with _$UserContext {
  const factory UserContext({
    int? age,
    String? gender,
    required List<String> availableDays,
    String? constraints, // Simplified string constraints
  }) = _UserContext;

  factory UserContext.fromJson(Map<String, dynamic> json) =>
      _$UserContextFromJson(json);

  factory UserContext.fromEntity(User user) {
    // Combine explicit constraints into a single string for token efficiency
    // Assuming user entity has injuryHistory or we just leave it blank for now
    // until User entity is fully updated.
    // Checking User entity fields from memory: availableDays is there.
    // If User doesn't have injuryHistory exposed, we leave constraints null.
    // (User entity usually has it, assuming getter exists)
    return UserContext(
      age: user.age,
      gender: user.gender,
      availableDays: user.availableDays,
    );
  }

  // Custom toJson for token optimization (strip nulls/empty)
  static Map<String, dynamic> activeToJson(UserContext instance) {
    return instance.toJson()
      ..removeWhere(
          (key, value) => value == null || (value is List && value.isEmpty));
  }
}

@freezed
class GoalContext with _$GoalContext {
  const factory GoalContext({
    required String type,
    required String target,
    required DateTime deadline,
    String? currentFitness,
    double? initialWeeklyVolume,
    bool? isFirstTime,
    required Map<String, String?> priorities,
  }) = _GoalContext;

  factory GoalContext.fromJson(Map<String, dynamic> json) =>
      _$GoalContextFromJson(json);

  factory GoalContext.fromEntity(Goal goal, {bool includeBaseline = false}) {
    return GoalContext(
      type: goal.type.name,
      target: _formatGoalTarget(goal),
      deadline: goal.targetDate ??
          goal.endDate ??
          DateTime.now().add(const Duration(days: 90)),
      currentFitness: null, // Populate if available in Goal or separate logic
      initialWeeklyVolume: includeBaseline ? goal.initialWeeklyVolume : null,
      isFirstTime: includeBaseline ? goal.isFirstTime : null,
      priorities: {
        'running': goal.runningPriority,
        'strength': goal.strengthPriority,
        'mobility': goal.mobilityPriority,
      }..removeWhere((k, v) => v == null),
    );
  }

  static String _formatGoalTarget(Goal goal) {
    if (goal.targetDistance != null) return 'Run ${goal.targetDistance}km';
    if (goal.targetTime != null) return 'Run in ${goal.targetTime}s';
    if (goal.eventName != null) return 'Train for ${goal.eventName}';
    return 'Maintain fitness';
  }

  // Custom toJson for token optimization
  static Map<String, dynamic> activeToJson(GoalContext instance) {
    return instance.toJson()
      ..removeWhere(
          (key, value) => value == null || (value is Map && value.isEmpty));
  }
}

@freezed
class WorkoutSummary with _$WorkoutSummary {
  const factory WorkoutSummary({
    required String id,
    required int daysAgo,
    required String type,
    required bool isKey,
    required String status,
    int? plannedDuration, // seconds
    int? actualDuration,
    double? plannedDistance, // km
    double? actualDistance,
    int? rpe,
  }) = _WorkoutSummary;

  factory WorkoutSummary.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSummaryFromJson(json);

  factory WorkoutSummary.fromEntity(Workout w, DateTime now) {
    // Standardize to midnight for "days ago/ahead" calculation to avoid off-by-one errors
    // from time-of-day differences and truncate-towards-zero behavior in Duration.inDays
    final today = DateTime(now.year, now.month, now.day);
    final workoutDay = DateTime(
        w.scheduledDate.year, w.scheduledDate.month, w.scheduledDate.day);

    final daysAgo = today.difference(workoutDay).inDays;

    // Filter metrics based on type relevance to save tokens
    final isRun = !['strength', 'mobility', 'yoga', 'cross_training']
        .contains(w.type.split('.').last);

    return WorkoutSummary(
      id: w.id,
      daysAgo: daysAgo,
      type: w.type,
      isKey: w.isKey,
      status: w.status,
      plannedDuration: w.plannedDuration,
      actualDuration: w.actualDuration,
      // Only include distance for run-based workouts
      plannedDistance: isRun ? w.plannedDistance : null,
      actualDistance: isRun ? w.actualDistance : null,
      rpe: w.rpe,
    );
  }

  // Custom toJson for token optimization
  static Map<String, dynamic> activeToJson(WorkoutSummary instance) {
    final json = instance.toJson();

    // Structure into planned/actual for clarity & filtering
    final filtered = {
      'daysAgo': json['daysAgo'],
      'type': json['type'],
      'isKey': json['isKey'],
      'status': json['status'],
      'planned': {
        'duration': json['plannedDuration'],
        'distance': json['plannedDistance'],
      }..removeWhere((k, v) => v == null),
      'actual': {
        'duration': json['actualDuration'],
        'distance': json['actualDistance'],
        'rpe': json['rpe'],
      }..removeWhere((k, v) => v == null),
    };

    return filtered
      ..removeWhere(
          (key, value) => value == null || (value is Map && value.isEmpty));
  }
}

@freezed
class TimeOffContext with _$TimeOffContext {
  const factory TimeOffContext({
    required DateTime startDate,
    required DateTime endDate,
    String? reason,
  }) = _TimeOffContext;

  factory TimeOffContext.fromJson(Map<String, dynamic> json) =>
      _$TimeOffContextFromJson(json);
}

@freezed
class CoachingChatContext with _$CoachingChatContext {
  const factory CoachingChatContext({
    required LongTermContext longTerm,
    required MediumTermContext mediumTerm,
    required ShortTermContext shortTerm,
  }) = _CoachingChatContext;

  factory CoachingChatContext.fromJson(Map<String, dynamic> json) =>
      _$CoachingChatContextFromJson(json);
}

@freezed
class LongTermContext with _$LongTermContext {
  const factory LongTermContext({
    required UserContext user,
    required GoalContext goal,
    required String trainingPhilosophy,
    required double overallAdherence,
    required List<DateTime> raceDays,
  }) = _LongTermContext;

  factory LongTermContext.fromJson(Map<String, dynamic> json) =>
      _$LongTermContextFromJson(json);
}

@freezed
class MediumTermContext with _$MediumTermContext {
  const factory MediumTermContext({
    required DateTime periodStart,
    required DateTime periodEnd,
    required int workoutsCompleted,
    required int workoutsPlanned,
    required double adherenceRate,
    required double averageRPE,
    required double totalDistance,
    required List<String> concerns,
    required List<String> achievements,
  }) = _MediumTermContext;

  factory MediumTermContext.fromJson(Map<String, dynamic> json) =>
      _$MediumTermContextFromJson(json);
}

@freezed
class ShortTermContext with _$ShortTermContext {
  const factory ShortTermContext({
    required DateTime currentDate,
    WorkoutSummary? todayWorkout,
    required List<WorkoutSummary> next7Days,
    required List<ConversationMessage> conversationHistory,
    int? currentPainLevel,
    String? sleepQuality,
    String? weather,
  }) = _ShortTermContext;

  factory ShortTermContext.fromJson(Map<String, dynamic> json) =>
      _$ShortTermContextFromJson(json);
}
