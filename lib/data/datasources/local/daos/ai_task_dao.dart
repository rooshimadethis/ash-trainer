import 'package:drift/drift.dart';
import '../drift_database.dart';
import '../tables/ai_tasks_table.dart';

part 'ai_task_dao.g.dart';

@DriftAccessor(tables: [AiTasks])
class AiTaskDao extends DatabaseAccessor<AppDatabase> with _$AiTaskDaoMixin {
  AiTaskDao(super.db);

  Future<void> upsertTask(AiTasksCompanion row) {
    return into(aiTasks).insertOnConflictUpdate(row);
  }

  Future<void> deleteTask(String id) {
    return (delete(aiTasks)..where((t) => t.id.equals(id))).go();
  }

  Stream<AiTaskDTO?> watchTask(String id) {
    return (select(aiTasks)..where((t) => t.id.equals(id))).watchSingleOrNull();
  }

  Stream<List<AiTaskDTO>> watchActiveTasks() {
    return (select(aiTasks)..where((t) => t.status.equals('running'))).watch();
  }

  Future<AiTaskDTO?> getTask(String id) {
    return (select(aiTasks)..where((t) => t.id.equals(id))).getSingleOrNull();
  }
}
