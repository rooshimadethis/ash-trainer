import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';
import '../../../../infrastructure/providers/service_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AshScaffold(
      appBar: AppBar(
        title: const Text('Ash Trainer'),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.home, size: 64, color: AppColors.primary),
            const SizedBox(height: 16),
            Text('Welcome Home!', style: AppTextStyles.h2),
            const SizedBox(height: 8),
            Text('Your personalized plan awaits.',
                style: AppTextStyles.bodyLarge),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final db = ref.read(driftDatabaseProvider);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DriftDbViewer(db),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.storage, color: Colors.white),
      ),
    );
  }
}
