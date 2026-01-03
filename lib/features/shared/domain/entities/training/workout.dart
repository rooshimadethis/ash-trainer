import 'package:freezed_annotation/freezed_annotation.dart';
import 'strength_exercise.dart';
import 'mobility_module.dart';

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
    int? intensity, // Planned RPE (1-10)
    String? description,
    required String
        status, // 'planned', 'in_progress', 'completed', 'skipped', 'missed'
    int? actualDuration,
    double? actualDistance,
    double? actualPace,
    int? rpe,
    String? syncedFrom,
    @Default(false) bool isKey,
    DateTime? completedAt,
    List<StrengthExercise>? strengthExercises,
    List<MobilityModule>? mobilitySequence,
  }) = _Workout;

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);
}
