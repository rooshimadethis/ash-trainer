import 'package:drift/drift.dart';
import 'users_table.dart';

/// Biomarkers table for storing daily health metrics from Health Connect/HealthKit
/// Phase 2 MVP: Only tracks sleep duration, HRV, and RHR
class Biomarkers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();

  /// Date (one record per user per day)
  DateTimeColumn get date => dateTime()();

  /// Health metrics (Phase 2 MVP)
  IntColumn get sleepDuration => integer().nullable()(); // minutes
  RealColumn get hrv => real().nullable()(); // Heart Rate Variability SDNN (ms)
  IntColumn get rhr => integer().nullable()(); // Resting Heart Rate (bpm)

  /// Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {userId, date}
      ];
}
