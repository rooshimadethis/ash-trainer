// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      availableDays: (json['availableDays'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      constraints: json['constraints'] as String?,
      healthPermissionsGranted:
          json['healthPermissionsGranted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'availableDays': instance.availableDays,
      'constraints': instance.constraints,
      'healthPermissionsGranted': instance.healthPermissionsGranted,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
