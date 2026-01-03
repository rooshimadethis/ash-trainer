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
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  if (Platform.isAndroid) {
    try {
      await FlutterDisplayMode.setHighRefreshRate();
    } catch (e) {
      AppLogger.e('Failed to set high refresh rate',
          error: e, stackTrace: StackTrace.current);
    }
  }

  // Catch Flutter framework errors
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    AppLogger.e('Flutter Framework Error',
        error: details.exception, stackTrace: details.stack);
  };

  // Catch asynchronous errors outside the Flutter framework
  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.e('Platform Dispatcher Error', error: error, stackTrace: stack);
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
        // Wrap with DebugOverlay and set global system UI style
        final isDark = theme.brightness == Brightness.dark;
        final systemUiOverlayStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        );

        Widget wrappedChild = AnnotatedRegion<SystemUiOverlayStyle>(
          value: systemUiOverlayStyle,
          child: child!,
        );

        assert(() {
          wrappedChild = DebugOverlay(
            child: wrappedChild,
          );
          return true;
        }());
        return wrappedChild;
      },
    );
  }
}
