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
  List<Mesocycle> get mesocycles => throw _privateConstructorUsedError;
  List<Microcycle> get microcycles => throw _privateConstructorUsedError;
  List<Workout> get workouts => throw _privateConstructorUsedError;
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
      {List<Mesocycle> mesocycles,
      List<Microcycle> microcycles,
      List<Workout> workouts,
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
    Object? mesocycles = null,
    Object? microcycles = null,
    Object? workouts = null,
    Object? rationale = null,
  }) {
    return _then(_value.copyWith(
      mesocycles: null == mesocycles
          ? _value.mesocycles
          : mesocycles // ignore: cast_nullable_to_non_nullable
              as List<Mesocycle>,
      microcycles: null == microcycles
          ? _value.microcycles
          : microcycles // ignore: cast_nullable_to_non_nullable
              as List<Microcycle>,
      workouts: null == workouts
          ? _value.workouts
          : workouts // ignore: cast_nullable_to_non_nullable
              as List<Workout>,
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
      {List<Mesocycle> mesocycles,
      List<Microcycle> microcycles,
      List<Workout> workouts,
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
    Object? mesocycles = null,
    Object? microcycles = null,
    Object? workouts = null,
    Object? rationale = null,
  }) {
    return _then(_$TrainingPlanImpl(
      mesocycles: null == mesocycles
          ? _value._mesocycles
          : mesocycles // ignore: cast_nullable_to_non_nullable
              as List<Mesocycle>,
      microcycles: null == microcycles
          ? _value._microcycles
          : microcycles // ignore: cast_nullable_to_non_nullable
              as List<Microcycle>,
      workouts: null == workouts
          ? _value._workouts
          : workouts // ignore: cast_nullable_to_non_nullable
              as List<Workout>,
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
      {required final List<Mesocycle> mesocycles,
      required final List<Microcycle> microcycles,
      required final List<Workout> workouts,
      required this.rationale})
      : _mesocycles = mesocycles,
        _microcycles = microcycles,
        _workouts = workouts;

  factory _$TrainingPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrainingPlanImplFromJson(json);

  final List<Mesocycle> _mesocycles;
  @override
  List<Mesocycle> get mesocycles {
    if (_mesocycles is EqualUnmodifiableListView) return _mesocycles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mesocycles);
  }

  final List<Microcycle> _microcycles;
  @override
  List<Microcycle> get microcycles {
    if (_microcycles is EqualUnmodifiableListView) return _microcycles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_microcycles);
  }

  final List<Workout> _workouts;
  @override
  List<Workout> get workouts {
    if (_workouts is EqualUnmodifiableListView) return _workouts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_workouts);
  }

  @override
  final PlanRationale rationale;

  @override
  String toString() {
    return 'TrainingPlan(mesocycles: $mesocycles, microcycles: $microcycles, workouts: $workouts, rationale: $rationale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingPlanImpl &&
            const DeepCollectionEquality()
                .equals(other._mesocycles, _mesocycles) &&
            const DeepCollectionEquality()
                .equals(other._microcycles, _microcycles) &&
            const DeepCollectionEquality().equals(other._workouts, _workouts) &&
            (identical(other.rationale, rationale) ||
                other.rationale == rationale));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_mesocycles),
      const DeepCollectionEquality().hash(_microcycles),
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
      {required final List<Mesocycle> mesocycles,
      required final List<Microcycle> microcycles,
      required final List<Workout> workouts,
      required final PlanRationale rationale}) = _$TrainingPlanImpl;

  factory _TrainingPlan.fromJson(Map<String, dynamic> json) =
      _$TrainingPlanImpl.fromJson;

  @override
  List<Mesocycle> get mesocycles;
  @override
  List<Microcycle> get microcycles;
  @override
  List<Workout> get workouts;
  @override
  PlanRationale get rationale;

  /// Create a copy of TrainingPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrainingPlanImplCopyWith<_$TrainingPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Mesocycle _$MesocycleFromJson(Map<String, dynamic> json) {
  return _Mesocycle.fromJson(json);
}

/// @nodoc
mixin _$Mesocycle {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  String get emphasis => throw _privateConstructorUsedError;

  /// Serializes this Mesocycle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Mesocycle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MesocycleCopyWith<Mesocycle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MesocycleCopyWith<$Res> {
  factory $MesocycleCopyWith(Mesocycle value, $Res Function(Mesocycle) then) =
      _$MesocycleCopyWithImpl<$Res, Mesocycle>;
  @useResult
  $Res call(
      {String id,
      String name,
      DateTime startDate,
      DateTime endDate,
      String emphasis});
}

/// @nodoc
class _$MesocycleCopyWithImpl<$Res, $Val extends Mesocycle>
    implements $MesocycleCopyWith<$Res> {
  _$MesocycleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Mesocycle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? emphasis = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      emphasis: null == emphasis
          ? _value.emphasis
          : emphasis // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MesocycleImplCopyWith<$Res>
    implements $MesocycleCopyWith<$Res> {
  factory _$$MesocycleImplCopyWith(
          _$MesocycleImpl value, $Res Function(_$MesocycleImpl) then) =
      __$$MesocycleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      DateTime startDate,
      DateTime endDate,
      String emphasis});
}

/// @nodoc
class __$$MesocycleImplCopyWithImpl<$Res>
    extends _$MesocycleCopyWithImpl<$Res, _$MesocycleImpl>
    implements _$$MesocycleImplCopyWith<$Res> {
  __$$MesocycleImplCopyWithImpl(
      _$MesocycleImpl _value, $Res Function(_$MesocycleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Mesocycle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? emphasis = null,
  }) {
    return _then(_$MesocycleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      emphasis: null == emphasis
          ? _value.emphasis
          : emphasis // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MesocycleImpl implements _Mesocycle {
  const _$MesocycleImpl(
      {required this.id,
      required this.name,
      required this.startDate,
      required this.endDate,
      required this.emphasis});

  factory _$MesocycleImpl.fromJson(Map<String, dynamic> json) =>
      _$$MesocycleImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final String emphasis;

  @override
  String toString() {
    return 'Mesocycle(id: $id, name: $name, startDate: $startDate, endDate: $endDate, emphasis: $emphasis)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MesocycleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.emphasis, emphasis) ||
                other.emphasis == emphasis));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, startDate, endDate, emphasis);

  /// Create a copy of Mesocycle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MesocycleImplCopyWith<_$MesocycleImpl> get copyWith =>
      __$$MesocycleImplCopyWithImpl<_$MesocycleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MesocycleImplToJson(
      this,
    );
  }
}

abstract class _Mesocycle implements Mesocycle {
  const factory _Mesocycle(
      {required final String id,
      required final String name,
      required final DateTime startDate,
      required final DateTime endDate,
      required final String emphasis}) = _$MesocycleImpl;

  factory _Mesocycle.fromJson(Map<String, dynamic> json) =
      _$MesocycleImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  String get emphasis;

  /// Create a copy of Mesocycle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MesocycleImplCopyWith<_$MesocycleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Microcycle _$MicrocycleFromJson(Map<String, dynamic> json) {
  return _Microcycle.fromJson(json);
}

/// @nodoc
mixin _$Microcycle {
  String get id => throw _privateConstructorUsedError;
  int get weekNumber => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  String get emphasis => throw _privateConstructorUsedError;

  /// Serializes this Microcycle to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Microcycle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MicrocycleCopyWith<Microcycle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MicrocycleCopyWith<$Res> {
  factory $MicrocycleCopyWith(
          Microcycle value, $Res Function(Microcycle) then) =
      _$MicrocycleCopyWithImpl<$Res, Microcycle>;
  @useResult
  $Res call(
      {String id,
      int weekNumber,
      DateTime startDate,
      DateTime endDate,
      String emphasis});
}

/// @nodoc
class _$MicrocycleCopyWithImpl<$Res, $Val extends Microcycle>
    implements $MicrocycleCopyWith<$Res> {
  _$MicrocycleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Microcycle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weekNumber = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? emphasis = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      weekNumber: null == weekNumber
          ? _value.weekNumber
          : weekNumber // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      emphasis: null == emphasis
          ? _value.emphasis
          : emphasis // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MicrocycleImplCopyWith<$Res>
    implements $MicrocycleCopyWith<$Res> {
  factory _$$MicrocycleImplCopyWith(
          _$MicrocycleImpl value, $Res Function(_$MicrocycleImpl) then) =
      __$$MicrocycleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int weekNumber,
      DateTime startDate,
      DateTime endDate,
      String emphasis});
}

/// @nodoc
class __$$MicrocycleImplCopyWithImpl<$Res>
    extends _$MicrocycleCopyWithImpl<$Res, _$MicrocycleImpl>
    implements _$$MicrocycleImplCopyWith<$Res> {
  __$$MicrocycleImplCopyWithImpl(
      _$MicrocycleImpl _value, $Res Function(_$MicrocycleImpl) _then)
      : super(_value, _then);

  /// Create a copy of Microcycle
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weekNumber = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? emphasis = null,
  }) {
    return _then(_$MicrocycleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      weekNumber: null == weekNumber
          ? _value.weekNumber
          : weekNumber // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      emphasis: null == emphasis
          ? _value.emphasis
          : emphasis // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MicrocycleImpl implements _Microcycle {
  const _$MicrocycleImpl(
      {required this.id,
      required this.weekNumber,
      required this.startDate,
      required this.endDate,
      required this.emphasis});

  factory _$MicrocycleImpl.fromJson(Map<String, dynamic> json) =>
      _$$MicrocycleImplFromJson(json);

  @override
  final String id;
  @override
  final int weekNumber;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final String emphasis;

  @override
  String toString() {
    return 'Microcycle(id: $id, weekNumber: $weekNumber, startDate: $startDate, endDate: $endDate, emphasis: $emphasis)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MicrocycleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.weekNumber, weekNumber) ||
                other.weekNumber == weekNumber) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.emphasis, emphasis) ||
                other.emphasis == emphasis));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, weekNumber, startDate, endDate, emphasis);

  /// Create a copy of Microcycle
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MicrocycleImplCopyWith<_$MicrocycleImpl> get copyWith =>
      __$$MicrocycleImplCopyWithImpl<_$MicrocycleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MicrocycleImplToJson(
      this,
    );
  }
}

abstract class _Microcycle implements Microcycle {
  const factory _Microcycle(
      {required final String id,
      required final int weekNumber,
      required final DateTime startDate,
      required final DateTime endDate,
      required final String emphasis}) = _$MicrocycleImpl;

  factory _Microcycle.fromJson(Map<String, dynamic> json) =
      _$MicrocycleImpl.fromJson;

  @override
  String get id;
  @override
  int get weekNumber;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  String get emphasis;

  /// Create a copy of Microcycle
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MicrocycleImplCopyWith<_$MicrocycleImpl> get copyWith =>
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
