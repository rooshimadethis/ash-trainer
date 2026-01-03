import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

/// A premium, integrated bottom bar with a sculpted top edge.
/// This bar is fixed at the bottom to avoid clutter but has a unique,
/// intentional shape that feels high-end.
class AshBottomActionBar extends StatelessWidget {
  final List<ActionBarItem> actions;

  const AshBottomActionBar({
    super.key,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Sculpted top edge / Glow line
          Positioned(
            top: -1,
            left: 0,
            right: 0,
            child: Container(
              height: 1.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.primaryColor.withValues(alpha: 0),
                    theme.primaryColor.withValues(alpha: 0.5),
                    theme.primaryColor.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 8,
              ),
              child: Row(
                children: [
                  for (int i = 0; i < actions.length; i++) ...[
                    Expanded(
                      child: _buildItem(context, actions[i], isDark),
                    ),
                    if (i < actions.length - 1)
                      Container(
                        height: 32,
                        width: 1.5,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.05)
                              : Colors.black.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, ActionBarItem action, bool isDark) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: action.onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: action.color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: action.color.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: action.color.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  action.icon,
                  color: action.color,
                  size: 22,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                action.label.toUpperCase(),
                style: AppTextStyles.labelSmall.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionBarItem {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const ActionBarItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}
