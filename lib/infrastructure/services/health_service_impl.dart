import 'package:health/health.dart';
import '../../features/shared/domain/interfaces/health_service.dart';
import '../../core/utils/logger.dart';

class HealthServiceImpl implements HealthService {
  final Health _health = Health();

  static final _types = [
    HealthDataType.STEPS,
    HealthDataType.HEART_RATE,
    HealthDataType.SLEEP_SESSION,
    HealthDataType.WORKOUT,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.DISTANCE_DELTA,
  ];

  @override
  Future<bool> requestPermissions() async {
    try {
      await _health.configure();
      final requested = await _health.requestAuthorization(_types);
      return requested;
    } catch (e, stack) {
      AppLogger.error('Failed to request health permissions', e, stack);
      return false;
    }
  }

  @override
  Future<bool> hasPermissions() async {
    try {
      // The 'health' package doesn't have a direct 'hasPermissions' check that works consistently across platforms without requesting.
      // Typically, requestAuthorization returns true if already granted.
      // For now, we will assume we need to request if we aren't sure.
      // But let's use hasPermissions if available or just return false to force a check.
      // Actually, hasPermissions checks if *all* are granted.
      return await _health.hasPermissions(_types) ?? false;
    } catch (e) {
      return false;
    }
  }
}
