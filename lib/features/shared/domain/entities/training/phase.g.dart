// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PhaseImpl _$$PhaseImplFromJson(Map<String, dynamic> json) => _$PhaseImpl(
      id: json['id'] as String,
      goalId: json['goalId'] as String,
      phaseNumber: (json['phaseNumber'] as num).toInt(),
      phaseType: json['phaseType'] as String,
      durationWeeks: (json['durationWeeks'] as num).toInt(),
      targetWeeklyVolume: json['targetWeeklyVolume'] as String,
      targetWeeklyDuration: json['targetWeeklyDuration'] as String,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$PhaseImplToJson(_$PhaseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'goalId': instance.goalId,
      'phaseNumber': instance.phaseNumber,
      'phaseType': instance.phaseType,
      'durationWeeks': instance.durationWeeks,
      'targetWeeklyVolume': instance.targetWeeklyVolume,
      'targetWeeklyDuration': instance.targetWeeklyDuration,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'description': instance.description,
    };
