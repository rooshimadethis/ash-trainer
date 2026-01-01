import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../infrastructure/providers/service_providers.dart';

import '../../../shared/domain/entities/ai/context_models.dart';
import '../../../../core/constants/ai_schemas.dart';
import '../../../../core/constants/prompts.dart';
import '../../../shared/domain/entities/training/workout.dart';
import '../../../../core/utils/logger.dart';

class AIWorkoutAdjusterTab extends ConsumerStatefulWidget {
  const AIWorkoutAdjusterTab({super.key});

  @override
  ConsumerState<AIWorkoutAdjusterTab> createState() =>
      _AIWorkoutAdjusterTabState();
}

class _AIWorkoutAdjusterTabState extends ConsumerState<AIWorkoutAdjusterTab> {
  final _feedbackController = TextEditingController();
  String _output = '';
  String _inputJson = '';
  bool _isLoading = false;

  Future<void> _adjustWorkout() async {
    if (_feedbackController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Enter mock feedback')));
      return;
    }

    setState(() {
      _isLoading = true;
      _output = 'Adjusting...';
    });

    try {
      final service = ref.read(aiServiceProvider);

      // Mock Data
      final plannedWorkout = Workout(
        id: 'mock-w-1',
        userId: 'mock-user',
        goalId: 'mock-goal',
        name: 'Tempo Run',
        description: 'Mock tempo run',
        type: 'run',
        status: 'planned',
        scheduledDate: DateTime.now(),
        plannedDuration: 3600,
        plannedDistance: 10.0,
        intensity: 7, // RPE for moderate tempo run
        blockId: 'mock-block',
      );

      final context = ShortTermContext(
        currentDate: DateTime.now(),
        todayWorkout: WorkoutSummary.fromEntity(plannedWorkout, DateTime.now()),
        next7Days: [],
        conversationHistory: [],
        currentPainLevel: 2,
        sleepQuality: 'good',
        weather: 'Sunny, 20C',
      );

      const systemPrompt = AIPrompts.ashPersona;
      const taskPrompt = AIPrompts.adjustWorkoutTask;
      final responseSchema = AISchemas.adjustedWorkout;

      setState(() {
        _inputJson = '''
Feedback: ${_feedbackController.text}
Workout: ${plannedWorkout.toJson()}
Context: ${context.toJson()}
''';
      });

      final result = await service.adjustWorkout(
        plannedWorkout: plannedWorkout,
        userFeedback: _feedbackController.text,
        context: context,
        systemPrompt: systemPrompt,
        taskPrompt: taskPrompt,
        responseSchema: responseSchema,
      );

      final prettyOutput =
          'Tokens: ${result.tokensUsed}\n\n${const JsonEncoder.withIndent('  ').convert((result.data as dynamic)?.toJson())}';

      setState(() {
        _output = prettyOutput;
      });
    } catch (e, st) {
      AppLogger.error('Adjustment Error', e, st);
      setState(() => _output = 'Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Mock Adjust Workout',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            controller: _feedbackController,
            decoration: const InputDecoration(
              labelText: 'User Feedback',
              hintText: 'e.g., "Too hard", "I have knee pain"',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _isLoading ? null : _adjustWorkout,
            child: Text(_isLoading ? 'Processing...' : 'Adjust Workout'),
          ),
          const Divider(height: 32),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text('Input Context',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Container(
                          color: Colors.black12,
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          child: SingleChildScrollView(
                              child: SelectableText(_inputJson)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    children: [
                      const Text('Output (Adjusted Workout)',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Container(
                          color: Colors.black12,
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          child: SingleChildScrollView(
                              child: SelectableText(_output)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
