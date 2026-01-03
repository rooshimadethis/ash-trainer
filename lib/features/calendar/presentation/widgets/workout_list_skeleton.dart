import 'package:flutter/material.dart';
import '../../../../core/theme/borders.dart';
import '../../../../core/theme/dimensions.dart';
import '../../../shared/presentation/widgets/shimmer_widget.dart';

/// Skeleton loading state for workout list
class WorkoutListSkeleton extends StatelessWidget {
  final int cardCount;

  const WorkoutListSkeleton({
    super.key,
    this.cardCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor =
        isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05);
    final headerColor =
        isDark ? Colors.white24 : Colors.black.withValues(alpha: 0.08);

    return ShimmerWidget(
      child: Column(
        children: List.generate(cardCount, (index) {
          return Container(
            margin: EdgeInsets.only(
              bottom: index == cardCount - 1 ? 0 : AppDimensions.spacingMd,
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.grey[900]?.withValues(alpha: 0.5)
                  : Colors.white,
              borderRadius: BorderRadius.circular(AppBorders.radiusLg),
              border: Border.all(
                color: isDark ? Colors.white12 : Colors.black12,
                width: AppBorders.medium,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header bar (mimics workout type tag)
                Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: headerColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppBorders.radiusLg),
                      topRight: Radius.circular(AppBorders.radiusLg),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.spacingMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title placeholder
                      Container(
                        height: 20,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius:
                              BorderRadius.circular(AppBorders.radiusSm),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spacingSm),
                      // Subtitle placeholder
                      Container(
                        height: 16,
                        width: 150,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius:
                              BorderRadius.circular(AppBorders.radiusSm),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spacingMd),
                      // Stats row placeholder
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius:
                                    BorderRadius.circular(AppBorders.radiusSm),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppDimensions.spacingSm),
                          Expanded(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius:
                                    BorderRadius.circular(AppBorders.radiusSm),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
