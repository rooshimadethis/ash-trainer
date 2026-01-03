// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Workout _$WorkoutFromJson(Map<String, dynamic> json) {
  return _Workout.fromJson(json);
}

/// @nodoc
mixin _$Workout {
  String get id =>
      throw _privateConstructorUsedError; // Domain ID (usually matches DB ID, but string)
  String get userId => throw _privateConstructorUsedError;
  String get goalId => throw _privateConstructorUsedError;
  String? get phaseId => throw _privateConstructorUsedError;
  String? get blockId => throw _privateConstructorUsedError;
  DateTime get scheduledDate => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // 'easy_run', 'tempo', etc.
  String get name => throw _privateConstructorUsedError;
  int get plannedDuration => throw _privateConstructorUsedError; // seconds
  double? get plannedDistance => throw _privateConstructorUsedError; // km
  int? get intensity =>
      throw _privateConstructorUsedError; // Planned RPE (1-10)
  String? get description => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // 'planned', 'in_progress', 'completed', 'skipped', 'missed'
  int? get actualDuration => throw _privateConstructorUsedError;
  double? get actualDistance => throw _privateConstructorUsedError;
  double? get actualPace => throw _privateConstructorUsedError;
  int? get rpe => throw _privateConstructorUsedError;
  String? get syncedFrom => throw _privateConstructorUsedError;
  bool get isKey => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  List<StrengthExercise>? get strengthExercises =>
      throw _privateConstructorUsedError;
  List<MobilityModule>? get mobilitySequence =>
      throw _privateConstructorUsedError;

  /// Serializes this Workout to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Workout
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutCopyWith<Workout> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutCopyWith<$Res> {
  factory $WorkoutCopyWith(Workout value, $Res Function(Workout) then) =
      _$WorkoutCopyWithImpl<$Res, Workout>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String goalId,
      String? phaseId,
      String? blockId,
      DateTime scheduledDate,
      String type,
      String name,
      int plannedDuration,
      double? plannedDistance,
      int? intensity,
      String? description,
      String status,
      int? actualDuration,
      double? actualDistance,
      double? actualPace,
      int? rpe,
      String? syncedFrom,
      bool isKey,
      DateTime? completedAt,
      List<StrengthExercise>? strengthExercises,
      List<MobilityModule>? mobilitySequence});
}

/// @nodoc
class _$WorkoutCopyWithImpl<$Res, $Val extends Workout>
    implements $WorkoutCopyWith<$Res> {
  _$WorkoutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Workout
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? goalId = null,
    Object? phaseId = freezed,
    Object? blockId = freezed,
    Object? scheduledDate = null,
    Object? type = null,
    Object? name = null,
    Object? plannedDuration = null,
    Object? plannedDistance = freezed,
    Object? intensity = freezed,
    Object? description = freezed,
    Object? status = null,
    Object? actualDuration = freezed,
    Object? actualDistance = freezed,
    Object? actualPace = freezed,
    Object? rpe = freezed,
    Object? syncedFrom = freezed,
    Object? isKey = null,
    Object? completedAt = freezed,
    Object? strengthExercises = freezed,
    Object? mobilitySequence = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      phaseId: freezed == phaseId
          ? _value.phaseId
          : phaseId // ignore: cast_nullable_to_non_nullable
              as String?,
      blockId: freezed == blockId
          ? _value.blockId
          : blockId // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledDate: null == scheduledDate
          ? _value.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      plannedDuration: null == plannedDuration
          ? _value.plannedDuration
          : plannedDuration // ignore: cast_nullable_to_non_nullable
              as int,
      plannedDistance: freezed == plannedDistance
          ? _value.plannedDistance
          : plannedDistance // ignore: cast_nullable_to_non_nullable
              as double?,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      actualDuration: freezed == actualDuration
          ? _value.actualDuration
          : actualDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      actualDistance: freezed == actualDistance
          ? _value.actualDistance
          : actualDistance // ignore: cast_nullable_to_non_nullable
              as double?,
      actualPace: freezed == actualPace
          ? _value.actualPace
          : actualPace // ignore: cast_nullable_to_non_nullable
              as double?,
      rpe: freezed == rpe
          ? _value.rpe
          : rpe // ignore: cast_nullable_to_non_nullable
              as int?,
      syncedFrom: freezed == syncedFrom
          ? _value.syncedFrom
          : syncedFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      isKey: null == isKey
          ? _value.isKey
          : isKey // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      strengthExercises: freezed == strengthExercises
          ? _value.strengthExercises
          : strengthExercises // ignore: cast_nullable_to_non_nullable
              as List<StrengthExercise>?,
      mobilitySequence: freezed == mobilitySequence
          ? _value.mobilitySequence
          : mobilitySequence // ignore: cast_nullable_to_non_nullable
              as List<MobilityModule>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkoutImplCopyWith<$Res> implements $WorkoutCopyWith<$Res> {
  factory _$$WorkoutImplCopyWith(
          _$WorkoutImpl value, $Res Function(_$WorkoutImpl) then) =
      __$$WorkoutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String goalId,
      String? phaseId,
      String? blockId,
      DateTime scheduledDate,
      String type,
      String name,
      int plannedDuration,
      double? plannedDistance,
      int? intensity,
      String? description,
      String status,
      int? actualDuration,
      double? actualDistance,
      double? actualPace,
      int? rpe,
      String? syncedFrom,
      bool isKey,
      DateTime? completedAt,
      List<StrengthExercise>? strengthExercises,
      List<MobilityModule>? mobilitySequence});
}

/// @nodoc
class __$$WorkoutImplCopyWithImpl<$Res>
    extends _$WorkoutCopyWithImpl<$Res, _$WorkoutImpl>
    implements _$$WorkoutImplCopyWith<$Res> {
  __$$WorkoutImplCopyWithImpl(
      _$WorkoutImpl _value, $Res Function(_$WorkoutImpl) _then)
      : super(_value, _then);

  /// Create a copy of Workout
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? goalId = null,
    Object? phaseId = freezed,
    Object? blockId = freezed,
    Object? scheduledDate = null,
    Object? type = null,
    Object? name = null,
    Object? plannedDuration = null,
    Object? plannedDistance = freezed,
    Object? intensity = freezed,
    Object? description = freezed,
    Object? status = null,
    Object? actualDuration = freezed,
    Object? actualDistance = freezed,
    Object? actualPace = freezed,
    Object? rpe = freezed,
    Object? syncedFrom = freezed,
    Object? isKey = null,
    Object? completedAt = freezed,
    Object? strengthExercises = freezed,
    Object? mobilitySequence = freezed,
  }) {
    return _then(_$WorkoutImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      goalId: null == goalId
          ? _value.goalId
          : goalId // ignore: cast_nullable_to_non_nullable
              as String,
      phaseId: freezed == phaseId
          ? _value.phaseId
          : phaseId // ignore: cast_nullable_to_non_nullable
              as String?,
      blockId: freezed == blockId
          ? _value.blockId
          : blockId // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledDate: null == scheduledDate
          ? _value.scheduledDate
          : scheduledDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      plannedDuration: null == plannedDuration
          ? _value.plannedDuration
          : plannedDuration // ignore: cast_nullable_to_non_nullable
              as int,
      plannedDistance: freezed == plannedDistance
          ? _value.plannedDistance
          : plannedDistance // ignore: cast_nullable_to_non_nullable
              as double?,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      actualDuration: freezed == actualDuration
          ? _value.actualDuration
          : actualDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      actualDistance: freezed == actualDistance
          ? _value.actualDistance
          : actualDistance // ignore: cast_nullable_to_non_nullable
              as double?,
      actualPace: freezed == actualPace
          ? _value.actualPace
          : actualPace // ignore: cast_nullable_to_non_nullable
              as double?,
      rpe: freezed == rpe
          ? _value.rpe
          : rpe // ignore: cast_nullable_to_non_nullable
              as int?,
      syncedFrom: freezed == syncedFrom
          ? _value.syncedFrom
          : syncedFrom // ignore: cast_nullable_to_non_nullable
              as String?,
      isKey: null == isKey
          ? _value.isKey
          : isKey // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      strengthExercises: freezed == strengthExercises
          ? _value._strengthExercises
          : strengthExercises // ignore: cast_nullable_to_non_nullable
              as List<StrengthExercise>?,
      mobilitySequence: freezed == mobilitySequence
          ? _value._mobilitySequence
          : mobilitySequence // ignore: cast_nullable_to_non_nullable
              as List<MobilityModule>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutImpl implements _Workout {
  const _$WorkoutImpl(
      {required this.id,
      required this.userId,
      required this.goalId,
      this.phaseId,
      this.blockId,
      required this.scheduledDate,
      required this.type,
      required this.name,
      required this.plannedDuration,
      this.plannedDistance,
      this.intensity,
      this.description,
      required this.status,
      this.actualDuration,
      this.actualDistance,
      this.actualPace,
      this.rpe,
      this.syncedFrom,
      this.isKey = false,
      this.completedAt,
      final List<StrengthExercise>? strengthExercises,
      final List<MobilityModule>? mobilitySequence})
      : _strengthExercises = strengthExercises,
        _mobilitySequence = mobilitySequence;

  factory _$WorkoutImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutImplFromJson(json);

  @override
  final String id;
// Domain ID (usually matches DB ID, but string)
  @override
  final String userId;
  @override
  final String goalId;
  @override
  final String? phaseId;
  @override
  final String? blockId;
  @override
  final DateTime scheduledDate;
  @override
  final String type;
// 'easy_run', 'tempo', etc.
  @override
  final String name;
  @override
  final int plannedDuration;
// seconds
  @override
  final double? plannedDistance;
// km
  @override
  final int? intensity;
// Planned RPE (1-10)
  @override
  final String? description;
  @override
  final String status;
// 'planned', 'in_progress', 'completed', 'skipped', 'missed'
  @override
  final int? actualDuration;
  @override
  final double? actualDistance;
  @override
  final double? actualPace;
  @override
  final int? rpe;
  @override
  final String? syncedFrom;
  @override
  @JsonKey()
  final bool isKey;
  @override
  final DateTime? completedAt;
  final List<StrengthExercise>? _strengthExercises;
  @override
  List<StrengthExercise>? get strengthExercises {
    final value = _strengthExercises;
    if (value == null) return null;
    if (_strengthExercises is EqualUnmodifiableListView)
      return _strengthExercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<MobilityModule>? _mobilitySequence;
  @override
  List<MobilityModule>? get mobilitySequence {
    final value = _mobilitySequence;
    if (value == null) return null;
    if (_mobilitySequence is EqualUnmodifiableListView)
      return _mobilitySequence;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Workout(id: $id, userId: $userId, goalId: $goalId, phaseId: $phaseId, blockId: $blockId, scheduledDate: $scheduledDate, type: $type, name: $name, plannedDuration: $plannedDuration, plannedDistance: $plannedDistance, intensity: $intensity, description: $description, status: $status, actualDuration: $actualDuration, actualDistance: $actualDistance, actualPace: $actualPace, rpe: $rpe, syncedFrom: $syncedFrom, isKey: $isKey, completedAt: $completedAt, strengthExercises: $strengthExercises, mobilitySequence: $mobilitySequence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.goalId, goalId) || other.goalId == goalId) &&
            (identical(other.phaseId, phaseId) || other.phaseId == phaseId) &&
            (identical(other.blockId, blockId) || other.blockId == blockId) &&
            (identical(other.scheduledDate, scheduledDate) ||
                other.scheduledDate == scheduledDate) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.plannedDuration, plannedDuration) ||
                other.plannedDuration == plannedDuration) &&
            (identical(other.plannedDistance, plannedDistance) ||
                other.plannedDistance == plannedDistance) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.actualDuration, actualDuration) ||
                other.actualDuration == actualDuration) &&
            (identical(other.actualDistance, actualDistance) ||
                other.actualDistance == actualDistance) &&
            (identical(other.actualPace, actualPace) ||
                other.actualPace == actualPace) &&
            (identical(other.rpe, rpe) || other.rpe == rpe) &&
            (identical(other.syncedFrom, syncedFrom) ||
                other.syncedFrom == syncedFrom) &&
            (identical(other.isKey, isKey) || other.isKey == isKey) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            const DeepCollectionEquality()
                .equals(other._strengthExercises, _strengthExercises) &&
            const DeepCollectionEquality()
                .equals(other._mobilitySequence, _mobilitySequence));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        goalId,
        phaseId,
        blockId,
        scheduledDate,
        type,
        name,
        plannedDuration,
        plannedDistance,
        intensity,
        description,
        status,
        actualDuration,
        actualDistance,
        actualPace,
        rpe,
        syncedFrom,
        isKey,
        completedAt,
        const DeepCollectionEquality().hash(_strengthExercises),
        const DeepCollectionEquality().hash(_mobilitySequence)
      ]);

  /// Create a copy of Workout
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutImplCopyWith<_$WorkoutImpl> get copyWith =>
      __$$WorkoutImplCopyWithImpl<_$WorkoutImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutImplToJson(
      this,
    );
  }
}

abstract class _Workout implements Workout {
  const factory _Workout(
      {required final String id,
      required final String userId,
      required final String goalId,
      final String? phaseId,
      final String? blockId,
      required final DateTime scheduledDate,
      required final String type,
      required final String name,
      required final int plannedDuration,
      final double? plannedDistance,
      final int? intensity,
      final String? description,
      required final String status,
      final int? actualDuration,
      final double? actualDistance,
      final double? actualPace,
      final int? rpe,
      final String? syncedFrom,
      final bool isKey,
      final DateTime? completedAt,
      final List<StrengthExercise>? strengthExercises,
      final List<MobilityModule>? mobilitySequence}) = _$WorkoutImpl;

  factory _Workout.fromJson(Map<String, dynamic> json) = _$WorkoutImpl.fromJson;

  @override
  String get id; // Domain ID (usually matches DB ID, but string)
  @override
  String get userId;
  @override
  String get goalId;
  @override
  String? get phaseId;
  @override
  String? get blockId;
  @override
  DateTime get scheduledDate;
  @override
  String get type; // 'easy_run', 'tempo', etc.
  @override
  String get name;
  @override
  int get plannedDuration; // seconds
  @override
  double? get plannedDistance; // km
  @override
  int? get intensity; // Planned RPE (1-10)
  @override
  String? get description;
  @override
  String
      get status; // 'planned', 'in_progress', 'completed', 'skipped', 'missed'
  @override
  int? get actualDuration;
  @override
  double? get actualDistance;
  @override
  double? get actualPace;
  @override
  int? get rpe;
  @override
  String? get syncedFrom;
  @override
  bool get isKey;
  @override
  DateTime? get completedAt;
  @override
  List<StrengthExercise>? get strengthExercises;
  @override
  List<MobilityModule>? get mobilitySequence;

  /// Create a copy of Workout
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutImplCopyWith<_$WorkoutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
