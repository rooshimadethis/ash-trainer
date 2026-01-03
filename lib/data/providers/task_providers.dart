import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/providers/service_providers.dart';
import '../datasources/local/drift_database.dart';

final aiTaskDaoProvider = Provider((ref) {
  final db = ref.watch(driftDatabaseProvider);
  return db.aiTaskDao;
});

final activeAITasksProvider = StreamProvider<List<AiTaskDTO>>((ref) async* {
  final dao = ref.watch(aiTaskDaoProvider);
  // Periodic polling to catch updates from background isolates
  while (true) {
    final tasks = await dao.watchActiveTasks().first;
    yield tasks;
    await Future.delayed(const Duration(seconds: 2));
  }
});

final isTaskRunningForGoalProvider =
    Provider.family<bool, String>((ref, goalId) {
  final tasks = ref.watch(activeAITasksProvider).value ?? [];
  return tasks.any((t) => t.targetId == goalId);
});

final isAnyAIProcessingProvider = Provider<bool>((ref) {
  final tasks = ref.watch(activeAITasksProvider).value ?? [];
  return tasks.isNotEmpty;
});
