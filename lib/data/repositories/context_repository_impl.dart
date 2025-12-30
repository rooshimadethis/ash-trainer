import 'package:uuid/uuid.dart';
import '../../features/shared/domain/entities/ai/context_models.dart';
import '../../features/shared/domain/repositories/context_repository.dart';
import '../datasources/local/daos/context_dao.dart';
import '../models/ai_mappers.dart';

class ContextRepositoryImpl implements ContextRepository {
  final ContextDao _dao;

  ContextRepositoryImpl(this._dao);

  int _parseId(String id) => int.parse(id);

  @override
  Future<LongTermContext?> getLongTermContext(
      String userId, String goalId) async {
    final dto =
        await _dao.getLongTermContext(_parseId(userId), _parseId(goalId));
    return dto?.toEntity();
  }

  @override
  Future<void> saveLongTermContext(
      LongTermContext context, String userId, String goalId) async {
    final id = const Uuid().v4();
    await _dao.saveLongTermContext(
      LongTermContextDTOMapper.toCompanion(
        context: context,
        id: id,
        userId: userId,
        goalId: goalId,
      ),
    );
  }

  @override
  Future<MediumTermContext?> getMediumTermContext(String userId) async {
    final dto = await _dao.getMediumTermContext(_parseId(userId));
    return dto?.toEntity();
  }

  @override
  Future<void> saveMediumTermContext(
      MediumTermContext context, String userId) async {
    final id = const Uuid().v4();
    await _dao.saveMediumTermContext(
      MediumTermContextDTOMapper.toCompanion(
        context: context,
        id: id,
        userId: userId,
      ),
    );
  }

  @override
  Future<void> invalidateLongTermContext(String id) async {
    await _dao.deleteLongTermContext(id);
  }

  @override
  Future<bool> needsLongTermRegeneration(String userId, String goalId) async {
    final context =
        await _dao.getLongTermContext(_parseId(userId), _parseId(goalId));
    if (context == null) return true;
    return false;
  }

  @override
  Future<bool> needsMediumTermRegeneration(String userId) async {
    final context = await _dao.getMediumTermContext(_parseId(userId));
    if (context == null) return true;

    final age = DateTime.now().difference(context.createdAt);
    return age.inDays >= 7;
  }
}
