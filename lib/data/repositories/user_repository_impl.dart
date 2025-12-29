import '../../features/shared/domain/entities/user.dart';
import '../../features/shared/domain/repositories/user_repository.dart';
import '../datasources/local/daos/user_dao.dart';
import '../models/user_mapper.dart'; // Import the mapper

class UserRepositoryImpl implements UserRepository {
  final UserDao _dao;

  UserRepositoryImpl(this._dao);

  @override
  Future<User> createUser(User user) async {
    // Phase 1: Single user, ID 1.
    // If we were creating a NEW user, we'd use auto-increment, but for logic consistency
    // we'll assume the user being passed in might not have a valid ID yet.
    // However, clean architecture says Domain entities should have IDs.
    // We can ignore the ID in the entity and let the DB assign it, then return a new Entity with the DB ID.

    // For now, let's map it to a companion without ID (or absent ID)
    // The mapper handles JSON serialization

    // But wait, user_mapper.dart defined `toDTO` and `toCompanion`.
    // `toDTO` returns a full object which might need all fields.
    // Let's us the companion approach for inserts to be safe with auto-increments.
    final companion = user.toCompanion();

    await _dao.insertUser(companion);

    // Fetch the fresh user
    final freshUser = await _dao.getUser();
    if (freshUser == null) throw Exception('Failed to create user');
    return freshUser.toEntity();
  }

  @override
  Future<User?> getCurrentUser() async {
    final dto = await _dao.getUser();
    return dto?.toEntity();
  }

  @override
  Future<void> updateUser(User user) async {
    final dto = user.toDTO();
    // In Drift, replace will look for the primary key (id)
    await _dao.updateUser(dto);
  }

  @override
  Future<void> updateAvailableDays(List<String> days) async {
    await _dao.updateAvailableDays(days);
  }

  @override
  Future<void> updateHealthPermissions(bool granted) async {
    // Fetch current, update field, save back.
    // Or use custom query. Since we have single user, let's just use a specialized DAO method if it existed,
    // or generic update.
    // For simplicity/robustness without adding more DAO methods:
    final userDTO = await _dao.getUser();
    if (userDTO != null) {
      final updatedUser = userDTO.copyWith(healthPermissionsGranted: granted);
      await _dao.updateUser(updatedUser);
    }
  }
}
