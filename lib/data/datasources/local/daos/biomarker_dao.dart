import 'package:drift/drift.dart';
import '../drift_database.dart';
import '../tables/biomarkers_table.dart';

part 'biomarker_dao.g.dart';

@DriftAccessor(tables: [Biomarkers])
class BiomarkerDao extends DatabaseAccessor<AppDatabase>
    with _$BiomarkerDaoMixin {
  BiomarkerDao(super.db);

  /// Watch today's biomarkers for real-time updates
  Stream<Biomarker?> watchTodaysBiomarkers(int userId) {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (select(biomarkers)
          ..where((b) => b.userId.equals(userId))
          ..where((b) => b.date.isBiggerOrEqualValue(startOfDay))
          ..where((b) => b.date.isSmallerThanValue(endOfDay)))
        .watchSingleOrNull();
  }

  /// Upsert biomarkers for a specific date
  /// Updates if record exists for this user+date, inserts otherwise
  Future<int> upsertBiomarkers(BiomarkersCompanion entry) async {
    return into(biomarkers).insertOnConflictUpdate(entry);
  }
}
