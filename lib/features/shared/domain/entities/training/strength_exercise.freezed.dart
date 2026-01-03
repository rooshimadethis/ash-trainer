// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'strength_exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StrengthExercise _$StrengthExerciseFromJson(Map<String, dynamic> json) {
  return _StrengthExercise.fromJson(json);
}

/// @nodoc
mixin _$StrengthExercise {
  String get id => throw _privateConstructorUsedError;
  String get workoutId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get sets => throw _privateConstructorUsedError;
  String get reps => throw _privateConstructorUsedError;
  int get rpe => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this StrengthExercise to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StrengthExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StrengthExerciseCopyWith<StrengthExercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StrengthExerciseCopyWith<$Res> {
  factory $StrengthExerciseCopyWith(
          StrengthExercise value, $Res Function(StrengthExercise) then) =
      _$StrengthExerciseCopyWithImpl<$Res, StrengthExercise>;
  @useResult
  $Res call(
      {String id,
      String workoutId,
      String name,
      int sets,
      String reps,
      int rpe,
      String? notes});
}

/// @nodoc
class _$StrengthExerciseCopyWithImpl<$Res, $Val extends StrengthExercise>
    implements $StrengthExerciseCopyWith<$Res> {
  _$StrengthExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StrengthExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workoutId = null,
    Object? name = null,
    Object? sets = null,
    Object? reps = null,
    Object? rpe = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workoutId: null == workoutId
          ? _value.workoutId
          : workoutId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sets: null == sets
          ? _value.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as int,
      reps: null == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as String,
      rpe: null == rpe
          ? _value.rpe
          : rpe // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StrengthExerciseImplCopyWith<$Res>
    implements $StrengthExerciseCopyWith<$Res> {
  factory _$$StrengthExerciseImplCopyWith(_$StrengthExerciseImpl value,
          $Res Function(_$StrengthExerciseImpl) then) =
      __$$StrengthExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String workoutId,
      String name,
      int sets,
      String reps,
      int rpe,
      String? notes});
}

/// @nodoc
class __$$StrengthExerciseImplCopyWithImpl<$Res>
    extends _$StrengthExerciseCopyWithImpl<$Res, _$StrengthExerciseImpl>
    implements _$$StrengthExerciseImplCopyWith<$Res> {
  __$$StrengthExerciseImplCopyWithImpl(_$StrengthExerciseImpl _value,
      $Res Function(_$StrengthExerciseImpl) _then)
      : super(_value, _then);

  /// Create a copy of StrengthExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workoutId = null,
    Object? name = null,
    Object? sets = null,
    Object? reps = null,
    Object? rpe = null,
    Object? notes = freezed,
  }) {
    return _then(_$StrengthExerciseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workoutId: null == workoutId
          ? _value.workoutId
          : workoutId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sets: null == sets
          ? _value.sets
          : sets // ignore: cast_nullable_to_non_nullable
              as int,
      reps: null == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as String,
      rpe: null == rpe
          ? _value.rpe
          : rpe // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StrengthExerciseImpl implements _StrengthExercise {
  const _$StrengthExerciseImpl(
      {required this.id,
      required this.workoutId,
      required this.name,
      required this.sets,
      required this.reps,
      required this.rpe,
      this.notes});

  factory _$StrengthExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StrengthExerciseImplFromJson(json);

  @override
  final String id;
  @override
  final String workoutId;
  @override
  final String name;
  @override
  final int sets;
  @override
  final String reps;
  @override
  final int rpe;
  @override
  final String? notes;

  @override
  String toString() {
    return 'StrengthExercise(id: $id, workoutId: $workoutId, name: $name, sets: $sets, reps: $reps, rpe: $rpe, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StrengthExerciseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workoutId, workoutId) ||
                other.workoutId == workoutId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sets, sets) || other.sets == sets) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.rpe, rpe) || other.rpe == rpe) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, workoutId, name, sets, reps, rpe, notes);

  /// Create a copy of StrengthExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StrengthExerciseImplCopyWith<_$StrengthExerciseImpl> get copyWith =>
      __$$StrengthExerciseImplCopyWithImpl<_$StrengthExerciseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StrengthExerciseImplToJson(
      this,
    );
  }
}

abstract class _StrengthExercise implements StrengthExercise {
  const factory _StrengthExercise(
      {required final String id,
      required final String workoutId,
      required final String name,
      required final int sets,
      required final String reps,
      required final int rpe,
      final String? notes}) = _$StrengthExerciseImpl;

  factory _StrengthExercise.fromJson(Map<String, dynamic> json) =
      _$StrengthExerciseImpl.fromJson;

  @override
  String get id;
  @override
  String get workoutId;
  @override
  String get name;
  @override
  int get sets;
  @override
  String get reps;
  @override
  int get rpe;
  @override
  String? get notes;

  /// Create a copy of StrengthExercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StrengthExerciseImplCopyWith<_$StrengthExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
