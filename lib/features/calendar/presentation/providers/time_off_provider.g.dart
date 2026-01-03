// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_off_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timeOffRepositoryHash() => r'f535325f9c2d0ff16802b31bd32dcda0ed994e35';

/// See also [timeOffRepository].
@ProviderFor(timeOffRepository)
final timeOffRepositoryProvider =
    AutoDisposeProvider<TimeOffRepository>.internal(
  timeOffRepository,
  name: r'timeOffRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$timeOffRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TimeOffRepositoryRef = AutoDisposeProviderRef<TimeOffRepository>;
String _$timeOffControllerHash() => r'0a966471683c933d542a105566e696b8d17a574e';

/// See also [TimeOffController].
@ProviderFor(TimeOffController)
final timeOffControllerProvider = AutoDisposeAsyncNotifierProvider<
    TimeOffController, List<TimeOffEntry>>.internal(
  TimeOffController.new,
  name: r'timeOffControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$timeOffControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TimeOffController = AutoDisposeAsyncNotifier<List<TimeOffEntry>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
