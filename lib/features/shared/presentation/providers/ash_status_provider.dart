import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Global provider to track if Ash is currently "thinking" (e.g. processing an AI request).
final isAshThinkingProvider = StateProvider<bool>((ref) => false);
