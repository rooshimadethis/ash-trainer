import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/shared/domain/repositories/user_repository.dart';
import '../../features/shared/domain/repositories/goal_repository.dart';
import '../../features/shared/domain/repositories/workout_repository.dart';
import '../../features/shared/domain/repositories/conversation_repository.dart';
import '../../features/shared/domain/repositories/context_repository.dart';
import '../../features/shared/domain/repositories/biomarker_repository.dart';
import '../../features/shared/domain/repositories/time_off_repository.dart';
import '../../infrastructure/providers/service_providers.dart';
import '../repositories/user_repository_impl.dart';
import '../repositories/goal_repository_impl.dart';
import '../repositories/workout_repository_impl.dart';
import '../repositories/conversation_repository_impl.dart';
import '../repositories/context_repository_impl.dart';
import '../repositories/biomarker_repository_impl.dart';
import '../repositories/time_off_repository_impl.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final db = ref.read(driftDatabaseProvider);
  return UserRepositoryImpl(db.userDao);
});

final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  final db = ref.read(driftDatabaseProvider);
  return GoalRepositoryImpl(db.goalDao);
});

final workoutRepositoryProvider = Provider<WorkoutRepository>((ref) {
  final db = ref.read(driftDatabaseProvider);
  return WorkoutRepositoryImpl(db.workoutDao, db.trainingPlanDao);
});

final conversationRepositoryProvider = Provider<ConversationRepository>((ref) {
  final db = ref.read(driftDatabaseProvider);
  return ConversationRepositoryImpl(db.conversationDao);
});

final contextRepositoryProvider = Provider<ContextRepository>((ref) {
  final db = ref.read(driftDatabaseProvider);
  return ContextRepositoryImpl(db.contextDao);
});

final biomarkerRepositoryProvider = Provider<BiomarkerRepository>((ref) {
  final db = ref.read(driftDatabaseProvider);
  // Single-user assumption: userId = 1
  return BiomarkerRepositoryImpl(db.biomarkerDao, 1);
});

final timeOffRepositoryProvider = Provider<TimeOffRepository>((ref) {
  final db = ref.read(driftDatabaseProvider);
  return TimeOffRepositoryImpl(db.timeOffDao);
});
