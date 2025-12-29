import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/shared/domain/repositories/user_repository.dart';
import '../../features/shared/domain/repositories/goal_repository.dart';
import '../../infrastructure/providers/service_providers.dart';
import '../repositories/user_repository_impl.dart';
import '../repositories/goal_repository_impl.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final db = ref.read(driftDatabaseProvider);
  return UserRepositoryImpl(db.userDao);
});

final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  final db = ref.read(driftDatabaseProvider);
  return GoalRepositoryImpl(db.goalDao);
});
