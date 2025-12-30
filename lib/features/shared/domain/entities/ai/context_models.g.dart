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
      trainingPhilosophy: json['trainingPhilosophy'] as String,
    );

Map<String, dynamic> _$$PlanGenerationContextImplToJson(
        _$PlanGenerationContextImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'goal': instance.goal,
      'trainingHistory': instance.trainingHistory,
      'trainingPhilosophy': instance.trainingPhilosophy,
    };

_$UserContextImpl _$$UserContextImplFromJson(Map<String, dynamic> json) =>
    _$UserContextImpl(
      age: (json['age'] as num).toInt(),
      gender: json['gender'] as String,
      availableDays: (json['availableDays'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      timeConstraints: Map<String, int>.from(json['timeConstraints'] as Map),
      injuryHistory: (json['injuryHistory'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      weeklyTrainingFrequency:
          (json['weeklyTrainingFrequency'] as num?)?.toInt(),
      weeklyVolume: (json['weeklyVolume'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$UserContextImplToJson(_$UserContextImpl instance) =>
    <String, dynamic>{
      'age': instance.age,
      'gender': instance.gender,
      'availableDays': instance.availableDays,
      'timeConstraints': instance.timeConstraints,
      'injuryHistory': instance.injuryHistory,
      'weeklyTrainingFrequency': instance.weeklyTrainingFrequency,
      'weeklyVolume': instance.weeklyVolume,
    };

_$GoalContextImpl _$$GoalContextImplFromJson(Map<String, dynamic> json) =>
    _$GoalContextImpl(
      type: json['type'] as String,
      target: json['target'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
      confidence: (json['confidence'] as num).toDouble(),
      specialInstructions: (json['specialInstructions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      currentPace: json['currentPace'] as String?,
      isFirstTime: json['isFirstTime'] as bool?,
      daysUntilGoal: (json['daysUntilGoal'] as num?)?.toInt(),
      currentBestTime: (json['currentBestTime'] as num?)?.toInt(),
      eventName: json['eventName'] as String?,
      runningPriority: json['runningPriority'] as String?,
      strengthPriority: json['strengthPriority'] as String?,
      mobilityPriority: json['mobilityPriority'] as String?,
    );

Map<String, dynamic> _$$GoalContextImplToJson(_$GoalContextImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'target': instance.target,
      'deadline': instance.deadline.toIso8601String(),
      'confidence': instance.confidence,
      'specialInstructions': instance.specialInstructions,
      'currentPace': instance.currentPace,
      'isFirstTime': instance.isFirstTime,
      'daysUntilGoal': instance.daysUntilGoal,
      'currentBestTime': instance.currentBestTime,
      'eventName': instance.eventName,
      'runningPriority': instance.runningPriority,
      'strengthPriority': instance.strengthPriority,
      'mobilityPriority': instance.mobilityPriority,
    };

_$WorkoutSummaryImpl _$$WorkoutSummaryImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutSummaryImpl(
      date: DateTime.parse(json['date'] as String),
      type: json['type'] as String,
      duration: (json['duration'] as num).toInt(),
      distance: (json['distance'] as num?)?.toDouble(),
      rpe: (json['rpe'] as num?)?.toInt(),
      completed: json['completed'] as bool,
    );

Map<String, dynamic> _$$WorkoutSummaryImplToJson(
        _$WorkoutSummaryImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'type': instance.type,
      'duration': instance.duration,
      'distance': instance.distance,
      'rpe': instance.rpe,
      'completed': instance.completed,
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
