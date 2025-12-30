import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_plan_response.freezed.dart';
part 'training_plan_response.g.dart';

@freezed
class TrainingPlan with _$TrainingPlan {
  const factory TrainingPlan({
    required List<PhaseSkeleton> phases,
    required List<TrainingBlockSkeleton> blocks,
    required List<WorkoutSkeleton> workouts,
    required PlanRationale rationale,
  }) = _TrainingPlan;

  factory TrainingPlan.fromJson(Map<String, dynamic> json) =>
      _$TrainingPlanFromJson(json);
}

@freezed
class PhaseSkeleton with _$PhaseSkeleton {
  const factory PhaseSkeleton({
    required String id,
    required int phaseNumber,
    required String phaseType,
    required int durationWeeks,
    required String targetWeeklyVolume,
    required String targetWeeklyDuration,
    String? description,
  }) = _PhaseSkeleton;

  factory PhaseSkeleton.fromJson(Map<String, dynamic> json) =>
      _$PhaseSkeletonFromJson(json);
}

@freezed
class TrainingBlockSkeleton with _$TrainingBlockSkeleton {
  const factory TrainingBlockSkeleton({
    required String id,
    required String phaseId,
    required int blockNumber,
    required String intent,
    required int durationDays,
  }) = _TrainingBlockSkeleton;

  factory TrainingBlockSkeleton.fromJson(Map<String, dynamic> json) =>
      _$TrainingBlockSkeletonFromJson(json);
}

@freezed
class WorkoutSkeleton with _$WorkoutSkeleton {
  const factory WorkoutSkeleton({
    required String id,
    required String phaseId,
    required String blockId,
    required int
        dayNumber, // Relative day number in the plan or block? Usually block day or global day. Let's assume Global from plan start or Block relative.
    // The plan says "identifies specific days by dayNumber relative to the phase or block."
    // Let's use Block relative day (1-7 usually) for simplicity in prompt, or global if easier.
    // Actually, "dayNumber" relative to the block (1..durationDays) is safest.
    required String type,
    required String name,
    required int plannedDuration,
    double? plannedDistance,
    required String intensity,
    required String description,
  }) = _WorkoutSkeleton;

  factory WorkoutSkeleton.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSkeletonFromJson(json);
}

@freezed
class PlanRationale with _$PlanRationale {
  const factory PlanRationale({
    required String overallApproach,
    required String intensityDistribution,
    required String keyWorkouts,
    required String recoveryStrategy,
  }) = _PlanRationale;

  factory PlanRationale.fromJson(Map<String, dynamic> json) =>
      _$PlanRationaleFromJson(json);
}
