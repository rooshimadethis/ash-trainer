import 'package:freezed_annotation/freezed_annotation.dart';

part 'strength_exercise.freezed.dart';
part 'strength_exercise.g.dart';

@freezed
class StrengthExercise with _$StrengthExercise {
  const factory StrengthExercise({
    required String id,
    required String workoutId,
    required String name,
    required int sets,
    required String reps,
    required int rpe,
    String? notes,
  }) = _StrengthExercise;

  factory StrengthExercise.fromJson(Map<String, dynamic> json) =>
      _$StrengthExerciseFromJson(json);
}
