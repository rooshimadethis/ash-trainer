import 'package:workmanager/workmanager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ash_trainer/data/datasources/local/drift_database.dart';
import 'package:ash_trainer/data/repositories/user_repository_impl.dart';
import 'package:ash_trainer/data/repositories/goal_repository_impl.dart';
import 'package:ash_trainer/data/repositories/workout_repository_impl.dart';
import 'package:ash_trainer/data/repositories/time_off_repository_impl.dart';
import 'package:ash_trainer/infrastructure/services/ai_service_impl.dart';
import 'package:ash_trainer/features/training/application/usecases/generate_training_plan.dart';
import 'package:ash_trainer/features/training/application/usecases/build_planning_context.dart';
import 'package:ash_trainer/core/utils/training_plan_scheduler.dart';
import 'package:ash_trainer/features/shared/domain/entities/ai/context_models.dart';
import 'package:ash_trainer/core/utils/logger.dart';
import 'package:drift/drift.dart';
import 'package:ash_trainer/data/datasources/local/daos/ai_task_dao.dart';

class BackgroundTasks {
  static const String planGenerationTask = "com.ash_trainer.plan_generation";

  static Future<void> schedulePlanGeneration({
    required String goalId,
    required String userId,
    PlanningMode mode = PlanningMode.initial,
    bool useMockAi = false,
    bool alternateMockPlan = false,
  }) async {
    await Workmanager().registerOneOffTask(
      "plan_gen_$goalId",
      planGenerationTask,
      inputData: {
        'goalId': goalId,
        'userId': userId,
        'mode': mode.toString(),
        'useMockAi': useMockAi,
        'alternateMockPlan': alternateMockPlan,
      },
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final taskId = task == BackgroundTasks.planGenerationTask
        ? "plan_gen_${inputData?['goalId']}"
        : task;

    if (task == BackgroundTasks.planGenerationTask) {
      final db = AppDatabase();
      try {
        // 1. Initialize Firebase
        if (Firebase.apps.isEmpty) {
          await Firebase.initializeApp();
        }

        // 2. Initialize DAOs and Services (Headless)
        final aiTaskDao = AiTaskDao(db);

        // Mark task as running
        await aiTaskDao.upsertTask(AiTasksCompanion(
          id: Value(taskId),
          taskType: Value(task),
          status: Value('running'),
          targetId: Value(inputData?['goalId'] as String?),
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
        ));

        final userRepo = UserRepositoryImpl(db.userDao);
        final goalRepo = GoalRepositoryImpl(db.goalDao);
        final workoutRepo =
            WorkoutRepositoryImpl(db.workoutDao, db.trainingPlanDao);
        final timeOffRepo = TimeOffRepositoryImpl(db.timeOffDao);

        final aiService = AIServiceImpl(
          useMockAi: inputData?['useMockAi'] ?? false,
          alternateMockPlan: inputData?['alternateMockPlan'] ?? false,
        );
        final contextBuilder =
            BuildPlanningContext(userRepo, goalRepo, workoutRepo, timeOffRepo);
        final scheduler = TrainingPlanScheduler();

        final generatePlan = GenerateTrainingPlan(
          contextBuilder,
          aiService,
          workoutRepo,
          goalRepo,
          scheduler,
        );

        final goalId = inputData?['goalId'] as String?;
        final userId = inputData?['userId'] as String?;
        final modeStr = inputData?['mode'] as String?;

        if (goalId == null || userId == null) {
          await aiTaskDao.deleteTask(taskId);
          return Future.value(false);
        }

        final mode = PlanningMode.values.firstWhere(
          (e) => e.toString() == modeStr,
          orElse: () => PlanningMode.initial,
        );

        // 3. Run Generation
        await generatePlan.execute(
          goalId: goalId,
          userId: userId,
          mode: mode,
        );

        // 4. Cleanup and Notify
        await aiTaskDao.deleteTask(taskId);
        await _showNotification();

        return Future.value(true);
      } catch (e, stack) {
        AppLogger.e('Background Task Failed', error: e, stackTrace: stack);
        // Ensure cleanup if fail
        await AiTaskDao(db).deleteTask(taskId);
        return Future.value(false);
      } finally {
        await db.close();
      }
    }
    return Future.value(true);
  });
}

Future<void> _showNotification() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosSettings = DarwinInitializationSettings();
  const initSettings =
      InitializationSettings(android: androidSettings, iOS: iosSettings);

  await flutterLocalNotificationsPlugin.initialize(initSettings);

  const androidDetails = AndroidNotificationDetails(
    'ash_tasks',
    'Ash Tasks',
    channelDescription: 'Notifications for long-running AI tasks',
    importance: Importance.high,
    priority: Priority.high,
  );
  const iosDetails = DarwinNotificationDetails();
  const notificationDetails =
      NotificationDetails(android: androidDetails, iOS: iosDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    'Plan Ready! 🏃',
    'Ash has finished building your personal training plan.',
    notificationDetails,
  );
}
