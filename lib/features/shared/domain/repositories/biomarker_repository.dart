import '../entities/biomarker.dart';

/// Repository interface for biomarker data access
abstract class BiomarkerRepository {
  /// Watch today's biomarkers (reactive stream)
  /// Returns a stream that emits whenever today's biomarker data changes
  Stream<Biomarker?> watchTodaysBiomarkers();

  /// Save biomarkers to database
  /// Uses upsert pattern - updates if exists, inserts if not
  Future<void> saveBiomarkers(Biomarker biomarker);
}
