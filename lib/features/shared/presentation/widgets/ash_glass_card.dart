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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.03)
            : Theme.of(context).colorScheme.surface,
        borderRadius: borderRadius ?? BorderRadius.circular(32),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.05),
          width: 0.5,
        ),
        boxShadow: [
          // Depth shadow
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            offset: const Offset(0, 12),
            blurRadius: 24,
            spreadRadius: -8,
          ),
          // Top highlight (edge light)
          BoxShadow(
            color: Colors.white.withValues(alpha: isDark ? 0.05 : 0.4),
            offset: const Offset(0, 1),
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
