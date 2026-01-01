import 'package:ash_trainer/features/developer/presentation/widgets/debug_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ash_trainer/core/theme/theme_provider.dart';
import 'package:ash_trainer/core/routing/startup_router.dart';
import 'package:ash_trainer/core/utils/logger.dart';
import 'package:ash_trainer/core/utils/provider_logger.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';
import 'package:flutter_displaymode/flutter_displaymode.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    try {
      await FlutterDisplayMode.setHighRefreshRate();
    } catch (e) {
      AppLogger.error('Failed to set high refresh rate', e, StackTrace.current);
    }
  }

  // Catch Flutter framework errors
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    AppLogger.error(
        'Flutter Framework Error', details.exception, details.stack);
  };

  // Catch asynchronous errors outside the Flutter framework
  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.error('Platform Dispatcher Error', error, stack);
    return true;
  };

  await dotenv.load(fileName: ".env");

  // ignore: avoid_print
  print('🚀 App starting...');

  runApp(ProviderScope(
    observers: [ProviderLogger()],
    child: AshTrainerApp(),
  ));
}

class AshTrainerApp extends ConsumerWidget {
  AshTrainerApp({super.key});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Ash Trainer',
      theme: theme,
      home: const StartupRouter(),
      builder: (context, child) {
        // Wrap with DebugOverlay only in debug mode
        assert(() {
          child = DebugOverlay(
            child: child!,
          );
          return true;
        }());
        return child!;
      },
    );
  }
}
