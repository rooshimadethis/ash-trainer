import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_providers.g.dart';

@riverpod
class DebugShowShimmerSkeleton extends _$DebugShowShimmerSkeleton {
  @override
  bool build() {
    return false; // Default to false
  }

  void toggle() {
    state = !state;
  }

  void set(bool value) {
    state = value;
  }
}
