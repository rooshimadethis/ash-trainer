import 'package:drift/drift.dart';
import '../drift_database.dart';
import '../tables/long_term_context_table.dart';
import '../tables/medium_term_context_table.dart';

part 'context_dao.g.dart';

@DriftAccessor(tables: [LongTermContext, MediumTermContext])
class ContextDao extends DatabaseAccessor<AppDatabase> with _$ContextDaoMixin {
  ContextDao(super.db);

  // Long Term Context
  Future<LongTermContextDTO?> getLongTermContext(int userId, int goalId) {
    return (select(longTermContext)
          ..where((l) => l.userId.equals(userId) & l.goalId.equals(goalId))
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> saveLongTermContext(Insertable<LongTermContextDTO> context) =>
      into(longTermContext).insert(context);

  Future<void> deleteLongTermContext(String id) =>
      (delete(longTermContext)..where((l) => l.id.equals(id))).go();

  // Medium Term Context
  Future<MediumTermContextDTO?> getMediumTermContext(int userId) {
    return (select(mediumTermContext)
          ..where((m) => m.userId.equals(userId))
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> saveMediumTermContext(
          Insertable<MediumTermContextDTO> context) =>
      into(mediumTermContext).insert(context);
}
