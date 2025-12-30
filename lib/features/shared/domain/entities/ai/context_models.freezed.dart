// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'context_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlanGenerationContext _$PlanGenerationContextFromJson(
    Map<String, dynamic> json) {
  return _PlanGenerationContext.fromJson(json);
}

/// @nodoc
mixin _$PlanGenerationContext {
  UserContext get user => throw _privateConstructorUsedError;
  GoalContext get goal => throw _privateConstructorUsedError;
  List<WorkoutSummary> get trainingHistory =>
      throw _privateConstructorUsedError;
  PlanGenerationPhilosophy get philosophy => throw _privateConstructorUsedError;

  /// Serializes this PlanGenerationContext to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlanGenerationContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlanGenerationContextCopyWith<PlanGenerationContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanGenerationContextCopyWith<$Res> {
  factory $PlanGenerationContextCopyWith(PlanGenerationContext value,
          $Res Function(PlanGenerationContext) then) =
      _$PlanGenerationContextCopyWithImpl<$Res, PlanGenerationContext>;
  @useResult
  $Res call(
      {UserContext user,
      GoalContext goal,
      List<WorkoutSummary> trainingHistory,
      PlanGenerationPhilosophy philosophy});

  $UserContextCopyWith<$Res> get user;
  $GoalContextCopyWith<$Res> get goal;
  $PlanGenerationPhilosophyCopyWith<$Res> get philosophy;
}

/// @nodoc
class _$PlanGenerationContextCopyWithImpl<$Res,
        $Val extends PlanGenerationContext>
    implements $PlanGenerationContextCopyWith<$Res> {
  _$PlanGenerationContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlanGenerationContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? goal = null,
    Object? trainingHistory = null,
    Object? philosophy = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserContext,
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as GoalContext,
      trainingHistory: null == trainingHistory
          ? _value.trainingHistory
          : trainingHistory // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSummary>,
      philosophy: null == philosophy
          ? _value.philosophy
          : philosophy // ignore: cast_nullable_to_non_nullable
              as PlanGenerationPhilosophy,
    ) as $Val);
  }

  /// Create a copy of PlanGenerationContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserContextCopyWith<$Res> get user {
    return $UserContextCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of PlanGenerationContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GoalContextCopyWith<$Res> get goal {
    return $GoalContextCopyWith<$Res>(_value.goal, (value) {
      return _then(_value.copyWith(goal: value) as $Val);
    });
  }

  /// Create a copy of PlanGenerationContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlanGenerationPhilosophyCopyWith<$Res> get philosophy {
    return $PlanGenerationPhilosophyCopyWith<$Res>(_value.philosophy, (value) {
      return _then(_value.copyWith(philosophy: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlanGenerationContextImplCopyWith<$Res>
    implements $PlanGenerationContextCopyWith<$Res> {
  factory _$$PlanGenerationContextImplCopyWith(
          _$PlanGenerationContextImpl value,
          $Res Function(_$PlanGenerationContextImpl) then) =
      __$$PlanGenerationContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserContext user,
      GoalContext goal,
      List<WorkoutSummary> trainingHistory,
      PlanGenerationPhilosophy philosophy});

  @override
  $UserContextCopyWith<$Res> get user;
  @override
  $GoalContextCopyWith<$Res> get goal;
  @override
  $PlanGenerationPhilosophyCopyWith<$Res> get philosophy;
}

/// @nodoc
class __$$PlanGenerationContextImplCopyWithImpl<$Res>
    extends _$PlanGenerationContextCopyWithImpl<$Res,
        _$PlanGenerationContextImpl>
    implements _$$PlanGenerationContextImplCopyWith<$Res> {
  __$$PlanGenerationContextImplCopyWithImpl(_$PlanGenerationContextImpl _value,
      $Res Function(_$PlanGenerationContextImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlanGenerationContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? goal = null,
    Object? trainingHistory = null,
    Object? philosophy = null,
  }) {
    return _then(_$PlanGenerationContextImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserContext,
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as GoalContext,
      trainingHistory: null == trainingHistory
          ? _value._trainingHistory
          : trainingHistory // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSummary>,
      philosophy: null == philosophy
          ? _value.philosophy
          : philosophy // ignore: cast_nullable_to_non_nullable
              as PlanGenerationPhilosophy,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlanGenerationContextImpl implements _PlanGenerationContext {
  const _$PlanGenerationContextImpl(
      {required this.user,
      required this.goal,
      required final List<WorkoutSummary> trainingHistory,
      required this.philosophy})
      : _trainingHistory = trainingHistory;

  factory _$PlanGenerationContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlanGenerationContextImplFromJson(json);

  @override
  final UserContext user;
  @override
  final GoalContext goal;
  final List<WorkoutSummary> _trainingHistory;
  @override
  List<WorkoutSummary> get trainingHistory {
    if (_trainingHistory is EqualUnmodifiableListView) return _trainingHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trainingHistory);
  }

  @override
  final PlanGenerationPhilosophy philosophy;

  @override
  String toString() {
    return 'PlanGenerationContext(user: $user, goal: $goal, trainingHistory: $trainingHistory, philosophy: $philosophy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanGenerationContextImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            const DeepCollectionEquality()
                .equals(other._trainingHistory, _trainingHistory) &&
            (identical(other.philosophy, philosophy) ||
                other.philosophy == philosophy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user, goal,
      const DeepCollectionEquality().hash(_trainingHistory), philosophy);

  /// Create a copy of PlanGenerationContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanGenerationContextImplCopyWith<_$PlanGenerationContextImpl>
      get copyWith => __$$PlanGenerationContextImplCopyWithImpl<
          _$PlanGenerationContextImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlanGenerationContextImplToJson(
      this,
    );
  }
}

abstract class _PlanGenerationContext implements PlanGenerationContext {
  const factory _PlanGenerationContext(
          {required final UserContext user,
          required final GoalContext goal,
          required final List<WorkoutSummary> trainingHistory,
          required final PlanGenerationPhilosophy philosophy}) =
      _$PlanGenerationContextImpl;

  factory _PlanGenerationContext.fromJson(Map<String, dynamic> json) =
      _$PlanGenerationContextImpl.fromJson;

  @override
  UserContext get user;
  @override
  GoalContext get goal;
  @override
  List<WorkoutSummary> get trainingHistory;
  @override
  PlanGenerationPhilosophy get philosophy;

  /// Create a copy of PlanGenerationContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlanGenerationContextImplCopyWith<_$PlanGenerationContextImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PlanGenerationPhilosophy _$PlanGenerationPhilosophyFromJson(
    Map<String, dynamic> json) {
  return _PlanGenerationPhilosophy.fromJson(json);
}

/// @nodoc
mixin _$PlanGenerationPhilosophy {
// RUNNING GUIDANCE
  IntensityStrategy get intensityStrategy => throw _privateConstructorUsedError;
  Map<String, double> get intensityBreakdown =>
      throw _privateConstructorUsedError;
  double get maxWeeklyVolumeIncrease =>
      throw _privateConstructorUsedError; // 0.10 = max 10% increase
  int get minWeeksBetweenRecovery =>
      throw _privateConstructorUsedError; // 3 = at least 3 weeks
  int get maxWeeksBetweenRecovery =>
      throw _privateConstructorUsedError; // 5 = at most 5 weeks
  double get recoveryVolumeReduction =>
      throw _privateConstructorUsedError; // 0.25 = 25% reduction
  List<String> get pillarConstraints => throw _privateConstructorUsedError;
  TaperGuidance? get taperGuidance => throw _privateConstructorUsedError;
  String get trainingFocus => throw _privateConstructorUsedError;
  String get workoutStyle => throw _privateConstructorUsedError;
  String get flexibilityLevel =>
      throw _privateConstructorUsedError; // STRENGTH GUIDANCE (Phase 1 - MVP)
  StrengthGuidance get strengthGuidance =>
      throw _privateConstructorUsedError; // MOBILITY GUIDANCE (Phase 1 - MVP)
  MobilityGuidance get mobilityGuidance => throw _privateConstructorUsedError;

  /// Serializes this PlanGenerationPhilosophy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlanGenerationPhilosophy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlanGenerationPhilosophyCopyWith<PlanGenerationPhilosophy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanGenerationPhilosophyCopyWith<$Res> {
  factory $PlanGenerationPhilosophyCopyWith(PlanGenerationPhilosophy value,
          $Res Function(PlanGenerationPhilosophy) then) =
      _$PlanGenerationPhilosophyCopyWithImpl<$Res, PlanGenerationPhilosophy>;
  @useResult
  $Res call(
      {IntensityStrategy intensityStrategy,
      Map<String, double> intensityBreakdown,
      double maxWeeklyVolumeIncrease,
      int minWeeksBetweenRecovery,
      int maxWeeksBetweenRecovery,
      double recoveryVolumeReduction,
      List<String> pillarConstraints,
      TaperGuidance? taperGuidance,
      String trainingFocus,
      String workoutStyle,
      String flexibilityLevel,
      StrengthGuidance strengthGuidance,
      MobilityGuidance mobilityGuidance});

  $TaperGuidanceCopyWith<$Res>? get taperGuidance;
  $StrengthGuidanceCopyWith<$Res> get strengthGuidance;
  $MobilityGuidanceCopyWith<$Res> get mobilityGuidance;
}

/// @nodoc
class _$PlanGenerationPhilosophyCopyWithImpl<$Res,
        $Val extends PlanGenerationPhilosophy>
    implements $PlanGenerationPhilosophyCopyWith<$Res> {
  _$PlanGenerationPhilosophyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlanGenerationPhilosophy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intensityStrategy = null,
    Object? intensityBreakdown = null,
    Object? maxWeeklyVolumeIncrease = null,
    Object? minWeeksBetweenRecovery = null,
    Object? maxWeeksBetweenRecovery = null,
    Object? recoveryVolumeReduction = null,
    Object? pillarConstraints = null,
    Object? taperGuidance = freezed,
    Object? trainingFocus = null,
    Object? workoutStyle = null,
    Object? flexibilityLevel = null,
    Object? strengthGuidance = null,
    Object? mobilityGuidance = null,
  }) {
    return _then(_value.copyWith(
      intensityStrategy: null == intensityStrategy
          ? _value.intensityStrategy
          : intensityStrategy // ignore: cast_nullable_to_non_nullable
              as IntensityStrategy,
      intensityBreakdown: null == intensityBreakdown
          ? _value.intensityBreakdown
          : intensityBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      maxWeeklyVolumeIncrease: null == maxWeeklyVolumeIncrease
          ? _value.maxWeeklyVolumeIncrease
          : maxWeeklyVolumeIncrease // ignore: cast_nullable_to_non_nullable
              as double,
      minWeeksBetweenRecovery: null == minWeeksBetweenRecovery
          ? _value.minWeeksBetweenRecovery
          : minWeeksBetweenRecovery // ignore: cast_nullable_to_non_nullable
              as int,
      maxWeeksBetweenRecovery: null == maxWeeksBetweenRecovery
          ? _value.maxWeeksBetweenRecovery
          : maxWeeksBetweenRecovery // ignore: cast_nullable_to_non_nullable
              as int,
      recoveryVolumeReduction: null == recoveryVolumeReduction
          ? _value.recoveryVolumeReduction
          : recoveryVolumeReduction // ignore: cast_nullable_to_non_nullable
              as double,
      pillarConstraints: null == pillarConstraints
          ? _value.pillarConstraints
          : pillarConstraints // ignore: cast_nullable_to_non_nullable
              as List<String>,
      taperGuidance: freezed == taperGuidance
          ? _value.taperGuidance
          : taperGuidance // ignore: cast_nullable_to_non_nullable
              as TaperGuidance?,
      trainingFocus: null == trainingFocus
          ? _value.trainingFocus
          : trainingFocus // ignore: cast_nullable_to_non_nullable
              as String,
      workoutStyle: null == workoutStyle
          ? _value.workoutStyle
          : workoutStyle // ignore: cast_nullable_to_non_nullable
              as String,
      flexibilityLevel: null == flexibilityLevel
          ? _value.flexibilityLevel
          : flexibilityLevel // ignore: cast_nullable_to_non_nullable
              as String,
      strengthGuidance: null == strengthGuidance
          ? _value.strengthGuidance
          : strengthGuidance // ignore: cast_nullable_to_non_nullable
              as StrengthGuidance,
      mobilityGuidance: null == mobilityGuidance
          ? _value.mobilityGuidance
          : mobilityGuidance // ignore: cast_nullable_to_non_nullable
              as MobilityGuidance,
    ) as $Val);
  }

  /// Create a copy of PlanGenerationPhilosophy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaperGuidanceCopyWith<$Res>? get taperGuidance {
    if (_value.taperGuidance == null) {
      return null;
    }

    return $TaperGuidanceCopyWith<$Res>(_value.taperGuidance!, (value) {
      return _then(_value.copyWith(taperGuidance: value) as $Val);
    });
  }

  /// Create a copy of PlanGenerationPhilosophy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StrengthGuidanceCopyWith<$Res> get strengthGuidance {
    return $StrengthGuidanceCopyWith<$Res>(_value.strengthGuidance, (value) {
      return _then(_value.copyWith(strengthGuidance: value) as $Val);
    });
  }

  /// Create a copy of PlanGenerationPhilosophy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MobilityGuidanceCopyWith<$Res> get mobilityGuidance {
    return $MobilityGuidanceCopyWith<$Res>(_value.mobilityGuidance, (value) {
      return _then(_value.copyWith(mobilityGuidance: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlanGenerationPhilosophyImplCopyWith<$Res>
    implements $PlanGenerationPhilosophyCopyWith<$Res> {
  factory _$$PlanGenerationPhilosophyImplCopyWith(
          _$PlanGenerationPhilosophyImpl value,
          $Res Function(_$PlanGenerationPhilosophyImpl) then) =
      __$$PlanGenerationPhilosophyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {IntensityStrategy intensityStrategy,
      Map<String, double> intensityBreakdown,
      double maxWeeklyVolumeIncrease,
      int minWeeksBetweenRecovery,
      int maxWeeksBetweenRecovery,
      double recoveryVolumeReduction,
      List<String> pillarConstraints,
      TaperGuidance? taperGuidance,
      String trainingFocus,
      String workoutStyle,
      String flexibilityLevel,
      StrengthGuidance strengthGuidance,
      MobilityGuidance mobilityGuidance});

  @override
  $TaperGuidanceCopyWith<$Res>? get taperGuidance;
  @override
  $StrengthGuidanceCopyWith<$Res> get strengthGuidance;
  @override
  $MobilityGuidanceCopyWith<$Res> get mobilityGuidance;
}

/// @nodoc
class __$$PlanGenerationPhilosophyImplCopyWithImpl<$Res>
    extends _$PlanGenerationPhilosophyCopyWithImpl<$Res,
        _$PlanGenerationPhilosophyImpl>
    implements _$$PlanGenerationPhilosophyImplCopyWith<$Res> {
  __$$PlanGenerationPhilosophyImplCopyWithImpl(
      _$PlanGenerationPhilosophyImpl _value,
      $Res Function(_$PlanGenerationPhilosophyImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlanGenerationPhilosophy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intensityStrategy = null,
    Object? intensityBreakdown = null,
    Object? maxWeeklyVolumeIncrease = null,
    Object? minWeeksBetweenRecovery = null,
    Object? maxWeeksBetweenRecovery = null,
    Object? recoveryVolumeReduction = null,
    Object? pillarConstraints = null,
    Object? taperGuidance = freezed,
    Object? trainingFocus = null,
    Object? workoutStyle = null,
    Object? flexibilityLevel = null,
    Object? strengthGuidance = null,
    Object? mobilityGuidance = null,
  }) {
    return _then(_$PlanGenerationPhilosophyImpl(
      intensityStrategy: null == intensityStrategy
          ? _value.intensityStrategy
          : intensityStrategy // ignore: cast_nullable_to_non_nullable
              as IntensityStrategy,
      intensityBreakdown: null == intensityBreakdown
          ? _value._intensityBreakdown
          : intensityBreakdown // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      maxWeeklyVolumeIncrease: null == maxWeeklyVolumeIncrease
          ? _value.maxWeeklyVolumeIncrease
          : maxWeeklyVolumeIncrease // ignore: cast_nullable_to_non_nullable
              as double,
      minWeeksBetweenRecovery: null == minWeeksBetweenRecovery
          ? _value.minWeeksBetweenRecovery
          : minWeeksBetweenRecovery // ignore: cast_nullable_to_non_nullable
              as int,
      maxWeeksBetweenRecovery: null == maxWeeksBetweenRecovery
          ? _value.maxWeeksBetweenRecovery
          : maxWeeksBetweenRecovery // ignore: cast_nullable_to_non_nullable
              as int,
      recoveryVolumeReduction: null == recoveryVolumeReduction
          ? _value.recoveryVolumeReduction
          : recoveryVolumeReduction // ignore: cast_nullable_to_non_nullable
              as double,
      pillarConstraints: null == pillarConstraints
          ? _value._pillarConstraints
          : pillarConstraints // ignore: cast_nullable_to_non_nullable
              as List<String>,
      taperGuidance: freezed == taperGuidance
          ? _value.taperGuidance
          : taperGuidance // ignore: cast_nullable_to_non_nullable
              as TaperGuidance?,
      trainingFocus: null == trainingFocus
          ? _value.trainingFocus
          : trainingFocus // ignore: cast_nullable_to_non_nullable
              as String,
      workoutStyle: null == workoutStyle
          ? _value.workoutStyle
          : workoutStyle // ignore: cast_nullable_to_non_nullable
              as String,
      flexibilityLevel: null == flexibilityLevel
          ? _value.flexibilityLevel
          : flexibilityLevel // ignore: cast_nullable_to_non_nullable
              as String,
      strengthGuidance: null == strengthGuidance
          ? _value.strengthGuidance
          : strengthGuidance // ignore: cast_nullable_to_non_nullable
              as StrengthGuidance,
      mobilityGuidance: null == mobilityGuidance
          ? _value.mobilityGuidance
          : mobilityGuidance // ignore: cast_nullable_to_non_nullable
              as MobilityGuidance,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlanGenerationPhilosophyImpl implements _PlanGenerationPhilosophy {
  const _$PlanGenerationPhilosophyImpl(
      {required this.intensityStrategy,
      required final Map<String, double> intensityBreakdown,
      required this.maxWeeklyVolumeIncrease,
      required this.minWeeksBetweenRecovery,
      required this.maxWeeksBetweenRecovery,
      required this.recoveryVolumeReduction,
      required final List<String> pillarConstraints,
      this.taperGuidance,
      required this.trainingFocus,
      required this.workoutStyle,
      required this.flexibilityLevel,
      required this.strengthGuidance,
      required this.mobilityGuidance})
      : _intensityBreakdown = intensityBreakdown,
        _pillarConstraints = pillarConstraints;

  factory _$PlanGenerationPhilosophyImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlanGenerationPhilosophyImplFromJson(json);

// RUNNING GUIDANCE
  @override
  final IntensityStrategy intensityStrategy;
  final Map<String, double> _intensityBreakdown;
  @override
  Map<String, double> get intensityBreakdown {
    if (_intensityBreakdown is EqualUnmodifiableMapView)
      return _intensityBreakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_intensityBreakdown);
  }

  @override
  final double maxWeeklyVolumeIncrease;
// 0.10 = max 10% increase
  @override
  final int minWeeksBetweenRecovery;
// 3 = at least 3 weeks
  @override
  final int maxWeeksBetweenRecovery;
// 5 = at most 5 weeks
  @override
  final double recoveryVolumeReduction;
// 0.25 = 25% reduction
  final List<String> _pillarConstraints;
// 0.25 = 25% reduction
  @override
  List<String> get pillarConstraints {
    if (_pillarConstraints is EqualUnmodifiableListView)
      return _pillarConstraints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pillarConstraints);
  }

  @override
  final TaperGuidance? taperGuidance;
  @override
  final String trainingFocus;
  @override
  final String workoutStyle;
  @override
  final String flexibilityLevel;
// STRENGTH GUIDANCE (Phase 1 - MVP)
  @override
  final StrengthGuidance strengthGuidance;
// MOBILITY GUIDANCE (Phase 1 - MVP)
  @override
  final MobilityGuidance mobilityGuidance;

  @override
  String toString() {
    return 'PlanGenerationPhilosophy(intensityStrategy: $intensityStrategy, intensityBreakdown: $intensityBreakdown, maxWeeklyVolumeIncrease: $maxWeeklyVolumeIncrease, minWeeksBetweenRecovery: $minWeeksBetweenRecovery, maxWeeksBetweenRecovery: $maxWeeksBetweenRecovery, recoveryVolumeReduction: $recoveryVolumeReduction, pillarConstraints: $pillarConstraints, taperGuidance: $taperGuidance, trainingFocus: $trainingFocus, workoutStyle: $workoutStyle, flexibilityLevel: $flexibilityLevel, strengthGuidance: $strengthGuidance, mobilityGuidance: $mobilityGuidance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanGenerationPhilosophyImpl &&
            (identical(other.intensityStrategy, intensityStrategy) ||
                other.intensityStrategy == intensityStrategy) &&
            const DeepCollectionEquality()
                .equals(other._intensityBreakdown, _intensityBreakdown) &&
            (identical(
                    other.maxWeeklyVolumeIncrease, maxWeeklyVolumeIncrease) ||
                other.maxWeeklyVolumeIncrease == maxWeeklyVolumeIncrease) &&
            (identical(
                    other.minWeeksBetweenRecovery, minWeeksBetweenRecovery) ||
                other.minWeeksBetweenRecovery == minWeeksBetweenRecovery) &&
            (identical(
                    other.maxWeeksBetweenRecovery, maxWeeksBetweenRecovery) ||
                other.maxWeeksBetweenRecovery == maxWeeksBetweenRecovery) &&
            (identical(
                    other.recoveryVolumeReduction, recoveryVolumeReduction) ||
                other.recoveryVolumeReduction == recoveryVolumeReduction) &&
            const DeepCollectionEquality()
                .equals(other._pillarConstraints, _pillarConstraints) &&
            (identical(other.taperGuidance, taperGuidance) ||
                other.taperGuidance == taperGuidance) &&
            (identical(other.trainingFocus, trainingFocus) ||
                other.trainingFocus == trainingFocus) &&
            (identical(other.workoutStyle, workoutStyle) ||
                other.workoutStyle == workoutStyle) &&
            (identical(other.flexibilityLevel, flexibilityLevel) ||
                other.flexibilityLevel == flexibilityLevel) &&
            (identical(other.strengthGuidance, strengthGuidance) ||
                other.strengthGuidance == strengthGuidance) &&
            (identical(other.mobilityGuidance, mobilityGuidance) ||
                other.mobilityGuidance == mobilityGuidance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      intensityStrategy,
      const DeepCollectionEquality().hash(_intensityBreakdown),
      maxWeeklyVolumeIncrease,
      minWeeksBetweenRecovery,
      maxWeeksBetweenRecovery,
      recoveryVolumeReduction,
      const DeepCollectionEquality().hash(_pillarConstraints),
      taperGuidance,
      trainingFocus,
      workoutStyle,
      flexibilityLevel,
      strengthGuidance,
      mobilityGuidance);

  /// Create a copy of PlanGenerationPhilosophy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanGenerationPhilosophyImplCopyWith<_$PlanGenerationPhilosophyImpl>
      get copyWith => __$$PlanGenerationPhilosophyImplCopyWithImpl<
          _$PlanGenerationPhilosophyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlanGenerationPhilosophyImplToJson(
      this,
    );
  }
}

abstract class _PlanGenerationPhilosophy implements PlanGenerationPhilosophy {
  const factory _PlanGenerationPhilosophy(
          {required final IntensityStrategy intensityStrategy,
          required final Map<String, double> intensityBreakdown,
          required final double maxWeeklyVolumeIncrease,
          required final int minWeeksBetweenRecovery,
          required final int maxWeeksBetweenRecovery,
          required final double recoveryVolumeReduction,
          required final List<String> pillarConstraints,
          final TaperGuidance? taperGuidance,
          required final String trainingFocus,
          required final String workoutStyle,
          required final String flexibilityLevel,
          required final StrengthGuidance strengthGuidance,
          required final MobilityGuidance mobilityGuidance}) =
      _$PlanGenerationPhilosophyImpl;

  factory _PlanGenerationPhilosophy.fromJson(Map<String, dynamic> json) =
      _$PlanGenerationPhilosophyImpl.fromJson;

// RUNNING GUIDANCE
  @override
  IntensityStrategy get intensityStrategy;
  @override
  Map<String, double> get intensityBreakdown;
  @override
  double get maxWeeklyVolumeIncrease; // 0.10 = max 10% increase
  @override
  int get minWeeksBetweenRecovery; // 3 = at least 3 weeks
  @override
  int get maxWeeksBetweenRecovery; // 5 = at most 5 weeks
  @override
  double get recoveryVolumeReduction; // 0.25 = 25% reduction
  @override
  List<String> get pillarConstraints;
  @override
  TaperGuidance? get taperGuidance;
  @override
  String get trainingFocus;
  @override
  String get workoutStyle;
  @override
  String get flexibilityLevel; // STRENGTH GUIDANCE (Phase 1 - MVP)
  @override
  StrengthGuidance get strengthGuidance; // MOBILITY GUIDANCE (Phase 1 - MVP)
  @override
  MobilityGuidance get mobilityGuidance;

  /// Create a copy of PlanGenerationPhilosophy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlanGenerationPhilosophyImplCopyWith<_$PlanGenerationPhilosophyImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TaperGuidance _$TaperGuidanceFromJson(Map<String, dynamic> json) {
  return _TaperGuidance.fromJson(json);
}

/// @nodoc
mixin _$TaperGuidance {
  String get strategy =>
      throw _privateConstructorUsedError; // "progressive_volume_reduction"
  int get minDurationDays => throw _privateConstructorUsedError;
  int get maxDurationDays => throw _privateConstructorUsedError;
  bool get maintainIntensity => throw _privateConstructorUsedError;

  /// Serializes this TaperGuidance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaperGuidance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaperGuidanceCopyWith<TaperGuidance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaperGuidanceCopyWith<$Res> {
  factory $TaperGuidanceCopyWith(
          TaperGuidance value, $Res Function(TaperGuidance) then) =
      _$TaperGuidanceCopyWithImpl<$Res, TaperGuidance>;
  @useResult
  $Res call(
      {String strategy,
      int minDurationDays,
      int maxDurationDays,
      bool maintainIntensity});
}

/// @nodoc
class _$TaperGuidanceCopyWithImpl<$Res, $Val extends TaperGuidance>
    implements $TaperGuidanceCopyWith<$Res> {
  _$TaperGuidanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaperGuidance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strategy = null,
    Object? minDurationDays = null,
    Object? maxDurationDays = null,
    Object? maintainIntensity = null,
  }) {
    return _then(_value.copyWith(
      strategy: null == strategy
          ? _value.strategy
          : strategy // ignore: cast_nullable_to_non_nullable
              as String,
      minDurationDays: null == minDurationDays
          ? _value.minDurationDays
          : minDurationDays // ignore: cast_nullable_to_non_nullable
              as int,
      maxDurationDays: null == maxDurationDays
          ? _value.maxDurationDays
          : maxDurationDays // ignore: cast_nullable_to_non_nullable
              as int,
      maintainIntensity: null == maintainIntensity
          ? _value.maintainIntensity
          : maintainIntensity // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaperGuidanceImplCopyWith<$Res>
    implements $TaperGuidanceCopyWith<$Res> {
  factory _$$TaperGuidanceImplCopyWith(
          _$TaperGuidanceImpl value, $Res Function(_$TaperGuidanceImpl) then) =
      __$$TaperGuidanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String strategy,
      int minDurationDays,
      int maxDurationDays,
      bool maintainIntensity});
}

/// @nodoc
class __$$TaperGuidanceImplCopyWithImpl<$Res>
    extends _$TaperGuidanceCopyWithImpl<$Res, _$TaperGuidanceImpl>
    implements _$$TaperGuidanceImplCopyWith<$Res> {
  __$$TaperGuidanceImplCopyWithImpl(
      _$TaperGuidanceImpl _value, $Res Function(_$TaperGuidanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaperGuidance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strategy = null,
    Object? minDurationDays = null,
    Object? maxDurationDays = null,
    Object? maintainIntensity = null,
  }) {
    return _then(_$TaperGuidanceImpl(
      strategy: null == strategy
          ? _value.strategy
          : strategy // ignore: cast_nullable_to_non_nullable
              as String,
      minDurationDays: null == minDurationDays
          ? _value.minDurationDays
          : minDurationDays // ignore: cast_nullable_to_non_nullable
              as int,
      maxDurationDays: null == maxDurationDays
          ? _value.maxDurationDays
          : maxDurationDays // ignore: cast_nullable_to_non_nullable
              as int,
      maintainIntensity: null == maintainIntensity
          ? _value.maintainIntensity
          : maintainIntensity // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaperGuidanceImpl implements _TaperGuidance {
  const _$TaperGuidanceImpl(
      {required this.strategy,
      required this.minDurationDays,
      required this.maxDurationDays,
      required this.maintainIntensity});

  factory _$TaperGuidanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaperGuidanceImplFromJson(json);

  @override
  final String strategy;
// "progressive_volume_reduction"
  @override
  final int minDurationDays;
  @override
  final int maxDurationDays;
  @override
  final bool maintainIntensity;

  @override
  String toString() {
    return 'TaperGuidance(strategy: $strategy, minDurationDays: $minDurationDays, maxDurationDays: $maxDurationDays, maintainIntensity: $maintainIntensity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaperGuidanceImpl &&
            (identical(other.strategy, strategy) ||
                other.strategy == strategy) &&
            (identical(other.minDurationDays, minDurationDays) ||
                other.minDurationDays == minDurationDays) &&
            (identical(other.maxDurationDays, maxDurationDays) ||
                other.maxDurationDays == maxDurationDays) &&
            (identical(other.maintainIntensity, maintainIntensity) ||
                other.maintainIntensity == maintainIntensity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, strategy, minDurationDays,
      maxDurationDays, maintainIntensity);

  /// Create a copy of TaperGuidance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaperGuidanceImplCopyWith<_$TaperGuidanceImpl> get copyWith =>
      __$$TaperGuidanceImplCopyWithImpl<_$TaperGuidanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaperGuidanceImplToJson(
      this,
    );
  }
}

abstract class _TaperGuidance implements TaperGuidance {
  const factory _TaperGuidance(
      {required final String strategy,
      required final int minDurationDays,
      required final int maxDurationDays,
      required final bool maintainIntensity}) = _$TaperGuidanceImpl;

  factory _TaperGuidance.fromJson(Map<String, dynamic> json) =
      _$TaperGuidanceImpl.fromJson;

  @override
  String get strategy; // "progressive_volume_reduction"
  @override
  int get minDurationDays;
  @override
  int get maxDurationDays;
  @override
  bool get maintainIntensity;

  /// Create a copy of TaperGuidance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaperGuidanceImplCopyWith<_$TaperGuidanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StrengthGuidance _$StrengthGuidanceFromJson(Map<String, dynamic> json) {
  return _StrengthGuidance.fromJson(json);
}

/// @nodoc
mixin _$StrengthGuidance {
  int get weeklyFrequency =>
      throw _privateConstructorUsedError; // 1-4 based on priority
  int get sessionDurationMinutes =>
      throw _privateConstructorUsedError; // 10-20 for Phase 1
  int get setsPerExercise =>
      throw _privateConstructorUsedError; // 2-3 based on priority
  String get repRange => throw _privateConstructorUsedError;

  /// Serializes this StrengthGuidance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StrengthGuidance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StrengthGuidanceCopyWith<StrengthGuidance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StrengthGuidanceCopyWith<$Res> {
  factory $StrengthGuidanceCopyWith(
          StrengthGuidance value, $Res Function(StrengthGuidance) then) =
      _$StrengthGuidanceCopyWithImpl<$Res, StrengthGuidance>;
  @useResult
  $Res call(
      {int weeklyFrequency,
      int sessionDurationMinutes,
      int setsPerExercise,
      String repRange});
}

/// @nodoc
class _$StrengthGuidanceCopyWithImpl<$Res, $Val extends StrengthGuidance>
    implements $StrengthGuidanceCopyWith<$Res> {
  _$StrengthGuidanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StrengthGuidance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weeklyFrequency = null,
    Object? sessionDurationMinutes = null,
    Object? setsPerExercise = null,
    Object? repRange = null,
  }) {
    return _then(_value.copyWith(
      weeklyFrequency: null == weeklyFrequency
          ? _value.weeklyFrequency
          : weeklyFrequency // ignore: cast_nullable_to_non_nullable
              as int,
      sessionDurationMinutes: null == sessionDurationMinutes
          ? _value.sessionDurationMinutes
          : sessionDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      setsPerExercise: null == setsPerExercise
          ? _value.setsPerExercise
          : setsPerExercise // ignore: cast_nullable_to_non_nullable
              as int,
      repRange: null == repRange
          ? _value.repRange
          : repRange // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StrengthGuidanceImplCopyWith<$Res>
    implements $StrengthGuidanceCopyWith<$Res> {
  factory _$$StrengthGuidanceImplCopyWith(_$StrengthGuidanceImpl value,
          $Res Function(_$StrengthGuidanceImpl) then) =
      __$$StrengthGuidanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int weeklyFrequency,
      int sessionDurationMinutes,
      int setsPerExercise,
      String repRange});
}

/// @nodoc
class __$$StrengthGuidanceImplCopyWithImpl<$Res>
    extends _$StrengthGuidanceCopyWithImpl<$Res, _$StrengthGuidanceImpl>
    implements _$$StrengthGuidanceImplCopyWith<$Res> {
  __$$StrengthGuidanceImplCopyWithImpl(_$StrengthGuidanceImpl _value,
      $Res Function(_$StrengthGuidanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of StrengthGuidance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weeklyFrequency = null,
    Object? sessionDurationMinutes = null,
    Object? setsPerExercise = null,
    Object? repRange = null,
  }) {
    return _then(_$StrengthGuidanceImpl(
      weeklyFrequency: null == weeklyFrequency
          ? _value.weeklyFrequency
          : weeklyFrequency // ignore: cast_nullable_to_non_nullable
              as int,
      sessionDurationMinutes: null == sessionDurationMinutes
          ? _value.sessionDurationMinutes
          : sessionDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      setsPerExercise: null == setsPerExercise
          ? _value.setsPerExercise
          : setsPerExercise // ignore: cast_nullable_to_non_nullable
              as int,
      repRange: null == repRange
          ? _value.repRange
          : repRange // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StrengthGuidanceImpl implements _StrengthGuidance {
  const _$StrengthGuidanceImpl(
      {required this.weeklyFrequency,
      required this.sessionDurationMinutes,
      required this.setsPerExercise,
      required this.repRange});

  factory _$StrengthGuidanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$StrengthGuidanceImplFromJson(json);

  @override
  final int weeklyFrequency;
// 1-4 based on priority
  @override
  final int sessionDurationMinutes;
// 10-20 for Phase 1
  @override
  final int setsPerExercise;
// 2-3 based on priority
  @override
  final String repRange;

  @override
  String toString() {
    return 'StrengthGuidance(weeklyFrequency: $weeklyFrequency, sessionDurationMinutes: $sessionDurationMinutes, setsPerExercise: $setsPerExercise, repRange: $repRange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StrengthGuidanceImpl &&
            (identical(other.weeklyFrequency, weeklyFrequency) ||
                other.weeklyFrequency == weeklyFrequency) &&
            (identical(other.sessionDurationMinutes, sessionDurationMinutes) ||
                other.sessionDurationMinutes == sessionDurationMinutes) &&
            (identical(other.setsPerExercise, setsPerExercise) ||
                other.setsPerExercise == setsPerExercise) &&
            (identical(other.repRange, repRange) ||
                other.repRange == repRange));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, weeklyFrequency,
      sessionDurationMinutes, setsPerExercise, repRange);

  /// Create a copy of StrengthGuidance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StrengthGuidanceImplCopyWith<_$StrengthGuidanceImpl> get copyWith =>
      __$$StrengthGuidanceImplCopyWithImpl<_$StrengthGuidanceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StrengthGuidanceImplToJson(
      this,
    );
  }
}

abstract class _StrengthGuidance implements StrengthGuidance {
  const factory _StrengthGuidance(
      {required final int weeklyFrequency,
      required final int sessionDurationMinutes,
      required final int setsPerExercise,
      required final String repRange}) = _$StrengthGuidanceImpl;

  factory _StrengthGuidance.fromJson(Map<String, dynamic> json) =
      _$StrengthGuidanceImpl.fromJson;

  @override
  int get weeklyFrequency; // 1-4 based on priority
  @override
  int get sessionDurationMinutes; // 10-20 for Phase 1
  @override
  int get setsPerExercise; // 2-3 based on priority
  @override
  String get repRange;

  /// Create a copy of StrengthGuidance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StrengthGuidanceImplCopyWith<_$StrengthGuidanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MobilityGuidance _$MobilityGuidanceFromJson(Map<String, dynamic> json) {
  return _MobilityGuidance.fromJson(json);
}

/// @nodoc
mixin _$MobilityGuidance {
  int get weeklyFrequency =>
      throw _privateConstructorUsedError; // 2-7 based on priority
  int get sessionDurationMinutes =>
      throw _privateConstructorUsedError; // 10-30 based on priority
  List<String> get sessionTypes =>
      throw _privateConstructorUsedError; // ["active_pre_run", "passive_post_run", "recovery_deep"]
  List<String> get focusAreas =>
      throw _privateConstructorUsedError; // ["hip_mobility", "ankle_mobility", "thoracic_spine", "hamstrings"]
  bool get increaseDuringTaper => throw _privateConstructorUsedError;

  /// Serializes this MobilityGuidance to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MobilityGuidance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MobilityGuidanceCopyWith<MobilityGuidance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MobilityGuidanceCopyWith<$Res> {
  factory $MobilityGuidanceCopyWith(
          MobilityGuidance value, $Res Function(MobilityGuidance) then) =
      _$MobilityGuidanceCopyWithImpl<$Res, MobilityGuidance>;
  @useResult
  $Res call(
      {int weeklyFrequency,
      int sessionDurationMinutes,
      List<String> sessionTypes,
      List<String> focusAreas,
      bool increaseDuringTaper});
}

/// @nodoc
class _$MobilityGuidanceCopyWithImpl<$Res, $Val extends MobilityGuidance>
    implements $MobilityGuidanceCopyWith<$Res> {
  _$MobilityGuidanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MobilityGuidance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weeklyFrequency = null,
    Object? sessionDurationMinutes = null,
    Object? sessionTypes = null,
    Object? focusAreas = null,
    Object? increaseDuringTaper = null,
  }) {
    return _then(_value.copyWith(
      weeklyFrequency: null == weeklyFrequency
          ? _value.weeklyFrequency
          : weeklyFrequency // ignore: cast_nullable_to_non_nullable
              as int,
      sessionDurationMinutes: null == sessionDurationMinutes
          ? _value.sessionDurationMinutes
          : sessionDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      sessionTypes: null == sessionTypes
          ? _value.sessionTypes
          : sessionTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      focusAreas: null == focusAreas
          ? _value.focusAreas
          : focusAreas // ignore: cast_nullable_to_non_nullable
              as List<String>,
      increaseDuringTaper: null == increaseDuringTaper
          ? _value.increaseDuringTaper
          : increaseDuringTaper // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MobilityGuidanceImplCopyWith<$Res>
    implements $MobilityGuidanceCopyWith<$Res> {
  factory _$$MobilityGuidanceImplCopyWith(_$MobilityGuidanceImpl value,
          $Res Function(_$MobilityGuidanceImpl) then) =
      __$$MobilityGuidanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int weeklyFrequency,
      int sessionDurationMinutes,
      List<String> sessionTypes,
      List<String> focusAreas,
      bool increaseDuringTaper});
}

/// @nodoc
class __$$MobilityGuidanceImplCopyWithImpl<$Res>
    extends _$MobilityGuidanceCopyWithImpl<$Res, _$MobilityGuidanceImpl>
    implements _$$MobilityGuidanceImplCopyWith<$Res> {
  __$$MobilityGuidanceImplCopyWithImpl(_$MobilityGuidanceImpl _value,
      $Res Function(_$MobilityGuidanceImpl) _then)
      : super(_value, _then);

  /// Create a copy of MobilityGuidance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weeklyFrequency = null,
    Object? sessionDurationMinutes = null,
    Object? sessionTypes = null,
    Object? focusAreas = null,
    Object? increaseDuringTaper = null,
  }) {
    return _then(_$MobilityGuidanceImpl(
      weeklyFrequency: null == weeklyFrequency
          ? _value.weeklyFrequency
          : weeklyFrequency // ignore: cast_nullable_to_non_nullable
              as int,
      sessionDurationMinutes: null == sessionDurationMinutes
          ? _value.sessionDurationMinutes
          : sessionDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      sessionTypes: null == sessionTypes
          ? _value._sessionTypes
          : sessionTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      focusAreas: null == focusAreas
          ? _value._focusAreas
          : focusAreas // ignore: cast_nullable_to_non_nullable
              as List<String>,
      increaseDuringTaper: null == increaseDuringTaper
          ? _value.increaseDuringTaper
          : increaseDuringTaper // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MobilityGuidanceImpl implements _MobilityGuidance {
  const _$MobilityGuidanceImpl(
      {required this.weeklyFrequency,
      required this.sessionDurationMinutes,
      required final List<String> sessionTypes,
      required final List<String> focusAreas,
      required this.increaseDuringTaper})
      : _sessionTypes = sessionTypes,
        _focusAreas = focusAreas;

  factory _$MobilityGuidanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$MobilityGuidanceImplFromJson(json);

  @override
  final int weeklyFrequency;
// 2-7 based on priority
  @override
  final int sessionDurationMinutes;
// 10-30 based on priority
  final List<String> _sessionTypes;
// 10-30 based on priority
  @override
  List<String> get sessionTypes {
    if (_sessionTypes is EqualUnmodifiableListView) return _sessionTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessionTypes);
  }

// ["active_pre_run", "passive_post_run", "recovery_deep"]
  final List<String> _focusAreas;
// ["active_pre_run", "passive_post_run", "recovery_deep"]
  @override
  List<String> get focusAreas {
    if (_focusAreas is EqualUnmodifiableListView) return _focusAreas;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_focusAreas);
  }

// ["hip_mobility", "ankle_mobility", "thoracic_spine", "hamstrings"]
  @override
  final bool increaseDuringTaper;

  @override
  String toString() {
    return 'MobilityGuidance(weeklyFrequency: $weeklyFrequency, sessionDurationMinutes: $sessionDurationMinutes, sessionTypes: $sessionTypes, focusAreas: $focusAreas, increaseDuringTaper: $increaseDuringTaper)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MobilityGuidanceImpl &&
            (identical(other.weeklyFrequency, weeklyFrequency) ||
                other.weeklyFrequency == weeklyFrequency) &&
            (identical(other.sessionDurationMinutes, sessionDurationMinutes) ||
                other.sessionDurationMinutes == sessionDurationMinutes) &&
            const DeepCollectionEquality()
                .equals(other._sessionTypes, _sessionTypes) &&
            const DeepCollectionEquality()
                .equals(other._focusAreas, _focusAreas) &&
            (identical(other.increaseDuringTaper, increaseDuringTaper) ||
                other.increaseDuringTaper == increaseDuringTaper));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      weeklyFrequency,
      sessionDurationMinutes,
      const DeepCollectionEquality().hash(_sessionTypes),
      const DeepCollectionEquality().hash(_focusAreas),
      increaseDuringTaper);

  /// Create a copy of MobilityGuidance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MobilityGuidanceImplCopyWith<_$MobilityGuidanceImpl> get copyWith =>
      __$$MobilityGuidanceImplCopyWithImpl<_$MobilityGuidanceImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MobilityGuidanceImplToJson(
      this,
    );
  }
}

abstract class _MobilityGuidance implements MobilityGuidance {
  const factory _MobilityGuidance(
      {required final int weeklyFrequency,
      required final int sessionDurationMinutes,
      required final List<String> sessionTypes,
      required final List<String> focusAreas,
      required final bool increaseDuringTaper}) = _$MobilityGuidanceImpl;

  factory _MobilityGuidance.fromJson(Map<String, dynamic> json) =
      _$MobilityGuidanceImpl.fromJson;

  @override
  int get weeklyFrequency; // 2-7 based on priority
  @override
  int get sessionDurationMinutes; // 10-30 based on priority
  @override
  List<String>
      get sessionTypes; // ["active_pre_run", "passive_post_run", "recovery_deep"]
  @override
  List<String>
      get focusAreas; // ["hip_mobility", "ankle_mobility", "thoracic_spine", "hamstrings"]
  @override
  bool get increaseDuringTaper;

  /// Create a copy of MobilityGuidance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MobilityGuidanceImplCopyWith<_$MobilityGuidanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserContext _$UserContextFromJson(Map<String, dynamic> json) {
  return _UserContext.fromJson(json);
}

/// @nodoc
mixin _$UserContext {
  int get age => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  List<String> get availableDays => throw _privateConstructorUsedError;
  Map<String, int> get timeConstraints => throw _privateConstructorUsedError;
  List<String> get injuryHistory =>
      throw _privateConstructorUsedError; // Current training metrics (from form on first plan, calculated from history on subsequent plans)
  int? get weeklyTrainingFrequency =>
      throw _privateConstructorUsedError; // sessions per week
  double? get weeklyVolume => throw _privateConstructorUsedError;

  /// Serializes this UserContext to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserContextCopyWith<UserContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserContextCopyWith<$Res> {
  factory $UserContextCopyWith(
          UserContext value, $Res Function(UserContext) then) =
      _$UserContextCopyWithImpl<$Res, UserContext>;
  @useResult
  $Res call(
      {int age,
      String gender,
      List<String> availableDays,
      Map<String, int> timeConstraints,
      List<String> injuryHistory,
      int? weeklyTrainingFrequency,
      double? weeklyVolume});
}

/// @nodoc
class _$UserContextCopyWithImpl<$Res, $Val extends UserContext>
    implements $UserContextCopyWith<$Res> {
  _$UserContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? age = null,
    Object? gender = null,
    Object? availableDays = null,
    Object? timeConstraints = null,
    Object? injuryHistory = null,
    Object? weeklyTrainingFrequency = freezed,
    Object? weeklyVolume = freezed,
  }) {
    return _then(_value.copyWith(
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      availableDays: null == availableDays
          ? _value.availableDays
          : availableDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timeConstraints: null == timeConstraints
          ? _value.timeConstraints
          : timeConstraints // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      injuryHistory: null == injuryHistory
          ? _value.injuryHistory
          : injuryHistory // ignore: cast_nullable_to_non_nullable
              as List<String>,
      weeklyTrainingFrequency: freezed == weeklyTrainingFrequency
          ? _value.weeklyTrainingFrequency
          : weeklyTrainingFrequency // ignore: cast_nullable_to_non_nullable
              as int?,
      weeklyVolume: freezed == weeklyVolume
          ? _value.weeklyVolume
          : weeklyVolume // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserContextImplCopyWith<$Res>
    implements $UserContextCopyWith<$Res> {
  factory _$$UserContextImplCopyWith(
          _$UserContextImpl value, $Res Function(_$UserContextImpl) then) =
      __$$UserContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int age,
      String gender,
      List<String> availableDays,
      Map<String, int> timeConstraints,
      List<String> injuryHistory,
      int? weeklyTrainingFrequency,
      double? weeklyVolume});
}

/// @nodoc
class __$$UserContextImplCopyWithImpl<$Res>
    extends _$UserContextCopyWithImpl<$Res, _$UserContextImpl>
    implements _$$UserContextImplCopyWith<$Res> {
  __$$UserContextImplCopyWithImpl(
      _$UserContextImpl _value, $Res Function(_$UserContextImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? age = null,
    Object? gender = null,
    Object? availableDays = null,
    Object? timeConstraints = null,
    Object? injuryHistory = null,
    Object? weeklyTrainingFrequency = freezed,
    Object? weeklyVolume = freezed,
  }) {
    return _then(_$UserContextImpl(
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      availableDays: null == availableDays
          ? _value._availableDays
          : availableDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timeConstraints: null == timeConstraints
          ? _value._timeConstraints
          : timeConstraints // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      injuryHistory: null == injuryHistory
          ? _value._injuryHistory
          : injuryHistory // ignore: cast_nullable_to_non_nullable
              as List<String>,
      weeklyTrainingFrequency: freezed == weeklyTrainingFrequency
          ? _value.weeklyTrainingFrequency
          : weeklyTrainingFrequency // ignore: cast_nullable_to_non_nullable
              as int?,
      weeklyVolume: freezed == weeklyVolume
          ? _value.weeklyVolume
          : weeklyVolume // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserContextImpl implements _UserContext {
  const _$UserContextImpl(
      {required this.age,
      required this.gender,
      required final List<String> availableDays,
      required final Map<String, int> timeConstraints,
      required final List<String> injuryHistory,
      this.weeklyTrainingFrequency,
      this.weeklyVolume})
      : _availableDays = availableDays,
        _timeConstraints = timeConstraints,
        _injuryHistory = injuryHistory;

  factory _$UserContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserContextImplFromJson(json);

  @override
  final int age;
  @override
  final String gender;
  final List<String> _availableDays;
  @override
  List<String> get availableDays {
    if (_availableDays is EqualUnmodifiableListView) return _availableDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableDays);
  }

  final Map<String, int> _timeConstraints;
  @override
  Map<String, int> get timeConstraints {
    if (_timeConstraints is EqualUnmodifiableMapView) return _timeConstraints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_timeConstraints);
  }

  final List<String> _injuryHistory;
  @override
  List<String> get injuryHistory {
    if (_injuryHistory is EqualUnmodifiableListView) return _injuryHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_injuryHistory);
  }

// Current training metrics (from form on first plan, calculated from history on subsequent plans)
  @override
  final int? weeklyTrainingFrequency;
// sessions per week
  @override
  final double? weeklyVolume;

  @override
  String toString() {
    return 'UserContext(age: $age, gender: $gender, availableDays: $availableDays, timeConstraints: $timeConstraints, injuryHistory: $injuryHistory, weeklyTrainingFrequency: $weeklyTrainingFrequency, weeklyVolume: $weeklyVolume)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserContextImpl &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            const DeepCollectionEquality()
                .equals(other._availableDays, _availableDays) &&
            const DeepCollectionEquality()
                .equals(other._timeConstraints, _timeConstraints) &&
            const DeepCollectionEquality()
                .equals(other._injuryHistory, _injuryHistory) &&
            (identical(
                    other.weeklyTrainingFrequency, weeklyTrainingFrequency) ||
                other.weeklyTrainingFrequency == weeklyTrainingFrequency) &&
            (identical(other.weeklyVolume, weeklyVolume) ||
                other.weeklyVolume == weeklyVolume));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      age,
      gender,
      const DeepCollectionEquality().hash(_availableDays),
      const DeepCollectionEquality().hash(_timeConstraints),
      const DeepCollectionEquality().hash(_injuryHistory),
      weeklyTrainingFrequency,
      weeklyVolume);

  /// Create a copy of UserContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserContextImplCopyWith<_$UserContextImpl> get copyWith =>
      __$$UserContextImplCopyWithImpl<_$UserContextImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserContextImplToJson(
      this,
    );
  }
}

abstract class _UserContext implements UserContext {
  const factory _UserContext(
      {required final int age,
      required final String gender,
      required final List<String> availableDays,
      required final Map<String, int> timeConstraints,
      required final List<String> injuryHistory,
      final int? weeklyTrainingFrequency,
      final double? weeklyVolume}) = _$UserContextImpl;

  factory _UserContext.fromJson(Map<String, dynamic> json) =
      _$UserContextImpl.fromJson;

  @override
  int get age;
  @override
  String get gender;
  @override
  List<String> get availableDays;
  @override
  Map<String, int> get timeConstraints;
  @override
  List<String>
      get injuryHistory; // Current training metrics (from form on first plan, calculated from history on subsequent plans)
  @override
  int? get weeklyTrainingFrequency; // sessions per week
  @override
  double? get weeklyVolume;

  /// Create a copy of UserContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserContextImplCopyWith<_$UserContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GoalContext _$GoalContextFromJson(Map<String, dynamic> json) {
  return _GoalContext.fromJson(json);
}

/// @nodoc
mixin _$GoalContext {
  String get type => throw _privateConstructorUsedError;
  String get target => throw _privateConstructorUsedError;
  DateTime get deadline => throw _privateConstructorUsedError;
  List<String> get specialInstructions => throw _privateConstructorUsedError;
  String? get currentPace => throw _privateConstructorUsedError;
  bool? get isFirstTime =>
      throw _privateConstructorUsedError; // Timeline calculations
  int? get daysUntilGoal =>
      throw _privateConstructorUsedError; // Goal-specific parameters
  int? get currentBestTime =>
      throw _privateConstructorUsedError; // For time performance goals (seconds)
  String? get eventName =>
      throw _privateConstructorUsedError; // For event goals
// Pillar priorities (goal-specific training focus)
  String? get runningPriority => throw _privateConstructorUsedError;
  String? get strengthPriority => throw _privateConstructorUsedError;
  String? get mobilityPriority => throw _privateConstructorUsedError;

  /// Serializes this GoalContext to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GoalContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoalContextCopyWith<GoalContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalContextCopyWith<$Res> {
  factory $GoalContextCopyWith(
          GoalContext value, $Res Function(GoalContext) then) =
      _$GoalContextCopyWithImpl<$Res, GoalContext>;
  @useResult
  $Res call(
      {String type,
      String target,
      DateTime deadline,
      List<String> specialInstructions,
      String? currentPace,
      bool? isFirstTime,
      int? daysUntilGoal,
      int? currentBestTime,
      String? eventName,
      String? runningPriority,
      String? strengthPriority,
      String? mobilityPriority});
}

/// @nodoc
class _$GoalContextCopyWithImpl<$Res, $Val extends GoalContext>
    implements $GoalContextCopyWith<$Res> {
  _$GoalContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GoalContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? target = null,
    Object? deadline = null,
    Object? specialInstructions = null,
    Object? currentPace = freezed,
    Object? isFirstTime = freezed,
    Object? daysUntilGoal = freezed,
    Object? currentBestTime = freezed,
    Object? eventName = freezed,
    Object? runningPriority = freezed,
    Object? strengthPriority = freezed,
    Object? mobilityPriority = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      specialInstructions: null == specialInstructions
          ? _value.specialInstructions
          : specialInstructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentPace: freezed == currentPace
          ? _value.currentPace
          : currentPace // ignore: cast_nullable_to_non_nullable
              as String?,
      isFirstTime: freezed == isFirstTime
          ? _value.isFirstTime
          : isFirstTime // ignore: cast_nullable_to_non_nullable
              as bool?,
      daysUntilGoal: freezed == daysUntilGoal
          ? _value.daysUntilGoal
          : daysUntilGoal // ignore: cast_nullable_to_non_nullable
              as int?,
      currentBestTime: freezed == currentBestTime
          ? _value.currentBestTime
          : currentBestTime // ignore: cast_nullable_to_non_nullable
              as int?,
      eventName: freezed == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String?,
      runningPriority: freezed == runningPriority
          ? _value.runningPriority
          : runningPriority // ignore: cast_nullable_to_non_nullable
              as String?,
      strengthPriority: freezed == strengthPriority
          ? _value.strengthPriority
          : strengthPriority // ignore: cast_nullable_to_non_nullable
              as String?,
      mobilityPriority: freezed == mobilityPriority
          ? _value.mobilityPriority
          : mobilityPriority // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GoalContextImplCopyWith<$Res>
    implements $GoalContextCopyWith<$Res> {
  factory _$$GoalContextImplCopyWith(
          _$GoalContextImpl value, $Res Function(_$GoalContextImpl) then) =
      __$$GoalContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      String target,
      DateTime deadline,
      List<String> specialInstructions,
      String? currentPace,
      bool? isFirstTime,
      int? daysUntilGoal,
      int? currentBestTime,
      String? eventName,
      String? runningPriority,
      String? strengthPriority,
      String? mobilityPriority});
}

/// @nodoc
class __$$GoalContextImplCopyWithImpl<$Res>
    extends _$GoalContextCopyWithImpl<$Res, _$GoalContextImpl>
    implements _$$GoalContextImplCopyWith<$Res> {
  __$$GoalContextImplCopyWithImpl(
      _$GoalContextImpl _value, $Res Function(_$GoalContextImpl) _then)
      : super(_value, _then);

  /// Create a copy of GoalContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? target = null,
    Object? deadline = null,
    Object? specialInstructions = null,
    Object? currentPace = freezed,
    Object? isFirstTime = freezed,
    Object? daysUntilGoal = freezed,
    Object? currentBestTime = freezed,
    Object? eventName = freezed,
    Object? runningPriority = freezed,
    Object? strengthPriority = freezed,
    Object? mobilityPriority = freezed,
  }) {
    return _then(_$GoalContextImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      specialInstructions: null == specialInstructions
          ? _value._specialInstructions
          : specialInstructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentPace: freezed == currentPace
          ? _value.currentPace
          : currentPace // ignore: cast_nullable_to_non_nullable
              as String?,
      isFirstTime: freezed == isFirstTime
          ? _value.isFirstTime
          : isFirstTime // ignore: cast_nullable_to_non_nullable
              as bool?,
      daysUntilGoal: freezed == daysUntilGoal
          ? _value.daysUntilGoal
          : daysUntilGoal // ignore: cast_nullable_to_non_nullable
              as int?,
      currentBestTime: freezed == currentBestTime
          ? _value.currentBestTime
          : currentBestTime // ignore: cast_nullable_to_non_nullable
              as int?,
      eventName: freezed == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String?,
      runningPriority: freezed == runningPriority
          ? _value.runningPriority
          : runningPriority // ignore: cast_nullable_to_non_nullable
              as String?,
      strengthPriority: freezed == strengthPriority
          ? _value.strengthPriority
          : strengthPriority // ignore: cast_nullable_to_non_nullable
              as String?,
      mobilityPriority: freezed == mobilityPriority
          ? _value.mobilityPriority
          : mobilityPriority // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GoalContextImpl implements _GoalContext {
  const _$GoalContextImpl(
      {required this.type,
      required this.target,
      required this.deadline,
      required final List<String> specialInstructions,
      this.currentPace,
      this.isFirstTime,
      this.daysUntilGoal,
      this.currentBestTime,
      this.eventName,
      this.runningPriority,
      this.strengthPriority,
      this.mobilityPriority})
      : _specialInstructions = specialInstructions;

  factory _$GoalContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoalContextImplFromJson(json);

  @override
  final String type;
  @override
  final String target;
  @override
  final DateTime deadline;
  final List<String> _specialInstructions;
  @override
  List<String> get specialInstructions {
    if (_specialInstructions is EqualUnmodifiableListView)
      return _specialInstructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_specialInstructions);
  }

  @override
  final String? currentPace;
  @override
  final bool? isFirstTime;
// Timeline calculations
  @override
  final int? daysUntilGoal;
// Goal-specific parameters
  @override
  final int? currentBestTime;
// For time performance goals (seconds)
  @override
  final String? eventName;
// For event goals
// Pillar priorities (goal-specific training focus)
  @override
  final String? runningPriority;
  @override
  final String? strengthPriority;
  @override
  final String? mobilityPriority;

  @override
  String toString() {
    return 'GoalContext(type: $type, target: $target, deadline: $deadline, specialInstructions: $specialInstructions, currentPace: $currentPace, isFirstTime: $isFirstTime, daysUntilGoal: $daysUntilGoal, currentBestTime: $currentBestTime, eventName: $eventName, runningPriority: $runningPriority, strengthPriority: $strengthPriority, mobilityPriority: $mobilityPriority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalContextImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            const DeepCollectionEquality()
                .equals(other._specialInstructions, _specialInstructions) &&
            (identical(other.currentPace, currentPace) ||
                other.currentPace == currentPace) &&
            (identical(other.isFirstTime, isFirstTime) ||
                other.isFirstTime == isFirstTime) &&
            (identical(other.daysUntilGoal, daysUntilGoal) ||
                other.daysUntilGoal == daysUntilGoal) &&
            (identical(other.currentBestTime, currentBestTime) ||
                other.currentBestTime == currentBestTime) &&
            (identical(other.eventName, eventName) ||
                other.eventName == eventName) &&
            (identical(other.runningPriority, runningPriority) ||
                other.runningPriority == runningPriority) &&
            (identical(other.strengthPriority, strengthPriority) ||
                other.strengthPriority == strengthPriority) &&
            (identical(other.mobilityPriority, mobilityPriority) ||
                other.mobilityPriority == mobilityPriority));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      target,
      deadline,
      const DeepCollectionEquality().hash(_specialInstructions),
      currentPace,
      isFirstTime,
      daysUntilGoal,
      currentBestTime,
      eventName,
      runningPriority,
      strengthPriority,
      mobilityPriority);

  /// Create a copy of GoalContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalContextImplCopyWith<_$GoalContextImpl> get copyWith =>
      __$$GoalContextImplCopyWithImpl<_$GoalContextImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalContextImplToJson(
      this,
    );
  }
}

abstract class _GoalContext implements GoalContext {
  const factory _GoalContext(
      {required final String type,
      required final String target,
      required final DateTime deadline,
      required final List<String> specialInstructions,
      final String? currentPace,
      final bool? isFirstTime,
      final int? daysUntilGoal,
      final int? currentBestTime,
      final String? eventName,
      final String? runningPriority,
      final String? strengthPriority,
      final String? mobilityPriority}) = _$GoalContextImpl;

  factory _GoalContext.fromJson(Map<String, dynamic> json) =
      _$GoalContextImpl.fromJson;

  @override
  String get type;
  @override
  String get target;
  @override
  DateTime get deadline;
  @override
  List<String> get specialInstructions;
  @override
  String? get currentPace;
  @override
  bool? get isFirstTime; // Timeline calculations
  @override
  int? get daysUntilGoal; // Goal-specific parameters
  @override
  int? get currentBestTime; // For time performance goals (seconds)
  @override
  String? get eventName; // For event goals
// Pillar priorities (goal-specific training focus)
  @override
  String? get runningPriority;
  @override
  String? get strengthPriority;
  @override
  String? get mobilityPriority;

  /// Create a copy of GoalContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoalContextImplCopyWith<_$GoalContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkoutSummary _$WorkoutSummaryFromJson(Map<String, dynamic> json) {
  return _WorkoutSummary.fromJson(json);
}

/// @nodoc
mixin _$WorkoutSummary {
  DateTime get date => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;
  int? get rpe => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;

  /// Serializes this WorkoutSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutSummaryCopyWith<WorkoutSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutSummaryCopyWith<$Res> {
  factory $WorkoutSummaryCopyWith(
          WorkoutSummary value, $Res Function(WorkoutSummary) then) =
      _$WorkoutSummaryCopyWithImpl<$Res, WorkoutSummary>;
  @useResult
  $Res call(
      {DateTime date,
      String type,
      int duration,
      double? distance,
      int? rpe,
      bool completed});
}

/// @nodoc
class _$WorkoutSummaryCopyWithImpl<$Res, $Val extends WorkoutSummary>
    implements $WorkoutSummaryCopyWith<$Res> {
  _$WorkoutSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? type = null,
    Object? duration = null,
    Object? distance = freezed,
    Object? rpe = freezed,
    Object? completed = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      rpe: freezed == rpe
          ? _value.rpe
          : rpe // ignore: cast_nullable_to_non_nullable
              as int?,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkoutSummaryImplCopyWith<$Res>
    implements $WorkoutSummaryCopyWith<$Res> {
  factory _$$WorkoutSummaryImplCopyWith(_$WorkoutSummaryImpl value,
          $Res Function(_$WorkoutSummaryImpl) then) =
      __$$WorkoutSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      String type,
      int duration,
      double? distance,
      int? rpe,
      bool completed});
}

/// @nodoc
class __$$WorkoutSummaryImplCopyWithImpl<$Res>
    extends _$WorkoutSummaryCopyWithImpl<$Res, _$WorkoutSummaryImpl>
    implements _$$WorkoutSummaryImplCopyWith<$Res> {
  __$$WorkoutSummaryImplCopyWithImpl(
      _$WorkoutSummaryImpl _value, $Res Function(_$WorkoutSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkoutSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? type = null,
    Object? duration = null,
    Object? distance = freezed,
    Object? rpe = freezed,
    Object? completed = null,
  }) {
    return _then(_$WorkoutSummaryImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      rpe: freezed == rpe
          ? _value.rpe
          : rpe // ignore: cast_nullable_to_non_nullable
              as int?,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutSummaryImpl implements _WorkoutSummary {
  const _$WorkoutSummaryImpl(
      {required this.date,
      required this.type,
      required this.duration,
      this.distance,
      this.rpe,
      required this.completed});

  factory _$WorkoutSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutSummaryImplFromJson(json);

  @override
  final DateTime date;
  @override
  final String type;
  @override
  final int duration;
  @override
  final double? distance;
  @override
  final int? rpe;
  @override
  final bool completed;

  @override
  String toString() {
    return 'WorkoutSummary(date: $date, type: $type, duration: $duration, distance: $distance, rpe: $rpe, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutSummaryImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.rpe, rpe) || other.rpe == rpe) &&
            (identical(other.completed, completed) ||
                other.completed == completed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, date, type, duration, distance, rpe, completed);

  /// Create a copy of WorkoutSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutSummaryImplCopyWith<_$WorkoutSummaryImpl> get copyWith =>
      __$$WorkoutSummaryImplCopyWithImpl<_$WorkoutSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutSummaryImplToJson(
      this,
    );
  }
}

abstract class _WorkoutSummary implements WorkoutSummary {
  const factory _WorkoutSummary(
      {required final DateTime date,
      required final String type,
      required final int duration,
      final double? distance,
      final int? rpe,
      required final bool completed}) = _$WorkoutSummaryImpl;

  factory _WorkoutSummary.fromJson(Map<String, dynamic> json) =
      _$WorkoutSummaryImpl.fromJson;

  @override
  DateTime get date;
  @override
  String get type;
  @override
  int get duration;
  @override
  double? get distance;
  @override
  int? get rpe;
  @override
  bool get completed;

  /// Create a copy of WorkoutSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutSummaryImplCopyWith<_$WorkoutSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CoachingChatContext _$CoachingChatContextFromJson(Map<String, dynamic> json) {
  return _CoachingChatContext.fromJson(json);
}

/// @nodoc
mixin _$CoachingChatContext {
  LongTermContext get longTerm => throw _privateConstructorUsedError;
  MediumTermContext get mediumTerm => throw _privateConstructorUsedError;
  ShortTermContext get shortTerm => throw _privateConstructorUsedError;

  /// Serializes this CoachingChatContext to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CoachingChatContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoachingChatContextCopyWith<CoachingChatContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoachingChatContextCopyWith<$Res> {
  factory $CoachingChatContextCopyWith(
          CoachingChatContext value, $Res Function(CoachingChatContext) then) =
      _$CoachingChatContextCopyWithImpl<$Res, CoachingChatContext>;
  @useResult
  $Res call(
      {LongTermContext longTerm,
      MediumTermContext mediumTerm,
      ShortTermContext shortTerm});

  $LongTermContextCopyWith<$Res> get longTerm;
  $MediumTermContextCopyWith<$Res> get mediumTerm;
  $ShortTermContextCopyWith<$Res> get shortTerm;
}

/// @nodoc
class _$CoachingChatContextCopyWithImpl<$Res, $Val extends CoachingChatContext>
    implements $CoachingChatContextCopyWith<$Res> {
  _$CoachingChatContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoachingChatContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? longTerm = null,
    Object? mediumTerm = null,
    Object? shortTerm = null,
  }) {
    return _then(_value.copyWith(
      longTerm: null == longTerm
          ? _value.longTerm
          : longTerm // ignore: cast_nullable_to_non_nullable
              as LongTermContext,
      mediumTerm: null == mediumTerm
          ? _value.mediumTerm
          : mediumTerm // ignore: cast_nullable_to_non_nullable
              as MediumTermContext,
      shortTerm: null == shortTerm
          ? _value.shortTerm
          : shortTerm // ignore: cast_nullable_to_non_nullable
              as ShortTermContext,
    ) as $Val);
  }

  /// Create a copy of CoachingChatContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LongTermContextCopyWith<$Res> get longTerm {
    return $LongTermContextCopyWith<$Res>(_value.longTerm, (value) {
      return _then(_value.copyWith(longTerm: value) as $Val);
    });
  }

  /// Create a copy of CoachingChatContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MediumTermContextCopyWith<$Res> get mediumTerm {
    return $MediumTermContextCopyWith<$Res>(_value.mediumTerm, (value) {
      return _then(_value.copyWith(mediumTerm: value) as $Val);
    });
  }

  /// Create a copy of CoachingChatContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ShortTermContextCopyWith<$Res> get shortTerm {
    return $ShortTermContextCopyWith<$Res>(_value.shortTerm, (value) {
      return _then(_value.copyWith(shortTerm: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CoachingChatContextImplCopyWith<$Res>
    implements $CoachingChatContextCopyWith<$Res> {
  factory _$$CoachingChatContextImplCopyWith(_$CoachingChatContextImpl value,
          $Res Function(_$CoachingChatContextImpl) then) =
      __$$CoachingChatContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LongTermContext longTerm,
      MediumTermContext mediumTerm,
      ShortTermContext shortTerm});

  @override
  $LongTermContextCopyWith<$Res> get longTerm;
  @override
  $MediumTermContextCopyWith<$Res> get mediumTerm;
  @override
  $ShortTermContextCopyWith<$Res> get shortTerm;
}

/// @nodoc
class __$$CoachingChatContextImplCopyWithImpl<$Res>
    extends _$CoachingChatContextCopyWithImpl<$Res, _$CoachingChatContextImpl>
    implements _$$CoachingChatContextImplCopyWith<$Res> {
  __$$CoachingChatContextImplCopyWithImpl(_$CoachingChatContextImpl _value,
      $Res Function(_$CoachingChatContextImpl) _then)
      : super(_value, _then);

  /// Create a copy of CoachingChatContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? longTerm = null,
    Object? mediumTerm = null,
    Object? shortTerm = null,
  }) {
    return _then(_$CoachingChatContextImpl(
      longTerm: null == longTerm
          ? _value.longTerm
          : longTerm // ignore: cast_nullable_to_non_nullable
              as LongTermContext,
      mediumTerm: null == mediumTerm
          ? _value.mediumTerm
          : mediumTerm // ignore: cast_nullable_to_non_nullable
              as MediumTermContext,
      shortTerm: null == shortTerm
          ? _value.shortTerm
          : shortTerm // ignore: cast_nullable_to_non_nullable
              as ShortTermContext,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CoachingChatContextImpl implements _CoachingChatContext {
  const _$CoachingChatContextImpl(
      {required this.longTerm,
      required this.mediumTerm,
      required this.shortTerm});

  factory _$CoachingChatContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoachingChatContextImplFromJson(json);

  @override
  final LongTermContext longTerm;
  @override
  final MediumTermContext mediumTerm;
  @override
  final ShortTermContext shortTerm;

  @override
  String toString() {
    return 'CoachingChatContext(longTerm: $longTerm, mediumTerm: $mediumTerm, shortTerm: $shortTerm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoachingChatContextImpl &&
            (identical(other.longTerm, longTerm) ||
                other.longTerm == longTerm) &&
            (identical(other.mediumTerm, mediumTerm) ||
                other.mediumTerm == mediumTerm) &&
            (identical(other.shortTerm, shortTerm) ||
                other.shortTerm == shortTerm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, longTerm, mediumTerm, shortTerm);

  /// Create a copy of CoachingChatContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoachingChatContextImplCopyWith<_$CoachingChatContextImpl> get copyWith =>
      __$$CoachingChatContextImplCopyWithImpl<_$CoachingChatContextImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoachingChatContextImplToJson(
      this,
    );
  }
}

abstract class _CoachingChatContext implements CoachingChatContext {
  const factory _CoachingChatContext(
      {required final LongTermContext longTerm,
      required final MediumTermContext mediumTerm,
      required final ShortTermContext shortTerm}) = _$CoachingChatContextImpl;

  factory _CoachingChatContext.fromJson(Map<String, dynamic> json) =
      _$CoachingChatContextImpl.fromJson;

  @override
  LongTermContext get longTerm;
  @override
  MediumTermContext get mediumTerm;
  @override
  ShortTermContext get shortTerm;

  /// Create a copy of CoachingChatContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoachingChatContextImplCopyWith<_$CoachingChatContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LongTermContext _$LongTermContextFromJson(Map<String, dynamic> json) {
  return _LongTermContext.fromJson(json);
}

/// @nodoc
mixin _$LongTermContext {
  UserContext get user => throw _privateConstructorUsedError;
  GoalContext get goal => throw _privateConstructorUsedError;
  String get trainingPhilosophy => throw _privateConstructorUsedError;
  double get overallAdherence => throw _privateConstructorUsedError;
  List<DateTime> get raceDays => throw _privateConstructorUsedError;

  /// Serializes this LongTermContext to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LongTermContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LongTermContextCopyWith<LongTermContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LongTermContextCopyWith<$Res> {
  factory $LongTermContextCopyWith(
          LongTermContext value, $Res Function(LongTermContext) then) =
      _$LongTermContextCopyWithImpl<$Res, LongTermContext>;
  @useResult
  $Res call(
      {UserContext user,
      GoalContext goal,
      String trainingPhilosophy,
      double overallAdherence,
      List<DateTime> raceDays});

  $UserContextCopyWith<$Res> get user;
  $GoalContextCopyWith<$Res> get goal;
}

/// @nodoc
class _$LongTermContextCopyWithImpl<$Res, $Val extends LongTermContext>
    implements $LongTermContextCopyWith<$Res> {
  _$LongTermContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LongTermContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? goal = null,
    Object? trainingPhilosophy = null,
    Object? overallAdherence = null,
    Object? raceDays = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserContext,
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as GoalContext,
      trainingPhilosophy: null == trainingPhilosophy
          ? _value.trainingPhilosophy
          : trainingPhilosophy // ignore: cast_nullable_to_non_nullable
              as String,
      overallAdherence: null == overallAdherence
          ? _value.overallAdherence
          : overallAdherence // ignore: cast_nullable_to_non_nullable
              as double,
      raceDays: null == raceDays
          ? _value.raceDays
          : raceDays // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
    ) as $Val);
  }

  /// Create a copy of LongTermContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserContextCopyWith<$Res> get user {
    return $UserContextCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of LongTermContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GoalContextCopyWith<$Res> get goal {
    return $GoalContextCopyWith<$Res>(_value.goal, (value) {
      return _then(_value.copyWith(goal: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LongTermContextImplCopyWith<$Res>
    implements $LongTermContextCopyWith<$Res> {
  factory _$$LongTermContextImplCopyWith(_$LongTermContextImpl value,
          $Res Function(_$LongTermContextImpl) then) =
      __$$LongTermContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserContext user,
      GoalContext goal,
      String trainingPhilosophy,
      double overallAdherence,
      List<DateTime> raceDays});

  @override
  $UserContextCopyWith<$Res> get user;
  @override
  $GoalContextCopyWith<$Res> get goal;
}

/// @nodoc
class __$$LongTermContextImplCopyWithImpl<$Res>
    extends _$LongTermContextCopyWithImpl<$Res, _$LongTermContextImpl>
    implements _$$LongTermContextImplCopyWith<$Res> {
  __$$LongTermContextImplCopyWithImpl(
      _$LongTermContextImpl _value, $Res Function(_$LongTermContextImpl) _then)
      : super(_value, _then);

  /// Create a copy of LongTermContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? goal = null,
    Object? trainingPhilosophy = null,
    Object? overallAdherence = null,
    Object? raceDays = null,
  }) {
    return _then(_$LongTermContextImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserContext,
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as GoalContext,
      trainingPhilosophy: null == trainingPhilosophy
          ? _value.trainingPhilosophy
          : trainingPhilosophy // ignore: cast_nullable_to_non_nullable
              as String,
      overallAdherence: null == overallAdherence
          ? _value.overallAdherence
          : overallAdherence // ignore: cast_nullable_to_non_nullable
              as double,
      raceDays: null == raceDays
          ? _value._raceDays
          : raceDays // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LongTermContextImpl implements _LongTermContext {
  const _$LongTermContextImpl(
      {required this.user,
      required this.goal,
      required this.trainingPhilosophy,
      required this.overallAdherence,
      required final List<DateTime> raceDays})
      : _raceDays = raceDays;

  factory _$LongTermContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$LongTermContextImplFromJson(json);

  @override
  final UserContext user;
  @override
  final GoalContext goal;
  @override
  final String trainingPhilosophy;
  @override
  final double overallAdherence;
  final List<DateTime> _raceDays;
  @override
  List<DateTime> get raceDays {
    if (_raceDays is EqualUnmodifiableListView) return _raceDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_raceDays);
  }

  @override
  String toString() {
    return 'LongTermContext(user: $user, goal: $goal, trainingPhilosophy: $trainingPhilosophy, overallAdherence: $overallAdherence, raceDays: $raceDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LongTermContextImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.trainingPhilosophy, trainingPhilosophy) ||
                other.trainingPhilosophy == trainingPhilosophy) &&
            (identical(other.overallAdherence, overallAdherence) ||
                other.overallAdherence == overallAdherence) &&
            const DeepCollectionEquality().equals(other._raceDays, _raceDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user, goal, trainingPhilosophy,
      overallAdherence, const DeepCollectionEquality().hash(_raceDays));

  /// Create a copy of LongTermContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LongTermContextImplCopyWith<_$LongTermContextImpl> get copyWith =>
      __$$LongTermContextImplCopyWithImpl<_$LongTermContextImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LongTermContextImplToJson(
      this,
    );
  }
}

abstract class _LongTermContext implements LongTermContext {
  const factory _LongTermContext(
      {required final UserContext user,
      required final GoalContext goal,
      required final String trainingPhilosophy,
      required final double overallAdherence,
      required final List<DateTime> raceDays}) = _$LongTermContextImpl;

  factory _LongTermContext.fromJson(Map<String, dynamic> json) =
      _$LongTermContextImpl.fromJson;

  @override
  UserContext get user;
  @override
  GoalContext get goal;
  @override
  String get trainingPhilosophy;
  @override
  double get overallAdherence;
  @override
  List<DateTime> get raceDays;

  /// Create a copy of LongTermContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LongTermContextImplCopyWith<_$LongTermContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MediumTermContext _$MediumTermContextFromJson(Map<String, dynamic> json) {
  return _MediumTermContext.fromJson(json);
}

/// @nodoc
mixin _$MediumTermContext {
  DateTime get periodStart => throw _privateConstructorUsedError;
  DateTime get periodEnd => throw _privateConstructorUsedError;
  int get workoutsCompleted => throw _privateConstructorUsedError;
  int get workoutsPlanned => throw _privateConstructorUsedError;
  double get adherenceRate => throw _privateConstructorUsedError;
  double get averageRPE => throw _privateConstructorUsedError;
  double get totalDistance => throw _privateConstructorUsedError;
  List<String> get concerns => throw _privateConstructorUsedError;
  List<String> get achievements => throw _privateConstructorUsedError;

  /// Serializes this MediumTermContext to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MediumTermContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MediumTermContextCopyWith<MediumTermContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediumTermContextCopyWith<$Res> {
  factory $MediumTermContextCopyWith(
          MediumTermContext value, $Res Function(MediumTermContext) then) =
      _$MediumTermContextCopyWithImpl<$Res, MediumTermContext>;
  @useResult
  $Res call(
      {DateTime periodStart,
      DateTime periodEnd,
      int workoutsCompleted,
      int workoutsPlanned,
      double adherenceRate,
      double averageRPE,
      double totalDistance,
      List<String> concerns,
      List<String> achievements});
}

/// @nodoc
class _$MediumTermContextCopyWithImpl<$Res, $Val extends MediumTermContext>
    implements $MediumTermContextCopyWith<$Res> {
  _$MediumTermContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MediumTermContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? workoutsCompleted = null,
    Object? workoutsPlanned = null,
    Object? adherenceRate = null,
    Object? averageRPE = null,
    Object? totalDistance = null,
    Object? concerns = null,
    Object? achievements = null,
  }) {
    return _then(_value.copyWith(
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      workoutsCompleted: null == workoutsCompleted
          ? _value.workoutsCompleted
          : workoutsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      workoutsPlanned: null == workoutsPlanned
          ? _value.workoutsPlanned
          : workoutsPlanned // ignore: cast_nullable_to_non_nullable
              as int,
      adherenceRate: null == adherenceRate
          ? _value.adherenceRate
          : adherenceRate // ignore: cast_nullable_to_non_nullable
              as double,
      averageRPE: null == averageRPE
          ? _value.averageRPE
          : averageRPE // ignore: cast_nullable_to_non_nullable
              as double,
      totalDistance: null == totalDistance
          ? _value.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double,
      concerns: null == concerns
          ? _value.concerns
          : concerns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      achievements: null == achievements
          ? _value.achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MediumTermContextImplCopyWith<$Res>
    implements $MediumTermContextCopyWith<$Res> {
  factory _$$MediumTermContextImplCopyWith(_$MediumTermContextImpl value,
          $Res Function(_$MediumTermContextImpl) then) =
      __$$MediumTermContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime periodStart,
      DateTime periodEnd,
      int workoutsCompleted,
      int workoutsPlanned,
      double adherenceRate,
      double averageRPE,
      double totalDistance,
      List<String> concerns,
      List<String> achievements});
}

/// @nodoc
class __$$MediumTermContextImplCopyWithImpl<$Res>
    extends _$MediumTermContextCopyWithImpl<$Res, _$MediumTermContextImpl>
    implements _$$MediumTermContextImplCopyWith<$Res> {
  __$$MediumTermContextImplCopyWithImpl(_$MediumTermContextImpl _value,
      $Res Function(_$MediumTermContextImpl) _then)
      : super(_value, _then);

  /// Create a copy of MediumTermContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? periodStart = null,
    Object? periodEnd = null,
    Object? workoutsCompleted = null,
    Object? workoutsPlanned = null,
    Object? adherenceRate = null,
    Object? averageRPE = null,
    Object? totalDistance = null,
    Object? concerns = null,
    Object? achievements = null,
  }) {
    return _then(_$MediumTermContextImpl(
      periodStart: null == periodStart
          ? _value.periodStart
          : periodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      periodEnd: null == periodEnd
          ? _value.periodEnd
          : periodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      workoutsCompleted: null == workoutsCompleted
          ? _value.workoutsCompleted
          : workoutsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      workoutsPlanned: null == workoutsPlanned
          ? _value.workoutsPlanned
          : workoutsPlanned // ignore: cast_nullable_to_non_nullable
              as int,
      adherenceRate: null == adherenceRate
          ? _value.adherenceRate
          : adherenceRate // ignore: cast_nullable_to_non_nullable
              as double,
      averageRPE: null == averageRPE
          ? _value.averageRPE
          : averageRPE // ignore: cast_nullable_to_non_nullable
              as double,
      totalDistance: null == totalDistance
          ? _value.totalDistance
          : totalDistance // ignore: cast_nullable_to_non_nullable
              as double,
      concerns: null == concerns
          ? _value._concerns
          : concerns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      achievements: null == achievements
          ? _value._achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MediumTermContextImpl implements _MediumTermContext {
  const _$MediumTermContextImpl(
      {required this.periodStart,
      required this.periodEnd,
      required this.workoutsCompleted,
      required this.workoutsPlanned,
      required this.adherenceRate,
      required this.averageRPE,
      required this.totalDistance,
      required final List<String> concerns,
      required final List<String> achievements})
      : _concerns = concerns,
        _achievements = achievements;

  factory _$MediumTermContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$MediumTermContextImplFromJson(json);

  @override
  final DateTime periodStart;
  @override
  final DateTime periodEnd;
  @override
  final int workoutsCompleted;
  @override
  final int workoutsPlanned;
  @override
  final double adherenceRate;
  @override
  final double averageRPE;
  @override
  final double totalDistance;
  final List<String> _concerns;
  @override
  List<String> get concerns {
    if (_concerns is EqualUnmodifiableListView) return _concerns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_concerns);
  }

  final List<String> _achievements;
  @override
  List<String> get achievements {
    if (_achievements is EqualUnmodifiableListView) return _achievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_achievements);
  }

  @override
  String toString() {
    return 'MediumTermContext(periodStart: $periodStart, periodEnd: $periodEnd, workoutsCompleted: $workoutsCompleted, workoutsPlanned: $workoutsPlanned, adherenceRate: $adherenceRate, averageRPE: $averageRPE, totalDistance: $totalDistance, concerns: $concerns, achievements: $achievements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MediumTermContextImpl &&
            (identical(other.periodStart, periodStart) ||
                other.periodStart == periodStart) &&
            (identical(other.periodEnd, periodEnd) ||
                other.periodEnd == periodEnd) &&
            (identical(other.workoutsCompleted, workoutsCompleted) ||
                other.workoutsCompleted == workoutsCompleted) &&
            (identical(other.workoutsPlanned, workoutsPlanned) ||
                other.workoutsPlanned == workoutsPlanned) &&
            (identical(other.adherenceRate, adherenceRate) ||
                other.adherenceRate == adherenceRate) &&
            (identical(other.averageRPE, averageRPE) ||
                other.averageRPE == averageRPE) &&
            (identical(other.totalDistance, totalDistance) ||
                other.totalDistance == totalDistance) &&
            const DeepCollectionEquality().equals(other._concerns, _concerns) &&
            const DeepCollectionEquality()
                .equals(other._achievements, _achievements));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      periodStart,
      periodEnd,
      workoutsCompleted,
      workoutsPlanned,
      adherenceRate,
      averageRPE,
      totalDistance,
      const DeepCollectionEquality().hash(_concerns),
      const DeepCollectionEquality().hash(_achievements));

  /// Create a copy of MediumTermContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MediumTermContextImplCopyWith<_$MediumTermContextImpl> get copyWith =>
      __$$MediumTermContextImplCopyWithImpl<_$MediumTermContextImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MediumTermContextImplToJson(
      this,
    );
  }
}

abstract class _MediumTermContext implements MediumTermContext {
  const factory _MediumTermContext(
      {required final DateTime periodStart,
      required final DateTime periodEnd,
      required final int workoutsCompleted,
      required final int workoutsPlanned,
      required final double adherenceRate,
      required final double averageRPE,
      required final double totalDistance,
      required final List<String> concerns,
      required final List<String> achievements}) = _$MediumTermContextImpl;

  factory _MediumTermContext.fromJson(Map<String, dynamic> json) =
      _$MediumTermContextImpl.fromJson;

  @override
  DateTime get periodStart;
  @override
  DateTime get periodEnd;
  @override
  int get workoutsCompleted;
  @override
  int get workoutsPlanned;
  @override
  double get adherenceRate;
  @override
  double get averageRPE;
  @override
  double get totalDistance;
  @override
  List<String> get concerns;
  @override
  List<String> get achievements;

  /// Create a copy of MediumTermContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MediumTermContextImplCopyWith<_$MediumTermContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShortTermContext _$ShortTermContextFromJson(Map<String, dynamic> json) {
  return _ShortTermContext.fromJson(json);
}

/// @nodoc
mixin _$ShortTermContext {
  DateTime get currentDate => throw _privateConstructorUsedError;
  WorkoutSummary? get todayWorkout => throw _privateConstructorUsedError;
  List<WorkoutSummary> get next7Days => throw _privateConstructorUsedError;
  List<ConversationMessage> get conversationHistory =>
      throw _privateConstructorUsedError;
  int? get currentPainLevel => throw _privateConstructorUsedError;
  String? get sleepQuality => throw _privateConstructorUsedError;
  String? get weather => throw _privateConstructorUsedError;

  /// Serializes this ShortTermContext to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShortTermContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShortTermContextCopyWith<ShortTermContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShortTermContextCopyWith<$Res> {
  factory $ShortTermContextCopyWith(
          ShortTermContext value, $Res Function(ShortTermContext) then) =
      _$ShortTermContextCopyWithImpl<$Res, ShortTermContext>;
  @useResult
  $Res call(
      {DateTime currentDate,
      WorkoutSummary? todayWorkout,
      List<WorkoutSummary> next7Days,
      List<ConversationMessage> conversationHistory,
      int? currentPainLevel,
      String? sleepQuality,
      String? weather});

  $WorkoutSummaryCopyWith<$Res>? get todayWorkout;
}

/// @nodoc
class _$ShortTermContextCopyWithImpl<$Res, $Val extends ShortTermContext>
    implements $ShortTermContextCopyWith<$Res> {
  _$ShortTermContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShortTermContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDate = null,
    Object? todayWorkout = freezed,
    Object? next7Days = null,
    Object? conversationHistory = null,
    Object? currentPainLevel = freezed,
    Object? sleepQuality = freezed,
    Object? weather = freezed,
  }) {
    return _then(_value.copyWith(
      currentDate: null == currentDate
          ? _value.currentDate
          : currentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      todayWorkout: freezed == todayWorkout
          ? _value.todayWorkout
          : todayWorkout // ignore: cast_nullable_to_non_nullable
              as WorkoutSummary?,
      next7Days: null == next7Days
          ? _value.next7Days
          : next7Days // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSummary>,
      conversationHistory: null == conversationHistory
          ? _value.conversationHistory
          : conversationHistory // ignore: cast_nullable_to_non_nullable
              as List<ConversationMessage>,
      currentPainLevel: freezed == currentPainLevel
          ? _value.currentPainLevel
          : currentPainLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      sleepQuality: freezed == sleepQuality
          ? _value.sleepQuality
          : sleepQuality // ignore: cast_nullable_to_non_nullable
              as String?,
      weather: freezed == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of ShortTermContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutSummaryCopyWith<$Res>? get todayWorkout {
    if (_value.todayWorkout == null) {
      return null;
    }

    return $WorkoutSummaryCopyWith<$Res>(_value.todayWorkout!, (value) {
      return _then(_value.copyWith(todayWorkout: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ShortTermContextImplCopyWith<$Res>
    implements $ShortTermContextCopyWith<$Res> {
  factory _$$ShortTermContextImplCopyWith(_$ShortTermContextImpl value,
          $Res Function(_$ShortTermContextImpl) then) =
      __$$ShortTermContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime currentDate,
      WorkoutSummary? todayWorkout,
      List<WorkoutSummary> next7Days,
      List<ConversationMessage> conversationHistory,
      int? currentPainLevel,
      String? sleepQuality,
      String? weather});

  @override
  $WorkoutSummaryCopyWith<$Res>? get todayWorkout;
}

/// @nodoc
class __$$ShortTermContextImplCopyWithImpl<$Res>
    extends _$ShortTermContextCopyWithImpl<$Res, _$ShortTermContextImpl>
    implements _$$ShortTermContextImplCopyWith<$Res> {
  __$$ShortTermContextImplCopyWithImpl(_$ShortTermContextImpl _value,
      $Res Function(_$ShortTermContextImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShortTermContext
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDate = null,
    Object? todayWorkout = freezed,
    Object? next7Days = null,
    Object? conversationHistory = null,
    Object? currentPainLevel = freezed,
    Object? sleepQuality = freezed,
    Object? weather = freezed,
  }) {
    return _then(_$ShortTermContextImpl(
      currentDate: null == currentDate
          ? _value.currentDate
          : currentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      todayWorkout: freezed == todayWorkout
          ? _value.todayWorkout
          : todayWorkout // ignore: cast_nullable_to_non_nullable
              as WorkoutSummary?,
      next7Days: null == next7Days
          ? _value._next7Days
          : next7Days // ignore: cast_nullable_to_non_nullable
              as List<WorkoutSummary>,
      conversationHistory: null == conversationHistory
          ? _value._conversationHistory
          : conversationHistory // ignore: cast_nullable_to_non_nullable
              as List<ConversationMessage>,
      currentPainLevel: freezed == currentPainLevel
          ? _value.currentPainLevel
          : currentPainLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      sleepQuality: freezed == sleepQuality
          ? _value.sleepQuality
          : sleepQuality // ignore: cast_nullable_to_non_nullable
              as String?,
      weather: freezed == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShortTermContextImpl implements _ShortTermContext {
  const _$ShortTermContextImpl(
      {required this.currentDate,
      this.todayWorkout,
      required final List<WorkoutSummary> next7Days,
      required final List<ConversationMessage> conversationHistory,
      this.currentPainLevel,
      this.sleepQuality,
      this.weather})
      : _next7Days = next7Days,
        _conversationHistory = conversationHistory;

  factory _$ShortTermContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShortTermContextImplFromJson(json);

  @override
  final DateTime currentDate;
  @override
  final WorkoutSummary? todayWorkout;
  final List<WorkoutSummary> _next7Days;
  @override
  List<WorkoutSummary> get next7Days {
    if (_next7Days is EqualUnmodifiableListView) return _next7Days;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_next7Days);
  }

  final List<ConversationMessage> _conversationHistory;
  @override
  List<ConversationMessage> get conversationHistory {
    if (_conversationHistory is EqualUnmodifiableListView)
      return _conversationHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversationHistory);
  }

  @override
  final int? currentPainLevel;
  @override
  final String? sleepQuality;
  @override
  final String? weather;

  @override
  String toString() {
    return 'ShortTermContext(currentDate: $currentDate, todayWorkout: $todayWorkout, next7Days: $next7Days, conversationHistory: $conversationHistory, currentPainLevel: $currentPainLevel, sleepQuality: $sleepQuality, weather: $weather)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShortTermContextImpl &&
            (identical(other.currentDate, currentDate) ||
                other.currentDate == currentDate) &&
            (identical(other.todayWorkout, todayWorkout) ||
                other.todayWorkout == todayWorkout) &&
            const DeepCollectionEquality()
                .equals(other._next7Days, _next7Days) &&
            const DeepCollectionEquality()
                .equals(other._conversationHistory, _conversationHistory) &&
            (identical(other.currentPainLevel, currentPainLevel) ||
                other.currentPainLevel == currentPainLevel) &&
            (identical(other.sleepQuality, sleepQuality) ||
                other.sleepQuality == sleepQuality) &&
            (identical(other.weather, weather) || other.weather == weather));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentDate,
      todayWorkout,
      const DeepCollectionEquality().hash(_next7Days),
      const DeepCollectionEquality().hash(_conversationHistory),
      currentPainLevel,
      sleepQuality,
      weather);

  /// Create a copy of ShortTermContext
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShortTermContextImplCopyWith<_$ShortTermContextImpl> get copyWith =>
      __$$ShortTermContextImplCopyWithImpl<_$ShortTermContextImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShortTermContextImplToJson(
      this,
    );
  }
}

abstract class _ShortTermContext implements ShortTermContext {
  const factory _ShortTermContext(
      {required final DateTime currentDate,
      final WorkoutSummary? todayWorkout,
      required final List<WorkoutSummary> next7Days,
      required final List<ConversationMessage> conversationHistory,
      final int? currentPainLevel,
      final String? sleepQuality,
      final String? weather}) = _$ShortTermContextImpl;

  factory _ShortTermContext.fromJson(Map<String, dynamic> json) =
      _$ShortTermContextImpl.fromJson;

  @override
  DateTime get currentDate;
  @override
  WorkoutSummary? get todayWorkout;
  @override
  List<WorkoutSummary> get next7Days;
  @override
  List<ConversationMessage> get conversationHistory;
  @override
  int? get currentPainLevel;
  @override
  String? get sleepQuality;
  @override
  String? get weather;

  /// Create a copy of ShortTermContext
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShortTermContextImplCopyWith<_$ShortTermContextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
