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
import 'daos/workout_dao.dart';
import 'daos/training_plan_dao.dart';
import 'daos/biomarker_dao.dart';

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
], daos: [
  UserDao,
  GoalDao,
  ConversationDao,
  ContextDao,
  WorkoutDao,
  TrainingPlanDao,
  BiomarkerDao,
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
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          for (var i = from; i < to; i++) {
            if (i == 1) {
              // Add columns for Phase 2: Workout Logging
              await m.addColumn(workouts, workouts.syncedFrom);
              await m.addColumn(phases, phases.actualDistance);
              await m.addColumn(phases, phases.actualDuration);
              await m.addColumn(trainingBlocks, trainingBlocks.actualDistance);
              await m.addColumn(trainingBlocks, trainingBlocks.actualDuration);
            }
            if (i == 2) {
              // Add biomarkers table for recovery widget
              await m.createTable(biomarkers);
            }
            if (i == 3) {
              // Add isKey column for Algorithmic Rescheduling
              await m.addColumn(workouts, workouts.isKey);
            }
            if (i == 4) {
              // Add rationale columns for Phase 2: AI Rationale
              await m.addColumn(goals, goals.rationaleOverallApproach);
              await m.addColumn(goals, goals.rationaleIntensityDistribution);
              await m.addColumn(goals, goals.rationaleKeyWorkouts);
              await m.addColumn(goals, goals.rationaleRecoveryStrategy);
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

    return NativeDatabase.createInBackground(file);
  });
}
