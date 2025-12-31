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
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius:
            borderRadius ?? BorderRadius.circular(20), // Larger radius
        border: Border.all(
          color: Colors.white.withAlpha(15), // Subtle edge highlight
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
