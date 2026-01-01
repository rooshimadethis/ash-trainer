import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/domain/entities/biomarker.dart';
import '../../../../data/providers/repository_providers.dart';
import '../../../../infrastructure/providers/service_providers.dart';
import '../../application/usecases/sync_health_data.dart';

part 'biomarkers_provider.g.dart';

@riverpod
Future<bool> healthAuthorized(Ref ref) async {
  final healthService = ref.watch(healthServiceProvider);
  return healthService.hasPermissions();
}

/// Provider for today's biomarkers (reactive stream)
@riverpod
Stream<Biomarker?> todaysBiomarkers(Ref ref) {
  final repo = ref.watch(biomarkerRepositoryProvider);
  return repo.watchTodaysBiomarkers();
}

/// Provider for syncing health data
@riverpod
class HealthSync extends _$HealthSync {
  @override
  FutureOr<void> build() async {
    // Auto-sync on build
    await _syncHealthData();
  }

  Future<void> _syncHealthData() async {
    final healthService = ref.read(healthServiceProvider);
    final biomarkerRepo = ref.read(biomarkerRepositoryProvider);

    final syncUseCase = SyncHealthData(healthService, biomarkerRepo, 1);
    await syncUseCase.call();
  }

  /// Manual refresh method
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    // Invalidate authorization status too
    ref.invalidate(healthAuthorizedProvider);
    state = await AsyncValue.guard(() async {
      await _syncHealthData();
    });
  }
}
