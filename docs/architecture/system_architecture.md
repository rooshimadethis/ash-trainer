# System Architecture

**Architecture Pattern**: Riverpod + Clean Architecture  
**Last Updated**: 2025-12-29

---

## Overview

The Ash Trainer app follows **Clean Architecture** principles with **Riverpod** for state management. This architecture provides:

- **Clear separation of concerns** across 5 layers
- **Testable business logic** independent of UI and database
- **Offline-first** design with local Drift database
- **Scalable** structure for Phase 2+ features

---

## Architecture Diagram

```
┌─────────────────────────────────────────────────────┐
│              Presentation Layer                     │
│  - Screens (UI)                                     │
│  - Widgets (Reusable components)                    │
│  - Providers (Riverpod StateNotifiers)              │
│  - No business logic, only UI logic                 │
├─────────────────────────────────────────────────────┤
│              Application Layer                      │
│  - Use Cases (Business logic operations)            │
│  - State Management (Riverpod Providers)            │
│  - Coordinates between domain and data layers       │
├─────────────────────────────────────────────────────┤
│              Domain Layer                           │
│  - Entities (Pure Dart models)                      │
│  - Repository Interfaces (Contracts)                │
│  - Business Rules (Validation, calculations)        │
│  - No framework dependencies                        │
├─────────────────────────────────────────────────────┤
│              Data Layer                             │
│  - Repository Implementations                       │
│  - Data Sources (Local DB, API, Health Connect)     │
│  - DTOs (Data Transfer Objects)                     │
│  - Caching strategy                                 │
├─────────────────────────────────────────────────────┤
│              Infrastructure                         │
│  - Drift Database                                   │
│  - Health Connect/HealthKit integration             │
│  - AI API client (Gemini)                           │
│  - Analytics                                        │
└─────────────────────────────────────────────────────┘
```

---

## Dependency Rules

**Critical**: Dependencies flow **downward only** (no circular dependencies)

```
Presentation → Application → Domain ← Data → Infrastructure
                                ↑
                                └─── (Data depends on Domain interfaces)
```

| Layer | Depends On | Cannot Depend On |
|-------|------------|------------------|
| **Presentation** | Application, Domain | Data, Infrastructure |
| **Application** | Domain | Presentation, Data, Infrastructure |
| **Domain** | Nothing | All other layers |
| **Data** | Domain | Presentation, Application |
| **Infrastructure** | Nothing (or minimal) | All other layers |

---

## Layer Responsibilities

### 1. Presentation Layer

**Purpose**: Display data and handle user interactions

**Contains**:
- **Screens**: Full-page views (e.g., `TodayView`, `GoalProgressDashboard`)
- **Widgets**: Reusable UI components (e.g., `WorkoutCard`, `ConfidenceGauge`)
- **Providers**: Riverpod StateNotifiers that manage UI state

**Rules**:
- ✅ Can call use cases from Application layer
- ✅ Can read entities from Domain layer
- ❌ Cannot contain business logic
- ❌ Cannot directly access repositories or data sources

**Example**:
```dart
class TodayView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workouts = ref.watch(todayWorkoutsProvider);
    
    return workouts.when(
      data: (workouts) => WorkoutList(workouts: workouts),
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => ErrorWidget(err),
    );
  }
}
```

---

### 2. Application Layer

**Purpose**: Orchestrate business logic and coordinate data flow

**Contains**:
- **Use Cases**: Single-purpose operations (e.g., `CalculateConfidence`, `CreateGoal`)
- **Providers**: Riverpod providers that expose use cases to UI

**Rules**:
- ✅ Can call repository interfaces from Domain layer
- ✅ Can orchestrate multiple repositories
- ✅ Contains business workflows
- ❌ Cannot depend on UI framework
- ❌ Cannot know about database or API details

**Example**:
```dart
class CalculateConfidence {
  final GoalRepository _goalRepo;
  final WorkoutRepository _workoutRepo;
  
  Future<double> execute(String goalId) async {
    final workouts = await _workoutRepo.getWorkoutsForGoal(goalId);
    final adherence = _calculateAdherence(workouts);
    final quality = _calculateQuality(workouts);
    
    return (adherence * 0.4) + (quality * 0.3) + ...;
  }
}
```

---

### 3. Domain Layer

**Purpose**: Define business entities and contracts

**Contains**:
- **Entities**: Pure Dart classes (e.g., `Goal`, `Workout`, `User`)
- **Repository Interfaces**: Contracts for data access
- **Business Rules**: Validation logic, domain calculations

**Rules**:
- ✅ Pure Dart only (no Flutter, no external packages)
- ✅ Can be used in any Dart project
- ❌ Cannot depend on any other layer
- ❌ Cannot know about UI, database, or APIs

**Example**:
```dart
// Entity
class Goal {
  final String id;
  final String name;
  final double confidence;
  
  Goal({required this.id, required this.name, required this.confidence}) {
    if (confidence < 0 || confidence > 100) {
      throw DomainException('Confidence must be 0-100');
    }
  }
}

// Repository interface
abstract class GoalRepository {
  Future<Goal> getGoal(String id);
  Future<void> saveGoal(Goal goal);
  Future<Goal?> getActiveGoal();
}
```

---

### 4. Data Layer

**Purpose**: Implement data access and storage

**Contains**:
- **Repository Implementations**: Concrete implementations of Domain interfaces
- **Data Sources**: Drift DAOs, API clients, Health Connect
- **DTOs**: Database-specific models (Drift tables)

**Rules**:
- ✅ Implements repository interfaces from Domain
- ✅ Handles all database/API details
- ✅ Transforms between DTOs and Domain entities
- ❌ Cannot depend on Presentation or Application

**Example**:
```dart
class GoalRepositoryImpl implements GoalRepository {
  final GoalDao _dao;
  
  @override
  Future<Goal> getGoal(String id) async {
    final dto = await _dao.getGoalById(id);
    return Goal(
      id: dto.id,
      name: dto.name,
      confidence: dto.confidence,
    );
  }
  
  @override
  Future<void> saveGoal(Goal goal) async {
    await _dao.insertGoal(GoalDTO.fromEntity(goal));
  }
}
```

---

### 5. Infrastructure Layer

**Purpose**: Provide external services and integrations

**Contains**:
- **Drift Database**: SQLite setup and configuration
- **AI Service**: Gemini API client
- **Health Service**: Health Connect/HealthKit integration
- **Analytics**: Firebase Analytics, Crashlytics

**Rules**:
- ✅ Minimal dependencies on other layers
- ✅ Provides services to Data layer
- ❌ Should not contain business logic

---

## Folder Structure

See [Folder Structure](folder_structure.md) for complete directory layout.

**Key principles**:
- **Feature-based organization**: Each feature has its own folder
- **Shared domain**: Common entities in `features/shared/domain/`
- **Layer separation**: Each feature has `presentation/`, `application/`, `domain/` folders
- **Reusable widgets**: Shared UI components in `features/shared/presentation/widgets/`

---

## State Management (Riverpod)

### Provider Types

| Provider Type | Use Case | Example |
|---------------|----------|---------|
| **Provider** | Immutable data, dependencies | `goalRepositoryProvider` |
| **StateProvider** | Simple mutable state | `selectedDateProvider` |
| **StateNotifierProvider** | Complex state with methods | `calendarProvider` |
| **FutureProvider** | Async data loading | `activeGoalProvider` |
| **StreamProvider** | Real-time data streams | `biomarkersStreamProvider` |

### Provider Organization

```dart
// features/calendar/presentation/providers/calendar_provider.dart
final calendarProvider = StateNotifierProvider<CalendarNotifier, CalendarState>((ref) {
  final getWorkouts = ref.read(getWorkoutsForDateProvider);
  return CalendarNotifier(getWorkouts);
});

// Shared providers
// features/shared/presentation/providers/goal_provider.dart
final activeGoalProvider = FutureProvider<Goal>((ref) async {
  final repo = ref.read(goalRepositoryProvider);
  return repo.getActiveGoal();
});
```

---

## Data Flow Patterns

### Pattern 1: Read Data (Display)

```
Screen → Provider → Use Case → Repository → Data Source → Database
  ↓                                                           ↑
Display ←─────────────────────────────────────────────────────┘
```

### Pattern 2: Write Data (User Input)

```
Screen → Provider → Use Case → Repository → Data Source → Database
```

### Pattern 3: Computed Data (Business Logic)

```
Screen → Provider → Use Case → Multiple Repositories → Compute → Return
```

See [Data Flow Patterns](data_flow_patterns.md) for detailed examples.

---

## Service Boundaries

### AI Service

**Responsibilities**:
- Generate training plans
- Adjust and reschedule workouts
- Provide coaching chat (with function calling support)
- Manage AI context (long-term, medium-term, short-term)

**Interface**: See [AI Integration Architecture](ai_integration.md) and [AIService Interface](interfaces.md#ai-service)

**Related Repositories**:
- `ConversationRepository` - Manages chat sessions and messages
- `ContextRepository` - Manages AI context storage and regeneration

---

### Health Service

**Responsibilities**:
- Request Health Connect/HealthKit permissions
- Fetch workout and biomarker data
- Sync data to local database

**Interface**: See [Health Service](../services/health_service.md)

---

### Analytics Service

**Responsibilities**:
- Track user events
- Log errors and crashes
- Performance monitoring

**Interface**: See [Analytics Service](../services/analytics_service.md)

---

## Offline-First Strategy

### Local-First Architecture

- **All data stored locally** in Drift (SQLite)
- **App works 100% offline** for Phase 1
- **No cloud dependency** for core functionality

### Cloud Sync (Phase 2+)

- **Incremental sync**: Only changed records
- **Conflict resolution**: Last-write-wins with timestamp
- **Background sync**: When network available

---

## Testing Strategy

### Unit Tests
- **Domain Layer**: Test entities and business rules
- **Application Layer**: Test use cases with mocked repositories
- **Data Layer**: Test repository implementations with mocked data sources

### Widget Tests
- **Presentation Layer**: Test screens and widgets with mocked providers

### Integration Tests
- **End-to-end**: Test complete user flows

---

## Related Documentation

- **[Folder Structure](folder_structure.md)** - Complete directory layout
- **[Data Flow Patterns](data_flow_patterns.md)** - Detailed data flow examples
- **[Component Hierarchies](component_hierarchies.md)** - Feature-by-feature breakdown
- **[Data Models](../data_models/)** - Database schema
- **[User Journeys](../../ux/user_journeys/)** - UI/UX flows

---

**Last Updated**: 2025-12-29
