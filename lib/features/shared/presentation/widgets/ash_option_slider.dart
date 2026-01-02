import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/haptics.dart';

class AshOptionSlider extends StatelessWidget {
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final Color? color;
  final double? width;

  const AshOptionSlider({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.color,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Find index for the sliding pill position
    final selectedIndex =
        options.indexWhere((o) => o.toLowerCase() == value.toLowerCase());

    // Calculate alignment: -1.0 is far left, 1.0 is far right
    final double alignmentX = options.length > 1
        ? -1.0 + (selectedIndex * (2.0 / (options.length - 1)))
        : -1.0;

    Widget content = Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color:
            isDark ? AppColors.surfaceLighter : AppColors.surfaceLightSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.border : AppColors.borderLight,
          width: 1.5,
        ),
      ),
      child: Stack(
        children: [
          // The Sliding Pill
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutBack,
            alignment: Alignment(alignmentX, 0),
            child: FractionallySizedBox(
              widthFactor: 1 / options.length,
              child: Container(
                height: 36, // Fixed height for the pill
                decoration: BoxDecoration(
                  color: color ?? theme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color:
                          (color ?? theme.primaryColor).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
              ),
            ),
          ),
          // The Text Options
          Row(
            // mainAxisSize: MainAxisSize.min, // Removed as Expanded children will fill space
            children: options.map((option) {
              final isSelected = value.toLowerCase() == option.toLowerCase();
              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (!isSelected) {
                      AshHaptics.lightImpact();
                      onChanged(option);
                    }
                  },
                  child: Container(
                    height: 36,
                    alignment: Alignment.center,
                    child: Text(
                      option.toUpperCase(),
                      style: AppTextStyles.label.copyWith(
                        color: isSelected
                            ? Colors.white
                            : (isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight),
                        fontWeight:
                            isSelected ? FontWeight.w900 : FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );

    if (width != null) {
      return SizedBox(width: width, child: content);
    }
    return content;
  }
}
