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
    };
