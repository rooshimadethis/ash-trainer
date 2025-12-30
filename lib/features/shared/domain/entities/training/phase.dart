import 'package:freezed_annotation/freezed_annotation.dart';

part 'phase.freezed.dart';
part 'phase.g.dart';

@freezed
class Phase with _$Phase {
  const factory Phase({
    required String id,
    required String goalId,
    required int phaseNumber,
    required String phaseType, // 'base', 'build', 'peak', 'taper', 'recovery'
    required int durationWeeks,
    required String targetWeeklyVolume,
    required String targetWeeklyDuration,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
  }) = _Phase;

  factory Phase.fromJson(Map<String, dynamic> json) => _$PhaseFromJson(json);
}
