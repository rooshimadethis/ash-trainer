import 'dart:io';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../features/shared/domain/services/health_service.dart';

class HealthServiceImpl implements HealthService {
  final Health _health = Health();

  /// Get platform-specific health data types
  /// iOS supports SDNN, Android supports RMSSD
  List<HealthDataType> get _platformTypes {
    return [
      HealthDataType.SLEEP_ASLEEP,
      HealthDataType.SLEEP_SESSION,
      HealthDataType.SLEEP_DEEP, // Added for Health Connect coverage
      HealthDataType.SLEEP_LIGHT, // Added for Health Connect coverage
      HealthDataType.SLEEP_REM, // Added for Health Connect coverage
      HealthDataType.SLEEP_AWAKE, // Added for Health Connect coverage
      if (Platform.isIOS) HealthDataType.SLEEP_IN_BED, // Only IOS
      HealthDataType.RESTING_HEART_RATE,
      HealthDataType
          .WORKOUT, // Crucial: add WORKOUT so permissions are requested
      if (Platform.isIOS) HealthDataType.HEART_RATE_VARIABILITY_SDNN,
      if (Platform.isAndroid) HealthDataType.HEART_RATE_VARIABILITY_RMSSD,
    ];
  }

  bool _isConfigured = false;

  Future<void> _ensureConfigured() async {
    if (!_isConfigured) {
      await _health.configure();
      _isConfigured = true;
    }
  }

  @override
  Future<bool> requestPermissions() async {
    try {
      await _ensureConfigured();

      if (Platform.isAndroid) {
        // Activity recognition is required for steps
        await Permission.activityRecognition.request();
        // Location is required for workout distance
        await Permission.location.request();
      }

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
      await _ensureConfigured();

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
      await _ensureConfigured();
      final now = DateTime.now();
      // Broaden search to last 48 hours to ensure we capture RHR and Sleep
      // especially when checking at unconventional times.
      final searchStart = now.subtract(const Duration(hours: 48));
      final searchEnd =
          now.add(const Duration(hours: 1)); // Buffer for very recent data

      // Only search for recovery-related types here
      final recoveryTypes = [
        HealthDataType.SLEEP_ASLEEP,
        HealthDataType.SLEEP_SESSION,
        HealthDataType.SLEEP_DEEP,
        HealthDataType.SLEEP_LIGHT,
        HealthDataType.SLEEP_REM,
        HealthDataType.SLEEP_AWAKE,
        if (Platform.isIOS) HealthDataType.SLEEP_IN_BED,
        HealthDataType.RESTING_HEART_RATE,
        if (Platform.isIOS) HealthDataType.HEART_RATE_VARIABILITY_SDNN,
        if (Platform.isAndroid) HealthDataType.HEART_RATE_VARIABILITY_RMSSD,
      ];

      // ignore: avoid_print
      print(
          'DEBUG: Fetching recovery data (Sleep/HRV/RHR) from $searchStart to $searchEnd');

      final healthData = await _health.getHealthDataFromTypes(
        types: recoveryTypes,
        startTime: searchStart,
        endTime: searchEnd,
      );

      // ignore: avoid_print
      print('DEBUG: Fetched ${healthData.length} recovery data points.');

      int totalSleepMinutes = 0;
      double? hrv;
      int? rhr;

      // Track sleep session to avoid double counting
      bool hasSleepSession = false;

      for (var point in healthData) {
        final value = point.value;
        // ignore: avoid_print
        print(
            'DEBUG: Point: ${point.type}, Value: $value, From: ${point.dateFrom}');

        if (value is NumericHealthValue) {
          final numericVal = value.numericValue.toDouble();

          if (point.type == HealthDataType.RESTING_HEART_RATE) {
            // Keep the most recent RHR
            rhr = numericVal.toInt();
          } else if (point.type == HealthDataType.HEART_RATE_VARIABILITY_SDNN ||
              point.type == HealthDataType.HEART_RATE_VARIABILITY_RMSSD) {
            // Keep the most recent HRV
            hrv = numericVal;
          } else if (point.type == HealthDataType.SLEEP_SESSION) {
            // If we have multiple sessions in 24h, we usually want the largest/most recent.
            // For simplicity, let's take the largest one.
            hasSleepSession = true;
            if (numericVal.toInt() > totalSleepMinutes) {
              totalSleepMinutes = numericVal.toInt();
            }
          } else if (!hasSleepSession) {
            if (point.type == HealthDataType.SLEEP_ASLEEP ||
                point.type == HealthDataType.SLEEP_DEEP ||
                point.type == HealthDataType.SLEEP_LIGHT ||
                point.type == HealthDataType.SLEEP_REM) {
              totalSleepMinutes += numericVal.toInt();
            }
          }
        }
      }

      // ignore: avoid_print
      print(
          'DEBUG: Final results -> Sleep: $totalSleepMinutes min, HRV: $hrv, RHR: $rhr');

      if (totalSleepMinutes == 0 && hrv == null && rhr == null) {
        return null;
      }

      return HealthData(
        sleepDuration: totalSleepMinutes > 0 ? totalSleepMinutes : null,
        hrv: hrv,
        rhr: rhr,
      );
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching health data: $e');
      return null;
    }
  }

  @override
  Future<List<ExternalWorkout>> fetchTodaysWorkouts() async {
    try {
      await _ensureConfigured();
      final now = DateTime.now();
      // Look back 18 hours to catch previous evening sessions for early morning users
      final startTime = now.subtract(const Duration(hours: 18));
      final endTime = now;

      // Ensure we request WORKOUT type
      final types = [HealthDataType.WORKOUT];

      final healthData = await _health.getHealthDataFromTypes(
        types: types,
        startTime: startTime,
        endTime: endTime,
      );

      // Remove duplicates based on ID
      final uniquePoints = <String, HealthDataPoint>{};
      for (var point in healthData) {
        uniquePoints[point.uuid] = point;
      }

      // ignore: avoid_print
      print(
          'DEBUG: Fetched ${uniquePoints.length} unique external workouts from health service window.');

      return uniquePoints.values.map((point) {
        // Safe access to value
        final value = point.value;
        double? distance;
        int? calories;
        String type = 'Workout';

        // Try to extract extra data if available in metadata or value
        // Note: Health package mapping varies.
        // We'll trust the point's main properties for time.

        // For 'WorkoutHealthValue', we cast if possible
        if (value is WorkoutHealthValue) {
          distance = value.totalDistance?.toDouble(); // meters? usually meters.
          calories = value.totalEnergyBurned;
          // Convert meters to km
          if (distance != null) distance = distance / 1000.0;
          type = value.workoutActivityType.name;
        }

        return ExternalWorkout(
          id: point.uuid,
          type: type,
          startTime: point.dateFrom,
          endTime: point.dateTo,
          durationSeconds: point.dateTo.difference(point.dateFrom).inSeconds,
          distanceKm: distance,
          energryBurnedKcal: calories,
          sourceName: point.sourceName,
        );
      }).toList();
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching external workouts: $e');
      return [];
    }
  }
}
