import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../infrastructure/providers/service_providers.dart';

import '../../../shared/domain/entities/ai/context_models.dart';
import '../../../../core/constants/ai_schemas.dart';
import '../../../../core/constants/prompts.dart';
import '../../../../core/utils/logger.dart';
import 'package:ash_trainer/features/shared/presentation/providers/ash_status_provider.dart';

class AIReschedulerTab extends ConsumerStatefulWidget {
  const AIReschedulerTab({super.key});

  @override
  ConsumerState<AIReschedulerTab> createState() => _AIReschedulerTabState();
}

class _AIReschedulerTabState extends ConsumerState<AIReschedulerTab> {
  final _reasonController = TextEditingController();
  String _output = '';
  String _inputJson = '';
  bool _isLoading = false;

  Future<void> _reschedule() async {
    if (_reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Enter mock reason')));
      return;
    }

    setState(() {
      _isLoading = true;
      _output = 'Rescheduling...';
    });
    ref.read(isAshThinkingProvider.notifier).state = true;

    try {
      final service = ref.read(aiServiceProvider);

      // Mock Context
      final context = ShortTermContext(
        currentDate: DateTime.now(),
        next7Days: [], // Mocking empty for test simplicity
        conversationHistory: [],
        currentPainLevel: 0,
        sleepQuality: 'good',
        weather: 'Rainy',
      );

      const systemPrompt = AIPrompts.ashPersona;
      const taskPrompt = AIPrompts.rescheduleTask;
      final responseSchema = AISchemas.rescheduleWorkouts;

      final workoutIds = ['w-1', 'w-2'];

      setState(() {
        _inputJson = '''
Reason: ${_reasonController.text}
Workouts: $workoutIds
Context: ${context.toJson()}
''';
      });

      final result = await service.rescheduleWorkouts(
        workoutIds: workoutIds,
        reason: _reasonController.text,
        context: context,
        systemPrompt: systemPrompt,
        taskPrompt: taskPrompt,
        responseSchema: responseSchema,
      );

      final costStr = result.totalCost != null
          ? ' (\$${result.totalCost!.toStringAsFixed(4)})'
          : '';
      final prettyOutput =
          'Tokens: ${result.tokensUsed}$costStr\n\n${const JsonEncoder.withIndent('  ').convert((result.data as List<dynamic>?)?.map((w) => w.toJson()).toList())}';

      setState(() {
        _output = prettyOutput;
      });
    } catch (e, st) {
      AppLogger.e('Reschedule Error', error: e, stackTrace: st);
      setState(() => _output = 'Error: $e');
    } finally {
      setState(() => _isLoading = false);
      ref.read(isAshThinkingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Mock Reschedule Workouts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            controller: _reasonController,
            decoration: const InputDecoration(
              labelText: 'Reschedule Reason',
              hintText: 'e.g., "Sick today", "Traveling until Friday"',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _isLoading ? null : _reschedule,
            child: Text(_isLoading ? 'Processing...' : 'Reschedule (Mock)'),
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
                      const Text('Output (New Schedule)',
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
