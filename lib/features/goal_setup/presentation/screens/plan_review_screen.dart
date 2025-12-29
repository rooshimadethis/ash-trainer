import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_button.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../../../shared/presentation/widgets/ash_card.dart';
import '../providers/goal_setup_provider.dart';
import 'first_workout_prompt_screen.dart';

class PlanReviewScreen extends ConsumerWidget {
  const PlanReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AshScaffold(
      appBar: AppBar(
          title: const Text('Your Plan'), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Week 1 Ready! 🎉', style: AppTextStyles.h2),
            const SizedBox(height: 16),
            AshCard(
              child: Column(children: [
                Text('Confidence: ${(85.0).toStringAsFixed(0)}%',
                    style: AppTextStyles.h1.copyWith(color: AppColors.primary)),
                Text('Goal Probability', style: AppTextStyles.bodyMedium),
              ]),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: const [
                  _MockWorkoutTile(day: 'Mon', title: 'Rest Day', type: 'Rest'),
                  _MockWorkoutTile(
                      day: 'Tue',
                      title: 'Easy Run',
                      type: 'Run',
                      distance: '5 km'),
                  _MockWorkoutTile(day: 'Wed', title: 'Strength', type: 'Gym'),
                  _MockWorkoutTile(
                      day: 'Thu',
                      title: 'Tempo Run',
                      type: 'Run',
                      distance: '6 km'),
                  _MockWorkoutTile(day: 'Fri', title: 'Rest Day', type: 'Rest'),
                  _MockWorkoutTile(
                      day: 'Sat',
                      title: 'Long Run',
                      type: 'Run',
                      distance: '10 km'),
                  _MockWorkoutTile(
                      day: 'Sun',
                      title: 'Recovery',
                      type: 'Run',
                      distance: '3 km'),
                ],
              ),
            ),
            AshButton(
              label: 'Looks Good!',
              onPressed: () {
                ref.read(goalSetupProvider.notifier).nextStep();
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => const FirstWorkoutPromptScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _MockWorkoutTile extends StatelessWidget {
  final String day;
  final String title;
  final String type;
  final String? distance;

  const _MockWorkoutTile({
    required this.day,
    required this.title,
    required this.type,
    this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceHighlight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SizedBox(
              width: 40,
              child: Text(day,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                if (distance != null)
                  Text(distance!,
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: type == 'Rest'
                  ? Colors.grey.withValues(alpha: 0.2)
                  : AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(type,
                style: TextStyle(
                    fontSize: 10,
                    color: type == 'Rest' ? Colors.grey : AppColors.primary)),
          ),
        ],
      ),
    );
  }
}
