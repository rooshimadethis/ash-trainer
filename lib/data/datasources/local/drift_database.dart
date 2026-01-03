import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables/users_table.dart';
import 'tables/goals_table.dart';
import 'daos/user_dao.dart';
import 'daos/goal_dao.dart';

import 'tables/conversations_table.dart';
import 'tables/conversation_messages_table.dart';
import 'tables/long_term_context_table.dart';
import 'tables/medium_term_context_table.dart';
import 'daos/conversation_dao.dart';
import 'daos/context_dao.dart';

import 'tables/workouts_table.dart';
import 'tables/phases_table.dart';
import 'tables/training_blocks_table.dart';
import 'tables/biomarkers_table.dart';
import 'tables/workout_details_tables.dart';
import 'daos/workout_dao.dart';
import 'daos/training_plan_dao.dart';
import 'daos/biomarker_dao.dart';
import 'tables/time_off_table.dart';
import 'daos/time_off_dao.dart';

import 'tables/ai_tasks_table.dart';
import 'daos/ai_task_dao.dart';

part 'drift_database.g.dart';

@DriftDatabase(tables: [
  Users,
  Goals,
  Conversations,
  ConversationMessages,
  LongTermContext,
  MediumTermContext,
  Workouts,
  Phases,
  TrainingBlocks,
  Biomarkers,
  StrengthExercises,
  MobilityModules,
  MobilityPhases,
  TimeOffs,
  AiTasks,
], daos: [
  UserDao,
  GoalDao,
  ConversationDao,
  ContextDao,
  WorkoutDao,
  TrainingPlanDao,
  BiomarkerDao,
  TimeOffDao,
  AiTaskDao,
])
class AppDatabase extends _$AppDatabase {
  static int _instanceCount = 0;
  final int _instanceId;

  AppDatabase()
      : _instanceId = ++_instanceCount,
        super(_openConnection()) {
    // ignore: avoid_print
    print('🔵 Database instance #$_instanceId created');
  }

  @override
  int get schemaVersion => 9;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          for (var i = from; i < to; i++) {
            if (i == 1) {
              await m.addColumn(workouts, workouts.syncedFrom);
              await m.addColumn(phases, phases.actualDistance);
              await m.addColumn(phases, phases.actualDuration);
              await m.addColumn(trainingBlocks, trainingBlocks.actualDistance);
              await m.addColumn(trainingBlocks, trainingBlocks.actualDuration);
            }
            if (i == 2) {
              await m.createTable(biomarkers);
            }
            if (i == 3) {
              await m.addColumn(workouts, workouts.isKey);
            }
            if (i == 4) {
              await m.addColumn(goals, goals.rationaleOverallApproach);
              await m.addColumn(goals, goals.rationaleIntensityDistribution);
              await m.addColumn(goals, goals.rationaleKeyWorkouts);
              await m.addColumn(goals, goals.rationaleRecoveryStrategy);
            }
            if (i == 5) {
              await m.createTable(strengthExercises);
              await m.createTable(mobilityModules);
              await m.createTable(mobilityPhases);
            }
            if (i == 6) {
              await m.addColumn(mobilityPhases, mobilityPhases.intensityNotes);
              await m.addColumn(mobilityPhases, mobilityPhases.irradiationPct);
            }
            if (i == 7) {
              await m.createTable(timeOffs);
            }
            if (i == 8) {
              await m.createTable(aiTasks);
            }
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  @override
  Future<void> close() {
    // ignore: avoid_print
    print('🔴 Database instance #$_instanceId closing');
    return super.close();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    final exists = await file.exists();
    // ignore: avoid_print
    print('💾 Database path: ${file.path}');
    // ignore: avoid_print
    print('💾 Database file exists: $exists');

    if (exists) {
      final size = await file.length();
      // ignore: avoid_print
      print('💾 Database file size: $size bytes');
    }

    return NativeDatabase.createInBackground(file, setup: (db) {
      db.execute('PRAGMA journal_mode=WAL;');
      db.execute('PRAGMA busy_timeout=5000;');
    });
  });
}
