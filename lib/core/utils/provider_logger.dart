import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'logger.dart';

/// Observer for logging Riverpod provider events
class ProviderLogger extends ProviderObserver {
  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    AppLogger.e(
      'Provider ${provider.name ?? provider.runtimeType} failed',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
