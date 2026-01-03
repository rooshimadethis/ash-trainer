import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ash_trainer/data/providers/task_providers.dart';

/// Global provider to track if Ash is currently "thinking".
/// Combines explicit UI state and background task status.
final isAshThinkingProvider = Provider<bool>((ref) {
  final uiThinking = ref.watch(uiThinkingProvider);
  final backgroundThinking = ref.watch(isAnyAIProcessingProvider);
  return uiThinking || backgroundThinking;
});

// Rename the old StateProvider to be the UI-only portion
final uiThinkingProvider = StateProvider<bool>((ref) => false);
