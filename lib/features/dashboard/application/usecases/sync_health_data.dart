import '../../../shared/domain/repositories/biomarker_repository.dart';
import '../../../shared/domain/services/health_service.dart';

/// Use case for syncing health data from Health Connect/HealthKit to local database
class SyncHealthData {
  final HealthService _healthService;
  final BiomarkerRepository _biomarkerRepository;
  final int _userId; // Single-user assumption

  SyncHealthData(
    this._healthService,
    this._biomarkerRepository,
    this._userId,
  );

  /// Fetch today's health data and save to database
  Future<void> call() async {
    final healthData = await _healthService.fetchTodaysHealthData();

    if (healthData != null) {
      final biomarker = healthData.toBiomarker(_userId);
      await _biomarkerRepository.saveBiomarkers(biomarker);
    }
  }
}
