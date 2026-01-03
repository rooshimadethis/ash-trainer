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

@Riverpod(keepAlive: true)
class DebugUseMockAi extends _$DebugUseMockAi {
  @override
  bool build() {
    return false;
  }

  void set(bool value) {
    state = value;
  }
}

@Riverpod(keepAlive: true)
class DebugAlternateMockPlan extends _$DebugAlternateMockPlan {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
