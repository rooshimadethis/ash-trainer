import 'package:flutter/material.dart';
import '../../../../core/utils/haptics.dart';
import '../../../../core/theme/colors.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).primaryColor.withValues(alpha: 0.5)
                : borderColor ?? Colors.transparent,
            width: isSelected ? 2.0 : (borderColor != null ? borderWidth : 0),
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                blurRadius: 32,
                spreadRadius: 2,
              )
            else ...[
              // Standard depth shadow
              BoxShadow(
                color: Colors.black
                    .withValues(alpha: AppColors.glassShadowOpacity),
                offset: const Offset(0, 8),
                blurRadius: 16,
                spreadRadius: -4,
              ),
              // Subtle inner glow/highlight for 3D feel
              BoxShadow(
                color: Colors.white.withValues(
                    alpha: isDark
                        ? AppColors.glassHighlightDarkOpacity
                        : AppColors.glassHighlightLightOpacity),
                offset: const Offset(0, 1),
                blurRadius: 0,
                spreadRadius: 0,
              ),
            ],
          ],
        ),
        child: child,
      ),
    );
  }
}
