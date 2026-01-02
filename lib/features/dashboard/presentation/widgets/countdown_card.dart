import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_card.dart';

class CountdownCard extends StatelessWidget {
  final String goalName;
  final DateTime targetDate;
  final DateTime createdAt;

  const CountdownCard({
    super.key,
    required this.goalName,
    required this.targetDate,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final target = DateTime(targetDate.year, targetDate.month, targetDate.day);
    final created = DateTime(createdAt.year, createdAt.month, createdAt.day);

    final totalDuration = target.difference(created).inDays;
    final elapsed = today.difference(created).inDays;
    final remaining = target.difference(today).inDays;

    // Calculate progress (clamped between 0 and 1)
    double progress = 0;
    if (totalDuration > 0) {
      progress = (elapsed / totalDuration).clamp(0.0, 1.0);
    } else if (today.isAfter(target) || today.isAtSameMomentAs(target)) {
      progress = 1.0;
    }

    return AshCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFBBF24).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: const Color(0xFFFBBF24).withValues(alpha: 0.2),
                width: 1.2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.timer_outlined,
                  size: 14,
                  color: Color(0xFFFBBF24),
                ),
                const SizedBox(width: 6),
                Text(
                  'COUNTDOWN',
                  style: AppTextStyles.labelSmall.copyWith(
                    letterSpacing: 1.2,
                    color: const Color(0xFFFBBF24),
                    fontWeight: FontWeight.w900,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${remaining > 0 ? remaining : 0}',
                style: AppTextStyles.h1.copyWith(
                  color: const Color(0xFFFBBF24), // Amber 400
                  fontSize: 48,
                  height: 1,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                remaining == 1 ? 'DAY TO GO' : 'DAYS TO GO',
                style: AppTextStyles.h4.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: const Color(0xFFFBBF24).withValues(alpha: 0.1),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFFFBBF24)),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            goalName,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.5),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
