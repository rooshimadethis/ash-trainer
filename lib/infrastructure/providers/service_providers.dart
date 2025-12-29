import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local/drift_database.dart';

final driftDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

// Placeholders for other services to allow compilation
final aiServiceProvider = Provider((ref) => null);
final healthServiceProvider = Provider((ref) => null);
final analyticsServiceProvider = Provider((ref) => null);
