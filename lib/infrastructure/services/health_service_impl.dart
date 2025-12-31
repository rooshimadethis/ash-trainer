import 'dart:io';
import 'package:health/health.dart';
import '../../features/shared/domain/services/health_service.dart';

class HealthServiceImpl implements HealthService {
  final Health _health = Health();

  /// Get platform-specific health data types
  /// iOS supports SDNN, Android supports RMSSD
  List<HealthDataType> get _platformTypes {
    final baseTypes = [
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.RESTING_HEART_RATE,
    ];

    if (Platform.isIOS) {
      return [...baseTypes, HealthDataType.HEART_RATE_VARIABILITY_SDNN];
    } else if (Platform.isAndroid) {
      return [...baseTypes, HealthDataType.HEART_RATE_VARIABILITY_RMSSD];
    }

    // Fallback: include both
    return [
      ...baseTypes,
      HealthDataType.HEART_RATE_VARIABILITY_SDNN,
      HealthDataType.HEART_RATE_VARIABILITY_RMSSD,
    ];
  }

  @override
  Future<bool> requestPermissions() async {
    try {
      final types = _platformTypes;
      final permissions = types.map((type) => HealthDataAccess.READ).toList();

      return await _health.requestAuthorization(types,
          permissions: permissions);
    } catch (e) {
      // ignore: avoid_print
      print('Error requesting health permissions: $e');
      return false;
    }
  }

  @override
  Future<bool> hasPermissions() async {
    try {
      final types = _platformTypes;
      final permissions = types.map((type) => HealthDataAccess.READ).toList();

      // Check each permission individually to allow partial access
      for (int i = 0; i < types.length; i++) {
        final has = await _health
            .hasPermissions([types[i]], permissions: [permissions[i]]);
        if (has ?? false) return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<HealthData?> fetchTodaysHealthData() async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final healthData = await _health.getHealthDataFromTypes(
        types: _platformTypes,
        startTime: startOfDay,
        endTime: endOfDay,
      );

      print('Health data points fetched: ${healthData.length}');

      int? sleepDuration;
      double? hrv;
      int? rhr;

      for (var point in healthData) {
        final value = point.value;
        print('Point: ${point.type}, Value: $value');
        if (value is NumericHealthValue) {
          if (point.type == HealthDataType.SLEEP_ASLEEP) {
            // Sleep duration is in minutes
            sleepDuration = value.numericValue.toInt();
          } else if (point.type == HealthDataType.HEART_RATE_VARIABILITY_SDNN ||
              point.type == HealthDataType.HEART_RATE_VARIABILITY_RMSSD) {
            // HRV in milliseconds (both SDNN and RMSSD)
            // Use whichever value is available from the platform
            hrv = value.numericValue.toDouble();
          } else if (point.type == HealthDataType.RESTING_HEART_RATE) {
            // RHR in bpm
            rhr = value.numericValue.toInt();
          }
        }
      }

      print('Parsed Health Data - Sleep: $sleepDuration, HRV: $hrv, RHR: $rhr');

      // Return null if no data at all
      if (sleepDuration == null && hrv == null && rhr == null) {
        print('No health data parsed, returning null');
        return null;
      }

      return HealthData(
        sleepDuration: sleepDuration,
        hrv: hrv,
        rhr: rhr,
      );
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching health data: $e');
      return null;
    }
  }
}
