import 'package:flutter/material.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/workout_types.dart';
import '../../../shared/presentation/widgets/ash_button.dart';

class WorkoutDetailModal extends StatelessWidget {
  final Workout workout;

  const WorkoutDetailModal({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final typeColor = WorkoutTypes.getColor(workout.type);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: typeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: typeColor.withValues(alpha: 0.5)),
                ),
                child: Text(
                  WorkoutTypes.getDisplayName(workout.type).toUpperCase(),
                  style: AppTextStyles.labelSmall.copyWith(
                    color: typeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.textSecondary),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(workout.name, style: AppTextStyles.h2),
          const SizedBox(height: 12),
          Text(
            workout.description ?? 'No description available.',
            style: AppTextStyles.bodyLarge
                .copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _detailItem(Icons.timer_outlined,
                  _formatDuration(workout.plannedDuration), 'Duration'),
              if (workout.plannedDistance != null) ...[
                const SizedBox(width: 32),
                _detailItem(Icons.straighten_outlined,
                    '${workout.plannedDistance} km', 'Distance'),
              ],
              if (workout.intensity != null) ...[
                const SizedBox(width: 32),
                _detailItem(
                    Icons.speed_outlined, workout.intensity!, 'Intensity'),
              ],
            ],
          ),
          const SizedBox(height: 32),
          AshButton(
            label: 'Start Workout',
            onPressed: () {
              // TODO: Navigate to workout tracking
              Navigator.pop(context);
            },
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
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _detailItem(IconData icon, String value, String label) {
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
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
