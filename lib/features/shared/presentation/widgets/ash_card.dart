import 'package:flutter/material.dart';
import '../../../../core/utils/haptics.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/shadows.dart';

class AshCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool isSelected;
  final Color? borderColor;
  final double borderWidth;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  const AshCard({
    super.key,
    required this.child,
    this.onTap,
    this.isSelected = false,
    this.borderColor,
    this.borderWidth = 1.5,
    this.backgroundColor,
    this.padding,
    this.borderRadius,
  });

  @override
  State<AshCard> createState() => _AshCardState();
}

class _AshCardState extends State<AshCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap != null
          ? () {
              AshHaptics.mediumImpact();
              widget.onTap!();
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
        padding: widget.padding ?? const EdgeInsets.all(16),
        transform: Matrix4.translationValues(
          _isPressed ? 2.0 : 0.0,
          _isPressed ? 2.0 : 0.0,
          0.0,
        ),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 24),
          border: Border.all(
            color: widget.borderColor ??
                (isDark
                    ? AppColors.retroAccent.withValues(alpha: 0.5)
                    : Colors.black.withValues(alpha: 0.8)),
            width: widget.borderWidth,
          ),
          boxShadow: _isPressed
              ? AppShadows.softMd
              : (isDark ? AppShadows.retroDark : AppShadows.retro),
        ),
        child: widget.child,
      ),
    );
  }
}
