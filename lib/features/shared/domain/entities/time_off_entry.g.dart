// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_off_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TimeOffEntryImpl _$$TimeOffEntryImplFromJson(Map<String, dynamic> json) =>
    _$TimeOffEntryImpl(
      id: (json['id'] as num).toInt(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      reason: json['reason'] as String?,
      isSynced: json['isSynced'] as bool? ?? false,
    );

Map<String, dynamic> _$$TimeOffEntryImplToJson(_$TimeOffEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'reason': instance.reason,
      'isSynced': instance.isSynced,
    };
