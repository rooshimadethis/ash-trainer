import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/shadows.dart';
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
    final theme = Theme.of(context);
    final isEnabled = widget.onPressed != null;
    final isPrimary = widget.variant == AshButtonVariant.primary;
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: isEnabled ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: isEnabled ? () => setState(() => _isPressed = false) : null,
      onTap: widget.onPressed != null
          ? () {
              AshHaptics.mediumImpact();
              widget.onPressed!();
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: double.infinity,
        height: 56,
        transform: Matrix4.translationValues(
          _isPressed ? 2.0 : 0.0,
          _isPressed ? 2.0 : 0.0,
          0.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isEnabled
              ? (isPrimary
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surfaceContainerHighest)
              : theme.colorScheme.surfaceContainerHighest
                  .withValues(alpha: 0.5),
          border: Border.all(
            color: isDark ? const Color(0xFFFF4D8C) : Colors.black,
            width: 2.0,
          ),
          boxShadow: isEnabled
              ? (_isPressed
                  ? AppShadows.retroHover
                  : (isDark ? AppShadows.retroDark : AppShadows.retro))
              : [],
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTextStyles.buttonText.copyWith(
                  color: isEnabled
                      ? (isPrimary
                          ? Colors.black // High contrast black on bright colors
                          : theme.colorScheme.onSurface)
                      : theme.colorScheme.onSurface.withValues(alpha: 0.38),
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 8),
                Icon(
                  widget.icon,
                  size: 20,
                  color: isEnabled
                      ? (isPrimary
                          ? Colors.black // High contrast black on bright colors
                          : theme.colorScheme.onSurface)
                      : theme.colorScheme.onSurface.withValues(alpha: 0.38),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
