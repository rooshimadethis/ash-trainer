import 'package:drift/drift.dart';

@DataClassName('AiTaskDTO')
class AiTasks extends Table {
  TextColumn get id =>
      text()(); // Unique ID for the task (e.g., com.ash_trainer.plan_gen_123)
  TextColumn get taskType => text()(); // 'plan_generation', 'repair', 'adjust'
  TextColumn get status =>
      text()(); // 'pending', 'running', 'completed', 'failed'
  TextColumn get targetId => text().nullable()(); // E.g., goalId or workoutId
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
