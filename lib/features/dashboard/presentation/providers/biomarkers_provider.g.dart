// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biomarkers_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$healthAuthorizedHash() => r'b8de01d317eb143676b9834a5ab4b600136fefb3';

/// See also [healthAuthorized].
@ProviderFor(healthAuthorized)
final healthAuthorizedProvider = AutoDisposeFutureProvider<bool>.internal(
  healthAuthorized,
  name: r'healthAuthorizedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$healthAuthorizedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HealthAuthorizedRef = AutoDisposeFutureProviderRef<bool>;
String _$todaysBiomarkersHash() => r'5853e7c838b05ef75113df81028c47f8666c6892';

/// Provider for today's biomarkers (reactive stream)
///
/// Copied from [todaysBiomarkers].
@ProviderFor(todaysBiomarkers)
final todaysBiomarkersProvider = AutoDisposeStreamProvider<Biomarker?>.internal(
  todaysBiomarkers,
  name: r'todaysBiomarkersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todaysBiomarkersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodaysBiomarkersRef = AutoDisposeStreamProviderRef<Biomarker?>;
String _$healthSyncHash() => r'd6ac84f30d842a5e1c4d54453eb388d55eda6e4d';

/// Provider for syncing health data
///
/// Copied from [HealthSync].
@ProviderFor(HealthSync)
final healthSyncProvider =
    AutoDisposeAsyncNotifierProvider<HealthSync, void>.internal(
  HealthSync.new,
  name: r'healthSyncProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$healthSyncHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HealthSync = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
