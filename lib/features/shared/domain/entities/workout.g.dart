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
      mesocycleId: json['mesocycleId'] as String?,
      microcycleId: json['microcycleId'] as String?,
      scheduledDate: DateTime.parse(json['scheduledDate'] as String),
      type: json['type'] as String,
      name: json['name'] as String,
      plannedDuration: (json['plannedDuration'] as num).toInt(),
      plannedDistance: (json['plannedDistance'] as num?)?.toDouble(),
      intensity: json['intensity'] as String?,
      description: json['description'] as String?,
      status: json['status'] as String,
      actualDuration: (json['actualDuration'] as num?)?.toInt(),
      actualDistance: (json['actualDistance'] as num?)?.toDouble(),
      actualPace: (json['actualPace'] as num?)?.toDouble(),
      rpe: (json['rpe'] as num?)?.toInt(),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$WorkoutImplToJson(_$WorkoutImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'goalId': instance.goalId,
      'mesocycleId': instance.mesocycleId,
      'microcycleId': instance.microcycleId,
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
      'completedAt': instance.completedAt?.toIso8601String(),
    };
