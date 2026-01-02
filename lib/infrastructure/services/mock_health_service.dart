import 'dart:math';
import '../../features/shared/domain/services/health_service.dart';

class MockHealthService implements HealthService {
  final _random = Random();

  @override
  Future<bool> requestPermissions() async {
    return true;
  }

  @override
  Future<bool> hasPermissions() async {
    return true;
  }

  @override
  Future<HealthData?> fetchTodaysHealthData() async {
    // Return realistic mock data
    return HealthData(
      sleepDuration: 420 + _random.nextInt(120), // 7h - 9h
      hrv: 45.0 + _random.nextDouble() * 40.0, // 45 - 85 ms
      rhr: 50 + _random.nextInt(15), // 50 - 65 bpm
    );
  }

  @override
  Future<List<ExternalWorkout>> fetchTodaysWorkouts() async {
    // Optionally return a mock workout
    return [
      ExternalWorkout(
        id: 'mock-1',
        type: 'Running',
        startTime: DateTime.now().subtract(const Duration(hours: 2)),
        endTime: DateTime.now().subtract(const Duration(hours: 1)),
        durationSeconds: 3600,
        distanceKm: 8.5,
        energryBurnedKcal: 650,
        sourceName: 'Mock Watch',
      ),
    ];
  }
}
