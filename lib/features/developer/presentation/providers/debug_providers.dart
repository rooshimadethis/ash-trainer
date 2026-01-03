import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_providers.g.dart';

@riverpod
class DebugShowShimmerSkeleton extends _$DebugShowShimmerSkeleton {
  @override
  bool build() {
    return false;
  }

  void set(bool value) {
    state = value;
  }
}

@riverpod
class DebugUseMockAi extends _$DebugUseMockAi {
  @override
  bool build() {
    return false;
  }

  void set(bool value) {
    state = value;
  }
}

@riverpod
class DebugAlternateMockPlan extends _$DebugAlternateMockPlan {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
