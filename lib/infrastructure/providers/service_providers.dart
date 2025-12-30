import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local/drift_database.dart';
import '../../features/shared/domain/interfaces/health_service.dart';
import '../services/health_service_impl.dart';

final driftDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

// Placeholders for other services to allow compilation
final aiServiceProvider = Provider((ref) => null);
final healthServiceProvider = Provider<HealthService>((ref) {
  return HealthServiceImpl();
});
final analyticsServiceProvider = Provider((ref) => null);
