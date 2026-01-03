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
      intensity: (json['intensity'] as num).toInt(),
      description: json['description'] as String,
      isKey: json['isKey'] as bool? ?? false,
      strengthExercises: (json['strengthExercises'] as List<dynamic>?)
          ?.map((e) =>
              StrengthExerciseSkeleton.fromJson(e as Map<String, dynamic>))
          .toList(),
      mobilitySequence: (json['mobilitySequence'] as List<dynamic>?)
          ?.map(
              (e) => MobilityModuleSkeleton.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'isKey': instance.isKey,
      'strengthExercises': instance.strengthExercises,
      'mobilitySequence': instance.mobilitySequence,
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

_$StrengthExerciseSkeletonImpl _$$StrengthExerciseSkeletonImplFromJson(
        Map<String, dynamic> json) =>
    _$StrengthExerciseSkeletonImpl(
      name: json['name'] as String,
      sets: (json['sets'] as num).toInt(),
      reps: json['reps'] as String,
      rpe: (json['rpe'] as num).toInt(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$StrengthExerciseSkeletonImplToJson(
        _$StrengthExerciseSkeletonImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'sets': instance.sets,
      'reps': instance.reps,
      'rpe': instance.rpe,
      'notes': instance.notes,
    };

_$MobilityModuleSkeletonImpl _$$MobilityModuleSkeletonImplFromJson(
        Map<String, dynamic> json) =>
    _$MobilityModuleSkeletonImpl(
      exerciseName: json['exerciseName'] as String,
      targetJoint: json['targetJoint'] as String,
      setupInstructions: json['setupInstructions'] as String,
      totalCycles: (json['totalCycles'] as num).toInt(),
      phases: (json['phases'] as List<dynamic>)
          .map((e) => MobilityPhaseSkeleton.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MobilityModuleSkeletonImplToJson(
        _$MobilityModuleSkeletonImpl instance) =>
    <String, dynamic>{
      'exerciseName': instance.exerciseName,
      'targetJoint': instance.targetJoint,
      'setupInstructions': instance.setupInstructions,
      'totalCycles': instance.totalCycles,
      'phases': instance.phases,
    };

_$MobilityPhaseSkeletonImpl _$$MobilityPhaseSkeletonImplFromJson(
        Map<String, dynamic> json) =>
    _$MobilityPhaseSkeletonImpl(
      phaseType: json['phaseType'] as String,
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
      intensityNotes: json['intensityNotes'] as String?,
      irradiationPct: (json['irradiationPct'] as num?)?.toInt(),
      instruction: json['instruction'] as String?,
      reps: (json['reps'] as num?)?.toInt(),
      holdTimeSeconds: (json['holdTimeSeconds'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$MobilityPhaseSkeletonImplToJson(
        _$MobilityPhaseSkeletonImpl instance) =>
    <String, dynamic>{
      'phaseType': instance.phaseType,
      'durationSeconds': instance.durationSeconds,
      'intensityNotes': instance.intensityNotes,
      'irradiationPct': instance.irradiationPct,
      'instruction': instance.instruction,
      'reps': instance.reps,
      'holdTimeSeconds': instance.holdTimeSeconds,
    };
