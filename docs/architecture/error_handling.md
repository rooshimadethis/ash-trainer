# Error Handling

**Purpose**: Define error handling contracts and patterns for the application.

**Last Updated**: 2025-12-29

---

## Overview

This document defines:
- **Failure classes** - Domain layer error types
- **Exception classes** - Domain layer exceptions
- **Error handling patterns** - How errors flow through layers
- **User-facing error messages** - Error presentation strategy

---

## Failure Classes (Domain Layer)

**Location**: `core/errors/failures.dart`

Failures represent **expected error states** in business logic. They are returned as part of the normal flow (not thrown).

```dart
/// Base class for all failures
abstract class Failure {
  final String message;
  
  const Failure(this.message);
  
  @override
  String toString() => message;
}

/// Server/API failures
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

/// Database failures
class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}

/// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}

/// Not found failures
class NotFoundFailure extends Failure {
  const NotFoundFailure(String message) : super(message);
}

/// Permission failures
class PermissionFailure extends Failure {
  const PermissionFailure(String message) : super(message);
}

/// Network failures
class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

/// AI-specific failures
class AINetworkFailure extends Failure {
  const AINetworkFailure(String message) : super(message);
}

class AIRateLimitFailure extends Failure {
  final DateTime retryAfter;
  
  const AIRateLimitFailure(String message, this.retryAfter) : super(message);
}

class AIInvalidResponseFailure extends Failure {
  final String rawResponse;
  
  const AIInvalidResponseFailure(String message, this.rawResponse) : super(message);
}

class AISafetyBlockFailure extends Failure {
  const AISafetyBlockFailure(String message) : super(message);
}

class AIBudgetExceededFailure extends Failure {
  const AIBudgetExceededFailure(String message) : super(message);
}
```

---

## Exception Classes (Domain Layer)

**Location**: `core/errors/exceptions.dart`

Exceptions represent **unexpected error states** that should be caught and handled.

```dart
/// Base domain exception
class DomainException implements Exception {
  final String message;
  
  DomainException(this.message);
  
  @override
  String toString() => 'DomainException: $message';
}

/// Validation exception (business rule violation)
class ValidationException extends DomainException {
  ValidationException(String message) : super(message);
}

/// Not found exception
class NotFoundException extends DomainException {
  NotFoundException(String message) : super(message);
}

/// Invalid state exception
class InvalidStateException extends DomainException {
  InvalidStateException(String message) : super(message);
}
```

---

## Error Handling Patterns

### Pattern 1: Repository Error Handling

Repositories catch exceptions and convert them to Failures:

```dart
class GoalRepositoryImpl implements GoalRepository {
  final GoalDao _dao;
  
  @override
  Future<Goal> getGoal(String id) async {
    try {
      final dto = await _dao.getGoalById(int.parse(id));
      return dto.toEntity();
    } on SqliteException catch (e) {
      throw DatabaseFailure('Failed to get goal: ${e.message}');
    } catch (e) {
      throw DatabaseFailure('Unexpected error: $e');
    }
  }
}
```

---

### Pattern 2: Use Case Error Handling

Use cases catch failures and handle them appropriately:

```dart
class CalculateConfidence {
  final GoalRepository _goalRepo;
  final WorkoutRepository _workoutRepo;
  
  Future<double> execute(String goalId) async {
    try {
      final goal = await _goalRepo.getGoal(goalId);
      final workouts = await _workoutRepo.getWorkoutsForGoal(goalId);
      
      // Business logic
      final confidence = _calculateConfidence(goal, workouts);
      
      await _goalRepo.updateConfidence(
        goalId: goalId,
        confidence: confidence,
        // ... other scores
      );
      
      return confidence;
    } on NotFoundFailure catch (e) {
      // Goal not found - rethrow
      rethrow;
    } on DatabaseFailure catch (e) {
      // Database error - log and rethrow
      print('Database error: $e');
      rethrow;
    }
  }
}
```

---

### Pattern 3: Provider Error Handling

Providers catch errors and update state:

```dart
class GoalProgressNotifier extends StateNotifier<AsyncValue<GoalProgressState>> {
  final CalculateConfidence _calculateConfidence;
  
  GoalProgressNotifier(this._calculateConfidence) 
    : super(const AsyncValue.loading());
  
  Future<void> refreshConfidence(String goalId) async {
    state = const AsyncValue.loading();
    
    try {
      final confidence = await _calculateConfidence.execute(goalId);
      
      state = AsyncValue.data(GoalProgressState(
        confidence: confidence,
        // ... other data
      ));
    } on NotFoundFailure catch (e, stack) {
      state = AsyncValue.error(e, stack);
    } on DatabaseFailure catch (e, stack) {
      state = AsyncValue.error(e, stack);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
```

---

### Pattern 4: UI Error Handling

Widgets display errors from AsyncValue:

```dart
class GoalProgressDashboard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalProgressAsync = ref.watch(goalProgressProvider);
    
    return goalProgressAsync.when(
      data: (state) => _buildDashboard(state),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => _buildError(error),
    );
  }
  
  Widget _buildError(Object error) {
    String message;
    
    if (error is NotFoundFailure) {
      message = 'Goal not found. Please create a goal first.';
    } else if (error is DatabaseFailure) {
      message = 'Database error. Please try again.';
    } else if (error is NetworkFailure) {
      message = 'Network error. Check your connection.';
    } else {
      message = 'An unexpected error occurred.';
    }
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red),
          SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => ref.refresh(goalProgressProvider),
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}
```

---

## User-Facing Error Messages

### Error Message Guidelines

1. **Be specific but not technical**
   - ❌ "SqliteException: UNIQUE constraint failed"
   - ✅ "This goal already exists"

2. **Provide actionable guidance**
   - ❌ "Error occurred"
   - ✅ "Network error. Check your connection and try again."

3. **Use friendly tone**
   - ❌ "Invalid input"
   - ✅ "Please enter a valid distance between 1-200 km"

### Error Message Map

| Failure Type | User Message | Action |
|--------------|--------------|--------|
| `NotFoundFailure` | "Goal not found. Please create a goal first." | Navigate to goal setup |
| `DatabaseFailure` | "Something went wrong. Please try again." | Retry button |
| `NetworkFailure` | "Network error. Check your connection." | Retry button |
| `ValidationFailure` | Specific validation message (e.g., "Distance must be 1-200 km") | Highlight field |
| `PermissionFailure` | "Health permissions required. Please grant access in Settings." | Open settings |
| `ServerFailure` | "Server error. Please try again later." | Retry button |
| `AINetworkFailure` | "Unable to connect to AI service. Check your connection." | Show cached response or retry |
| `AIRateLimitFailure` | "Too many AI requests. Try again in X minutes." | Queue for retry, show countdown |
| `AIInvalidResponseFailure` | "AI service error. Please try again." | Retry with simplified prompt |
| `AISafetyBlockFailure` | "Unable to process request. Please rephrase." | Log for review, show generic error |
| `AIBudgetExceededFailure` | "Daily AI limit reached. Upgrade for more." | Show upgrade prompt, disable AI features |

---

## AI-Specific Error Handling

### AI Service Error Patterns

AI services have unique error scenarios that require special handling:

```dart
class AIServiceImpl implements AIService {
  @override
  Future<AIResponse<TrainingPlan>> generatePlan({
    required PlanGenerationContext context,
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> responseSchema,
  }) async {
    try {
      final response = await _geminiClient.generateContent(...);
      return AIResponse(
        data: TrainingPlan.fromJson(response.json),
        tokensUsed: response.tokensUsed,
        timestamp: DateTime.now(),
      );
    } on SocketException {
      throw AINetworkFailure('No internet connection');
    } on HttpException catch (e) {
      if (e.message.contains('429')) {
        throw AIRateLimitFailure(
          'Rate limit exceeded',
          DateTime.now().add(Duration(minutes: 5)),
        );
      }
      throw AINetworkFailure('HTTP error: ${e.message}');
    } on FormatException catch (e) {
      throw AIInvalidResponseFailure(
        'Invalid JSON response',
        e.source.toString(),
      );
    } catch (e) {
      throw AINetworkFailure('Unexpected AI error: $e');
    }
  }
}
```

### AI Error Fallback Strategies

| Failure Type | Fallback Strategy | Implementation |
|--------------|------------------|----------------|
| `AINetworkFailure` | Show cached response if available, otherwise "Offline mode" message | Check cache, display last known good state |
| `AIRateLimitFailure` | Queue request for retry, show "Try again in X minutes" | Store request, schedule retry, show countdown |
| `AIInvalidResponseFailure` | Retry once with same prompt, once with simplified prompt, then show error | Implement retry logic with exponential backoff |
| `AISafetyBlockFailure` | Log for review, show generic error to user | Analytics event, generic message |
| `AIBudgetExceededFailure` | Disable AI features until next billing cycle, show upgrade prompt | Feature flags, upgrade CTA |

### Use Case Error Handling with AI

```dart
class GenerateTrainingPlanUseCase {
  final AIService _aiService;
  final PlanRepository _planRepo;
  
  Future<TrainingPlan> execute(String goalId) async {
    try {
      final context = await _buildContext(goalId);
      
      final response = await _aiService.generatePlan(
        context: context,
        systemPrompt: ashPersonality,
        taskPrompt: planGenerationPrompt,
        responseSchema: trainingPlanSchema,
      );
      
      // Save to database
      await _planRepo.savePlan(response.data!);
      
      return response.data!;
    } on AIRateLimitFailure catch (e) {
      // Queue for retry
      await _queueForRetry(goalId, e.retryAfter);
      rethrow;
    } on AIInvalidResponseFailure catch (e) {
      // Retry with simplified prompt
      return await _retryWithSimplifiedPrompt(goalId);
    } on AINetworkFailure {
      // Check for cached plan
      final cachedPlan = await _planRepo.getCachedPlan(goalId);
      if (cachedPlan != null) {
        return cachedPlan;
      }
      rethrow;
    }
  }
}
```

### Provider Error Handling with AI

```dart
class CoachingChatNotifier extends StateNotifier<AsyncValue<String>> {
  final CoachingChatUseCase _chatUseCase;
  
  Future<void> sendMessage(String message) async {
    state = const AsyncValue.loading();
    
    try {
      final response = await _chatUseCase.execute(message);
      state = AsyncValue.data(response);
    } on AIRateLimitFailure catch (e, stack) {
      state = AsyncValue.error(
        'Too many messages. Try again in ${_formatDuration(e.retryAfter)}',
        stack,
      );
    } on AINetworkFailure catch (e, stack) {
      state = AsyncValue.error(
        'Unable to connect. Check your internet connection.',
        stack,
      );
    } on AIBudgetExceededFailure catch (e, stack) {
      state = AsyncValue.error(
        'Daily AI limit reached. Upgrade for unlimited coaching!',
        stack,
      );
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

```

---

## Validation Error Handling

### Field Validation

```dart
class GoalFormValidator {
  static String? validateDistance(double? distance) {
    if (distance == null) {
      return 'Distance is required';
    }
    if (distance < 1 || distance > 200) {
      return 'Distance must be between 1-200 km';
    }
    return null;
  }
  
  static String? validateTargetTime(int? seconds) {
    if (seconds == null) {
      return 'Target time is required';
    }
    if (seconds <= 0) {
      return 'Target time must be positive';
    }
    return null;
  }
}
```

### Domain Validation

```dart
class Goal {
  final double confidence;
  
  Goal({required this.confidence}) {
    if (confidence < 0 || confidence > 100) {
      throw ValidationException('Confidence must be 0-100');
    }
  }
}
```

---

## Error Logging

### Analytics Integration

```dart
class ErrorLogger {
  final AnalyticsService _analytics;
  
  void logError(Object error, StackTrace stackTrace) {
    // Log to analytics
    _analytics.logError(error, stackTrace);
    
    // Print to console in debug mode
    if (kDebugMode) {
      print('Error: $error');
      print('Stack trace: $stackTrace');
    }
  }
}
```

### Usage in Providers

```dart
class GoalProgressNotifier extends StateNotifier<AsyncValue<GoalProgressState>> {
  final ErrorLogger _errorLogger;
  
  Future<void> refreshConfidence(String goalId) async {
    try {
      // ... business logic
    } catch (e, stack) {
      _errorLogger.logError(e, stack);
      state = AsyncValue.error(e, stack);
    }
  }
}
```

---

## Related Documentation

- **[Interfaces](interfaces.md)** - Repository and service contracts
- **[Validation Rules](../data_models/validation_rules.md)** - Field validation rules
- **[System Architecture](system_architecture.md)** - Layer responsibilities

---

**Last Updated**: 2025-12-29
