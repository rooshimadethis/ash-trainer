import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_glass_card.dart';

class RecoveryWidget extends StatelessWidget {
  const RecoveryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AshGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.favorite_outline,
                  color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text('Recovery', style: AppTextStyles.h4),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statItem('68', 'HRV', Colors.green),
              _statItem('7h 20m', 'Sleep', Colors.blue),
              _statItem('54', 'RHR', Colors.orange),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Connect health data for real-time recovery insights.',
            style: AppTextStyles.bodySmall
                .copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.h3.copyWith(color: color)),
        Text(label,
            style: AppTextStyles.labelSmall
                .copyWith(color: AppColors.textSecondary)),
      ],
    );
  }
}
