// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GoalImpl _$$GoalImplFromJson(Map<String, dynamic> json) => _$GoalImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$GoalTypeEnumMap, json['type']),
      name: json['name'] as String,
      isActive: json['isActive'] as bool? ?? true,
      targetDistance: (json['targetDistance'] as num?)?.toDouble(),
      targetDate: json['targetDate'] == null
          ? null
          : DateTime.parse(json['targetDate'] as String),
      targetTime: (json['targetTime'] as num?)?.toInt(),
      currentBestTime: (json['currentBestTime'] as num?)?.toInt(),
      eventName: json['eventName'] as String?,
      eventDate: json['eventDate'] == null
          ? null
          : DateTime.parse(json['eventDate'] as String),
      maintenanceFrequency: (json['maintenanceFrequency'] as num?)?.toInt(),
      maintenanceDuration: (json['maintenanceDuration'] as num?)?.toInt(),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      adherenceScore: (json['adherenceScore'] as num?)?.toDouble() ?? 0.0,
      qualityScore: (json['qualityScore'] as num?)?.toDouble() ?? 0.0,
      consistencyScore: (json['consistencyScore'] as num?)?.toDouble() ?? 0.0,
      recoveryScore: (json['recoveryScore'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$GoalImplToJson(_$GoalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$GoalTypeEnumMap[instance.type]!,
      'name': instance.name,
      'isActive': instance.isActive,
      'targetDistance': instance.targetDistance,
      'targetDate': instance.targetDate?.toIso8601String(),
      'targetTime': instance.targetTime,
      'currentBestTime': instance.currentBestTime,
      'eventName': instance.eventName,
      'eventDate': instance.eventDate?.toIso8601String(),
      'maintenanceFrequency': instance.maintenanceFrequency,
      'maintenanceDuration': instance.maintenanceDuration,
      'endDate': instance.endDate?.toIso8601String(),
      'confidence': instance.confidence,
      'adherenceScore': instance.adherenceScore,
      'qualityScore': instance.qualityScore,
      'consistencyScore': instance.consistencyScore,
      'recoveryScore': instance.recoveryScore,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$GoalTypeEnumMap = {
  GoalType.distanceMilestone: 'distanceMilestone',
  GoalType.timePerformance: 'timePerformance',
  GoalType.event: 'event',
  GoalType.maintenance: 'maintenance',
};
