import '../entities/time_off_entry.dart';

abstract class TimeOffRepository {
  Future<List<TimeOffEntry>> getAllTimeOffs();
  Future<List<TimeOffEntry>> getTimeOffsInMonth(DateTime month);
  Future<void> addTimeOff(DateTime start, DateTime end, String reason);
  Future<void> deleteTimeOff(int id);
}
