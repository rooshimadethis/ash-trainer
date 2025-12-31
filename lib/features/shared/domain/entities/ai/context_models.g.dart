// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'context_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlanGenerationContextImpl _$$PlanGenerationContextImplFromJson(
        Map<String, dynamic> json) =>
    _$PlanGenerationContextImpl(
      user: UserContext.fromJson(json['user'] as Map<String, dynamic>),
      goal: GoalContext.fromJson(json['goal'] as Map<String, dynamic>),
      trainingHistory: (json['trainingHistory'] as List<dynamic>)
          .map((e) => WorkoutSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      config: PlanningConfig.fromJson(json['config'] as Map<String, dynamic>),
      philosophy: PlanGenerationPhilosophy.fromJson(
          json['philosophy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PlanGenerationContextImplToJson(
        _$PlanGenerationContextImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'goal': instance.goal,
      'trainingHistory': instance.trainingHistory,
      'config': instance.config,
      'philosophy': instance.philosophy,
    };

_$PlanningConfigImpl _$$PlanningConfigImplFromJson(Map<String, dynamic> json) =>
    _$PlanningConfigImpl(
      mode: $enumDecode(_$PlanningModeEnumMap, json['mode']),
      startDate: DateTime.parse(json['startDate'] as String),
      upcomingWeekdays: (json['upcomingWeekdays'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      instruction: json['instruction'] as String,
    );

Map<String, dynamic> _$$PlanningConfigImplToJson(
        _$PlanningConfigImpl instance) =>
    <String, dynamic>{
      'mode': _$PlanningModeEnumMap[instance.mode]!,
      'startDate': instance.startDate.toIso8601String(),
      'upcomingWeekdays': instance.upcomingWeekdays,
      'instruction': instance.instruction,
    };

const _$PlanningModeEnumMap = {
  PlanningMode.initial: 'initial',
  PlanningMode.extend: 'extend',
  PlanningMode.repair: 'repair',
};

_$PlanGenerationPhilosophyImpl _$$PlanGenerationPhilosophyImplFromJson(
        Map<String, dynamic> json) =>
    _$PlanGenerationPhilosophyImpl(
      intensityStrategy:
          $enumDecode(_$IntensityStrategyEnumMap, json['intensityStrategy']),
      intensityBreakdown:
          (json['intensityBreakdown'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      maxWeeklyVolumeIncrease:
          (json['maxWeeklyVolumeIncrease'] as num).toDouble(),
      minWeeksBetweenRecovery: (json['minWeeksBetweenRecovery'] as num).toInt(),
      maxWeeksBetweenRecovery: (json['maxWeeksBetweenRecovery'] as num).toInt(),
      recoveryVolumeReduction:
          (json['recoveryVolumeReduction'] as num).toDouble(),
      pillarConstraints: (json['pillarConstraints'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      taperGuidance: json['taperGuidance'] == null
          ? null
          : TaperGuidance.fromJson(
              json['taperGuidance'] as Map<String, dynamic>),
      trainingFocus: json['trainingFocus'] as String,
      workoutStyle: json['workoutStyle'] as String,
      flexibilityLevel: json['flexibilityLevel'] as String,
      strengthGuidance: StrengthGuidance.fromJson(
          json['strengthGuidance'] as Map<String, dynamic>),
      mobilityGuidance: MobilityGuidance.fromJson(
          json['mobilityGuidance'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PlanGenerationPhilosophyImplToJson(
        _$PlanGenerationPhilosophyImpl instance) =>
    <String, dynamic>{
      'intensityStrategy':
          _$IntensityStrategyEnumMap[instance.intensityStrategy]!,
      'intensityBreakdown': instance.intensityBreakdown,
      'maxWeeklyVolumeIncrease': instance.maxWeeklyVolumeIncrease,
      'minWeeksBetweenRecovery': instance.minWeeksBetweenRecovery,
      'maxWeeksBetweenRecovery': instance.maxWeeksBetweenRecovery,
      'recoveryVolumeReduction': instance.recoveryVolumeReduction,
      'pillarConstraints': instance.pillarConstraints,
      'taperGuidance': instance.taperGuidance,
      'trainingFocus': instance.trainingFocus,
      'workoutStyle': instance.workoutStyle,
      'flexibilityLevel': instance.flexibilityLevel,
      'strengthGuidance': instance.strengthGuidance,
      'mobilityGuidance': instance.mobilityGuidance,
    };

const _$IntensityStrategyEnumMap = {
  IntensityStrategy.pyramidal: 'pyramidal',
  IntensityStrategy.polarized: 'polarized',
  IntensityStrategy.maintenance: 'maintenance',
};

_$TaperGuidanceImpl _$$TaperGuidanceImplFromJson(Map<String, dynamic> json) =>
    _$TaperGuidanceImpl(
      strategy: json['strategy'] as String,
      minDurationDays: (json['minDurationDays'] as num).toInt(),
      maxDurationDays: (json['maxDurationDays'] as num).toInt(),
      maintainIntensity: json['maintainIntensity'] as bool,
    );

Map<String, dynamic> _$$TaperGuidanceImplToJson(_$TaperGuidanceImpl instance) =>
    <String, dynamic>{
      'strategy': instance.strategy,
      'minDurationDays': instance.minDurationDays,
      'maxDurationDays': instance.maxDurationDays,
      'maintainIntensity': instance.maintainIntensity,
    };

_$StrengthGuidanceImpl _$$StrengthGuidanceImplFromJson(
        Map<String, dynamic> json) =>
    _$StrengthGuidanceImpl(
      weeklyFrequency: (json['weeklyFrequency'] as num).toInt(),
      sessionDurationMinutes: (json['sessionDurationMinutes'] as num).toInt(),
      setsPerExercise: (json['setsPerExercise'] as num).toInt(),
      repRange: json['repRange'] as String,
    );

Map<String, dynamic> _$$StrengthGuidanceImplToJson(
        _$StrengthGuidanceImpl instance) =>
    <String, dynamic>{
      'weeklyFrequency': instance.weeklyFrequency,
      'sessionDurationMinutes': instance.sessionDurationMinutes,
      'setsPerExercise': instance.setsPerExercise,
      'repRange': instance.repRange,
    };

_$MobilityGuidanceImpl _$$MobilityGuidanceImplFromJson(
        Map<String, dynamic> json) =>
    _$MobilityGuidanceImpl(
      weeklyFrequency: (json['weeklyFrequency'] as num).toInt(),
      sessionDurationMinutes: (json['sessionDurationMinutes'] as num).toInt(),
      sessionTypes: (json['sessionTypes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      focusAreas: (json['focusAreas'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      increaseDuringTaper: json['increaseDuringTaper'] as bool,
    );

Map<String, dynamic> _$$MobilityGuidanceImplToJson(
        _$MobilityGuidanceImpl instance) =>
    <String, dynamic>{
      'weeklyFrequency': instance.weeklyFrequency,
      'sessionDurationMinutes': instance.sessionDurationMinutes,
      'sessionTypes': instance.sessionTypes,
      'focusAreas': instance.focusAreas,
      'increaseDuringTaper': instance.increaseDuringTaper,
    };

_$UserContextImpl _$$UserContextImplFromJson(Map<String, dynamic> json) =>
    _$UserContextImpl(
      age: (json['age'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      availableDays: (json['availableDays'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      constraints: json['constraints'] as String?,
    );

Map<String, dynamic> _$$UserContextImplToJson(_$UserContextImpl instance) =>
    <String, dynamic>{
      'age': instance.age,
      'gender': instance.gender,
      'availableDays': instance.availableDays,
      'constraints': instance.constraints,
    };

_$GoalContextImpl _$$GoalContextImplFromJson(Map<String, dynamic> json) =>
    _$GoalContextImpl(
      type: json['type'] as String,
      target: json['target'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
      currentFitness: json['currentFitness'] as String?,
      initialWeeklyVolume: (json['initialWeeklyVolume'] as num?)?.toDouble(),
      isFirstTime: json['isFirstTime'] as bool?,
      priorities: Map<String, String?>.from(json['priorities'] as Map),
    );

Map<String, dynamic> _$$GoalContextImplToJson(_$GoalContextImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'target': instance.target,
      'deadline': instance.deadline.toIso8601String(),
      'currentFitness': instance.currentFitness,
      'initialWeeklyVolume': instance.initialWeeklyVolume,
      'isFirstTime': instance.isFirstTime,
      'priorities': instance.priorities,
    };

_$WorkoutSummaryImpl _$$WorkoutSummaryImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutSummaryImpl(
      id: json['id'] as String,
      daysAgo: (json['daysAgo'] as num).toInt(),
      type: json['type'] as String,
      isKey: json['isKey'] as bool,
      status: json['status'] as String,
      plannedDuration: (json['plannedDuration'] as num?)?.toInt(),
      actualDuration: (json['actualDuration'] as num?)?.toInt(),
      plannedDistance: (json['plannedDistance'] as num?)?.toDouble(),
      actualDistance: (json['actualDistance'] as num?)?.toDouble(),
      rpe: (json['rpe'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$WorkoutSummaryImplToJson(
        _$WorkoutSummaryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'daysAgo': instance.daysAgo,
      'type': instance.type,
      'isKey': instance.isKey,
      'status': instance.status,
      'plannedDuration': instance.plannedDuration,
      'actualDuration': instance.actualDuration,
      'plannedDistance': instance.plannedDistance,
      'actualDistance': instance.actualDistance,
      'rpe': instance.rpe,
    };

_$CoachingChatContextImpl _$$CoachingChatContextImplFromJson(
        Map<String, dynamic> json) =>
    _$CoachingChatContextImpl(
      longTerm:
          LongTermContext.fromJson(json['longTerm'] as Map<String, dynamic>),
      mediumTerm: MediumTermContext.fromJson(
          json['mediumTerm'] as Map<String, dynamic>),
      shortTerm:
          ShortTermContext.fromJson(json['shortTerm'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CoachingChatContextImplToJson(
        _$CoachingChatContextImpl instance) =>
    <String, dynamic>{
      'longTerm': instance.longTerm,
      'mediumTerm': instance.mediumTerm,
      'shortTerm': instance.shortTerm,
    };

_$LongTermContextImpl _$$LongTermContextImplFromJson(
        Map<String, dynamic> json) =>
    _$LongTermContextImpl(
      user: UserContext.fromJson(json['user'] as Map<String, dynamic>),
      goal: GoalContext.fromJson(json['goal'] as Map<String, dynamic>),
      trainingPhilosophy: json['trainingPhilosophy'] as String,
      overallAdherence: (json['overallAdherence'] as num).toDouble(),
      raceDays: (json['raceDays'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$$LongTermContextImplToJson(
        _$LongTermContextImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'goal': instance.goal,
      'trainingPhilosophy': instance.trainingPhilosophy,
      'overallAdherence': instance.overallAdherence,
      'raceDays': instance.raceDays.map((e) => e.toIso8601String()).toList(),
    };

_$MediumTermContextImpl _$$MediumTermContextImplFromJson(
        Map<String, dynamic> json) =>
    _$MediumTermContextImpl(
      periodStart: DateTime.parse(json['periodStart'] as String),
      periodEnd: DateTime.parse(json['periodEnd'] as String),
      workoutsCompleted: (json['workoutsCompleted'] as num).toInt(),
      workoutsPlanned: (json['workoutsPlanned'] as num).toInt(),
      adherenceRate: (json['adherenceRate'] as num).toDouble(),
      averageRPE: (json['averageRPE'] as num).toDouble(),
      totalDistance: (json['totalDistance'] as num).toDouble(),
      concerns:
          (json['concerns'] as List<dynamic>).map((e) => e as String).toList(),
      achievements: (json['achievements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$MediumTermContextImplToJson(
        _$MediumTermContextImpl instance) =>
    <String, dynamic>{
      'periodStart': instance.periodStart.toIso8601String(),
      'periodEnd': instance.periodEnd.toIso8601String(),
      'workoutsCompleted': instance.workoutsCompleted,
      'workoutsPlanned': instance.workoutsPlanned,
      'adherenceRate': instance.adherenceRate,
      'averageRPE': instance.averageRPE,
      'totalDistance': instance.totalDistance,
      'concerns': instance.concerns,
      'achievements': instance.achievements,
    };

_$ShortTermContextImpl _$$ShortTermContextImplFromJson(
        Map<String, dynamic> json) =>
    _$ShortTermContextImpl(
      currentDate: DateTime.parse(json['currentDate'] as String),
      todayWorkout: json['todayWorkout'] == null
          ? null
          : WorkoutSummary.fromJson(
              json['todayWorkout'] as Map<String, dynamic>),
      next7Days: (json['next7Days'] as List<dynamic>)
          .map((e) => WorkoutSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      conversationHistory: (json['conversationHistory'] as List<dynamic>)
          .map((e) => ConversationMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPainLevel: (json['currentPainLevel'] as num?)?.toInt(),
      sleepQuality: json['sleepQuality'] as String?,
      weather: json['weather'] as String?,
    );

Map<String, dynamic> _$$ShortTermContextImplToJson(
        _$ShortTermContextImpl instance) =>
    <String, dynamic>{
      'currentDate': instance.currentDate.toIso8601String(),
      'todayWorkout': instance.todayWorkout,
      'next7Days': instance.next7Days,
      'conversationHistory': instance.conversationHistory,
      'currentPainLevel': instance.currentPainLevel,
      'sleepQuality': instance.sleepQuality,
      'weather': instance.weather,
    };
