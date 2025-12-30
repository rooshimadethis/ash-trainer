// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  double? get weight =>
      throw _privateConstructorUsedError; // Always stored in KG
  String get preferredWeightUnit =>
      throw _privateConstructorUsedError; // UI display preference: 'kg' or 'lb'
  double? get height =>
      throw _privateConstructorUsedError; // Always stored in CM
  String get preferredHeightUnit =>
      throw _privateConstructorUsedError; // UI display preference: 'cm' or 'in'
  List<String> get availableDays => throw _privateConstructorUsedError;
  String? get constraints => throw _privateConstructorUsedError;
  bool get healthPermissionsGranted => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      int? age,
      String? gender,
      double? weight,
      String preferredWeightUnit,
      double? height,
      String preferredHeightUnit,
      List<String> availableDays,
      String? constraints,
      bool healthPermissionsGranted,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? age = freezed,
    Object? gender = freezed,
    Object? weight = freezed,
    Object? preferredWeightUnit = null,
    Object? height = freezed,
    Object? preferredHeightUnit = null,
    Object? availableDays = null,
    Object? constraints = freezed,
    Object? healthPermissionsGranted = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      preferredWeightUnit: null == preferredWeightUnit
          ? _value.preferredWeightUnit
          : preferredWeightUnit // ignore: cast_nullable_to_non_nullable
              as String,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      preferredHeightUnit: null == preferredHeightUnit
          ? _value.preferredHeightUnit
          : preferredHeightUnit // ignore: cast_nullable_to_non_nullable
              as String,
      availableDays: null == availableDays
          ? _value.availableDays
          : availableDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      constraints: freezed == constraints
          ? _value.constraints
          : constraints // ignore: cast_nullable_to_non_nullable
              as String?,
      healthPermissionsGranted: null == healthPermissionsGranted
          ? _value.healthPermissionsGranted
          : healthPermissionsGranted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int? age,
      String? gender,
      double? weight,
      String preferredWeightUnit,
      double? height,
      String preferredHeightUnit,
      List<String> availableDays,
      String? constraints,
      bool healthPermissionsGranted,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? age = freezed,
    Object? gender = freezed,
    Object? weight = freezed,
    Object? preferredWeightUnit = null,
    Object? height = freezed,
    Object? preferredHeightUnit = null,
    Object? availableDays = null,
    Object? constraints = freezed,
    Object? healthPermissionsGranted = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double?,
      preferredWeightUnit: null == preferredWeightUnit
          ? _value.preferredWeightUnit
          : preferredWeightUnit // ignore: cast_nullable_to_non_nullable
              as String,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as double?,
      preferredHeightUnit: null == preferredHeightUnit
          ? _value.preferredHeightUnit
          : preferredHeightUnit // ignore: cast_nullable_to_non_nullable
              as String,
      availableDays: null == availableDays
          ? _value._availableDays
          : availableDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      constraints: freezed == constraints
          ? _value.constraints
          : constraints // ignore: cast_nullable_to_non_nullable
              as String?,
      healthPermissionsGranted: null == healthPermissionsGranted
          ? _value.healthPermissionsGranted
          : healthPermissionsGranted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.id,
      this.age,
      this.gender,
      this.weight,
      this.preferredWeightUnit = 'kg',
      this.height,
      this.preferredHeightUnit = 'cm',
      final List<String> availableDays = const [],
      this.constraints,
      this.healthPermissionsGranted = false,
      required this.createdAt,
      required this.updatedAt})
      : _availableDays = availableDays;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final int? age;
  @override
  final String? gender;
  @override
  final double? weight;
// Always stored in KG
  @override
  @JsonKey()
  final String preferredWeightUnit;
// UI display preference: 'kg' or 'lb'
  @override
  final double? height;
// Always stored in CM
  @override
  @JsonKey()
  final String preferredHeightUnit;
// UI display preference: 'cm' or 'in'
  final List<String> _availableDays;
// UI display preference: 'cm' or 'in'
  @override
  @JsonKey()
  List<String> get availableDays {
    if (_availableDays is EqualUnmodifiableListView) return _availableDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableDays);
  }

  @override
  final String? constraints;
  @override
  @JsonKey()
  final bool healthPermissionsGranted;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'User(id: $id, age: $age, gender: $gender, weight: $weight, preferredWeightUnit: $preferredWeightUnit, height: $height, preferredHeightUnit: $preferredHeightUnit, availableDays: $availableDays, constraints: $constraints, healthPermissionsGranted: $healthPermissionsGranted, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.preferredWeightUnit, preferredWeightUnit) ||
                other.preferredWeightUnit == preferredWeightUnit) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.preferredHeightUnit, preferredHeightUnit) ||
                other.preferredHeightUnit == preferredHeightUnit) &&
            const DeepCollectionEquality()
                .equals(other._availableDays, _availableDays) &&
            (identical(other.constraints, constraints) ||
                other.constraints == constraints) &&
            (identical(
                    other.healthPermissionsGranted, healthPermissionsGranted) ||
                other.healthPermissionsGranted == healthPermissionsGranted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      age,
      gender,
      weight,
      preferredWeightUnit,
      height,
      preferredHeightUnit,
      const DeepCollectionEquality().hash(_availableDays),
      constraints,
      healthPermissionsGranted,
      createdAt,
      updatedAt);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final String id,
      final int? age,
      final String? gender,
      final double? weight,
      final String preferredWeightUnit,
      final double? height,
      final String preferredHeightUnit,
      final List<String> availableDays,
      final String? constraints,
      final bool healthPermissionsGranted,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  int? get age;
  @override
  String? get gender;
  @override
  double? get weight; // Always stored in KG
  @override
  String get preferredWeightUnit; // UI display preference: 'kg' or 'lb'
  @override
  double? get height; // Always stored in CM
  @override
  String get preferredHeightUnit; // UI display preference: 'cm' or 'in'
  @override
  List<String> get availableDays;
  @override
  String? get constraints;
  @override
  bool get healthPermissionsGranted;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
