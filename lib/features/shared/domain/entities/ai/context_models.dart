import 'package:freezed_annotation/freezed_annotation.dart';
import 'conversation.dart';

part 'context_models.freezed.dart';
part 'context_models.g.dart';

@freezed
class PlanGenerationContext with _$PlanGenerationContext {
  const factory PlanGenerationContext({
    required UserContext user,
    required GoalContext goal,
    required List<WorkoutSummary> trainingHistory,
    required PlanGenerationPhilosophy philosophy,
  }) = _PlanGenerationContext;

  factory PlanGenerationContext.fromJson(Map<String, dynamic> json) =>
      _$PlanGenerationContextFromJson(json);
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
    required int age,
    required String gender,
    required List<String> availableDays,
    required Map<String, int> timeConstraints,
    required List<String> injuryHistory,
    // Current training metrics (from form on first plan, calculated from history on subsequent plans)
    int? weeklyTrainingFrequency, // sessions per week
    double? weeklyVolume, // km per week
  }) = _UserContext;

  factory UserContext.fromJson(Map<String, dynamic> json) =>
      _$UserContextFromJson(json);
}

@freezed
class GoalContext with _$GoalContext {
  const factory GoalContext({
    required String type,
    required String target,
    required DateTime deadline,
    required List<String> specialInstructions,
    String? currentPace,
    bool? isFirstTime,
    // Timeline calculations
    int? daysUntilGoal,
    // Goal-specific parameters
    int? currentBestTime, // For time performance goals (seconds)
    String? eventName, // For event goals
    // Pillar priorities (goal-specific training focus)
    String? runningPriority,
    String? strengthPriority,
    String? mobilityPriority,
  }) = _GoalContext;

  factory GoalContext.fromJson(Map<String, dynamic> json) =>
      _$GoalContextFromJson(json);
}

@freezed
class WorkoutSummary with _$WorkoutSummary {
  const factory WorkoutSummary({
    required DateTime date,
    required String type,
    required int duration,
    double? distance,
    int? rpe,
    required bool completed,
  }) = _WorkoutSummary;

  factory WorkoutSummary.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSummaryFromJson(json);
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
