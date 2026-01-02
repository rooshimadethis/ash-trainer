import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/dimensions.dart';
import '../../../../core/theme/borders.dart';

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

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // The sculpted top border / accent line
        Positioned(
          top: -2,
          left: 0,
          right: 0,
          child: Container(
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  (isDark ? AppColors.retroAccent : AppColors.primary)
                      .withValues(alpha: 0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              top: BorderSide(
                color: isDark ? AppColors.border : AppColors.borderLight,
                width: AppBorders.thin,
              ),
            ),
          ),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: AppDimensions.spacingSm,
              ),
              child: Row(
                children: [
                  for (int i = 0; i < actions.length; i++) ...[
                    Expanded(
                      child: _buildItem(context, actions[i], isDark),
                    ),
                    if (i < actions.length - 1)
                      Container(
                        height: 28,
                        width: 1,
                        margin: EdgeInsets.only(top: 8),
                        color:
                            isDark ? AppColors.border : AppColors.borderLight,
                      ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, ActionBarItem action, bool isDark) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: action.onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppDimensions.spacingSm),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: action.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: action.color.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Icon(
                  action.icon,
                  color: action.color,
                  size: 20,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                action.label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
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
