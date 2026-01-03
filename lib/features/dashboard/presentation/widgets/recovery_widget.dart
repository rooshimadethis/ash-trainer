import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/presentation/widgets/ash_card.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/theme/colors.dart';
import '../providers/biomarkers_provider.dart';
import '../../../../infrastructure/providers/service_providers.dart';
import '../../../shared/presentation/widgets/shimmer_widget.dart';
import '../../../../core/theme/borders.dart';

class RecoveryWidget extends ConsumerWidget {
  const RecoveryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Trigger health sync on build
    ref.watch(healthSyncProvider);

    final biomarkersAsync = ref.watch(todaysBiomarkersProvider);
    final isAuthorizedAsync = ref.watch(healthAuthorizedProvider);

    return biomarkersAsync.when(
      data: (biomarker) {
        return isAuthorizedAsync.when(
          data: (isAuthorized) {
            return _buildRecoveryGrid(context, biomarker, ref, isAuthorized);
          },
          loading: () => _buildLoadingSkeleton(),
          error: (_, __) => _buildErrorState(context),
        );
      },
      loading: () => _buildLoadingSkeleton(),
      error: (_, __) => _buildErrorState(context),
    );
  }

  Widget _buildRecoveryGrid(
      BuildContext context, biomarker, WidgetRef ref, bool isAuthorized) {
    final readiness = _calculateReadiness(biomarker);
    final readinessColor = _getReadinessColor(readiness);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.favorite_outline, color: AppColors.rose, size: 20),
            const SizedBox(width: 8),
            Text('Recovery', style: AppTextStyles.h4),
            const Spacer(),
            if (!isAuthorized)
              TextButton.icon(
                onPressed: () => _requestPermissions(ref),
                icon: const Icon(Icons.link, size: 16),
                label: Text('Connect',
                    style: AppTextStyles.labelSmall.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
              )
            else
              IconButton(
                onPressed: () =>
                    ref.read(healthSyncProvider.notifier).refresh(),
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(Icons.refresh,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.3),
                    size: 16),
              ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            children: [
              _StatCard(
                label: 'Readiness',
                value: readiness,
                icon: Icons.bolt_outlined,
                color: readinessColor,
                status: readiness == '--' ? null : 'OPTIMAL',
              ),
              const SizedBox(width: 12),
              _StatCard(
                label: 'Sleep',
                value: biomarker?.sleepDurationFormatted ?? '--',
                icon: Icons.bedtime_outlined,
                color: AppColors.statSleep,
              ),
              const SizedBox(width: 12),
              _StatCard(
                label: 'RHR',
                value: biomarker?.rhr?.toString() ?? '--',
                icon: Icons.favorite_outline,
                color: AppColors.statRhr,
              ),
              const SizedBox(width: 12),
              _StatCard(
                label: 'HRV',
                value: biomarker?.hrv?.toStringAsFixed(0) ?? '--',
                icon: Icons.monitor_heart_outlined,
                color: AppColors.statHrv,
              ),
            ],
          ),
        ),
        if (isAuthorized && biomarker == null) ...[
          const SizedBox(height: 8),
          Text(
            'No data for today yet. Use your wearable to sync.',
            style: AppTextStyles.bodySmall.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }

  String _calculateReadiness(biomarker) {
    if (biomarker == null ||
        (biomarker.hrv == null &&
            biomarker.sleepDuration == null &&
            biomarker.rhr == null)) {
      return '--';
    }
    int goodCount = 0;
    if ((biomarker.hrv ?? 0) > 45) goodCount++;
    if ((biomarker.sleepDuration ?? 0) >= 420) goodCount++;
    if ((biomarker.rhr ?? 100) <= 65) goodCount++;

    if (goodCount == 3) return 'EXCELLENT';
    if (goodCount == 2) return 'GOOD';
    if (goodCount == 1) return 'FAIR';
    return 'RECOVERY';
  }

  Color _getReadinessColor(String readiness) {
    switch (readiness) {
      case 'EXCELLENT':
        return AppColors.emerald; // Green for excellent
      case 'GOOD':
        return AppColors.cyan; // Cyan for good
      case 'FAIR':
        return AppColors.amber; // Amber for fair
      case 'RECOVERY':
        return AppColors.rose; // Rose for needs recovery
      default:
        return AppColors.neutral;
    }
  }

  Widget _buildLoadingSkeleton() {
    return ShimmerWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.favorite_outline,
                  color: AppColors.neutral, size: 20),
              const SizedBox(width: 8),
              Container(
                height: 16,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(AppBorders.radiusSm),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: 4,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, __) => Container(
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(AppBorders.radiusLg),
                  border: Border.all(
                    color: Colors.white12,
                    width: AppBorders.medium,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return AshCard(
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Unable to load health data',
            style: AppTextStyles.h4,
          ),
        ],
      ),
    );
  }

  Future<void> _requestPermissions(WidgetRef ref) async {
    final healthService = ref.read(healthServiceProvider);
    final granted = await healthService.requestPermissions();

    if (granted) {
      ref.read(healthSyncProvider.notifier).refresh();
    }
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String? status;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: AshCard(
        padding: EdgeInsets.zero,
        backgroundColor: color,
        child: Stack(
          children: [
            // Background Icon pattern
            Positioned(
              right: -10,
              bottom: -10,
              child: Icon(
                icon,
                size: 80,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tag-style Header (Matching WorkoutCard)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icon, color: Colors.white, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          label.toUpperCase(),
                          style: AppTextStyles.label.copyWith(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value,
                          maxLines: 1,
                          softWrap: false,
                          style: AppTextStyles.h3.copyWith(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                        ),
                      ),
                      if (status != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          status!,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontWeight: FontWeight.w900,
                            fontSize: 10,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
