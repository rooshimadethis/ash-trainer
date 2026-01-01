import 'package:flutter/material.dart';
import '../../../../core/theme/text_styles.dart';
import 'ash_card.dart';

class AshSelectionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget leading;
  final bool isSelected;
  final VoidCallback onTap;

  const AshSelectionTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.leading,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return AshCard(
      isSelected: isSelected,
      onTap: onTap,
      backgroundColor: isSelected
          ? primaryColor.withValues(alpha: 0.1)
          : Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isSelected
                  ? primaryColor
                  : Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: isDark ? const Color(0xFFFF4D8C) : Colors.black,
                width: 2.0,
              ),
            ),
            child: Center(
              child: IconTheme(
                data: IconThemeData(
                  color: isSelected
                      ? (isDark ? Colors.black : Colors.white)
                      : null,
                ),
                child: leading,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? (isDark ? const Color(0xFFFF4D8C) : Colors.black)
                  : Colors.white,
              border: Border.all(
                color: isDark ? const Color(0xFFFF4D8C) : Colors.black,
                width: 2,
              ),
            ),
            child: isSelected
                ? const Icon(Icons.check, size: 18, color: Colors.white)
                : null,
          ),
        ],
      ),
    );
  }
}
