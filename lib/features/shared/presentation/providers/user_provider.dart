import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';
import '../../../../data/providers/repository_providers.dart';

/// Provider for the current user
/// Fetches and caches the current user from the repository
final currentUserProvider = FutureProvider<User?>((ref) async {
  final userRepo = ref.watch(userRepositoryProvider);
  return await userRepo.getCurrentUser();
});

/// Provider for the user's preferred distance unit
/// Defaults to 'km' if user is not found or preference is not set
final preferredDistanceUnitProvider = Provider<String>((ref) {
  final userAsync = ref.watch(currentUserProvider);
  return userAsync.when(
    data: (user) => user?.preferredDistanceUnit ?? 'km',
    loading: () => 'km',
    error: (_, __) => 'km',
  );
});
