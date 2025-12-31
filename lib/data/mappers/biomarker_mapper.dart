import 'package:drift/drift.dart';
import '../../features/shared/domain/entities/biomarker.dart' as domain;
import '../datasources/local/drift_database.dart';

/// Extension to convert Biomarker (Drift DTO) to domain.Biomarker (Entity)
extension BiomarkerDataMapper on Biomarker {
  domain.Biomarker toEntity() {
    return domain.Biomarker(
      id: id,
      userId: userId,
      date: date,
      sleepDuration: sleepDuration,
      hrv: hrv,
      rhr: rhr,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// Extension to convert domain.Biomarker (Entity) to BiomarkersCompanion (for insert/update)
extension BiomarkerEntityMapper on domain.Biomarker {
  BiomarkersCompanion toCompanion() {
    return BiomarkersCompanion(
      id: Value(id),
      userId: Value(userId),
      date: Value(date),
      sleepDuration: Value(sleepDuration),
      hrv: Value(hrv),
      rhr: Value(rhr),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}
