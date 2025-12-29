import 'package:flutter/material.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/presentation/widgets/ash_button.dart';
import '../../../shared/presentation/widgets/ash_scaffold.dart';
import '../../../shared/presentation/widgets/ash_card.dart';
import '../../../dashboard/presentation/screens/home_screen.dart';

class OnboardingFeedbackScreen extends StatefulWidget {
  final Duration duration;

  const OnboardingFeedbackScreen({super.key, required this.duration});

  @override
  State<OnboardingFeedbackScreen> createState() =>
      _OnboardingFeedbackScreenState();
}

class _OnboardingFeedbackScreenState extends State<OnboardingFeedbackScreen> {
  int? _rpe; // 1-10
  bool _hasPain = false;

  @override
  Widget build(BuildContext context) {
    // Format duration text
    final int seconds = widget.duration.inSeconds;
    final int minutes = seconds ~/ 60;
    final int remSeconds = seconds % 60;
    final String durationText =
        '${minutes}m ${remSeconds.toString().padLeft(2, '0')}s';

    return AshScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Text('Nice work! 🎉', style: AppTextStyles.h1),
            const SizedBox(height: 8),
            const Text(
              'That\'s one in the books.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
            ),
            const SizedBox(height: 32),
            AshCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat('Duration', durationText),
                  _buildStat('Distance', '2.5 km'), // Mock from health data
                  _buildStat('Pace', '6:00 /km'), // Mock
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text('How hard did that feel?', style: AppTextStyles.h3),
            const SizedBox(height: 16),
            _buildRpeSelector(),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Anything hurting?',
                    style:
                        AppTextStyles.h3.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                Switch(
                  value: _hasPain,
                  onChanged: (val) {
                    setState(() {
                      _hasPain = val;
                    });
                  },
                ),
              ],
            ),
            if (_hasPain) ...[
              const SizedBox(height: 16),
              const Text(
                'Please advise details in the next check-in (Feature coming soon)',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ],
            const SizedBox(height: 48),
            AshButton(
              label: 'Done',
              onPressed: _rpe != null
                  ? () {
                      // TODO: Save feedback
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (route) => false,
                      );
                    }
                  : null, // Disabled if RPE not selected
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        const SizedBox(height: 4),
        Text(label,
            style:
                const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      ],
    );
  }

  Widget _buildRpeSelector() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildRpeOption(1, 'Easy'),
            _buildRpeOption(5, 'Moderate'),
            _buildRpeOption(10, 'Max'),
          ],
        ),
        const SizedBox(height: 16),
        Slider(
          value: (_rpe ?? 5).toDouble(),
          min: 1,
          max: 10,
          divisions: 9,
          label: _rpe?.toString() ?? '-',
          activeColor: _getRpeColor(_rpe ?? 5),
          onChanged: (val) {
            setState(() {
              _rpe = val.round();
            });
          },
        ),
        Text(
          _getRpeLabel(_rpe),
          style: TextStyle(
              color: _getRpeColor(_rpe ?? 5),
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildRpeOption(int val, String label) {
    return Text(label,
        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12));
  }

  Color _getRpeColor(int val) {
    if (val <= 3) return Colors.greenAccent;
    if (val <= 6) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  String _getRpeLabel(int? val) {
    if (val == null) return 'Slide to rate';
    if (val <= 3) return 'Easy peasy';
    if (val <= 6) return 'Comfortably challenging';
    if (val <= 9) return 'Tough but doable';
    return 'Absolutely brutal';
  }
}
