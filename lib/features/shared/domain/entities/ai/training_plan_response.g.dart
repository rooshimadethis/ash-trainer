// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_plan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrainingPlanImpl _$$TrainingPlanImplFromJson(Map<String, dynamic> json) =>
    _$TrainingPlanImpl(
      mesocycles: (json['mesocycles'] as List<dynamic>)
          .map((e) => Mesocycle.fromJson(e as Map<String, dynamic>))
          .toList(),
      microcycles: (json['microcycles'] as List<dynamic>)
          .map((e) => Microcycle.fromJson(e as Map<String, dynamic>))
          .toList(),
      workouts: (json['workouts'] as List<dynamic>)
          .map((e) => Workout.fromJson(e as Map<String, dynamic>))
          .toList(),
      rationale:
          PlanRationale.fromJson(json['rationale'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TrainingPlanImplToJson(_$TrainingPlanImpl instance) =>
    <String, dynamic>{
      'mesocycles': instance.mesocycles,
      'microcycles': instance.microcycles,
      'workouts': instance.workouts,
      'rationale': instance.rationale,
    };

_$MesocycleImpl _$$MesocycleImplFromJson(Map<String, dynamic> json) =>
    _$MesocycleImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      emphasis: json['emphasis'] as String,
    );

Map<String, dynamic> _$$MesocycleImplToJson(_$MesocycleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'emphasis': instance.emphasis,
    };

_$MicrocycleImpl _$$MicrocycleImplFromJson(Map<String, dynamic> json) =>
    _$MicrocycleImpl(
      id: json['id'] as String,
      weekNumber: (json['weekNumber'] as num).toInt(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      emphasis: json['emphasis'] as String,
    );

Map<String, dynamic> _$$MicrocycleImplToJson(_$MicrocycleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weekNumber': instance.weekNumber,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'emphasis': instance.emphasis,
    };

_$PlanRationaleImpl _$$PlanRationaleImplFromJson(Map<String, dynamic> json) =>
    _$PlanRationaleImpl(
      overallApproach: json['overallApproach'] as String,
      intensityDistribution: json['intensityDistribution'] as String,
      keyWorkouts: json['keyWorkouts'] as String,
      recoveryStrategy: json['recoveryStrategy'] as String,
    );

Map<String, dynamic> _$$PlanRationaleImplToJson(_$PlanRationaleImpl instance) =>
    <String, dynamic>{
      'overallApproach': instance.overallApproach,
      'intensityDistribution': instance.intensityDistribution,
      'keyWorkouts': instance.keyWorkouts,
      'recoveryStrategy': instance.recoveryStrategy,
    };
