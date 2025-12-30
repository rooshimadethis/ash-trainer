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
    required String trainingPhilosophy,
  }) = _PlanGenerationContext;

  factory PlanGenerationContext.fromJson(Map<String, dynamic> json) =>
      _$PlanGenerationContextFromJson(json);
}

@freezed
class UserContext with _$UserContext {
  const factory UserContext({
    required int age,
    required String gender,
    required String experienceLevel,
    required List<String> availableDays,
    required Map<String, int> timeConstraints,
    required List<String> injuryHistory,
    double? weeklyMileageBase,
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
    required double confidence,
    required List<String> specialInstructions,
    String? currentPace,
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
