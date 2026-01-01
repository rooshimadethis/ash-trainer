import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/presentation/widgets/ash_glass_card.dart';
import '../../../shared/presentation/widgets/ash_button.dart';
import '../../../../core/theme/text_styles.dart';
import '../providers/biomarkers_provider.dart';
import '../../../../infrastructure/providers/service_providers.dart';

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
            if (biomarker == null) {
              return _buildConnectHealthPrompt(context, ref, isAuthorized);
            }
            return _buildRecoveryCard(context, biomarker, ref);
          },
          loading: () => _buildLoadingSkeleton(),
          error: (_, __) => _buildErrorState(context),
        );
      },
      loading: () => _buildLoadingSkeleton(),
      error: (_, __) => _buildErrorState(context),
    );
  }

  Widget _buildRecoveryCard(BuildContext context, biomarker, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        // Refresh health data on tap
        ref.read(healthSyncProvider.notifier).refresh();
      },
      child: AshGlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.favorite_outline,
                    color: Theme.of(context).primaryColor, size: 20),
                const SizedBox(width: 8),
                Text('Recovery', style: AppTextStyles.h4),
                const Spacer(),
                Icon(Icons.refresh,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.3),
                    size: 16),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _statItem(
                  context,
                  biomarker.hrv?.toStringAsFixed(0) ?? '--',
                  'HRV',
                  Colors.green,
                ),
                _statItem(
                  context,
                  biomarker.sleepDurationFormatted,
                  'Sleep',
                  Colors.blue,
                ),
                _statItem(
                  context,
                  biomarker.rhr?.toString() ?? '--',
                  'RHR',
                  Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Health data synced via Health Connect. Tap to refresh.',
              style: AppTextStyles.bodySmall.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statItem(
      BuildContext context, String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.h2.copyWith(
            color: color,
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
        Text(label,
            style: AppTextStyles.labelSmall.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurfaceVariant)),
      ],
    );
  }

  Widget _buildConnectHealthPrompt(
      BuildContext context, WidgetRef ref, bool isAuthorized) {
    return AshGlassCard(
      child: Column(
        children: [
          Icon(
            isAuthorized ? Icons.hourglass_empty : Icons.health_and_safety,
            size: 48,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            isAuthorized ? 'No Data Today' : 'Connect Health Data',
            style: AppTextStyles.h4,
          ),
          const SizedBox(height: 8),
          Text(
            isAuthorized
                ? 'Permissions are granted, but no recovery data was found for today yet.'
                : 'Connect Health Connect to track your recovery metrics',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          AshButton(
            onPressed: () => isAuthorized
                ? ref.read(healthSyncProvider.notifier).refresh()
                : _requestPermissions(ref),
            icon: isAuthorized ? Icons.refresh : Icons.link,
            label: isAuthorized ? 'Refresh' : 'Connect',
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSkeleton() {
    return const AshGlassCard(
      child: SizedBox(
        height: 120,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return AshGlassCard(
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
      // Trigger a refresh after permissions are granted
      ref.read(healthSyncProvider.notifier).refresh();
    }
  }
}
