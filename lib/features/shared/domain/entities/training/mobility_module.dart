import 'package:freezed_annotation/freezed_annotation.dart';

part 'mobility_module.freezed.dart';
part 'mobility_module.g.dart';

@freezed
class MobilityModule with _$MobilityModule {
  const factory MobilityModule({
    required String id,
    required String workoutId,
    required String exerciseName,
    required String targetJoint,
    required String setupInstructions,
    required int totalCycles,
    required List<MobilityPhase> phases,
  }) = _MobilityModule;

  factory MobilityModule.fromJson(Map<String, dynamic> json) =>
      _$MobilityModuleFromJson(json);
}

@freezed
class MobilityPhase with _$MobilityPhase {
  const factory MobilityPhase({
    required String id,
    required String moduleId,
    required String phaseType,
    int? durationSeconds,
    int? reps,
    int? holdTimeSeconds,
    String? instruction,
    String? intensityNotes,
    int? irradiationPct,
    String? notes,
    required int sequenceOrder,
  }) = _MobilityPhase;

  factory MobilityPhase.fromJson(Map<String, dynamic> json) =>
      _$MobilityPhaseFromJson(json);
}
