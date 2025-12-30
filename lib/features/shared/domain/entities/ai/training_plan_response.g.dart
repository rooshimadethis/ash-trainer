// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_plan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrainingPlanImpl _$$TrainingPlanImplFromJson(Map<String, dynamic> json) =>
    _$TrainingPlanImpl(
      phases: (json['phases'] as List<dynamic>)
          .map((e) => PhaseSkeleton.fromJson(e as Map<String, dynamic>))
          .toList(),
      blocks: (json['blocks'] as List<dynamic>)
          .map((e) => TrainingBlockSkeleton.fromJson(e as Map<String, dynamic>))
          .toList(),
      workouts: (json['workouts'] as List<dynamic>)
          .map((e) => WorkoutSkeleton.fromJson(e as Map<String, dynamic>))
          .toList(),
      rationale:
          PlanRationale.fromJson(json['rationale'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$TrainingPlanImplToJson(_$TrainingPlanImpl instance) =>
    <String, dynamic>{
      'phases': instance.phases,
      'blocks': instance.blocks,
      'workouts': instance.workouts,
      'rationale': instance.rationale,
    };

_$PhaseSkeletonImpl _$$PhaseSkeletonImplFromJson(Map<String, dynamic> json) =>
    _$PhaseSkeletonImpl(
      id: json['id'] as String,
      phaseNumber: (json['phaseNumber'] as num).toInt(),
      phaseType: json['phaseType'] as String,
      durationWeeks: (json['durationWeeks'] as num).toInt(),
      targetWeeklyVolume: json['targetWeeklyVolume'] as String,
      targetWeeklyDuration: json['targetWeeklyDuration'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$PhaseSkeletonImplToJson(_$PhaseSkeletonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phaseNumber': instance.phaseNumber,
      'phaseType': instance.phaseType,
      'durationWeeks': instance.durationWeeks,
      'targetWeeklyVolume': instance.targetWeeklyVolume,
      'targetWeeklyDuration': instance.targetWeeklyDuration,
      'description': instance.description,
    };

_$TrainingBlockSkeletonImpl _$$TrainingBlockSkeletonImplFromJson(
        Map<String, dynamic> json) =>
    _$TrainingBlockSkeletonImpl(
      id: json['id'] as String,
      phaseId: json['phaseId'] as String,
      blockNumber: (json['blockNumber'] as num).toInt(),
      intent: json['intent'] as String,
      durationDays: (json['durationDays'] as num).toInt(),
    );

Map<String, dynamic> _$$TrainingBlockSkeletonImplToJson(
        _$TrainingBlockSkeletonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phaseId': instance.phaseId,
      'blockNumber': instance.blockNumber,
      'intent': instance.intent,
      'durationDays': instance.durationDays,
    };

_$WorkoutSkeletonImpl _$$WorkoutSkeletonImplFromJson(
        Map<String, dynamic> json) =>
    _$WorkoutSkeletonImpl(
      id: json['id'] as String,
      phaseId: json['phaseId'] as String,
      blockId: json['blockId'] as String,
      dayNumber: (json['dayNumber'] as num).toInt(),
      type: json['type'] as String,
      name: json['name'] as String,
      plannedDuration: (json['plannedDuration'] as num).toInt(),
      plannedDistance: (json['plannedDistance'] as num?)?.toDouble(),
      intensity: json['intensity'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$WorkoutSkeletonImplToJson(
        _$WorkoutSkeletonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phaseId': instance.phaseId,
      'blockId': instance.blockId,
      'dayNumber': instance.dayNumber,
      'type': instance.type,
      'name': instance.name,
      'plannedDuration': instance.plannedDuration,
      'plannedDistance': instance.plannedDistance,
      'intensity': instance.intensity,
      'description': instance.description,
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
