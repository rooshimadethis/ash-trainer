import 'package:flutter/material.dart';
import '../../../../core/constants/workout_types.dart';

class WorkoutBadge extends StatelessWidget {
  final String type;
  final double size;

  const WorkoutBadge({
    super.key,
    required this.type,
    this.size = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: WorkoutTypes.getColor(type),
        shape: BoxShape.circle,
      ),
    );
  }
}
