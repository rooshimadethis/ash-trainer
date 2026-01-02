import 'package:ash_trainer/core/theme/shadows.dart';
import 'package:flutter/material.dart';

class AshGlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;

  const AshGlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final radius = borderRadius ?? BorderRadius.circular(24);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 1.0),
        borderRadius: radius,
        border: Border.all(
          color: isDark
              ? const Color(0xFFFF4D8C).withValues(alpha: 0.5)
              : Colors.black.withValues(alpha: 0.1),
          width: 1.5,
        ),
        boxShadow: isDark ? AppShadows.retroDark : AppShadows.retro,
      ),
      child: child,
    );
  }
}
