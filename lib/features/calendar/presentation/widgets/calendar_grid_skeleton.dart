import 'package:flutter/material.dart';
import '../../../../core/theme/borders.dart';
import '../../../shared/presentation/widgets/shimmer_widget.dart';

/// Skeleton loading state for calendar grid views
class CalendarGridSkeleton extends StatelessWidget {
  final bool isWeekly;

  const CalendarGridSkeleton({
    super.key,
    this.isWeekly = true,
  });

  @override
  Widget build(BuildContext context) {
    final rows = isWeekly ? 1 : 5;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ShimmerWidget(
      child: Column(
        children: List.generate(rows, (rowIndex) {
          return Expanded(
            child: Row(
              children: List.generate(7, (colIndex) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white10
                          : Colors.black.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(AppBorders.radiusMd),
                      border: Border.all(
                        color: isDark ? Colors.white24 : Colors.black12,
                        width: AppBorders.thin,
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}
