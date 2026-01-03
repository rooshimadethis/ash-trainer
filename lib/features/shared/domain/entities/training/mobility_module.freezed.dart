// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mobility_module.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MobilityModule _$MobilityModuleFromJson(Map<String, dynamic> json) {
  return _MobilityModule.fromJson(json);
}

/// @nodoc
mixin _$MobilityModule {
  String get id => throw _privateConstructorUsedError;
  String get workoutId => throw _privateConstructorUsedError;
  String get exerciseName => throw _privateConstructorUsedError;
  String get targetJoint => throw _privateConstructorUsedError;
  String get setupInstructions => throw _privateConstructorUsedError;
  int get totalCycles => throw _privateConstructorUsedError;
  List<MobilityPhase> get phases => throw _privateConstructorUsedError;

  /// Serializes this MobilityModule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MobilityModule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MobilityModuleCopyWith<MobilityModule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MobilityModuleCopyWith<$Res> {
  factory $MobilityModuleCopyWith(
          MobilityModule value, $Res Function(MobilityModule) then) =
      _$MobilityModuleCopyWithImpl<$Res, MobilityModule>;
  @useResult
  $Res call(
      {String id,
      String workoutId,
      String exerciseName,
      String targetJoint,
      String setupInstructions,
      int totalCycles,
      List<MobilityPhase> phases});
}

/// @nodoc
class _$MobilityModuleCopyWithImpl<$Res, $Val extends MobilityModule>
    implements $MobilityModuleCopyWith<$Res> {
  _$MobilityModuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MobilityModule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workoutId = null,
    Object? exerciseName = null,
    Object? targetJoint = null,
    Object? setupInstructions = null,
    Object? totalCycles = null,
    Object? phases = null,
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
      exerciseName: null == exerciseName
          ? _value.exerciseName
          : exerciseName // ignore: cast_nullable_to_non_nullable
              as String,
      targetJoint: null == targetJoint
          ? _value.targetJoint
          : targetJoint // ignore: cast_nullable_to_non_nullable
              as String,
      setupInstructions: null == setupInstructions
          ? _value.setupInstructions
          : setupInstructions // ignore: cast_nullable_to_non_nullable
              as String,
      totalCycles: null == totalCycles
          ? _value.totalCycles
          : totalCycles // ignore: cast_nullable_to_non_nullable
              as int,
      phases: null == phases
          ? _value.phases
          : phases // ignore: cast_nullable_to_non_nullable
              as List<MobilityPhase>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MobilityModuleImplCopyWith<$Res>
    implements $MobilityModuleCopyWith<$Res> {
  factory _$$MobilityModuleImplCopyWith(_$MobilityModuleImpl value,
          $Res Function(_$MobilityModuleImpl) then) =
      __$$MobilityModuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String workoutId,
      String exerciseName,
      String targetJoint,
      String setupInstructions,
      int totalCycles,
      List<MobilityPhase> phases});
}

/// @nodoc
class __$$MobilityModuleImplCopyWithImpl<$Res>
    extends _$MobilityModuleCopyWithImpl<$Res, _$MobilityModuleImpl>
    implements _$$MobilityModuleImplCopyWith<$Res> {
  __$$MobilityModuleImplCopyWithImpl(
      _$MobilityModuleImpl _value, $Res Function(_$MobilityModuleImpl) _then)
      : super(_value, _then);

  /// Create a copy of MobilityModule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workoutId = null,
    Object? exerciseName = null,
    Object? targetJoint = null,
    Object? setupInstructions = null,
    Object? totalCycles = null,
    Object? phases = null,
  }) {
    return _then(_$MobilityModuleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      workoutId: null == workoutId
          ? _value.workoutId
          : workoutId // ignore: cast_nullable_to_non_nullable
              as String,
      exerciseName: null == exerciseName
          ? _value.exerciseName
          : exerciseName // ignore: cast_nullable_to_non_nullable
              as String,
      targetJoint: null == targetJoint
          ? _value.targetJoint
          : targetJoint // ignore: cast_nullable_to_non_nullable
              as String,
      setupInstructions: null == setupInstructions
          ? _value.setupInstructions
          : setupInstructions // ignore: cast_nullable_to_non_nullable
              as String,
      totalCycles: null == totalCycles
          ? _value.totalCycles
          : totalCycles // ignore: cast_nullable_to_non_nullable
              as int,
      phases: null == phases
          ? _value._phases
          : phases // ignore: cast_nullable_to_non_nullable
              as List<MobilityPhase>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MobilityModuleImpl implements _MobilityModule {
  const _$MobilityModuleImpl(
      {required this.id,
      required this.workoutId,
      required this.exerciseName,
      required this.targetJoint,
      required this.setupInstructions,
      required this.totalCycles,
      required final List<MobilityPhase> phases})
      : _phases = phases;

  factory _$MobilityModuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$MobilityModuleImplFromJson(json);

  @override
  final String id;
  @override
  final String workoutId;
  @override
  final String exerciseName;
  @override
  final String targetJoint;
  @override
  final String setupInstructions;
  @override
  final int totalCycles;
  final List<MobilityPhase> _phases;
  @override
  List<MobilityPhase> get phases {
    if (_phases is EqualUnmodifiableListView) return _phases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_phases);
  }

  @override
  String toString() {
    return 'MobilityModule(id: $id, workoutId: $workoutId, exerciseName: $exerciseName, targetJoint: $targetJoint, setupInstructions: $setupInstructions, totalCycles: $totalCycles, phases: $phases)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MobilityModuleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workoutId, workoutId) ||
                other.workoutId == workoutId) &&
            (identical(other.exerciseName, exerciseName) ||
                other.exerciseName == exerciseName) &&
            (identical(other.targetJoint, targetJoint) ||
                other.targetJoint == targetJoint) &&
            (identical(other.setupInstructions, setupInstructions) ||
                other.setupInstructions == setupInstructions) &&
            (identical(other.totalCycles, totalCycles) ||
                other.totalCycles == totalCycles) &&
            const DeepCollectionEquality().equals(other._phases, _phases));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      workoutId,
      exerciseName,
      targetJoint,
      setupInstructions,
      totalCycles,
      const DeepCollectionEquality().hash(_phases));

  /// Create a copy of MobilityModule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MobilityModuleImplCopyWith<_$MobilityModuleImpl> get copyWith =>
      __$$MobilityModuleImplCopyWithImpl<_$MobilityModuleImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MobilityModuleImplToJson(
      this,
    );
  }
}

abstract class _MobilityModule implements MobilityModule {
  const factory _MobilityModule(
      {required final String id,
      required final String workoutId,
      required final String exerciseName,
      required final String targetJoint,
      required final String setupInstructions,
      required final int totalCycles,
      required final List<MobilityPhase> phases}) = _$MobilityModuleImpl;

  factory _MobilityModule.fromJson(Map<String, dynamic> json) =
      _$MobilityModuleImpl.fromJson;

  @override
  String get id;
  @override
  String get workoutId;
  @override
  String get exerciseName;
  @override
  String get targetJoint;
  @override
  String get setupInstructions;
  @override
  int get totalCycles;
  @override
  List<MobilityPhase> get phases;

  /// Create a copy of MobilityModule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MobilityModuleImplCopyWith<_$MobilityModuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MobilityPhase _$MobilityPhaseFromJson(Map<String, dynamic> json) {
  return _MobilityPhase.fromJson(json);
}

/// @nodoc
mixin _$MobilityPhase {
  String get id => throw _privateConstructorUsedError;
  String get moduleId => throw _privateConstructorUsedError;
  String get phaseType => throw _privateConstructorUsedError;
  int? get durationSeconds => throw _privateConstructorUsedError;
  int? get reps => throw _privateConstructorUsedError;
  int? get holdTimeSeconds => throw _privateConstructorUsedError;
  String? get instruction => throw _privateConstructorUsedError;
  String? get intensityNotes => throw _privateConstructorUsedError;
  int? get irradiationPct => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  int get sequenceOrder => throw _privateConstructorUsedError;

  /// Serializes this MobilityPhase to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MobilityPhase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MobilityPhaseCopyWith<MobilityPhase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MobilityPhaseCopyWith<$Res> {
  factory $MobilityPhaseCopyWith(
          MobilityPhase value, $Res Function(MobilityPhase) then) =
      _$MobilityPhaseCopyWithImpl<$Res, MobilityPhase>;
  @useResult
  $Res call(
      {String id,
      String moduleId,
      String phaseType,
      int? durationSeconds,
      int? reps,
      int? holdTimeSeconds,
      String? instruction,
      String? intensityNotes,
      int? irradiationPct,
      String? notes,
      int sequenceOrder});
}

/// @nodoc
class _$MobilityPhaseCopyWithImpl<$Res, $Val extends MobilityPhase>
    implements $MobilityPhaseCopyWith<$Res> {
  _$MobilityPhaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MobilityPhase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? moduleId = null,
    Object? phaseType = null,
    Object? durationSeconds = freezed,
    Object? reps = freezed,
    Object? holdTimeSeconds = freezed,
    Object? instruction = freezed,
    Object? intensityNotes = freezed,
    Object? irradiationPct = freezed,
    Object? notes = freezed,
    Object? sequenceOrder = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      moduleId: null == moduleId
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as String,
      phaseType: null == phaseType
          ? _value.phaseType
          : phaseType // ignore: cast_nullable_to_non_nullable
              as String,
      durationSeconds: freezed == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      reps: freezed == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as int?,
      holdTimeSeconds: freezed == holdTimeSeconds
          ? _value.holdTimeSeconds
          : holdTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      instruction: freezed == instruction
          ? _value.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as String?,
      intensityNotes: freezed == intensityNotes
          ? _value.intensityNotes
          : intensityNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      irradiationPct: freezed == irradiationPct
          ? _value.irradiationPct
          : irradiationPct // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      sequenceOrder: null == sequenceOrder
          ? _value.sequenceOrder
          : sequenceOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MobilityPhaseImplCopyWith<$Res>
    implements $MobilityPhaseCopyWith<$Res> {
  factory _$$MobilityPhaseImplCopyWith(
          _$MobilityPhaseImpl value, $Res Function(_$MobilityPhaseImpl) then) =
      __$$MobilityPhaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String moduleId,
      String phaseType,
      int? durationSeconds,
      int? reps,
      int? holdTimeSeconds,
      String? instruction,
      String? intensityNotes,
      int? irradiationPct,
      String? notes,
      int sequenceOrder});
}

/// @nodoc
class __$$MobilityPhaseImplCopyWithImpl<$Res>
    extends _$MobilityPhaseCopyWithImpl<$Res, _$MobilityPhaseImpl>
    implements _$$MobilityPhaseImplCopyWith<$Res> {
  __$$MobilityPhaseImplCopyWithImpl(
      _$MobilityPhaseImpl _value, $Res Function(_$MobilityPhaseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MobilityPhase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? moduleId = null,
    Object? phaseType = null,
    Object? durationSeconds = freezed,
    Object? reps = freezed,
    Object? holdTimeSeconds = freezed,
    Object? instruction = freezed,
    Object? intensityNotes = freezed,
    Object? irradiationPct = freezed,
    Object? notes = freezed,
    Object? sequenceOrder = null,
  }) {
    return _then(_$MobilityPhaseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      moduleId: null == moduleId
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as String,
      phaseType: null == phaseType
          ? _value.phaseType
          : phaseType // ignore: cast_nullable_to_non_nullable
              as String,
      durationSeconds: freezed == durationSeconds
          ? _value.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      reps: freezed == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as int?,
      holdTimeSeconds: freezed == holdTimeSeconds
          ? _value.holdTimeSeconds
          : holdTimeSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      instruction: freezed == instruction
          ? _value.instruction
          : instruction // ignore: cast_nullable_to_non_nullable
              as String?,
      intensityNotes: freezed == intensityNotes
          ? _value.intensityNotes
          : intensityNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      irradiationPct: freezed == irradiationPct
          ? _value.irradiationPct
          : irradiationPct // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      sequenceOrder: null == sequenceOrder
          ? _value.sequenceOrder
          : sequenceOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MobilityPhaseImpl implements _MobilityPhase {
  const _$MobilityPhaseImpl(
      {required this.id,
      required this.moduleId,
      required this.phaseType,
      this.durationSeconds,
      this.reps,
      this.holdTimeSeconds,
      this.instruction,
      this.intensityNotes,
      this.irradiationPct,
      this.notes,
      required this.sequenceOrder});

  factory _$MobilityPhaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MobilityPhaseImplFromJson(json);

  @override
  final String id;
  @override
  final String moduleId;
  @override
  final String phaseType;
  @override
  final int? durationSeconds;
  @override
  final int? reps;
  @override
  final int? holdTimeSeconds;
  @override
  final String? instruction;
  @override
  final String? intensityNotes;
  @override
  final int? irradiationPct;
  @override
  final String? notes;
  @override
  final int sequenceOrder;

  @override
  String toString() {
    return 'MobilityPhase(id: $id, moduleId: $moduleId, phaseType: $phaseType, durationSeconds: $durationSeconds, reps: $reps, holdTimeSeconds: $holdTimeSeconds, instruction: $instruction, intensityNotes: $intensityNotes, irradiationPct: $irradiationPct, notes: $notes, sequenceOrder: $sequenceOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MobilityPhaseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.moduleId, moduleId) ||
                other.moduleId == moduleId) &&
            (identical(other.phaseType, phaseType) ||
                other.phaseType == phaseType) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.holdTimeSeconds, holdTimeSeconds) ||
                other.holdTimeSeconds == holdTimeSeconds) &&
            (identical(other.instruction, instruction) ||
                other.instruction == instruction) &&
            (identical(other.intensityNotes, intensityNotes) ||
                other.intensityNotes == intensityNotes) &&
            (identical(other.irradiationPct, irradiationPct) ||
                other.irradiationPct == irradiationPct) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.sequenceOrder, sequenceOrder) ||
                other.sequenceOrder == sequenceOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      moduleId,
      phaseType,
      durationSeconds,
      reps,
      holdTimeSeconds,
      instruction,
      intensityNotes,
      irradiationPct,
      notes,
      sequenceOrder);

  /// Create a copy of MobilityPhase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MobilityPhaseImplCopyWith<_$MobilityPhaseImpl> get copyWith =>
      __$$MobilityPhaseImplCopyWithImpl<_$MobilityPhaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MobilityPhaseImplToJson(
      this,
    );
  }
}

abstract class _MobilityPhase implements MobilityPhase {
  const factory _MobilityPhase(
      {required final String id,
      required final String moduleId,
      required final String phaseType,
      final int? durationSeconds,
      final int? reps,
      final int? holdTimeSeconds,
      final String? instruction,
      final String? intensityNotes,
      final int? irradiationPct,
      final String? notes,
      required final int sequenceOrder}) = _$MobilityPhaseImpl;

  factory _MobilityPhase.fromJson(Map<String, dynamic> json) =
      _$MobilityPhaseImpl.fromJson;

  @override
  String get id;
  @override
  String get moduleId;
  @override
  String get phaseType;
  @override
  int? get durationSeconds;
  @override
  int? get reps;
  @override
  int? get holdTimeSeconds;
  @override
  String? get instruction;
  @override
  String? get intensityNotes;
  @override
  int? get irradiationPct;
  @override
  String? get notes;
  @override
  int get sequenceOrder;

  /// Create a copy of MobilityPhase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MobilityPhaseImplCopyWith<_$MobilityPhaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
