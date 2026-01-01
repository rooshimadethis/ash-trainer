// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Goal _$GoalFromJson(Map<String, dynamic> json) {
  return _Goal.fromJson(json);
}

/// @nodoc
mixin _$Goal {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  GoalType get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  double? get targetDistance => throw _privateConstructorUsedError;
  DateTime? get targetDate => throw _privateConstructorUsedError;
  int? get targetTime => throw _privateConstructorUsedError;
  int? get currentBestTime => throw _privateConstructorUsedError;
  bool? get isFirstTime => throw _privateConstructorUsedError;
  String? get eventName => throw _privateConstructorUsedError;
  DateTime? get eventDate => throw _privateConstructorUsedError;
  int? get maintenanceFrequency => throw _privateConstructorUsedError;
  int? get maintenanceDuration => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  int? get initialTrainingFrequency => throw _privateConstructorUsedError;
  double? get initialWeeklyVolume =>
      throw _privateConstructorUsedError; // In km
  String? get runningPriority => throw _privateConstructorUsedError;
  String? get strengthPriority => throw _privateConstructorUsedError;
  String? get mobilityPriority => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  double get adherenceScore => throw _privateConstructorUsedError;
  double get qualityScore => throw _privateConstructorUsedError;
  double get consistencyScore => throw _privateConstructorUsedError;
  double get recoveryScore => throw _privateConstructorUsedError;
  String? get rationaleOverallApproach => throw _privateConstructorUsedError;
  String? get rationaleIntensityDistribution =>
      throw _privateConstructorUsedError;
  String? get rationaleKeyWorkouts => throw _privateConstructorUsedError;
  String? get rationaleRecoveryStrategy => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Goal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GoalCopyWith<Goal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GoalCopyWith<$Res> {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) then) =
      _$GoalCopyWithImpl<$Res, Goal>;
  @useResult
  $Res call(
      {String id,
      String userId,
      GoalType type,
      String name,
      bool isActive,
      double? targetDistance,
      DateTime? targetDate,
      int? targetTime,
      int? currentBestTime,
      bool? isFirstTime,
      String? eventName,
      DateTime? eventDate,
      int? maintenanceFrequency,
      int? maintenanceDuration,
      DateTime? endDate,
      int? initialTrainingFrequency,
      double? initialWeeklyVolume,
      String? runningPriority,
      String? strengthPriority,
      String? mobilityPriority,
      double confidence,
      double adherenceScore,
      double qualityScore,
      double consistencyScore,
      double recoveryScore,
      String? rationaleOverallApproach,
      String? rationaleIntensityDistribution,
      String? rationaleKeyWorkouts,
      String? rationaleRecoveryStrategy,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$GoalCopyWithImpl<$Res, $Val extends Goal>
    implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? name = null,
    Object? isActive = null,
    Object? targetDistance = freezed,
    Object? targetDate = freezed,
    Object? targetTime = freezed,
    Object? currentBestTime = freezed,
    Object? isFirstTime = freezed,
    Object? eventName = freezed,
    Object? eventDate = freezed,
    Object? maintenanceFrequency = freezed,
    Object? maintenanceDuration = freezed,
    Object? endDate = freezed,
    Object? initialTrainingFrequency = freezed,
    Object? initialWeeklyVolume = freezed,
    Object? runningPriority = freezed,
    Object? strengthPriority = freezed,
    Object? mobilityPriority = freezed,
    Object? confidence = null,
    Object? adherenceScore = null,
    Object? qualityScore = null,
    Object? consistencyScore = null,
    Object? recoveryScore = null,
    Object? rationaleOverallApproach = freezed,
    Object? rationaleIntensityDistribution = freezed,
    Object? rationaleKeyWorkouts = freezed,
    Object? rationaleRecoveryStrategy = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
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
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GoalType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      targetDistance: freezed == targetDistance
          ? _value.targetDistance
          : targetDistance // ignore: cast_nullable_to_non_nullable
              as double?,
      targetDate: freezed == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      targetTime: freezed == targetTime
          ? _value.targetTime
          : targetTime // ignore: cast_nullable_to_non_nullable
              as int?,
      currentBestTime: freezed == currentBestTime
          ? _value.currentBestTime
          : currentBestTime // ignore: cast_nullable_to_non_nullable
              as int?,
      isFirstTime: freezed == isFirstTime
          ? _value.isFirstTime
          : isFirstTime // ignore: cast_nullable_to_non_nullable
              as bool?,
      eventName: freezed == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String?,
      eventDate: freezed == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      maintenanceFrequency: freezed == maintenanceFrequency
          ? _value.maintenanceFrequency
          : maintenanceFrequency // ignore: cast_nullable_to_non_nullable
              as int?,
      maintenanceDuration: freezed == maintenanceDuration
          ? _value.maintenanceDuration
          : maintenanceDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      initialTrainingFrequency: freezed == initialTrainingFrequency
          ? _value.initialTrainingFrequency
          : initialTrainingFrequency // ignore: cast_nullable_to_non_nullable
              as int?,
      initialWeeklyVolume: freezed == initialWeeklyVolume
          ? _value.initialWeeklyVolume
          : initialWeeklyVolume // ignore: cast_nullable_to_non_nullable
              as double?,
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
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      adherenceScore: null == adherenceScore
          ? _value.adherenceScore
          : adherenceScore // ignore: cast_nullable_to_non_nullable
              as double,
      qualityScore: null == qualityScore
          ? _value.qualityScore
          : qualityScore // ignore: cast_nullable_to_non_nullable
              as double,
      consistencyScore: null == consistencyScore
          ? _value.consistencyScore
          : consistencyScore // ignore: cast_nullable_to_non_nullable
              as double,
      recoveryScore: null == recoveryScore
          ? _value.recoveryScore
          : recoveryScore // ignore: cast_nullable_to_non_nullable
              as double,
      rationaleOverallApproach: freezed == rationaleOverallApproach
          ? _value.rationaleOverallApproach
          : rationaleOverallApproach // ignore: cast_nullable_to_non_nullable
              as String?,
      rationaleIntensityDistribution: freezed == rationaleIntensityDistribution
          ? _value.rationaleIntensityDistribution
          : rationaleIntensityDistribution // ignore: cast_nullable_to_non_nullable
              as String?,
      rationaleKeyWorkouts: freezed == rationaleKeyWorkouts
          ? _value.rationaleKeyWorkouts
          : rationaleKeyWorkouts // ignore: cast_nullable_to_non_nullable
              as String?,
      rationaleRecoveryStrategy: freezed == rationaleRecoveryStrategy
          ? _value.rationaleRecoveryStrategy
          : rationaleRecoveryStrategy // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$GoalImplCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$$GoalImplCopyWith(
          _$GoalImpl value, $Res Function(_$GoalImpl) then) =
      __$$GoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      GoalType type,
      String name,
      bool isActive,
      double? targetDistance,
      DateTime? targetDate,
      int? targetTime,
      int? currentBestTime,
      bool? isFirstTime,
      String? eventName,
      DateTime? eventDate,
      int? maintenanceFrequency,
      int? maintenanceDuration,
      DateTime? endDate,
      int? initialTrainingFrequency,
      double? initialWeeklyVolume,
      String? runningPriority,
      String? strengthPriority,
      String? mobilityPriority,
      double confidence,
      double adherenceScore,
      double qualityScore,
      double consistencyScore,
      double recoveryScore,
      String? rationaleOverallApproach,
      String? rationaleIntensityDistribution,
      String? rationaleKeyWorkouts,
      String? rationaleRecoveryStrategy,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$GoalImplCopyWithImpl<$Res>
    extends _$GoalCopyWithImpl<$Res, _$GoalImpl>
    implements _$$GoalImplCopyWith<$Res> {
  __$$GoalImplCopyWithImpl(_$GoalImpl _value, $Res Function(_$GoalImpl) _then)
      : super(_value, _then);

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? name = null,
    Object? isActive = null,
    Object? targetDistance = freezed,
    Object? targetDate = freezed,
    Object? targetTime = freezed,
    Object? currentBestTime = freezed,
    Object? isFirstTime = freezed,
    Object? eventName = freezed,
    Object? eventDate = freezed,
    Object? maintenanceFrequency = freezed,
    Object? maintenanceDuration = freezed,
    Object? endDate = freezed,
    Object? initialTrainingFrequency = freezed,
    Object? initialWeeklyVolume = freezed,
    Object? runningPriority = freezed,
    Object? strengthPriority = freezed,
    Object? mobilityPriority = freezed,
    Object? confidence = null,
    Object? adherenceScore = null,
    Object? qualityScore = null,
    Object? consistencyScore = null,
    Object? recoveryScore = null,
    Object? rationaleOverallApproach = freezed,
    Object? rationaleIntensityDistribution = freezed,
    Object? rationaleKeyWorkouts = freezed,
    Object? rationaleRecoveryStrategy = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$GoalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as GoalType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      targetDistance: freezed == targetDistance
          ? _value.targetDistance
          : targetDistance // ignore: cast_nullable_to_non_nullable
              as double?,
      targetDate: freezed == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      targetTime: freezed == targetTime
          ? _value.targetTime
          : targetTime // ignore: cast_nullable_to_non_nullable
              as int?,
      currentBestTime: freezed == currentBestTime
          ? _value.currentBestTime
          : currentBestTime // ignore: cast_nullable_to_non_nullable
              as int?,
      isFirstTime: freezed == isFirstTime
          ? _value.isFirstTime
          : isFirstTime // ignore: cast_nullable_to_non_nullable
              as bool?,
      eventName: freezed == eventName
          ? _value.eventName
          : eventName // ignore: cast_nullable_to_non_nullable
              as String?,
      eventDate: freezed == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      maintenanceFrequency: freezed == maintenanceFrequency
          ? _value.maintenanceFrequency
          : maintenanceFrequency // ignore: cast_nullable_to_non_nullable
              as int?,
      maintenanceDuration: freezed == maintenanceDuration
          ? _value.maintenanceDuration
          : maintenanceDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      initialTrainingFrequency: freezed == initialTrainingFrequency
          ? _value.initialTrainingFrequency
          : initialTrainingFrequency // ignore: cast_nullable_to_non_nullable
              as int?,
      initialWeeklyVolume: freezed == initialWeeklyVolume
          ? _value.initialWeeklyVolume
          : initialWeeklyVolume // ignore: cast_nullable_to_non_nullable
              as double?,
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
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
      adherenceScore: null == adherenceScore
          ? _value.adherenceScore
          : adherenceScore // ignore: cast_nullable_to_non_nullable
              as double,
      qualityScore: null == qualityScore
          ? _value.qualityScore
          : qualityScore // ignore: cast_nullable_to_non_nullable
              as double,
      consistencyScore: null == consistencyScore
          ? _value.consistencyScore
          : consistencyScore // ignore: cast_nullable_to_non_nullable
              as double,
      recoveryScore: null == recoveryScore
          ? _value.recoveryScore
          : recoveryScore // ignore: cast_nullable_to_non_nullable
              as double,
      rationaleOverallApproach: freezed == rationaleOverallApproach
          ? _value.rationaleOverallApproach
          : rationaleOverallApproach // ignore: cast_nullable_to_non_nullable
              as String?,
      rationaleIntensityDistribution: freezed == rationaleIntensityDistribution
          ? _value.rationaleIntensityDistribution
          : rationaleIntensityDistribution // ignore: cast_nullable_to_non_nullable
              as String?,
      rationaleKeyWorkouts: freezed == rationaleKeyWorkouts
          ? _value.rationaleKeyWorkouts
          : rationaleKeyWorkouts // ignore: cast_nullable_to_non_nullable
              as String?,
      rationaleRecoveryStrategy: freezed == rationaleRecoveryStrategy
          ? _value.rationaleRecoveryStrategy
          : rationaleRecoveryStrategy // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$GoalImpl implements _Goal {
  const _$GoalImpl(
      {required this.id,
      required this.userId,
      required this.type,
      required this.name,
      this.isActive = true,
      this.targetDistance,
      this.targetDate,
      this.targetTime,
      this.currentBestTime,
      this.isFirstTime,
      this.eventName,
      this.eventDate,
      this.maintenanceFrequency,
      this.maintenanceDuration,
      this.endDate,
      this.initialTrainingFrequency,
      this.initialWeeklyVolume,
      this.runningPriority,
      this.strengthPriority,
      this.mobilityPriority,
      this.confidence = 0.0,
      this.adherenceScore = 0.0,
      this.qualityScore = 0.0,
      this.consistencyScore = 0.0,
      this.recoveryScore = 0.0,
      this.rationaleOverallApproach,
      this.rationaleIntensityDistribution,
      this.rationaleKeyWorkouts,
      this.rationaleRecoveryStrategy,
      required this.createdAt,
      required this.updatedAt});

  factory _$GoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoalImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final GoalType type;
  @override
  final String name;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final double? targetDistance;
  @override
  final DateTime? targetDate;
  @override
  final int? targetTime;
  @override
  final int? currentBestTime;
  @override
  final bool? isFirstTime;
  @override
  final String? eventName;
  @override
  final DateTime? eventDate;
  @override
  final int? maintenanceFrequency;
  @override
  final int? maintenanceDuration;
  @override
  final DateTime? endDate;
  @override
  final int? initialTrainingFrequency;
  @override
  final double? initialWeeklyVolume;
// In km
  @override
  final String? runningPriority;
  @override
  final String? strengthPriority;
  @override
  final String? mobilityPriority;
  @override
  @JsonKey()
  final double confidence;
  @override
  @JsonKey()
  final double adherenceScore;
  @override
  @JsonKey()
  final double qualityScore;
  @override
  @JsonKey()
  final double consistencyScore;
  @override
  @JsonKey()
  final double recoveryScore;
  @override
  final String? rationaleOverallApproach;
  @override
  final String? rationaleIntensityDistribution;
  @override
  final String? rationaleKeyWorkouts;
  @override
  final String? rationaleRecoveryStrategy;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Goal(id: $id, userId: $userId, type: $type, name: $name, isActive: $isActive, targetDistance: $targetDistance, targetDate: $targetDate, targetTime: $targetTime, currentBestTime: $currentBestTime, isFirstTime: $isFirstTime, eventName: $eventName, eventDate: $eventDate, maintenanceFrequency: $maintenanceFrequency, maintenanceDuration: $maintenanceDuration, endDate: $endDate, initialTrainingFrequency: $initialTrainingFrequency, initialWeeklyVolume: $initialWeeklyVolume, runningPriority: $runningPriority, strengthPriority: $strengthPriority, mobilityPriority: $mobilityPriority, confidence: $confidence, adherenceScore: $adherenceScore, qualityScore: $qualityScore, consistencyScore: $consistencyScore, recoveryScore: $recoveryScore, rationaleOverallApproach: $rationaleOverallApproach, rationaleIntensityDistribution: $rationaleIntensityDistribution, rationaleKeyWorkouts: $rationaleKeyWorkouts, rationaleRecoveryStrategy: $rationaleRecoveryStrategy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.targetDistance, targetDistance) ||
                other.targetDistance == targetDistance) &&
            (identical(other.targetDate, targetDate) ||
                other.targetDate == targetDate) &&
            (identical(other.targetTime, targetTime) ||
                other.targetTime == targetTime) &&
            (identical(other.currentBestTime, currentBestTime) ||
                other.currentBestTime == currentBestTime) &&
            (identical(other.isFirstTime, isFirstTime) ||
                other.isFirstTime == isFirstTime) &&
            (identical(other.eventName, eventName) ||
                other.eventName == eventName) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.maintenanceFrequency, maintenanceFrequency) ||
                other.maintenanceFrequency == maintenanceFrequency) &&
            (identical(other.maintenanceDuration, maintenanceDuration) ||
                other.maintenanceDuration == maintenanceDuration) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.initialTrainingFrequency, initialTrainingFrequency) ||
                other.initialTrainingFrequency == initialTrainingFrequency) &&
            (identical(other.initialWeeklyVolume, initialWeeklyVolume) ||
                other.initialWeeklyVolume == initialWeeklyVolume) &&
            (identical(other.runningPriority, runningPriority) ||
                other.runningPriority == runningPriority) &&
            (identical(other.strengthPriority, strengthPriority) ||
                other.strengthPriority == strengthPriority) &&
            (identical(other.mobilityPriority, mobilityPriority) ||
                other.mobilityPriority == mobilityPriority) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.adherenceScore, adherenceScore) ||
                other.adherenceScore == adherenceScore) &&
            (identical(other.qualityScore, qualityScore) ||
                other.qualityScore == qualityScore) &&
            (identical(other.consistencyScore, consistencyScore) ||
                other.consistencyScore == consistencyScore) &&
            (identical(other.recoveryScore, recoveryScore) ||
                other.recoveryScore == recoveryScore) &&
            (identical(
                    other.rationaleOverallApproach, rationaleOverallApproach) ||
                other.rationaleOverallApproach == rationaleOverallApproach) &&
            (identical(other.rationaleIntensityDistribution,
                    rationaleIntensityDistribution) ||
                other.rationaleIntensityDistribution ==
                    rationaleIntensityDistribution) &&
            (identical(other.rationaleKeyWorkouts, rationaleKeyWorkouts) ||
                other.rationaleKeyWorkouts == rationaleKeyWorkouts) &&
            (identical(other.rationaleRecoveryStrategy,
                    rationaleRecoveryStrategy) ||
                other.rationaleRecoveryStrategy == rationaleRecoveryStrategy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        type,
        name,
        isActive,
        targetDistance,
        targetDate,
        targetTime,
        currentBestTime,
        isFirstTime,
        eventName,
        eventDate,
        maintenanceFrequency,
        maintenanceDuration,
        endDate,
        initialTrainingFrequency,
        initialWeeklyVolume,
        runningPriority,
        strengthPriority,
        mobilityPriority,
        confidence,
        adherenceScore,
        qualityScore,
        consistencyScore,
        recoveryScore,
        rationaleOverallApproach,
        rationaleIntensityDistribution,
        rationaleKeyWorkouts,
        rationaleRecoveryStrategy,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoalImplCopyWith<_$GoalImpl> get copyWith =>
      __$$GoalImplCopyWithImpl<_$GoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GoalImplToJson(
      this,
    );
  }
}

abstract class _Goal implements Goal {
  const factory _Goal(
      {required final String id,
      required final String userId,
      required final GoalType type,
      required final String name,
      final bool isActive,
      final double? targetDistance,
      final DateTime? targetDate,
      final int? targetTime,
      final int? currentBestTime,
      final bool? isFirstTime,
      final String? eventName,
      final DateTime? eventDate,
      final int? maintenanceFrequency,
      final int? maintenanceDuration,
      final DateTime? endDate,
      final int? initialTrainingFrequency,
      final double? initialWeeklyVolume,
      final String? runningPriority,
      final String? strengthPriority,
      final String? mobilityPriority,
      final double confidence,
      final double adherenceScore,
      final double qualityScore,
      final double consistencyScore,
      final double recoveryScore,
      final String? rationaleOverallApproach,
      final String? rationaleIntensityDistribution,
      final String? rationaleKeyWorkouts,
      final String? rationaleRecoveryStrategy,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$GoalImpl;

  factory _Goal.fromJson(Map<String, dynamic> json) = _$GoalImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  GoalType get type;
  @override
  String get name;
  @override
  bool get isActive;
  @override
  double? get targetDistance;
  @override
  DateTime? get targetDate;
  @override
  int? get targetTime;
  @override
  int? get currentBestTime;
  @override
  bool? get isFirstTime;
  @override
  String? get eventName;
  @override
  DateTime? get eventDate;
  @override
  int? get maintenanceFrequency;
  @override
  int? get maintenanceDuration;
  @override
  DateTime? get endDate;
  @override
  int? get initialTrainingFrequency;
  @override
  double? get initialWeeklyVolume; // In km
  @override
  String? get runningPriority;
  @override
  String? get strengthPriority;
  @override
  String? get mobilityPriority;
  @override
  double get confidence;
  @override
  double get adherenceScore;
  @override
  double get qualityScore;
  @override
  double get consistencyScore;
  @override
  double get recoveryScore;
  @override
  String? get rationaleOverallApproach;
  @override
  String? get rationaleIntensityDistribution;
  @override
  String? get rationaleKeyWorkouts;
  @override
  String? get rationaleRecoveryStrategy;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Goal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoalImplCopyWith<_$GoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
