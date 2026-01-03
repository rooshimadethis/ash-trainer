// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobility_module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MobilityModuleImpl _$$MobilityModuleImplFromJson(Map<String, dynamic> json) =>
    _$MobilityModuleImpl(
      id: json['id'] as String,
      workoutId: json['workoutId'] as String,
      exerciseName: json['exerciseName'] as String,
      targetJoint: json['targetJoint'] as String,
      setupInstructions: json['setupInstructions'] as String,
      totalCycles: (json['totalCycles'] as num).toInt(),
      phases: (json['phases'] as List<dynamic>)
          .map((e) => MobilityPhase.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MobilityModuleImplToJson(
        _$MobilityModuleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workoutId': instance.workoutId,
      'exerciseName': instance.exerciseName,
      'targetJoint': instance.targetJoint,
      'setupInstructions': instance.setupInstructions,
      'totalCycles': instance.totalCycles,
      'phases': instance.phases,
    };

_$MobilityPhaseImpl _$$MobilityPhaseImplFromJson(Map<String, dynamic> json) =>
    _$MobilityPhaseImpl(
      id: json['id'] as String,
      moduleId: json['moduleId'] as String,
      phaseType: json['phaseType'] as String,
      durationSeconds: (json['durationSeconds'] as num?)?.toInt(),
      reps: (json['reps'] as num?)?.toInt(),
      holdTimeSeconds: (json['holdTimeSeconds'] as num?)?.toInt(),
      instruction: json['instruction'] as String?,
      intensityNotes: json['intensityNotes'] as String?,
      irradiationPct: (json['irradiationPct'] as num?)?.toInt(),
      notes: json['notes'] as String?,
      sequenceOrder: (json['sequenceOrder'] as num).toInt(),
    );

Map<String, dynamic> _$$MobilityPhaseImplToJson(_$MobilityPhaseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'moduleId': instance.moduleId,
      'phaseType': instance.phaseType,
      'durationSeconds': instance.durationSeconds,
      'reps': instance.reps,
      'holdTimeSeconds': instance.holdTimeSeconds,
      'instruction': instance.instruction,
      'intensityNotes': instance.intensityNotes,
      'irradiationPct': instance.irradiationPct,
      'notes': instance.notes,
      'sequenceOrder': instance.sequenceOrder,
    };
