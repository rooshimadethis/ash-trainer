import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/presentation/widgets/ash_card.dart';
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
          loading: () => _buildLoadingSkeleton(context),
          error: (_, __) => _buildErrorState(context),
        );
      },
      loading: () => _buildLoadingSkeleton(context),
      error: (_, __) => _buildErrorState(context),
    );
  }
// ... (rest of file) ...

  Widget _buildRecoveryCard(BuildContext context, biomarker, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        // Refresh health data on tap
        ref.read(healthSyncProvider.notifier).refresh();
      },
      child: AshCard(
        backgroundColor:
            Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
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
                  const Color(0xFF4ADE80), // Softer Emerald
                ),
                _statItem(
                  context,
                  biomarker.sleepDurationFormatted,
                  'Sleep',
                  const Color(0xFF60A5FA), // Softer blue
                ),
                _statItem(
                  context,
                  biomarker.rhr?.toString() ?? '--',
                  'RHR',
                  const Color(0xFFFBBF24), // Softer Amber
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.h2.copyWith(
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label.toUpperCase(),
            style: AppTextStyles.labelSmall.copyWith(
              color: color.withValues(alpha: 0.8),
              letterSpacing: 1.0,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectHealthPrompt(
      BuildContext context, WidgetRef ref, bool isAuthorized) {
    return AshCard(
      backgroundColor:
          Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
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
          GestureDetector(
            onTap: () => isAuthorized
                ? ref.read(healthSyncProvider.notifier).refresh()
                : _requestPermissions(ref),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  // Standard depth shadow (same as AshCard)
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    offset: const Offset(0, 8),
                    blurRadius: 16,
                    spreadRadius: -4,
                  ),
                  // Subtle inner glow/highlight for 3D feel
                  BoxShadow(
                    color: Colors.white.withValues(
                        alpha: Theme.of(context).brightness == Brightness.dark
                            ? 0.03
                            : 0.5),
                    offset: const Offset(0, 1),
                    blurRadius: 0,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(isAuthorized ? Icons.refresh : Icons.link,
                      color: Theme.of(context).primaryColor, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    isAuthorized ? 'Refresh' : 'Connect',
                    style: AppTextStyles.buttonText.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingSkeleton(BuildContext context) {
    return AshCard(
      backgroundColor:
          Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
      child: SizedBox(
        height: 120,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return AshCard(
      backgroundColor:
          Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
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
