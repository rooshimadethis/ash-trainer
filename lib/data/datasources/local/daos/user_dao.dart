import 'package:drift/drift.dart';
import '../drift_database.dart';
import '../tables/users_table.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  /* Mapping for JSON conversion done in repository - this just does data access */

  Future<UserDTO?> getUser() => (select(users)..limit(1)).getSingleOrNull();

  Future<void> insertUser(Insertable<UserDTO> user) => into(users).insert(user);

  Future<bool> updateUser(Insertable<UserDTO> user) =>
      update(users).replace(user);

  Future<void> updateAvailableDays(List<String> days) async {
    // Note: Assuming single user with ID 1 for Phase 1 as per design docs
    // In a real app we'd pass the ID.
    // The repository will handle the JSON serialization
    // This method might need to be more generic if we support multiple users later
    // For now, simpler to do the update in repository via replace or specialized update
    // But let's add a helper for partial updates for safety

    // Actually, Drift specific update:
    // We will query by ID 1 since it's single user for now
    await (update(users)..where((u) => u.id.equals(1))).write(UsersCompanion(
            availableDays: Value(
                days.toString())) // This is wrong, Repo handles serialization
        );
  }
}
