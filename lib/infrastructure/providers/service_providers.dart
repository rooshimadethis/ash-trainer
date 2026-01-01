import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local/drift_database.dart';
import '../../features/shared/domain/services/health_service.dart';
import '../services/health_service_impl.dart';
import '../services/ai_service.dart';
import '../services/ai_service_impl.dart';

final driftDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  // Keep the database alive for the entire app lifecycle
  ref.onDispose(() {
    db.close();
  });
  return db;
});

final aiServiceProvider = Provider<AIService>((ref) {
  return AIServiceImpl();
});

final healthServiceProvider = Provider<HealthService>((ref) {
  return HealthServiceImpl();
});
final analyticsServiceProvider = Provider((ref) => null);
