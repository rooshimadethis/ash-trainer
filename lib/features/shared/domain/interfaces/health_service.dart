abstract class HealthService {
  /// Requests permissions to access health data.
  /// Returns [true] if permissions are granted, [false] otherwise.
  Future<bool> requestPermissions();

  /// Checks if health permissions are currently granted.
  Future<bool> hasPermissions();
}
