import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../providers/time_off_provider.dart';

mixin TimeOffHandlerMixin {
  Future<void> handlePlanTimeOff(BuildContext context, WidgetRef ref) async {
    final now = DateTime.now();
    final result = await showDateRangePicker(
      context: context,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: isDark
                ? ColorScheme.dark(
                    primary: AppColors.primary,
                    onPrimary: AppColors.black,
                    surface: const Color(0xFF1E1E1E),
                    onSurface: AppColors.white,
                  )
                : ColorScheme.light(
                    primary: AppColors.primary,
                    onPrimary: AppColors.black,
                    surface: AppColors.white,
                    onSurface: AppColors.black,
                  ),
          ),
          child: child!,
        );
      },
    );

    if (result != null) {
      if (context.mounted) {
        _checkAndScheduleTimeOff(context, ref, result.start, result.end);
      }
    }
  }

  Future<void> _checkAndScheduleTimeOff(
      BuildContext context, WidgetRef ref, DateTime start, DateTime end) async {
    final controller = ref.read(timeOffControllerProvider.notifier);
    final conflicts = await controller.checkConflicts(start, end);

    if (conflicts.isNotEmpty && context.mounted) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text('Conflicting Workouts', style: AppTextStyles.h3),
          content: Text(
            'Ash found ${conflicts.length} workouts scheduled during this period.\n\nAsh can clear these sessions and adjust your plan for your return.',
            style: AppTextStyles.body,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('CANCEL',
                  style: AppTextStyles.buttonText
                      .copyWith(color: AppColors.textMuted)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('CLEAR & SCHEDULE OFF',
                  style: AppTextStyles.buttonText
                      .copyWith(color: AppColors.primary)),
            ),
          ],
        ),
      );

      if (confirmed == true && context.mounted) {
        await controller.addTimeOff(start, end, 'User scheduled',
            deleteConflicts: true);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Time Off scheduled. Workouts cleared.')),
          );
        }
      }
    } else if (context.mounted) {
      await controller.addTimeOff(start, end, 'User scheduled',
          deleteConflicts: false);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Time Off scheduled.')),
        );
      }
    }
  }
}
