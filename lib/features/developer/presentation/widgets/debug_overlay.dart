import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ash_trainer/features/onboarding/presentation/screens/welcome_screen.dart';
import '../screens/ai_test_screen.dart';
import 'package:ash_trainer/infrastructure/providers/service_providers.dart';

class DebugOverlay extends ConsumerStatefulWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  const DebugOverlay({
    super.key,
    required this.child,
    required this.navigatorKey,
  });

  @override
  ConsumerState<DebugOverlay> createState() => _DebugOverlayState();
}

class _DebugOverlayState extends ConsumerState<DebugOverlay> {
  bool _isExpanded = false;
  Offset _position = const Offset(20, 100);

  Future<void> _clearDatabase() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Database?'),
        content: const Text(
          'This will delete all user data, goals, and workouts. '
          'You will be returned to the welcome screen.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear All Data'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final db = ref.read(driftDatabaseProvider);

      // Delete all data from all tables
      await db.transaction(() async {
        await db.delete(db.workouts).go();
        await db.delete(db.trainingBlocks).go();
        await db.delete(db.phases).go();
        await db.delete(db.conversationMessages).go();
        await db.delete(db.conversations).go();
        await db.delete(db.mediumTermContext).go();
        await db.delete(db.longTermContext).go();
        await db.delete(db.goals).go();
        await db.delete(db.users).go();
      });

      // ignore: avoid_print
      print('🗑️ Database cleared successfully');

      // Navigate to welcome screen
      if (mounted) {
        widget.navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print('❌ Error clearing database: $e');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error clearing database: $e')),
        );
      }
    }
  }

  void _navigateToTestHub(int index) {
    widget.navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => AITestScreen(initialIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          left: _position.dx,
          top: _position.dy,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _position += details.delta;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton.small(
                  backgroundColor: Colors.redAccent,
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: const Icon(Icons.bug_report),
                ),
                if (_isExpanded) ...[
                  const SizedBox(width: 8),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Plan Generator
                      FloatingActionButton.extended(
                        heroTag: 'ai_plan_btn',
                        onPressed: () => _navigateToTestHub(0),
                        label: const Text('AI: Plan'),
                        icon: const Icon(Icons.calendar_month),
                      ),
                      const SizedBox(height: 8),
                      // Adjuster
                      FloatingActionButton.extended(
                        heroTag: 'ai_adj_btn',
                        onPressed: () => _navigateToTestHub(1),
                        label: const Text('AI: Adjust'),
                        icon: const Icon(Icons.tune),
                      ),
                      const SizedBox(height: 8),
                      // Rescheduler
                      FloatingActionButton.extended(
                        heroTag: 'ai_res_btn',
                        onPressed: () => _navigateToTestHub(2),
                        label: const Text('AI: Resched'),
                        icon: const Icon(Icons.edit_calendar),
                      ),
                      const SizedBox(height: 8),
                      // Chat
                      FloatingActionButton.extended(
                        heroTag: 'ai_chat_btn',
                        onPressed: () => _navigateToTestHub(3),
                        label: const Text('AI: Chat'),
                        icon: const Icon(Icons.chat),
                      ),
                      const SizedBox(height: 8),
                      // Clear DB
                      FloatingActionButton.extended(
                        heroTag: 'clear_db_btn',
                        backgroundColor: Colors.orange,
                        onPressed: _clearDatabase,
                        label: const Text('Clear DB'),
                        icon: const Icon(Icons.delete_forever),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
