import '../entities/ai/context_models.dart';

abstract class ContextRepository {
  /// Gets long-term context for current user/goal
  Future<LongTermContext?> getLongTermContext(String userId, String goalId);

  /// Saves/updates long-term context
  Future<void> saveLongTermContext(
      LongTermContext context, String userId, String goalId);

  /// Gets medium-term context for current user
  Future<MediumTermContext?> getMediumTermContext(String userId);

  /// Saves/updates medium-term context
  Future<void> saveMediumTermContext(MediumTermContext context, String userId);

  /// Invalidates long-term context (forces regeneration)
  Future<void> invalidateLongTermContext(String id);

  /// Checks if long-term context needs regeneration
  Future<bool> needsLongTermRegeneration(String userId, String goalId);

  /// Checks if medium-term context needs regeneration
  Future<bool> needsMediumTermRegeneration(String userId);
}
