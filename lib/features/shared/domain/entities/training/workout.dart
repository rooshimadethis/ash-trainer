import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout.freezed.dart';
part 'workout.g.dart';

@freezed
class Workout with _$Workout {
  const factory Workout({
    required String id, // Domain ID (usually matches DB ID, but string)
    required String userId,
    required String goalId,
    String? phaseId,
    String? blockId,
    required DateTime scheduledDate,
    required String type, // 'easy_run', 'tempo', etc.
    required String name,
    required int plannedDuration, // seconds
    double? plannedDistance, // km
    String? intensity,
    String? description,
    required String
        status, // 'planned', 'in_progress', 'completed', 'skipped', 'missed'
    int? actualDuration,
    double? actualDistance,
    double? actualPace,
    int? rpe,
    DateTime? completedAt,
  }) = _Workout;

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);
}
