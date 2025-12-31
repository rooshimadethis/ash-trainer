import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/ai_plan_generator_tab.dart';
import '../widgets/ai_workout_adjuster_tab.dart';
import '../widgets/ai_rescheduler_tab.dart';
import '../widgets/ai_coaching_chat_tab.dart';

class AITestScreen extends ConsumerStatefulWidget {
  final int initialIndex;

  const AITestScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  ConsumerState<AITestScreen> createState() => _AITestScreenState();
}

class _AITestScreenState extends ConsumerState<AITestScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: widget.initialIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AI Test Hub'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.calendar_month), text: 'Plan Gen'),
              Tab(icon: Icon(Icons.tune), text: 'Adjuster'),
              Tab(icon: Icon(Icons.edit_calendar), text: 'Rescheduler'),
              Tab(icon: Icon(Icons.chat), text: 'Coaching Chat'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AIPlanGeneratorTab(),
            AIWorkoutAdjusterTab(),
            AIReschedulerTab(),
            AICoachingChatTab(),
          ],
        ),
      ),
    );
  }
}
