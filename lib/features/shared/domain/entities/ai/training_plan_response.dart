import 'package:freezed_annotation/freezed_annotation.dart';
import '../workout.dart';

part 'training_plan_response.freezed.dart';
part 'training_plan_response.g.dart';

@freezed
class TrainingPlan with _$TrainingPlan {
  const factory TrainingPlan({
    required List<Mesocycle> mesocycles,
    required List<Microcycle> microcycles,
    required List<Workout> workouts,
    required PlanRationale rationale,
  }) = _TrainingPlan;

  factory TrainingPlan.fromJson(Map<String, dynamic> json) =>
      _$TrainingPlanFromJson(json);
}

@freezed
class Mesocycle with _$Mesocycle {
  const factory Mesocycle({
    required String id,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required String emphasis,
  }) = _Mesocycle;

  factory Mesocycle.fromJson(Map<String, dynamic> json) =>
      _$MesocycleFromJson(json);
}

@freezed
class Microcycle with _$Microcycle {
  const factory Microcycle({
    required String id,
    required int weekNumber,
    required DateTime startDate,
    required DateTime endDate,
    required String emphasis,
  }) = _Microcycle;

  factory Microcycle.fromJson(Map<String, dynamic> json) =>
      _$MicrocycleFromJson(json);
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
