import 'package:freezed_annotation/freezed_annotation.dart';

part 'goal.freezed.dart';
part 'goal.g.dart';

enum GoalType { distanceMilestone, timePerformance, event, maintenance }

@freezed
class Goal with _$Goal {
  const factory Goal({
    required String id,
    required String userId,
    required GoalType type,
    required String name,
    @Default(true) bool isActive,
    double? targetDistance,
    DateTime? targetDate,
    int? targetTime,
    int? currentBestTime,
    String? eventName,
    DateTime? eventDate,
    int? maintenanceFrequency,
    int? maintenanceDuration,
    DateTime? endDate,
    @Default(0.0) double confidence,
    @Default(0.0) double adherenceScore,
    @Default(0.0) double qualityScore,
    @Default(0.0) double consistencyScore,
    @Default(0.0) double recoveryScore,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Goal;

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);
}
