import 'package:flutter/material.dart';
import '../../../../core/utils/haptics.dart';

class AshCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool isSelected;
  final Color? borderColor;
  final double borderWidth;
  final Color? backgroundColor;

  const AshCard({
    super.key,
    required this.child,
    this.onTap,
    this.isSelected = false,
    this.borderColor,
    this.borderWidth = 1.0,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null
          ? () {
              AshHaptics.mediumImpact();
              onTap!();
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(28), // More modern, larger radius
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor.withValues(alpha: 0.5)
                : borderColor ?? Theme.of(context).colorScheme.outline,
            width: isSelected ? 2.0 : borderWidth,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color:
                        Theme.of(context).primaryColor.withValues(alpha: 0.15),
                    blurRadius: 24,
                    spreadRadius: -4,
                  ),
                ]
              : [],
        ),
        child: child,
      ),
    );
  }
}
