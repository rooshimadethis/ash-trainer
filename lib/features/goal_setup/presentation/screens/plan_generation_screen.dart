import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/logger.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../providers/goal_setup_provider.dart';
import 'plan_review_screen.dart';

class PlanGenerationScreen extends ConsumerStatefulWidget {
  const PlanGenerationScreen({super.key});

  @override
  ConsumerState<PlanGenerationScreen> createState() =>
      _PlanGenerationScreenState();
}

class _PlanGenerationScreenState extends ConsumerState<PlanGenerationScreen> {
  @override
  Widget build(BuildContext context) {
    // Listen for completion
    ref.listen(goalSetupProvider, (previous, next) {
      if ((previous?.isGenerating ?? false) && !next.isGenerating) {
        if (next.error == null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const PlanReviewScreen()),
          );
        } else {
          AppLogger.error('Plan generation failed', next.error!, null);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${next.error}')),
          );
        }
      }
    });

    return AshScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: AppColors.primary),
            const SizedBox(height: 32),
            Text('Building your plan...', style: AppTextStyles.h2),
            const SizedBox(height: 16),
            Text(
              'Crunching the numbers based on your biology and goals.',
              style: AppTextStyles.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
