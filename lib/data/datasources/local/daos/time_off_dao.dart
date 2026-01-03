import 'package:drift/drift.dart';
import '../drift_database.dart';
import '../tables/time_off_table.dart';

part 'time_off_dao.g.dart';

@DriftAccessor(tables: [TimeOffs])
class TimeOffDao extends DatabaseAccessor<AppDatabase> with _$TimeOffDaoMixin {
  TimeOffDao(super.db);

  Future<List<TimeOffDTO>> getAllTimeOffs() => select(timeOffs).get();

  Future<List<TimeOffDTO>> getTimeOffsInMonth(DateTime month) {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0);

    return (select(timeOffs)
          ..where((t) =>
              t.startDate.isSmallerOrEqualValue(endOfMonth) &
              t.endDate.isBiggerOrEqualValue(startOfMonth)))
        .get();
  }

  Future<int> insertTimeOff(Insertable<TimeOffDTO> entry) =>
      into(timeOffs).insert(entry);

  Future<int> deleteTimeOff(int id) =>
      (delete(timeOffs)..where((t) => t.id.equals(id))).go();

  Future<List<TimeOffDTO>> getTimeOffsOverlapping(
      DateTime start, DateTime end) {
    return (select(timeOffs)
          ..where((t) =>
              t.startDate.isSmallerOrEqualValue(end) &
              t.endDate.isBiggerOrEqualValue(start)))
        .get();
  }
}
