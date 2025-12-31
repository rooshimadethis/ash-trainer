import 'package:drift/drift.dart';
import '../datasources/local/drift_database.dart';
import '../../features/shared/domain/entities/training/training_block.dart';

extension TrainingBlockMapper on TrainingBlock {
  TrainingBlocksCompanion toCompanion() {
    return TrainingBlocksCompanion.insert(
      id: id,
      phaseId: phaseId,
      blockNumber: blockNumber,
      intent: intent,
      durationDays: durationDays,
      startDate: Value(startDate),
      endDate: Value(endDate),
      actualDistance: Value(actualDistance),
      actualDuration: Value(actualDuration),
    );
  }
}

extension TrainingBlockDTOMapper on TrainingBlockDTO {
  TrainingBlock toEntity() {
    return TrainingBlock(
      id: id,
      phaseId: phaseId,
      blockNumber: blockNumber,
      intent: intent,
      durationDays: durationDays,
      startDate: startDate,
      endDate: endDate,
      actualDistance: actualDistance,
      actualDuration: actualDuration,
    );
  }
}
