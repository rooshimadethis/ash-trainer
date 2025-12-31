import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_block.freezed.dart';
part 'training_block.g.dart';

@freezed
class TrainingBlock with _$TrainingBlock {
  const factory TrainingBlock({
    required String id,
    required String phaseId,
    required int blockNumber,
    required String intent,
    required int durationDays,
    DateTime? startDate,
    DateTime? endDate,
    @Default(0.0) double actualDistance,
    @Default(0) int actualDuration,
  }) = _TrainingBlock;

  factory TrainingBlock.fromJson(Map<String, dynamic> json) =>
      _$TrainingBlockFromJson(json);
}
