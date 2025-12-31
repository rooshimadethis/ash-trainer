# Repository & Service Interfaces

**Purpose**: Define contracts between layers for data access and external integrations.

**Last Updated**: 2025-12-29

---

## Overview

This document defines all interfaces (contracts) for:
- **Repository Interfaces** - Data access contracts (Domain layer)
- **Service Interfaces** - External system contracts (Infrastructure layer)
- **DTOs** - Data transfer objects (Data layer)
- **Provider Organization** - Dependency injection patterns

---

## Repository Interfaces (Domain Layer)

All repository interfaces are defined in `features/shared/domain/repositories/` and represent contracts for accessing app data.

### User Repository

**Location**: `features/shared/domain/repositories/user_repository.dart`

```dart
abstract class UserRepository {
  /// Creates a new user profile
  Future<User> createUser(User user);
  
  /// Gets the current user (single-user app)
  Future<User?> getCurrentUser();
  
  /// Updates user profile
  Future<void> updateUser(User user);
  
  /// Updates available training days
  Future<void> updateAvailableDays(List<String> days);
  
  /// Updates health permissions status
  Future<void> updateHealthPermissions(bool granted);
}
```

---

### Goal Repository

**Location**: `features/shared/domain/repositories/goal_repository.dart`

```dart
abstract class GoalRepository {
  /// Creates a new goal
  Future<Goal> createGoal(Goal goal);
  
  /// Gets a goal by ID
  Future<Goal> getGoal(String id);
  
  /// Gets all goals
  Future<List<Goal>> getGoals();
  
  /// Gets the currently active goal
  Future<Goal?> getActiveGoal();
  
  /// Updates a goal
  Future<void> updateGoal(Goal goal);
  
  /// Updates confidence scores
  Future<void> updateConfidence({
    required String goalId,
    required double confidence,
    required double adherenceScore,
    required double qualityScore,
    required double consistencyScore,
    required double recoveryScore,
  });
  
  /// Deactivates a goal
  Future<void> deactivateGoal(String goalId);
  
  /// Deletes a goal
  Future<void> deleteGoal(String goalId);
}
```

---

### Workout Repository

**Location**: `features/shared/domain/repositories/workout_repository.dart`

```dart
abstract class WorkoutRepository {
  /// Creates a workout
  Future<Workout> createWorkout(Workout workout);
  
  /// Creates multiple workouts (bulk)
  Future<List<Workout>> createWorkouts(List<Workout> workouts);
  
  /// Gets a workout by ID
  Future<Workout> getWorkout(String id);
  
  /// Gets workouts for a goal
  Future<List<Workout>> getWorkoutsForGoal(String goalId);

  /// Gets workouts for a Phase
  Future<List<Workout>> getWorkoutsForPhase(String phaseId);

  /// Gets workouts for a Block
  Future<List<Workout>> getWorkoutsForBlock(String blockId);
  
  /// Gets workouts for a date
  Future<List<Workout>> getWorkoutsForDate(DateTime date);
  
  /// Gets workouts for a date range
  Future<List<Workout>> getWorkoutsForDateRange({
    required DateTime startDate,
    required DateTime endDate,
  });
  
  /// Updates a workout
  Future<void> updateWorkout(Workout workout);
  
  /// Logs workout completion
  Future<void> logWorkout({
    required String workoutId,
    required int actualDuration,
    required double? actualDistance,
    required double? actualPace,
    required int rpe,
  });
  
  /// Marks workout as skipped
  Future<void> skipWorkout(String workoutId);
  
  /// Marks workout as missed
  Future<void> markWorkoutMissed(String workoutId);
  
  /// Watches workouts (real-time updates)
  Stream<List<Workout>> watchWorkouts();
  
  /// Watches workouts for a date
  Stream<List<Workout>> watchWorkoutsForDate(DateTime date);

  /// Gets the date of the last scheduled workout
  /// Used for "Horizon Filling"
  Future<DateTime?> getLastScheduledWorkoutDate(String goalId);

  /// Gets the number of consecutive days with missed workouts (ending yesterday)
  /// Used for "Strategic Repair" trigger
  Future<int> getConsecutiveMissedDays(String goalId);

  /// Deletes all future workouts starting from a specific date
  /// Used during "Strategic Repair" to clear the runway for a new plan
  Future<void> clearFutureWorkouts({
    required String goalId,
    required DateTime fromDate,
  });
}
```

**Note**: See [implementation_plan.md](file:///Users/rooshi/.gemini/antigravity/brain/447231aa-97e6-4495-9cc1-bd1d32f7ae60/implementation_plan.md) for complete recovery widget implementation details.

---

### Biomarker Repository

**Location**: `features/shared/domain/repositories/biomarker_repository.dart`

```dart
abstract class BiomarkerRepository {
  /// Watch today's biomarkers (reactive stream)
  Stream<Biomarker?> watchTodaysBiomarkers();
  
  /// Save biomarkers to database
  Future<Either<Failure, void>> saveBiomarkers(Biomarker biomarker);
}
```

**Notes**:
- MVP implementation only includes two methods (add more as needed)
- `watchTodaysBiomarkers()` returns a stream for reactive UI updates
- `saveBiomarkers()` uses upsert pattern (update if exists, insert if not)
- Additional methods (getByDate, getDateRange, etc.) can be added in future phases

---

### Conversation Repository

**Location**: `features/shared/domain/repositories/conversation_repository.dart`

```dart
abstract class ConversationRepository {
  /// Creates a new conversation session
  Future<Conversation> createConversation(String userId);
  
  /// Gets a conversation by ID
  Future<Conversation?> getConversation(String id);
  
  /// Gets the current active conversation for user
  Future<Conversation?> getActiveConversation(String userId);
  
  /// Ends a conversation session
  Future<void> endConversation(String id);
  
  /// Saves a message to a conversation
  Future<ConversationMessage> saveMessage({
    required String conversationId,
    required String role,
    required String content,
    FunctionCall? functionCall,
  });
  
  /// Gets recent messages from a conversation
  Future<List<ConversationMessage>> getRecentMessages({
    required String conversationId,
    required int limit,
  });
  
  /// Deletes old conversations (cleanup)
  Future<void> deleteOldConversations({
    required DateTime before,
  });
}
```

---

### Context Repository

**Location**: `features/shared/domain/repositories/context_repository.dart`

```dart
abstract class ContextRepository {
  /// Gets long-term context for current user/goal
  Future<LongTermContext?> getLongTermContext();
  
  /// Saves/updates long-term context
  Future<void> saveLongTermContext(LongTermContext context);
  
  /// Gets medium-term context for current user
  Future<MediumTermContext?> getMediumTermContext();
  
  /// Saves/updates medium-term context
  Future<void> saveMediumTermContext(MediumTermContext context);
  
  /// Invalidates long-term context (forces regeneration)
  Future<void> invalidateLongTermContext();
  
  /// Checks if long-term context needs regeneration
  Future<bool> needsLongTermRegeneration();
  
  /// Checks if medium-term context needs regeneration
  Future<bool> needsMediumTermRegeneration();
}
```

---

## Service Interfaces (Infrastructure Layer)

### AI Service

**Location**: `infrastructure/services/ai_service.dart`

```dart
/// Training plan generated by AI
class TrainingPlan {
  final List<Phase> phases;
  final List<TrainingBlock> blocks;
  final List<Workout> workouts;
  
  TrainingPlan({
    required this.phases,
    required this.blocks,
    required this.workouts,
  });
}


/// AI service for plan generation, coaching, and adjustments
abstract class AIService {
  /// Generate a complete training plan
  /// Uses PlanGenerationContext built by BuildPlanGenerationContext use case
  Future<AIResponse<TrainingPlan>> generatePlan({
    required PlanGenerationContext context,
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> responseSchema,
  });
  
  /// Adjust a single workout based on user feedback
  /// Uses context built by BuildWorkoutAdjustmentContext use case
  Future<AIResponse<Workout>> adjustWorkout({
    required Workout plannedWorkout,
    required String userFeedback,
    required ShortTermContext context,
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> responseSchema,
  });
  
  /// Reschedule workouts within/across Phases/Blocks
  /// Uses context built by BuildRescheduleContext use case
  Future<AIResponse<List<Workout>>> rescheduleWorkouts({
    required List<String> workoutIds,
    required String reason,
    required ShortTermContext context,
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> responseSchema,
  });
  
  /// Daily coaching chat (non-streaming)
  /// Uses CoachingChatContext built by BuildCoachingChatContext use case
  Future<AIResponse<String>> chat({
    required String userMessage,
    required CoachingChatContext context,
    required String systemPrompt,
    required String taskPrompt,
  });
  
  /// Daily coaching chat (streaming)
  /// Uses CoachingChatContext built by BuildCoachingChatContext use case
  Stream<AIResponse<String>> chatStream({
    required String userMessage,
    required CoachingChatContext context,
    required String systemPrompt,
    required String taskPrompt,
  });
  
  /// Chat with function calling support (non-streaming)
  /// AI can decide to call functions or respond with text
  Future<AIResponse<String>> chatWithTools({
    required String userMessage,
    required CoachingChatContext context,
    required String systemPrompt,
    required String taskPrompt,
    required List<FunctionDeclaration> tools,
  });
  
  /// Chat with function calling support (streaming)
  /// AI can decide to call functions or respond with text
  Stream<AIResponse<String>> chatStreamWithTools({
    required String userMessage,
    required CoachingChatContext context,
    required String systemPrompt,
    required String taskPrompt,
    required List<FunctionDeclaration> tools,
  });
}
```

**Key Changes from Architecture Doc**:
- Uses concrete types (`PlanGenerationContext`, `CoachingChatContext`, etc.) instead of `Map<String, dynamic>`
- All methods return `AIResponse<T>` for consistent response handling
- Removed `explainConfidenceChange` (moved to local logic)
- Added both streaming and non-streaming variants for chat
- Added `chatWithTools` methods for function calling

**Related Types**:
- See [AI Entities](../data_models/ai_entities.md) for all context class definitions
- See [AI Integration Architecture](ai_integration.md) for usage patterns

---

### Health Service

**Location**: `features/shared/domain/services/health_service.dart`

```dart
/// Health data returned from Health Connect/HealthKit
class HealthData {
  final int? sleepDuration;  // minutes
  final double? hrv;  // milliseconds (SDNN)
  final int? rhr;  // beats per minute
  
  const HealthData({
    this.sleepDuration,
    this.hrv,
    this.rhr,
  });
}

/// Health service for device integration
abstract class HealthService {
  /// Request permissions for health data access
  Future<bool> requestPermissions();
  
  /// Fetch today's health data (sleep, HRV, RHR)
  Future<HealthData?> fetchTodaysHealthData();
}
```

**Phase 2 MVP Implementation**:
- Only fetches three metrics: sleep duration, HRV (SDNN), and RHR
- Requests permissions for: `SLEEP_ASLEEP`, `HEART_RATE_VARIABILITY_SDNN`, `RESTING_HEART_RATE`
- Returns `null` if no data available or permissions denied
- All fields in `HealthData` are nullable (partial data is acceptable)

**Future Expansion**:
- Add `watchHealthData()` stream for real-time updates
- Add methods for historical data (`getHealthDataForRange`)
- Add workout sync (`getWorkouts`)
- Add more health metrics (sleep quality, stress, etc.)

---

### Analytics Service

**Location**: `infrastructure/services/analytics_service.dart`

```dart
abstract class AnalyticsService {
  /// Logs a custom event
  void logEvent(String name, Map<String, dynamic> parameters);
  
  /// Logs a screen view
  void logScreenView(String screenName);
  
  /// Logs an error
  void logError(Object error, StackTrace stackTrace);
  
  /// Sets user properties
  void setUserProperties(Map<String, dynamic> properties);
}
```

---

## Data Transfer Objects (DTOs)

DTOs live in `data/models/` and map between Drift tables and Domain entities.

### DTO Mapping Pattern

```dart
// Extension on DTO for conversion
extension GoalDTOMapper on GoalDTO {
  /// Converts DTO to Domain entity
  Goal toEntity() {
    return Goal(
      id: id.toString(),
      userId: userId.toString(),
      type: GoalType.fromString(type),
      name: name,
      // ... all fields
    );
  }
  
  /// Converts Domain entity to DTO
  static GoalDTO fromEntity(Goal goal) {
    return GoalDTO(
      id: int.parse(goal.id),
      userId: int.parse(goal.userId),
      type: goal.type.toString(),
      name: goal.name,
      // ... all fields
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
```

### Usage in Repository

```dart
class GoalRepositoryImpl implements GoalRepository {
  final GoalDao _dao;
  
  @override
  Future<Goal> getGoal(String id) async {
    final dto = await _dao.getGoalById(int.parse(id));
    return dto.toEntity(); // DTO → Entity
  }
  
  @override
  Future<void> updateGoal(Goal goal) async {
    final dto = GoalDTOMapper.fromEntity(goal); // Entity → DTO
    await _dao.updateGoal(dto);
  }
}
```

---

## Provider Organization

### Dependency Providers

**Location**: `infrastructure/providers/service_providers.dart`

```dart
// Database
final driftDatabaseProvider = Provider<DriftDatabase>((ref) {
  return DriftDatabase();
});

// Services
final aiServiceProvider = Provider<AIService>((ref) {
  return AIServiceImpl();
});

final healthServiceProvider = Provider<HealthService>((ref) {
  return HealthServiceImpl();
});

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsServiceImpl();
});
```

---

### Repository Providers

**Location**: `data/providers/repository_providers.dart`

```dart
final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  final db = ref.read(driftDatabaseProvider);
  return GoalRepositoryImpl(db.goalDao);
});

final workoutRepositoryProvider = Provider<WorkoutRepository>((ref) {
  final db = ref.read(driftDatabaseProvider);
  return WorkoutRepositoryImpl(db.workoutDao);
});

// ... all 8 repositories
```

---

### Use Case Providers

**Location**: `features/*/application/providers/usecase_providers.dart`

```dart
final calculateConfidenceProvider = Provider<CalculateConfidence>((ref) {
  final goalRepo = ref.read(goalRepositoryProvider);
  final workoutRepo = ref.read(workoutRepositoryProvider);
  final acwrRepo = ref.read(acwrRepositoryProvider);
  return CalculateConfidence(goalRepo, workoutRepo, acwrRepo);
});
```

---

### State Providers

**Location**: `features/*/presentation/providers/*_provider.dart`

```dart
final goalProgressProvider = StateNotifierProvider<GoalProgressNotifier, GoalProgressState>((ref) {
  final calculateConfidence = ref.read(calculateConfidenceProvider);
  return GoalProgressNotifier(calculateConfidence);
});
```

---

## Related Documentation

- **[Error Handling](error_handling.md)** - Failure and exception contracts
- **[System Architecture](system_architecture.md)** - Layer responsibilities
- **[Data Models](../data_models/)** - Entity definitions

---

**Last Updated**: 2025-12-29
