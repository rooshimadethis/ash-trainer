import 'package:flutter/material.dart';
import '../../../../core/utils/haptics.dart';
import '../../../../core/theme/colors.dart';

class AshCard extends StatefulWidget {
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
  State<AshCard> createState() => _AshCardState();
}

class _AshCardState extends State<AshCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isEnabled = widget.onTap != null;

    return GestureDetector(
      onTapDown: isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: isEnabled ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: isEnabled ? () => setState(() => _isPressed = false) : null,
      onTap: isEnabled
          ? () {
              AshHaptics.mediumImpact();
              widget.onTap!();
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        transform: _isPressed && isEnabled
            ? Matrix4.translationValues(0, 4, 0)
            : Matrix4.identity(),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: widget.isSelected
                ? Theme.of(context).primaryColor.withValues(alpha: 0.5)
                : widget.borderColor ?? Colors.transparent,
            width: widget.isSelected
                ? 2.0
                : (widget.borderColor != null ? widget.borderWidth : 0),
          ),
          boxShadow: [
            if (widget.isSelected)
              BoxShadow(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                blurRadius: _isPressed ? 16 : 32,
                spreadRadius: _isPressed ? 1 : 2,
              )
            else ...[
              // Standard depth shadow
              BoxShadow(
                color: Colors.black.withValues(
                    alpha: _isPressed
                        ? AppColors.glassShadowOpacity * 0.5
                        : AppColors.glassShadowOpacity),
                offset: _isPressed ? const Offset(0, 4) : const Offset(0, 8),
                blurRadius: _isPressed ? 8 : 16,
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
        child: widget.child,
      ),
    );
  }
}
