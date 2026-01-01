import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/utils/haptics.dart';

enum AshButtonVariant { primary, secondary }

class AshButton extends StatefulWidget {
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
  State<AshButton> createState() => _AshButtonState();
}

class _AshButtonState extends State<AshButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;
    final isPrimary = widget.variant == AshButtonVariant.primary;

    return GestureDetector(
      onTapDown: isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: isEnabled ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: isEnabled ? () => setState(() => _isPressed = false) : null,
      onTap: isEnabled
          ? () {
              AshHaptics.mediumImpact();
              if (widget.onPressed != null) widget.onPressed!();
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        transform: _isPressed
            ? Matrix4.translationValues(0, 4, 0)
            : Matrix4.identity(),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isEnabled
              ? (isPrimary
                  ? Theme.of(context).primaryColor.withValues(
                      alpha: AppColors
                          .glassTintOpacity) // Matching WorkoutCard alpha
                  : Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withValues(alpha: AppColors.glassSurfaceOpacity))
              : (isPrimary
                  ? Theme.of(context)
                      .primaryColor
                      .withValues(alpha: AppColors.glassInactiveOpacity)
                  : Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withValues(alpha: 0.25)),
          boxShadow: isEnabled
              ? [
                  // Standard depth shadow (same as AshCard)
                  BoxShadow(
                    color: Colors.black.withValues(
                        alpha: _isPressed
                            ? AppColors.glassShadowOpacity * 0.5
                            : AppColors.glassShadowOpacity),
                    offset:
                        _isPressed ? const Offset(0, 4) : const Offset(0, 8),
                    blurRadius: _isPressed ? 8 : 16,
                    spreadRadius: -4,
                  ),
                  // Subtle inner glow/highlight for 3D feel (same as AshCard)
                  BoxShadow(
                    color: Colors.white.withValues(
                        alpha: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.glassHighlightDarkOpacity
                            : AppColors.glassHighlightLightOpacity),
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
                widget.label,
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
              if (widget.icon != null) ...[
                const SizedBox(width: 8),
                Icon(
                  widget.icon,
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
