// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      age: (json['age'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      preferredWeightUnit: json['preferredWeightUnit'] as String? ?? 'kg',
      height: (json['height'] as num?)?.toDouble(),
      preferredHeightUnit: json['preferredHeightUnit'] as String? ?? 'cm',
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
      'age': instance.age,
      'gender': instance.gender,
      'weight': instance.weight,
      'preferredWeightUnit': instance.preferredWeightUnit,
      'height': instance.height,
      'preferredHeightUnit': instance.preferredHeightUnit,
      'availableDays': instance.availableDays,
      'constraints': instance.constraints,
      'healthPermissionsGranted': instance.healthPermissionsGranted,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
