import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/workout_types.dart';
import '../../../shared/presentation/widgets/ash_button.dart';
import '../../../workout_logging/presentation/screens/workout_logging_screen.dart';

class WorkoutDetailScreen extends ConsumerWidget {
  final Workout workout;

  const WorkoutDetailScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final typeColor = WorkoutTypes.getColor(workout.type);
    final isToday = _isToday(workout.scheduledDate);
    final isCompleted = workout.status == 'completed';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Workout Detail',
          style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Badge & Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: typeColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: typeColor.withValues(alpha: 0.5)),
                    ),
                    child: Text(
                      WorkoutTypes.getDisplayName(workout.type).toUpperCase(),
                      style: AppTextStyles.labelSmall.copyWith(
                        color: typeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    DateFormat('EEEE, MMM d').format(workout.scheduledDate),
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Title & Description
              Text(workout.name, style: AppTextStyles.h1),
              const SizedBox(height: 12),
              Text(
                workout.description ??
                    'No description provided for this workout.',
                style: AppTextStyles.bodyLarge
                    .copyWith(color: AppColors.textSecondary),
              ),

              const SizedBox(height: 32),

              // Planned Metrics Section
              Text('PLANNED TARGETS',
                  style: AppTextStyles.labelLarge
                      .copyWith(color: AppColors.primary)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    _metricItem(Icons.timer_outlined,
                        _formatDuration(workout.plannedDuration), 'Duration'),
                    if (workout.plannedDistance != null) ...[
                      const SizedBox(width: 32),
                      _metricItem(Icons.straighten_outlined,
                          '${workout.plannedDistance} km', 'Distance'),
                    ],
                    if (workout.intensity != null) ...[
                      const SizedBox(width: 32),
                      _metricItem(Icons.speed_outlined, workout.intensity!,
                          'Intensity'),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Completion Status
              if (isCompleted) ...[
                Text('COMPLETED ACTUALS',
                    style: AppTextStyles.labelLarge
                        .copyWith(color: AppColors.success)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: AppColors.success.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      _metricItem(
                          Icons.check_circle_outline,
                          _formatDuration(workout.actualDuration ?? 0),
                          'Actual Time'),
                      if (workout.actualDistance != null) ...[
                        const SizedBox(width: 32),
                        _metricItem(Icons.straighten_outlined,
                            '${workout.actualDistance} km', 'Actual Distance'),
                      ],
                      if (workout.rpe != null) ...[
                        const SizedBox(width: 32),
                        _metricItem(Icons.psychology_outlined,
                            'RPE ${workout.rpe}', 'Effort'),
                      ],
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isToday && !isCompleted)
                AshButton(
                  label: 'Log Workout',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WorkoutLoggingScreen(workout: workout),
                      ),
                    );
                  },
                )
              else if (isCompleted)
                AshButton(
                  label: 'Workout Logged',
                  variant: AshButtonVariant.secondary,
                  onPressed: null, // Disabled or allows editing?
                )
              else
                AshButton(
                  label: 'Start Workout',
                  onPressed: null, // Only enabled for today in future
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: AshButton(
                      label: 'Adjust',
                      variant: AshButtonVariant.secondary,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AshButton(
                      label: 'Reschedule',
                      variant: AshButtonVariant.secondary,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _metricItem(IconData icon, String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.primary),
            const SizedBox(width: 4),
            Text(label,
                style: AppTextStyles.labelSmall
                    .copyWith(color: AppColors.textSecondary)),
          ],
        ),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.h4),
      ],
    );
  }

  String _formatDuration(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
