import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../shared/presentation/widgets/ash_card.dart';

/// A progress summary widget showing workout completion stats.
///
/// Displays completed/total workouts with a visual progress indicator.
class CalendarProgressSummary extends StatelessWidget {
  final List<Workout> workouts;
  final String periodLabel; // "This Week" or "This Month"

  const CalendarProgressSummary({
    super.key,
    required this.workouts,
    required this.periodLabel,
  });

  @override
  Widget build(BuildContext context) {
    final completed = workouts.where((w) => w.status == 'completed').length;
    final total = workouts.length;
    final progress = total > 0 ? completed / total : 0.0;

    // Calculate total planned time
    final totalMinutes = workouts.fold<int>(
      0,
      (sum, w) => sum + (w.plannedDuration ~/ 60),
    );
    final hours = totalMinutes ~/ 60;
    final mins = totalMinutes % 60;
    final timeStr = hours > 0 ? '${hours}h ${mins}m' : '${mins}m';

    return Row(
      children: [
        // Progress Ring Card
        Expanded(
          child: _StatCard(
            icon: Icons.check_circle_outline_rounded,
            iconColor:
                AppColors.statCompleted, // Uses emerald from unified palette
            label: 'COMPLETED',
            value: '$completed/$total',
            progress: progress,
          ),
        ),
        const SizedBox(width: 12),
        // Time Card
        Expanded(
          child: _StatCard(
            icon: Icons.schedule_rounded,
            iconColor: AppColors.statDuration, // Uses blue from unified palette
            label: 'PLANNED',
            value: timeStr,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final double? progress;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return AshCard(
      padding: const EdgeInsets.all(16),
      backgroundColor: iconColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 12, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      label,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: AppTextStyles.h2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (progress != null) ...[
                const Spacer(),
                SizedBox(
                  width: 32,
                  height: 32,
                  child: Stack(
                    children: [
                      CircularProgressIndicator(
                        value: 1.0,
                        strokeWidth: 3,
                        backgroundColor: Colors.white.withValues(alpha: 0.3),
                        valueColor: AlwaysStoppedAnimation(
                          Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 3,
                        backgroundColor: Colors.transparent,
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
