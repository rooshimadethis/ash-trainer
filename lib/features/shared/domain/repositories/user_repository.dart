import '../entities/user.dart';

abstract class UserRepository {
  /// Creates a new user profile
  Future<User> createUser(User user);

  /// Gets the current user (single-user app)
  Future<User?> getCurrentUser();

  /// Updates user profile
  Future<void> updateUser(User user);

  /// Updates available training days
  Future<void> updateAvailableDays(List<String> days);

  /// Updates health permissions status
  Future<void> updateHealthPermissions(bool granted);
}
