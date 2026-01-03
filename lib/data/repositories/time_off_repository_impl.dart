import 'package:drift/drift.dart';
import '../../features/shared/domain/entities/time_off_entry.dart';
import '../../features/shared/domain/repositories/time_off_repository.dart';
import '../datasources/local/daos/time_off_dao.dart';
import '../datasources/local/drift_database.dart';

class TimeOffRepositoryImpl implements TimeOffRepository {
  final TimeOffDao _dao;

  TimeOffRepositoryImpl(this._dao);

  @override
  Future<List<TimeOffEntry>> getAllTimeOffs() async {
    final dtos = await _dao.getAllTimeOffs();
    return dtos.map(_mapDtoToEntity).toList();
  }

  @override
  Future<List<TimeOffEntry>> getTimeOffsInMonth(DateTime month) async {
    final dtos = await _dao.getTimeOffsInMonth(month);
    return dtos.map(_mapDtoToEntity).toList();
  }

  @override
  Future<void> addTimeOff(DateTime start, DateTime end, String reason) async {
    final entry = TimeOffsCompanion(
      startDate: Value(start),
      endDate: Value(end),
      reason: Value(reason),
    );
    await _dao.insertTimeOff(entry);
  }

  @override
  Future<void> deleteTimeOff(int id) async {
    await _dao.deleteTimeOff(id);
  }

  TimeOffEntry _mapDtoToEntity(TimeOffDTO dto) {
    return TimeOffEntry(
      id: dto.id,
      startDate: dto.startDate,
      endDate: dto.endDate,
      reason: dto.reason,
      isSynced: dto.isSynced,
    );
  }
}
