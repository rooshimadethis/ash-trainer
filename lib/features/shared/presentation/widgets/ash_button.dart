import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
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

    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        boxShadow: isEnabled && isPrimary
            ? [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.25),
                  offset: const Offset(0, 4),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ]
            : [],
      ),
      child: ElevatedButton(
        onPressed: onPressed != null
            ? () {
                AshHaptics.mediumImpact();
                onPressed!();
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          disabledBackgroundColor:
              Theme.of(context).colorScheme.surfaceContainerHighest,
          foregroundColor: isPrimary
              ? AppColors.white
              : Theme.of(context).colorScheme.onSurface,
          disabledForegroundColor:
              Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Upgraded radius
            side: !isEnabled || !isPrimary
                ? BorderSide(color: Theme.of(context).colorScheme.outline)
                : BorderSide.none,
          ),
          elevation: 0, // Shadow handled by Container
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label,
                style: AppTextStyles.buttonText.copyWith(
                  color: isEnabled
                      ? (isPrimary
                          ? AppColors.white
                          : Theme.of(context).colorScheme.onSurface)
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.38),
                )),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(icon, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}
