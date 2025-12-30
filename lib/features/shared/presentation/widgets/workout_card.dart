import 'package:flutter/material.dart';
import '../../domain/entities/training/workout.dart';
import 'ash_card.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/workout_types.dart';

class WorkoutCard extends StatelessWidget {
  final Workout workout;
  final VoidCallback? onTap;

  const WorkoutCard({
    super.key,
    required this.workout,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final typeColor = WorkoutTypes.getColor(workout.type);

    return AshCard(
      onTap: onTap,
      borderColor: typeColor.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: typeColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
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
              const Spacer(),
              if (workout.status == 'completed')
                const Icon(Icons.check_circle, color: Colors.green, size: 16),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            workout.name,
            style: AppTextStyles.h3,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _infoTile(Icons.timer_outlined,
                  _formatDuration(workout.plannedDuration)),
              if (workout.plannedDistance != null) ...[
                const SizedBox(width: 16),
                _infoTile(
                    Icons.straighten_outlined, '${workout.plannedDistance} km'),
              ],
            ],
          ),
          if (workout.intensity != null) ...[
            const SizedBox(height: 8),
            _infoTile(Icons.speed_outlined, workout.intensity!),
          ],
          if (workout.description != null) ...[
            const SizedBox(height: 12),
            Text(
              workout.description!,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          text,
          style:
              AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
        ),
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
