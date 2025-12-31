// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Phase _$PhaseFromJson(Map<String, dynamic> json) {
  return _Phase.fromJson(json);
}

/// @nodoc
mixin _$Phase {
  String get id => throw _privateConstructorUsedError;
  String get goalId => throw _privateConstructorUsedError;
  int get phaseNumber => throw _privateConstructorUsedError;
  String get phaseType =>
      throw _privateConstructorUsedError; // 'base', 'build', 'peak', 'taper', 'recovery'
  int get durationWeeks => throw _privateConstructorUsedError;
  String get targetWeeklyVolume => throw _privateConstructorUsedError;
  String get targetWeeklyDuration => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  double get actualDistance => throw _privateConstructorUsedError;
  int get actualDuration => throw _privateConstructorUsedError;

  /// Serializes this Phase to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Phase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhaseCopyWith<Phase> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhaseCopyWith<$Res> {
  factory $PhaseCopyWith(Phase value, $Res Function(Phase) then) =
      _$PhaseCopyWithImpl<$Res, Phase>;
  @useResult
  $Res call(
      {String id,
      String goalId,
      int phaseNumber,
      String phaseType,
      int durationWeeks,
      String targetWeeklyVolume,
      String targetWeeklyDuration,
      DateTime? startDate,
      DateTime? endDate,
      String? description,
      double actualDistance,
      int actualDuration});
}

/// @nodoc
class _$PhaseCopyWithImpl<$Res, $Val extends Phase>
    implements $PhaseCopyWith<$Res> {
  _$PhaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Phase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? goalId = null,
    Object? phaseNumber = null,
    Object? phaseType = null,
    Object? durationWeeks = null,
    Object? targetWeeklyVolume = null,
    Object? targetWeeklyDuration = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? description = freezed,
    Object? actualDistance = null,
    Object? actualDuration = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      phaseNumber: null == phaseNumber
          ? _value.phaseNumber
          : phaseNumber // ignore: cast_nullable_to_non_nullable
              as int,
      phaseType: null == phaseType
          ? _value.phaseType
          : phaseType // ignore: cast_nullable_to_non_nullable
              as String,
      durationWeeks: null == durationWeeks
          ? _value.durationWeeks
          : durationWeeks // ignore: cast_nullable_to_non_nullable
              as int,
      targetWeeklyVolume: null == targetWeeklyVolume
          ? _value.targetWeeklyVolume
          : targetWeeklyVolume // ignore: cast_nullable_to_non_nullable
              as String,
      targetWeeklyDuration: null == targetWeeklyDuration
          ? _value.targetWeeklyDuration
          : targetWeeklyDuration // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      actualDistance: null == actualDistance
          ? _value.actualDistance
          : actualDistance // ignore: cast_nullable_to_non_nullable
              as double,
      actualDuration: null == actualDuration
          ? _value.actualDuration
          : actualDuration // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhaseImplCopyWith<$Res> implements $PhaseCopyWith<$Res> {
  factory _$$PhaseImplCopyWith(
          _$PhaseImpl value, $Res Function(_$PhaseImpl) then) =
      __$$PhaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String goalId,
      int phaseNumber,
      String phaseType,
      int durationWeeks,
      String targetWeeklyVolume,
      String targetWeeklyDuration,
      DateTime? startDate,
      DateTime? endDate,
      String? description,
      double actualDistance,
      int actualDuration});
}

/// @nodoc
class __$$PhaseImplCopyWithImpl<$Res>
    extends _$PhaseCopyWithImpl<$Res, _$PhaseImpl>
    implements _$$PhaseImplCopyWith<$Res> {
  __$$PhaseImplCopyWithImpl(
      _$PhaseImpl _value, $Res Function(_$PhaseImpl) _then)
      : super(_value, _then);

  /// Create a copy of Phase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? goalId = null,
    Object? phaseNumber = null,
    Object? phaseType = null,
    Object? durationWeeks = null,
    Object? targetWeeklyVolume = null,
    Object? targetWeeklyDuration = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? description = freezed,
    Object? actualDistance = null,
    Object? actualDuration = null,
  }) {
    return _then(_$PhaseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      phaseNumber: null == phaseNumber
          ? _value.phaseNumber
          : phaseNumber // ignore: cast_nullable_to_non_nullable
              as int,
      phaseType: null == phaseType
          ? _value.phaseType
          : phaseType // ignore: cast_nullable_to_non_nullable
              as String,
      durationWeeks: null == durationWeeks
          ? _value.durationWeeks
          : durationWeeks // ignore: cast_nullable_to_non_nullable
              as int,
      targetWeeklyVolume: null == targetWeeklyVolume
          ? _value.targetWeeklyVolume
          : targetWeeklyVolume // ignore: cast_nullable_to_non_nullable
              as String,
      targetWeeklyDuration: null == targetWeeklyDuration
          ? _value.targetWeeklyDuration
          : targetWeeklyDuration // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      actualDistance: null == actualDistance
          ? _value.actualDistance
          : actualDistance // ignore: cast_nullable_to_non_nullable
              as double,
      actualDuration: null == actualDuration
          ? _value.actualDuration
          : actualDuration // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PhaseImpl implements _Phase {
  const _$PhaseImpl(
      {required this.id,
      required this.goalId,
      required this.phaseNumber,
      required this.phaseType,
      required this.durationWeeks,
      required this.targetWeeklyVolume,
      required this.targetWeeklyDuration,
      this.startDate,
      this.endDate,
      this.description,
      this.actualDistance = 0.0,
      this.actualDuration = 0});

  factory _$PhaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhaseImplFromJson(json);

  @override
  final String id;
  @override
  final String goalId;
  @override
  final int phaseNumber;
  @override
  final String phaseType;
// 'base', 'build', 'peak', 'taper', 'recovery'
  @override
  final int durationWeeks;
  @override
  final String targetWeeklyVolume;
  @override
  final String targetWeeklyDuration;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final String? description;
  @override
  @JsonKey()
  final double actualDistance;
  @override
  @JsonKey()
  final int actualDuration;

  @override
  String toString() {
    return 'Phase(id: $id, goalId: $goalId, phaseNumber: $phaseNumber, phaseType: $phaseType, durationWeeks: $durationWeeks, targetWeeklyVolume: $targetWeeklyVolume, targetWeeklyDuration: $targetWeeklyDuration, startDate: $startDate, endDate: $endDate, description: $description, actualDistance: $actualDistance, actualDuration: $actualDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhaseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.goalId, goalId) || other.goalId == goalId) &&
            (identical(other.phaseNumber, phaseNumber) ||
                other.phaseNumber == phaseNumber) &&
            (identical(other.phaseType, phaseType) ||
                other.phaseType == phaseType) &&
            (identical(other.durationWeeks, durationWeeks) ||
                other.durationWeeks == durationWeeks) &&
            (identical(other.targetWeeklyVolume, targetWeeklyVolume) ||
                other.targetWeeklyVolume == targetWeeklyVolume) &&
            (identical(other.targetWeeklyDuration, targetWeeklyDuration) ||
                other.targetWeeklyDuration == targetWeeklyDuration) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.actualDistance, actualDistance) ||
                other.actualDistance == actualDistance) &&
            (identical(other.actualDuration, actualDuration) ||
                other.actualDuration == actualDuration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      goalId,
      phaseNumber,
      phaseType,
      durationWeeks,
      targetWeeklyVolume,
      targetWeeklyDuration,
      startDate,
      endDate,
      description,
      actualDistance,
      actualDuration);

  /// Create a copy of Phase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhaseImplCopyWith<_$PhaseImpl> get copyWith =>
      __$$PhaseImplCopyWithImpl<_$PhaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhaseImplToJson(
      this,
    );
  }
}

abstract class _Phase implements Phase {
  const factory _Phase(
      {required final String id,
      required final String goalId,
      required final int phaseNumber,
      required final String phaseType,
      required final int durationWeeks,
      required final String targetWeeklyVolume,
      required final String targetWeeklyDuration,
      final DateTime? startDate,
      final DateTime? endDate,
      final String? description,
      final double actualDistance,
      final int actualDuration}) = _$PhaseImpl;

  factory _Phase.fromJson(Map<String, dynamic> json) = _$PhaseImpl.fromJson;

  @override
  String get id;
  @override
  String get goalId;
  @override
  int get phaseNumber;
  @override
  String get phaseType; // 'base', 'build', 'peak', 'taper', 'recovery'
  @override
  int get durationWeeks;
  @override
  String get targetWeeklyVolume;
  @override
  String get targetWeeklyDuration;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  String? get description;
  @override
  double get actualDistance;
  @override
  int get actualDuration;

  /// Create a copy of Phase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhaseImplCopyWith<_$PhaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
