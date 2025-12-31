import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_glass_card.dart';

class WeekSummaryCard extends StatelessWidget {
  final double totalDistance;
  final Duration totalDuration;
  final int completedWorkouts;
  final int totalWorkouts;

  const WeekSummaryCard({
    super.key,
    required this.totalDistance,
    required this.totalDuration,
    required this.completedWorkouts,
    required this.totalWorkouts,
  });

  @override
  Widget build(BuildContext context) {
    final adherence = totalWorkouts > 0
        ? (completedWorkouts / totalWorkouts * 100).toInt()
        : 0;

    return AshGlassCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem('${totalDistance.toStringAsFixed(1)} KM', 'Volume'),
          _statItem(_formatDuration(totalDuration), 'Time'),
          _statItem('$adherence%', 'Adherence'),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.h4),
        Text(label,
            style: AppTextStyles.labelSmall
                .copyWith(color: AppColors.textSecondary)),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '${hours}h ${minutes}m';
  }
}
