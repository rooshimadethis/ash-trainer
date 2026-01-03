// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutImpl _$$WorkoutImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      goalId: json['goalId'] as String,
      phaseId: json['phaseId'] as String?,
      blockId: json['blockId'] as String?,
      scheduledDate: DateTime.parse(json['scheduledDate'] as String),
      type: json['type'] as String,
      name: json['name'] as String,
      plannedDuration: (json['plannedDuration'] as num).toInt(),
      plannedDistance: (json['plannedDistance'] as num?)?.toDouble(),
      intensity: (json['intensity'] as num?)?.toInt(),
      description: json['description'] as String?,
      status: json['status'] as String,
      actualDuration: (json['actualDuration'] as num?)?.toInt(),
      actualDistance: (json['actualDistance'] as num?)?.toDouble(),
      actualPace: (json['actualPace'] as num?)?.toDouble(),
      rpe: (json['rpe'] as num?)?.toInt(),
      syncedFrom: json['syncedFrom'] as String?,
      isKey: json['isKey'] as bool? ?? false,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      strengthExercises: (json['strengthExercises'] as List<dynamic>?)
          ?.map((e) => StrengthExercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      mobilitySequence: (json['mobilitySequence'] as List<dynamic>?)
          ?.map((e) => MobilityModule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$WorkoutImplToJson(_$WorkoutImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'goalId': instance.goalId,
      'phaseId': instance.phaseId,
      'blockId': instance.blockId,
      'scheduledDate': instance.scheduledDate.toIso8601String(),
      'type': instance.type,
      'name': instance.name,
      'plannedDuration': instance.plannedDuration,
      'plannedDistance': instance.plannedDistance,
      'intensity': instance.intensity,
      'description': instance.description,
      'status': instance.status,
      'actualDuration': instance.actualDuration,
      'actualDistance': instance.actualDistance,
      'actualPace': instance.actualPace,
      'rpe': instance.rpe,
      'syncedFrom': instance.syncedFrom,
      'isKey': instance.isKey,
      'completedAt': instance.completedAt?.toIso8601String(),
      'strengthExercises': instance.strengthExercises,
      'mobilitySequence': instance.mobilitySequence,
    };
