import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/shadows.dart';
import '../../../../core/utils/haptics.dart';

class AshSurfaceCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const AshSurfaceCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.borderRadius = 16.0,
  });

  @override
  State<AshSurfaceCard> createState() => _AshSurfaceCardState();
}

class _AshSurfaceCardState extends State<AshSurfaceCard> {
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
        width: double.infinity,
        transform: Matrix4.translationValues(
          _isPressed ? 2.0 : 0.0,
          _isPressed ? 2.0 : 0.0,
          0.0,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: isDark
                ? AppColors.retroAccent.withValues(alpha: 0.5)
                : Colors.black.withValues(alpha: 0.1),
            width: 1.5,
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
