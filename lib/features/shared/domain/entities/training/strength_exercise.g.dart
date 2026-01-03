// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'strength_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StrengthExerciseImpl _$$StrengthExerciseImplFromJson(
        Map<String, dynamic> json) =>
    _$StrengthExerciseImpl(
      id: json['id'] as String,
      workoutId: json['workoutId'] as String,
      name: json['name'] as String,
      sets: (json['sets'] as num).toInt(),
      reps: json['reps'] as String,
      rpe: (json['rpe'] as num).toInt(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$StrengthExerciseImplToJson(
        _$StrengthExerciseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'workoutId': instance.workoutId,
      'name': instance.name,
      'sets': instance.sets,
      'reps': instance.reps,
      'rpe': instance.rpe,
      'notes': instance.notes,
    };
