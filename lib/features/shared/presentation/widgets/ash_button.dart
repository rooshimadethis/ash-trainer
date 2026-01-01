import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/haptics.dart';

enum AshButtonVariant { primary, secondary }

class AshButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AshButtonVariant variant;

  const AshButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.variant = AshButtonVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    final isPrimary = variant == AshButtonVariant.primary;

    return GestureDetector(
      onTap: isEnabled
          ? () {
              AshHaptics.mediumImpact();
              if (onPressed != null) onPressed!();
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isEnabled
              ? (isPrimary
                  ? Theme.of(context)
                      .primaryColor
                      .withValues(alpha: 0.15) // Matching WorkoutCard alpha
                  : Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withValues(alpha: 0.5))
              : (isPrimary
                  ? Theme.of(context).primaryColor.withValues(alpha: 0.05)
                  : Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withValues(alpha: 0.25)),
          boxShadow: isEnabled
              ? [
                  // Standard depth shadow (same as AshCard)
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    offset: const Offset(0, 8),
                    blurRadius: 16,
                    spreadRadius: -4,
                  ),
                  // Subtle inner glow/highlight for 3D feel (same as AshCard)
                  BoxShadow(
                    color: Colors.white.withValues(
                        alpha: Theme.of(context).brightness == Brightness.dark
                            ? 0.03
                            : 0.5),
                    offset: const Offset(0, 1),
                    blurRadius: 0,
                    spreadRadius: 0,
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: AppTextStyles.buttonText.copyWith(
                  color: isEnabled
                      ? (isPrimary
                          ? Theme.of(context)
                              .primaryColor // Colored text for tint button
                          : Theme.of(context).colorScheme.onSurface)
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.3),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 8),
                Icon(
                  icon,
                  size: 20,
                  color: isEnabled
                      ? (isPrimary
                          ? Theme.of(context).primaryColor // Colored icon
                          : Theme.of(context).colorScheme.onSurface)
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.3),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
