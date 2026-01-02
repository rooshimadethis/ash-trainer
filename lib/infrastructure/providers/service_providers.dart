import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import '../../data/datasources/local/drift_database.dart';
import '../../features/shared/domain/services/health_service.dart';
import '../services/health_service_impl.dart';
import '../services/mock_health_service.dart';
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

/// Provider that determines if we are running on a physical device
final isPhysicalDeviceProvider = FutureProvider<bool>((ref) async {
  final deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.isPhysicalDevice;
  } else if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    return iosInfo.isPhysicalDevice;
  }
  return false;
});

final healthServiceProvider = Provider<HealthService>((ref) {
  final isPhysical = ref.watch(isPhysicalDeviceProvider).value ?? true;

  if (isPhysical) {
    return HealthServiceImpl();
  } else {
    // Return mock service on emulators/simulators
    return MockHealthService();
  }
});
final analyticsServiceProvider = Provider((ref) => null);
