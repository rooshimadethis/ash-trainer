// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrainingBlockImpl _$$TrainingBlockImplFromJson(Map<String, dynamic> json) =>
    _$TrainingBlockImpl(
      id: json['id'] as String,
      phaseId: json['phaseId'] as String,
      blockNumber: (json['blockNumber'] as num).toInt(),
      intent: json['intent'] as String,
      durationDays: (json['durationDays'] as num).toInt(),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      actualDistance: (json['actualDistance'] as num?)?.toDouble() ?? 0.0,
      actualDuration: (json['actualDuration'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$TrainingBlockImplToJson(_$TrainingBlockImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phaseId': instance.phaseId,
      'blockNumber': instance.blockNumber,
      'intent': instance.intent,
      'durationDays': instance.durationDays,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'actualDistance': instance.actualDistance,
      'actualDuration': instance.actualDuration,
    };
