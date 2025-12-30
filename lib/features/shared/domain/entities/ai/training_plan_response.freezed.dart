// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_plan_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrainingPlan _$TrainingPlanFromJson(Map<String, dynamic> json) {
  return _TrainingPlan.fromJson(json);
}

/// @nodoc
mixin _$TrainingPlan {
  List<PhaseSkeleton> get phases => throw _privateConstructorUsedError;
  List<TrainingBlockSkeleton> get blocks => throw _privateConstructorUsedError;
  List<WorkoutSkeleton> get workouts => throw _privateConstructorUsedError;
  PlanRationale get rationale => throw _privateConstructorUsedError;

  /// Serializes this TrainingPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrainingPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrainingPlanCopyWith<TrainingPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingPlanCopyWith<$Res> {
  factory $TrainingPlanCopyWith(
          TrainingPlan value, $Res Function(TrainingPlan) then) =
      _$TrainingPlanCopyWithImpl<$Res, TrainingPlan>;
  @useResult
  $Res call(
      {List<PhaseSkeleton> phases,
      List<TrainingBlockSkeleton> blocks,
      List<WorkoutSkeleton> workouts,
      PlanRationale rationale});

  $PlanRationaleCopyWith<$Res> get rationale;
}

/// @nodoc
class _$TrainingPlanCopyWithImpl<$Res, $Val extends TrainingPlan>
    implements $TrainingPlanCopyWith<$Res> {
  _$TrainingPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrainingPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phases = null,
    Object? blocks = null,
    Object? workouts = null,
    Object? rationale = null,
  }) {
    return _then(_value.copyWith(
      phases: null == phases
          ? _value.phases
          : phases // ignore: cast_nullable_to_non_nullable
              as List<PhaseSkeleton>,
      blocks: null == blocks
          ? _value.blocks
          : blocks // ignore: cast_nullable_to_non_nullable
              as List<TrainingBlockSkeleton>,
      workouts: null == workouts
          ? _value.workouts
          : workouts // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSkeleton>,
      rationale: null == rationale
          ? _value.rationale
          : rationale // ignore: cast_nullable_to_non_nullable
              as PlanRationale,
    ) as $Val);
  }

  /// Create a copy of TrainingPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlanRationaleCopyWith<$Res> get rationale {
    return $PlanRationaleCopyWith<$Res>(_value.rationale, (value) {
      return _then(_value.copyWith(rationale: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TrainingPlanImplCopyWith<$Res>
    implements $TrainingPlanCopyWith<$Res> {
  factory _$$TrainingPlanImplCopyWith(
          _$TrainingPlanImpl value, $Res Function(_$TrainingPlanImpl) then) =
      __$$TrainingPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PhaseSkeleton> phases,
      List<TrainingBlockSkeleton> blocks,
      List<WorkoutSkeleton> workouts,
      PlanRationale rationale});

  @override
  $PlanRationaleCopyWith<$Res> get rationale;
}

/// @nodoc
class __$$TrainingPlanImplCopyWithImpl<$Res>
    extends _$TrainingPlanCopyWithImpl<$Res, _$TrainingPlanImpl>
    implements _$$TrainingPlanImplCopyWith<$Res> {
  __$$TrainingPlanImplCopyWithImpl(
      _$TrainingPlanImpl _value, $Res Function(_$TrainingPlanImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrainingPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phases = null,
    Object? blocks = null,
    Object? workouts = null,
    Object? rationale = null,
  }) {
    return _then(_$TrainingPlanImpl(
      phases: null == phases
          ? _value._phases
          : phases // ignore: cast_nullable_to_non_nullable
              as List<PhaseSkeleton>,
      blocks: null == blocks
          ? _value._blocks
          : blocks // ignore: cast_nullable_to_non_nullable
              as List<TrainingBlockSkeleton>,
      workouts: null == workouts
          ? _value._workouts
          : workouts // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSkeleton>,
      rationale: null == rationale
          ? _value.rationale
          : rationale // ignore: cast_nullable_to_non_nullable
              as PlanRationale,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrainingPlanImpl implements _TrainingPlan {
  const _$TrainingPlanImpl(
      {required final List<PhaseSkeleton> phases,
      required final List<TrainingBlockSkeleton> blocks,
      required final List<WorkoutSkeleton> workouts,
      required this.rationale})
      : _phases = phases,
        _blocks = blocks,
        _workouts = workouts;

  factory _$TrainingPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrainingPlanImplFromJson(json);

  final List<PhaseSkeleton> _phases;
  @override
  List<PhaseSkeleton> get phases {
    if (_phases is EqualUnmodifiableListView) return _phases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_phases);
  }

  final List<TrainingBlockSkeleton> _blocks;
  @override
  List<TrainingBlockSkeleton> get blocks {
    if (_blocks is EqualUnmodifiableListView) return _blocks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blocks);
  }

  final List<WorkoutSkeleton> _workouts;
  @override
  List<WorkoutSkeleton> get workouts {
    if (_workouts is EqualUnmodifiableListView) return _workouts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workouts);
  }

  @override
  final PlanRationale rationale;

  @override
  String toString() {
    return 'TrainingPlan(phases: $phases, blocks: $blocks, workouts: $workouts, rationale: $rationale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingPlanImpl &&
            const DeepCollectionEquality().equals(other._phases, _phases) &&
            const DeepCollectionEquality().equals(other._blocks, _blocks) &&
            const DeepCollectionEquality().equals(other._workouts, _workouts) &&
            (identical(other.rationale, rationale) ||
                other.rationale == rationale));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_phases),
      const DeepCollectionEquality().hash(_blocks),
      const DeepCollectionEquality().hash(_workouts),
      rationale);

  /// Create a copy of TrainingPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingPlanImplCopyWith<_$TrainingPlanImpl> get copyWith =>
      __$$TrainingPlanImplCopyWithImpl<_$TrainingPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrainingPlanImplToJson(
      this,
    );
  }
}

abstract class _TrainingPlan implements TrainingPlan {
  const factory _TrainingPlan(
      {required final List<PhaseSkeleton> phases,
      required final List<TrainingBlockSkeleton> blocks,
      required final List<WorkoutSkeleton> workouts,
      required final PlanRationale rationale}) = _$TrainingPlanImpl;

  factory _TrainingPlan.fromJson(Map<String, dynamic> json) =
      _$TrainingPlanImpl.fromJson;

  @override
  List<PhaseSkeleton> get phases;
  @override
  List<TrainingBlockSkeleton> get blocks;
  @override
  List<WorkoutSkeleton> get workouts;
  @override
  PlanRationale get rationale;

  /// Create a copy of TrainingPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrainingPlanImplCopyWith<_$TrainingPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PhaseSkeleton _$PhaseSkeletonFromJson(Map<String, dynamic> json) {
  return _PhaseSkeleton.fromJson(json);
}

/// @nodoc
mixin _$PhaseSkeleton {
  String get id => throw _privateConstructorUsedError;
  int get phaseNumber => throw _privateConstructorUsedError;
  String get phaseType => throw _privateConstructorUsedError;
  int get durationWeeks => throw _privateConstructorUsedError;
  String get targetWeeklyVolume => throw _privateConstructorUsedError;
  String get targetWeeklyDuration => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this PhaseSkeleton to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PhaseSkeleton
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhaseSkeletonCopyWith<PhaseSkeleton> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhaseSkeletonCopyWith<$Res> {
  factory $PhaseSkeletonCopyWith(
          PhaseSkeleton value, $Res Function(PhaseSkeleton) then) =
      _$PhaseSkeletonCopyWithImpl<$Res, PhaseSkeleton>;
  @useResult
  $Res call(
      {String id,
      int phaseNumber,
      String phaseType,
      int durationWeeks,
      String targetWeeklyVolume,
      String targetWeeklyDuration,
      String? description});
}

/// @nodoc
class _$PhaseSkeletonCopyWithImpl<$Res, $Val extends PhaseSkeleton>
    implements $PhaseSkeletonCopyWith<$Res> {
  _$PhaseSkeletonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhaseSkeleton
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phaseNumber = null,
    Object? phaseType = null,
    Object? durationWeeks = null,
    Object? targetWeeklyVolume = null,
    Object? targetWeeklyDuration = null,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhaseSkeletonImplCopyWith<$Res>
    implements $PhaseSkeletonCopyWith<$Res> {
  factory _$$PhaseSkeletonImplCopyWith(
          _$PhaseSkeletonImpl value, $Res Function(_$PhaseSkeletonImpl) then) =
      __$$PhaseSkeletonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int phaseNumber,
      String phaseType,
      int durationWeeks,
      String targetWeeklyVolume,
      String targetWeeklyDuration,
      String? description});
}

/// @nodoc
class __$$PhaseSkeletonImplCopyWithImpl<$Res>
    extends _$PhaseSkeletonCopyWithImpl<$Res, _$PhaseSkeletonImpl>
    implements _$$PhaseSkeletonImplCopyWith<$Res> {
  __$$PhaseSkeletonImplCopyWithImpl(
      _$PhaseSkeletonImpl _value, $Res Function(_$PhaseSkeletonImpl) _then)
      : super(_value, _then);

  /// Create a copy of PhaseSkeleton
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phaseNumber = null,
    Object? phaseType = null,
    Object? durationWeeks = null,
    Object? targetWeeklyVolume = null,
    Object? targetWeeklyDuration = null,
    Object? description = freezed,
  }) {
    return _then(_$PhaseSkeletonImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PhaseSkeletonImpl implements _PhaseSkeleton {
  const _$PhaseSkeletonImpl(
      {required this.id,
      required this.phaseNumber,
      required this.phaseType,
      required this.durationWeeks,
      required this.targetWeeklyVolume,
      required this.targetWeeklyDuration,
      this.description});

  factory _$PhaseSkeletonImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhaseSkeletonImplFromJson(json);

  @override
  final String id;
  @override
  final int phaseNumber;
  @override
  final String phaseType;
  @override
  final int durationWeeks;
  @override
  final String targetWeeklyVolume;
  @override
  final String targetWeeklyDuration;
  @override
  final String? description;

  @override
  String toString() {
    return 'PhaseSkeleton(id: $id, phaseNumber: $phaseNumber, phaseType: $phaseType, durationWeeks: $durationWeeks, targetWeeklyVolume: $targetWeeklyVolume, targetWeeklyDuration: $targetWeeklyDuration, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhaseSkeletonImpl &&
            (identical(other.id, id) || other.id == id) &&
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
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, phaseNumber, phaseType,
      durationWeeks, targetWeeklyVolume, targetWeeklyDuration, description);

  /// Create a copy of PhaseSkeleton
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhaseSkeletonImplCopyWith<_$PhaseSkeletonImpl> get copyWith =>
      __$$PhaseSkeletonImplCopyWithImpl<_$PhaseSkeletonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhaseSkeletonImplToJson(
      this,
    );
  }
}

abstract class _PhaseSkeleton implements PhaseSkeleton {
  const factory _PhaseSkeleton(
      {required final String id,
      required final int phaseNumber,
      required final String phaseType,
      required final int durationWeeks,
      required final String targetWeeklyVolume,
      required final String targetWeeklyDuration,
      final String? description}) = _$PhaseSkeletonImpl;

  factory _PhaseSkeleton.fromJson(Map<String, dynamic> json) =
      _$PhaseSkeletonImpl.fromJson;

  @override
  String get id;
  @override
  int get phaseNumber;
  @override
  String get phaseType;
  @override
  int get durationWeeks;
  @override
  String get targetWeeklyVolume;
  @override
  String get targetWeeklyDuration;
  @override
  String? get description;

  /// Create a copy of PhaseSkeleton
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhaseSkeletonImplCopyWith<_$PhaseSkeletonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TrainingBlockSkeleton _$TrainingBlockSkeletonFromJson(
    Map<String, dynamic> json) {
  return _TrainingBlockSkeleton.fromJson(json);
}

/// @nodoc
mixin _$TrainingBlockSkeleton {
  String get id => throw _privateConstructorUsedError;
  String get phaseId => throw _privateConstructorUsedError;
  int get blockNumber => throw _privateConstructorUsedError;
  String get intent => throw _privateConstructorUsedError;
  int get durationDays => throw _privateConstructorUsedError;

  /// Serializes this TrainingBlockSkeleton to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrainingBlockSkeleton
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrainingBlockSkeletonCopyWith<TrainingBlockSkeleton> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingBlockSkeletonCopyWith<$Res> {
  factory $TrainingBlockSkeletonCopyWith(TrainingBlockSkeleton value,
          $Res Function(TrainingBlockSkeleton) then) =
      _$TrainingBlockSkeletonCopyWithImpl<$Res, TrainingBlockSkeleton>;
  @useResult
  $Res call(
      {String id,
      String phaseId,
      int blockNumber,
      String intent,
      int durationDays});
}

/// @nodoc
class _$TrainingBlockSkeletonCopyWithImpl<$Res,
        $Val extends TrainingBlockSkeleton>
    implements $TrainingBlockSkeletonCopyWith<$Res> {
  _$TrainingBlockSkeletonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrainingBlockSkeleton
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phaseId = null,
    Object? blockNumber = null,
    Object? intent = null,
    Object? durationDays = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      phaseId: null == phaseId
          ? _value.phaseId
          : phaseId // ignore: cast_nullable_to_non_nullable
              as String,
      blockNumber: null == blockNumber
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int,
      intent: null == intent
          ? _value.intent
          : intent // ignore: cast_nullable_to_non_nullable
              as String,
      durationDays: null == durationDays
          ? _value.durationDays
          : durationDays // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrainingBlockSkeletonImplCopyWith<$Res>
    implements $TrainingBlockSkeletonCopyWith<$Res> {
  factory _$$TrainingBlockSkeletonImplCopyWith(
          _$TrainingBlockSkeletonImpl value,
          $Res Function(_$TrainingBlockSkeletonImpl) then) =
      __$$TrainingBlockSkeletonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String phaseId,
      int blockNumber,
      String intent,
      int durationDays});
}

/// @nodoc
class __$$TrainingBlockSkeletonImplCopyWithImpl<$Res>
    extends _$TrainingBlockSkeletonCopyWithImpl<$Res,
        _$TrainingBlockSkeletonImpl>
    implements _$$TrainingBlockSkeletonImplCopyWith<$Res> {
  __$$TrainingBlockSkeletonImplCopyWithImpl(_$TrainingBlockSkeletonImpl _value,
      $Res Function(_$TrainingBlockSkeletonImpl) _then)
      : super(_value, _then);

  /// Create a copy of TrainingBlockSkeleton
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phaseId = null,
    Object? blockNumber = null,
    Object? intent = null,
    Object? durationDays = null,
  }) {
    return _then(_$TrainingBlockSkeletonImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      phaseId: null == phaseId
          ? _value.phaseId
          : phaseId // ignore: cast_nullable_to_non_nullable
              as String,
      blockNumber: null == blockNumber
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as int,
      intent: null == intent
          ? _value.intent
          : intent // ignore: cast_nullable_to_non_nullable
              as String,
      durationDays: null == durationDays
          ? _value.durationDays
          : durationDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrainingBlockSkeletonImpl implements _TrainingBlockSkeleton {
  const _$TrainingBlockSkeletonImpl(
      {required this.id,
      required this.phaseId,
      required this.blockNumber,
      required this.intent,
      required this.durationDays});

  factory _$TrainingBlockSkeletonImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrainingBlockSkeletonImplFromJson(json);

  @override
  final String id;
  @override
  final String phaseId;
  @override
  final int blockNumber;
  @override
  final String intent;
  @override
  final int durationDays;

  @override
  String toString() {
    return 'TrainingBlockSkeleton(id: $id, phaseId: $phaseId, blockNumber: $blockNumber, intent: $intent, durationDays: $durationDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingBlockSkeletonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phaseId, phaseId) || other.phaseId == phaseId) &&
            (identical(other.blockNumber, blockNumber) ||
                other.blockNumber == blockNumber) &&
            (identical(other.intent, intent) || other.intent == intent) &&
            (identical(other.durationDays, durationDays) ||
                other.durationDays == durationDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, phaseId, blockNumber, intent, durationDays);

  /// Create a copy of TrainingBlockSkeleton
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingBlockSkeletonImplCopyWith<_$TrainingBlockSkeletonImpl>
      get copyWith => __$$TrainingBlockSkeletonImplCopyWithImpl<
          _$TrainingBlockSkeletonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrainingBlockSkeletonImplToJson(
      this,
    );
  }
}

abstract class _TrainingBlockSkeleton implements TrainingBlockSkeleton {
  const factory _TrainingBlockSkeleton(
      {required final String id,
      required final String phaseId,
      required final int blockNumber,
      required final String intent,
      required final int durationDays}) = _$TrainingBlockSkeletonImpl;

  factory _TrainingBlockSkeleton.fromJson(Map<String, dynamic> json) =
      _$TrainingBlockSkeletonImpl.fromJson;

  @override
  String get id;
  @override
  String get phaseId;
  @override
  int get blockNumber;
  @override
  String get intent;
  @override
  int get durationDays;

  /// Create a copy of TrainingBlockSkeleton
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrainingBlockSkeletonImplCopyWith<_$TrainingBlockSkeletonImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WorkoutSkeleton _$WorkoutSkeletonFromJson(Map<String, dynamic> json) {
  return _WorkoutSkeleton.fromJson(json);
}

/// @nodoc
mixin _$WorkoutSkeleton {
  String get id => throw _privateConstructorUsedError;
  String get phaseId => throw _privateConstructorUsedError;
  String get blockId => throw _privateConstructorUsedError;
  int get dayNumber =>
      throw _privateConstructorUsedError; // Relative day number in the plan or block? Usually block day or global day. Let's assume Global from plan start or Block relative.
// The plan says "identifies specific days by dayNumber relative to the phase or block."
// Let's use Block relative day (1-7 usually) for simplicity in prompt, or global if easier.
// Actually, "dayNumber" relative to the block (1..durationDays) is safest.
  String get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get plannedDuration => throw _privateConstructorUsedError;
  double? get plannedDistance => throw _privateConstructorUsedError;
  String get intensity => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this WorkoutSkeleton to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutSkeleton
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutSkeletonCopyWith<WorkoutSkeleton> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutSkeletonCopyWith<$Res> {
  factory $WorkoutSkeletonCopyWith(
          WorkoutSkeleton value, $Res Function(WorkoutSkeleton) then) =
      _$WorkoutSkeletonCopyWithImpl<$Res, WorkoutSkeleton>;
  @useResult
  $Res call(
      {String id,
      String phaseId,
      String blockId,
      int dayNumber,
      String type,
      String name,
      int plannedDuration,
      double? plannedDistance,
      String intensity,
      String description});
}

/// @nodoc
class _$WorkoutSkeletonCopyWithImpl<$Res, $Val extends WorkoutSkeleton>
    implements $WorkoutSkeletonCopyWith<$Res> {
  _$WorkoutSkeletonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutSkeleton
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phaseId = null,
    Object? blockId = null,
    Object? dayNumber = null,
    Object? type = null,
    Object? name = null,
    Object? plannedDuration = null,
    Object? plannedDistance = freezed,
    Object? intensity = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      phaseId: null == phaseId
          ? _value.phaseId
          : phaseId // ignore: cast_nullable_to_non_nullable
              as String,
      blockId: null == blockId
          ? _value.blockId
          : blockId // ignore: cast_nullable_to_non_nullable
              as String,
      dayNumber: null == dayNumber
          ? _value.dayNumber
          : dayNumber // ignore: cast_nullable_to_non_nullable
              as int,
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
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkoutSkeletonImplCopyWith<$Res>
    implements $WorkoutSkeletonCopyWith<$Res> {
  factory _$$WorkoutSkeletonImplCopyWith(_$WorkoutSkeletonImpl value,
          $Res Function(_$WorkoutSkeletonImpl) then) =
      __$$WorkoutSkeletonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String phaseId,
      String blockId,
      int dayNumber,
      String type,
      String name,
      int plannedDuration,
      double? plannedDistance,
      String intensity,
      String description});
}

/// @nodoc
class __$$WorkoutSkeletonImplCopyWithImpl<$Res>
    extends _$WorkoutSkeletonCopyWithImpl<$Res, _$WorkoutSkeletonImpl>
    implements _$$WorkoutSkeletonImplCopyWith<$Res> {
  __$$WorkoutSkeletonImplCopyWithImpl(
      _$WorkoutSkeletonImpl _value, $Res Function(_$WorkoutSkeletonImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkoutSkeleton
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? phaseId = null,
    Object? blockId = null,
    Object? dayNumber = null,
    Object? type = null,
    Object? name = null,
    Object? plannedDuration = null,
    Object? plannedDistance = freezed,
    Object? intensity = null,
    Object? description = null,
  }) {
    return _then(_$WorkoutSkeletonImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      phaseId: null == phaseId
          ? _value.phaseId
          : phaseId // ignore: cast_nullable_to_non_nullable
              as String,
      blockId: null == blockId
          ? _value.blockId
          : blockId // ignore: cast_nullable_to_non_nullable
              as String,
      dayNumber: null == dayNumber
          ? _value.dayNumber
          : dayNumber // ignore: cast_nullable_to_non_nullable
              as int,
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
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutSkeletonImpl implements _WorkoutSkeleton {
  const _$WorkoutSkeletonImpl(
      {required this.id,
      required this.phaseId,
      required this.blockId,
      required this.dayNumber,
      required this.type,
      required this.name,
      required this.plannedDuration,
      this.plannedDistance,
      required this.intensity,
      required this.description});

  factory _$WorkoutSkeletonImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutSkeletonImplFromJson(json);

  @override
  final String id;
  @override
  final String phaseId;
  @override
  final String blockId;
  @override
  final int dayNumber;
// Relative day number in the plan or block? Usually block day or global day. Let's assume Global from plan start or Block relative.
// The plan says "identifies specific days by dayNumber relative to the phase or block."
// Let's use Block relative day (1-7 usually) for simplicity in prompt, or global if easier.
// Actually, "dayNumber" relative to the block (1..durationDays) is safest.
  @override
  final String type;
  @override
  final String name;
  @override
  final int plannedDuration;
  @override
  final double? plannedDistance;
  @override
  final String intensity;
  @override
  final String description;

  @override
  String toString() {
    return 'WorkoutSkeleton(id: $id, phaseId: $phaseId, blockId: $blockId, dayNumber: $dayNumber, type: $type, name: $name, plannedDuration: $plannedDuration, plannedDistance: $plannedDistance, intensity: $intensity, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutSkeletonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phaseId, phaseId) || other.phaseId == phaseId) &&
            (identical(other.blockId, blockId) || other.blockId == blockId) &&
            (identical(other.dayNumber, dayNumber) ||
                other.dayNumber == dayNumber) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.plannedDuration, plannedDuration) ||
                other.plannedDuration == plannedDuration) &&
            (identical(other.plannedDistance, plannedDistance) ||
                other.plannedDistance == plannedDistance) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, phaseId, blockId, dayNumber,
      type, name, plannedDuration, plannedDistance, intensity, description);

  /// Create a copy of WorkoutSkeleton
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutSkeletonImplCopyWith<_$WorkoutSkeletonImpl> get copyWith =>
      __$$WorkoutSkeletonImplCopyWithImpl<_$WorkoutSkeletonImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutSkeletonImplToJson(
      this,
    );
  }
}

abstract class _WorkoutSkeleton implements WorkoutSkeleton {
  const factory _WorkoutSkeleton(
      {required final String id,
      required final String phaseId,
      required final String blockId,
      required final int dayNumber,
      required final String type,
      required final String name,
      required final int plannedDuration,
      final double? plannedDistance,
      required final String intensity,
      required final String description}) = _$WorkoutSkeletonImpl;

  factory _WorkoutSkeleton.fromJson(Map<String, dynamic> json) =
      _$WorkoutSkeletonImpl.fromJson;

  @override
  String get id;
  @override
  String get phaseId;
  @override
  String get blockId;
  @override
  int get dayNumber; // Relative day number in the plan or block? Usually block day or global day. Let's assume Global from plan start or Block relative.
// The plan says "identifies specific days by dayNumber relative to the phase or block."
// Let's use Block relative day (1-7 usually) for simplicity in prompt, or global if easier.
// Actually, "dayNumber" relative to the block (1..durationDays) is safest.
  @override
  String get type;
  @override
  String get name;
  @override
  int get plannedDuration;
  @override
  double? get plannedDistance;
  @override
  String get intensity;
  @override
  String get description;

  /// Create a copy of WorkoutSkeleton
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutSkeletonImplCopyWith<_$WorkoutSkeletonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlanRationale _$PlanRationaleFromJson(Map<String, dynamic> json) {
  return _PlanRationale.fromJson(json);
}

/// @nodoc
mixin _$PlanRationale {
  String get overallApproach => throw _privateConstructorUsedError;
  String get intensityDistribution => throw _privateConstructorUsedError;
  String get keyWorkouts => throw _privateConstructorUsedError;
  String get recoveryStrategy => throw _privateConstructorUsedError;

  /// Serializes this PlanRationale to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlanRationale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlanRationaleCopyWith<PlanRationale> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanRationaleCopyWith<$Res> {
  factory $PlanRationaleCopyWith(
          PlanRationale value, $Res Function(PlanRationale) then) =
      _$PlanRationaleCopyWithImpl<$Res, PlanRationale>;
  @useResult
  $Res call(
      {String overallApproach,
      String intensityDistribution,
      String keyWorkouts,
      String recoveryStrategy});
}

/// @nodoc
class _$PlanRationaleCopyWithImpl<$Res, $Val extends PlanRationale>
    implements $PlanRationaleCopyWith<$Res> {
  _$PlanRationaleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlanRationale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallApproach = null,
    Object? intensityDistribution = null,
    Object? keyWorkouts = null,
    Object? recoveryStrategy = null,
  }) {
    return _then(_value.copyWith(
      overallApproach: null == overallApproach
          ? _value.overallApproach
          : overallApproach // ignore: cast_nullable_to_non_nullable
              as String,
      intensityDistribution: null == intensityDistribution
          ? _value.intensityDistribution
          : intensityDistribution // ignore: cast_nullable_to_non_nullable
              as String,
      keyWorkouts: null == keyWorkouts
          ? _value.keyWorkouts
          : keyWorkouts // ignore: cast_nullable_to_non_nullable
              as String,
      recoveryStrategy: null == recoveryStrategy
          ? _value.recoveryStrategy
          : recoveryStrategy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlanRationaleImplCopyWith<$Res>
    implements $PlanRationaleCopyWith<$Res> {
  factory _$$PlanRationaleImplCopyWith(
          _$PlanRationaleImpl value, $Res Function(_$PlanRationaleImpl) then) =
      __$$PlanRationaleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String overallApproach,
      String intensityDistribution,
      String keyWorkouts,
      String recoveryStrategy});
}

/// @nodoc
class __$$PlanRationaleImplCopyWithImpl<$Res>
    extends _$PlanRationaleCopyWithImpl<$Res, _$PlanRationaleImpl>
    implements _$$PlanRationaleImplCopyWith<$Res> {
  __$$PlanRationaleImplCopyWithImpl(
      _$PlanRationaleImpl _value, $Res Function(_$PlanRationaleImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlanRationale
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? overallApproach = null,
    Object? intensityDistribution = null,
    Object? keyWorkouts = null,
    Object? recoveryStrategy = null,
  }) {
    return _then(_$PlanRationaleImpl(
      overallApproach: null == overallApproach
          ? _value.overallApproach
          : overallApproach // ignore: cast_nullable_to_non_nullable
              as String,
      intensityDistribution: null == intensityDistribution
          ? _value.intensityDistribution
          : intensityDistribution // ignore: cast_nullable_to_non_nullable
              as String,
      keyWorkouts: null == keyWorkouts
          ? _value.keyWorkouts
          : keyWorkouts // ignore: cast_nullable_to_non_nullable
              as String,
      recoveryStrategy: null == recoveryStrategy
          ? _value.recoveryStrategy
          : recoveryStrategy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlanRationaleImpl implements _PlanRationale {
  const _$PlanRationaleImpl(
      {required this.overallApproach,
      required this.intensityDistribution,
      required this.keyWorkouts,
      required this.recoveryStrategy});

  factory _$PlanRationaleImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlanRationaleImplFromJson(json);

  @override
  final String overallApproach;
  @override
  final String intensityDistribution;
  @override
  final String keyWorkouts;
  @override
  final String recoveryStrategy;

  @override
  String toString() {
    return 'PlanRationale(overallApproach: $overallApproach, intensityDistribution: $intensityDistribution, keyWorkouts: $keyWorkouts, recoveryStrategy: $recoveryStrategy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanRationaleImpl &&
            (identical(other.overallApproach, overallApproach) ||
                other.overallApproach == overallApproach) &&
            (identical(other.intensityDistribution, intensityDistribution) ||
                other.intensityDistribution == intensityDistribution) &&
            (identical(other.keyWorkouts, keyWorkouts) ||
                other.keyWorkouts == keyWorkouts) &&
            (identical(other.recoveryStrategy, recoveryStrategy) ||
                other.recoveryStrategy == recoveryStrategy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, overallApproach,
      intensityDistribution, keyWorkouts, recoveryStrategy);

  /// Create a copy of PlanRationale
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanRationaleImplCopyWith<_$PlanRationaleImpl> get copyWith =>
      __$$PlanRationaleImplCopyWithImpl<_$PlanRationaleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlanRationaleImplToJson(
      this,
    );
  }
}

abstract class _PlanRationale implements PlanRationale {
  const factory _PlanRationale(
      {required final String overallApproach,
      required final String intensityDistribution,
      required final String keyWorkouts,
      required final String recoveryStrategy}) = _$PlanRationaleImpl;

  factory _PlanRationale.fromJson(Map<String, dynamic> json) =
      _$PlanRationaleImpl.fromJson;

  @override
  String get overallApproach;
  @override
  String get intensityDistribution;
  @override
  String get keyWorkouts;
  @override
  String get recoveryStrategy;

  /// Create a copy of PlanRationale
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlanRationaleImplCopyWith<_$PlanRationaleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
