import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables/users_table.dart';
import 'tables/goals_table.dart';
import 'daos/user_dao.dart';
import 'daos/goal_dao.dart';

part 'drift_database.g.dart';

@DriftDatabase(tables: [Users, Goals], daos: [UserDao, GoalDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    // ignore: avoid_print
    print('💾 Database path: ${file.path}');
    return NativeDatabase.createInBackground(file);
  });
}
