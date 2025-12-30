import 'package:flutter/material.dart';
import '../screens/ai_test_screen.dart';

class DebugOverlay extends StatefulWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  const DebugOverlay({
    super.key,
    required this.child,
    required this.navigatorKey,
  });

  @override
  State<DebugOverlay> createState() => _DebugOverlayState();
}

class _DebugOverlayState extends State<DebugOverlay> {
  bool _isExpanded = false;
  Offset _position = const Offset(20, 100);

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
                  FloatingActionButton.small(
                    heroTag: 'ai_test_btn',
                    onPressed: () {
                      widget.navigatorKey.currentState?.push(
                        MaterialPageRoute(
                          builder: (_) => const AITestScreen(),
                        ),
                      );
                    },
                    child: const Icon(Icons.psychology),
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
