import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../infrastructure/providers/service_providers.dart';

import '../../../shared/domain/entities/ai/context_models.dart';
import '../../../../core/constants/prompts.dart';

import '../../../../core/utils/logger.dart';

class AICoachingChatTab extends ConsumerStatefulWidget {
  const AICoachingChatTab({super.key});

  @override
  ConsumerState<AICoachingChatTab> createState() => _AICoachingChatTabState();
}

class _AICoachingChatTabState extends ConsumerState<AICoachingChatTab> {
  final _messageController = TextEditingController();
  final List<String> _chatLog = [];
  bool _isSending = false;

  Future<void> _sendMessage() async {
    final msg = _messageController.text;
    if (msg.isEmpty) return;

    setState(() {
      _chatLog.add('USER: $msg');
      _messageController.clear();
      _isSending = true;
    });

    try {
      final service = ref.read(aiServiceProvider);

      // Mock Context - In real app, this comes from BuildCoachingChatContext
      final context = CoachingChatContext(
        longTerm: LongTermContext(
          user: const UserContext(availableDays: ['mon', 'wed', 'fri']),
          goal: GoalContext(
              type: 'distance',
              target: 'Run 10km',
              deadline: DateTime.now().add(const Duration(days: 30)),
              priorities: {}),
          trainingPhilosophy: 'Consistency is key',
          overallAdherence: 0.8,
          raceDays: [],
        ),
        mediumTerm: MediumTermContext(
          periodStart: DateTime.now(),
          periodEnd: DateTime.now().add(const Duration(days: 7)),
          workoutsCompleted: 2,
          workoutsPlanned: 4,
          adherenceRate: 0.5,
          averageRPE: 7.0,
          totalDistance: 10.0,
          concerns: ['Knee pain'],
          achievements: [],
        ),
        shortTerm: ShortTermContext(
          currentDate: DateTime.now(),
          next7Days: [],
          conversationHistory: [], // Ideally we pass recent history here
          currentPainLevel: 3,
        ),
      );

      final response = await service.chat(
        userMessage: msg,
        context: context,
        systemPrompt: AIPrompts.ashPersona,
        taskPrompt: AIPrompts.coachingChatTask,
      );

      setState(() {
        _chatLog.add('ASH: ${response.data}');
      });
    } catch (e, st) {
      AppLogger.error('Chat Error', e, st);
      setState(() {
        _chatLog.add('SYSTEM ERROR: $e');
      });
    } finally {
      setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Chat History for Testing
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _chatLog.length,
            itemBuilder: (context, index) {
              final log = _chatLog[index];
              final isUser = log.startsWith('USER:');
              return Align(
                alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.blue[100] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(log),
                ),
              );
            },
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Type a message to Ash...',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: _isSending
                    ? const CircularProgressIndicator()
                    : const Icon(Icons.send),
                onPressed: _isSending ? null : _sendMessage,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
