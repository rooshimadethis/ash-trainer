import 'package:flutter/material.dart';
import '../../../shared/presentation/widgets/ash_card.dart';

/// A circular navigation button used in calendar view headers.
///
/// Provides consistent styling for prev/next navigation across
/// weekly and monthly views.
class CalendarNavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double size;

  const CalendarNavButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    return AshCard(
      onTap: onPressed,
      padding: EdgeInsets.zero,
      borderRadius: 100,
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurface,
          size: 24,
        ),
      ),
    );
  }
}
