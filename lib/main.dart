import 'package:ash_trainer/features/developer/presentation/widgets/debug_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ash_trainer/core/theme/app_theme.dart';
import 'package:ash_trainer/core/routing/startup_router.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // ignore: avoid_print
  print('🚀 App starting...');

  runApp(ProviderScope(child: AshTrainerApp()));
}

class AshTrainerApp extends StatelessWidget {
  AshTrainerApp({super.key});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Ash Trainer',
      theme: AppTheme.darkTheme,
      home: const StartupRouter(),
      builder: (context, child) {
        // Wrap with DebugOverlay only in debug mode
        assert(() {
          child = DebugOverlay(
            navigatorKey: _navigatorKey,
            child: child!,
          );
          return true;
        }());
        return child!;
      },
    );
  }
}
