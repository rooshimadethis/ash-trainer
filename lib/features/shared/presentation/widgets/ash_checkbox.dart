import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/shadows.dart';

class AshCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  const AshCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut, // More stable for shadow interpolation
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: value
                    ? primaryColor
                    : (isDark ? AppColors.surfaceLighter : AppColors.white),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: value
                      ? (isDark ? AppColors.retroAccent : Colors.black)
                      : (isDark ? AppColors.border : AppColors.borderLight),
                  width: 2,
                ),
                boxShadow: value
                    ? (isDark ? AppShadows.retroDark : AppShadows.retro)
                    : [
                        const BoxShadow(
                          color: Colors.transparent,
                          offset: Offset.zero,
                          blurRadius: 0,
                        )
                      ],
              ),
              child: value
                  ? Icon(
                      Icons.check_rounded,
                      color: isDark ? Colors.black : Colors.white,
                      size: 20,
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: value ? FontWeight.w700 : FontWeight.w500,
                  color: value
                      ? (isDark ? AppColors.white : Colors.black)
                      : (isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
