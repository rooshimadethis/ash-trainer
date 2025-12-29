# Design Progression Tracker

This document outlines the standard progression from product vision to implementation. Use this as a checklist to ensure you're building on solid foundations at each stage.

---

## 📋 Overview

The proper flow from idea to code follows these stages:

```
1. Product Spec (Features & Flows)
   ↓
2. UI/UX Wireframes & User Journeys
   ↓
3. Information Architecture (Data Models)
   ↓
4. System Architecture (Components & Layers)
   ↓
5. API/Interface Design
   ↓
6. Implementation (Functions & Code)
```

**Key Principle**: Each stage validates and informs the next. Skipping stages leads to rework and architectural debt.

---

## Stage 1: Product Specification ✅

**Status**: Complete  
**Location**: [`docs/ux/product_spec/`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/)

### Purpose
Define **what** the app does and **why** it exists.

### Deliverables
- [x] Feature list organized by domain
- [x] User personas and target audience
- [x] Core value propositions
- [x] Design philosophy and brand identity
- [x] Privacy and security considerations

### Validation Criteria
- [ ] Each feature has a clear user benefit
- [ ] Features align with the core vision
- [ ] Scope is realistic for MVP

### Next Step
Once features are defined, map out **how users will interact** with each feature.

---

## Stage 2: UI/UX Wireframes & User Journeys ✅

**Status**: Phase 1 Complete  
**Location**: [`docs/ux/user_journeys/`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/user_journeys/)

### Purpose
Define **how** users will experience each feature through visual flows and interaction patterns.

### Deliverables
- [x] User journey maps for core features (Phase 1)
  - [x] Goal Setting journey ([01_onboarding_goal_setup.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/user_journeys/01_onboarding_goal_setup.md))
  - [ ] Daily Check-in journey (Phase 2)
  - [ ] Workout Logging journey (Phase 2)
  - [x] Calendar/Plan Review journey ([04_calendar_view.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/user_journeys/04_calendar_view.md))
  - [x] Onboarding journey (included in 01_onboarding_goal_setup.md)
  - [x] Goal Progress journey ([05_goal_progress.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/user_journeys/05_goal_progress.md))
- [x] Screen inventory (23 screens identified from Phase 1 journeys)
- [ ] Wireframes or mockups (deferred to implementation)
- [x] Navigation map (entry/exit points documented in each journey)
- [x] Interaction patterns (swipe gestures, modals, transitions documented)

### User Journey Template
For each feature, document:
```
Feature: [Feature Name]
Entry Points: [How users access this feature]
Steps:
  1. [Screen Name] → [User Action] → [System Response]
  2. [Screen Name] → [User Action] → [System Response]
  ...
Exit Points: [Where users go after completion]
Edge Cases: [Error states, empty states, loading states]
```

### Validation Criteria
- [x] Every feature from Stage 1 has a corresponding user journey (Phase 1 features complete)
- [x] All screens are accounted for (23 screens documented)
- [x] Navigation flows are logical and intuitive (entry/exit points defined)
- [x] Edge cases and error states are considered (documented in each journey)

### Next Step
Once you know what screens exist and what they display, define the **data structures** needed to support them.

---

## Stage 3: Information Architecture (Data Models) ✅

**Status**: Complete  
**Location**: [`docs/architecture/data_models/`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/data_models/)

### Purpose
Define **what data** the app needs to store, retrieve, and manipulate.

### Deliverables
- [x] Entity-Relationship Diagrams (ERD) - [_index.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/data_models/_index.md)
- [x] Data model definitions (tables, fields, relationships) - [entities.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/data_models/entities.md)
- [x] Data validation rules - [validation_rules.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/data_models/validation_rules.md)
- [x] Data lifecycle (creation, updates, deletion) - [data_lifecycle.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/data_models/data_lifecycle.md)
- [x] Screen-to-data mapping (which screens need which data) - [entities.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/data_models/entities.md)

### Screen-to-Data Mapping Template
```
Screen: [Screen Name]
Displays:
  - [Data Entity 1] (fields: x, y, z)
  - [Data Entity 2] (fields: a, b, c)
Collects:
  - [Form Field 1] → [Data Entity.field]
  - [Form Field 2] → [Data Entity.field]
Modifies:
  - [Data Entity] (update action)
Data Source:
  - Local DB (Drift)
  - API Call (which endpoint)
  - Computed (from what)
```

### Validation Criteria
- [ ] Every screen from Stage 2 has its data requirements mapped
- [ ] All data entities have clear ownership and lifecycle
- [ ] Relationships between entities are defined
- [ ] Data models support all features from Stage 1
- [ ] No redundant or conflicting data structures

### Next Step
Once data models are validated, define **how the app is structured** to manage this data.

---

## Stage 4: System Architecture (Components & Layers) ✅

**Status**: Complete  
**Location**: [`docs/architecture/`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/)

### Purpose
Define **how** the app is organized into layers, components, and services.

### Deliverables
- [x] Architecture pattern selection (Riverpod + Clean Architecture) - [system_architecture.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/system_architecture.md)
- [x] Layer definitions and responsibilities - [system_architecture.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/system_architecture.md#layer-responsibilities)
- [x] Folder structure and organization - [folder_structure.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/folder_structure.md)
- [x] Dependency rules (which layers can depend on which) - [system_architecture.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/system_architecture.md#dependency-rules)
- [x] Component hierarchy per feature - [system_architecture.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/system_architecture.md)
- [x] Service boundaries and responsibilities - [system_architecture.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/system_architecture.md#service-boundaries)
- [x] Data flow diagrams (how data moves through layers) - [system_architecture.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/system_architecture.md#data-flow-patterns)
- [x] Local vs Cloud strategy (what lives where) - [system_architecture.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/system_architecture.md#offline-first-strategy)
- [x] Offline support strategy - [system_architecture.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/system_architecture.md#offline-first-strategy)

### Flutter Layer Template
```
┌─────────────────────────────────┐
│   UI Layer (Widgets/Screens)   │
│   - Displays data               │
│   - Handles user input          │
│   - No business logic           │
├─────────────────────────────────┤
│   Business Logic (State Mgmt)  │
│   - Manages app state           │
│   - Coordinates data flow       │
│   - Implements use cases        │
├─────────────────────────────────┤
│   Domain Layer (Models)         │
│   - Pure Dart classes           │
│   - Business rules              │
│   - No framework dependencies   │
├─────────────────────────────────┤
│   Data Layer (Repositories)     │
│   - Abstracts data sources      │
│   - Caching strategy            │
│   - Data transformation         │
├─────────────────────────────────┤
│   Services (External)           │
│   - API clients                 │
│   - Database (Drift)            │
│   - AI/ML services              │
│   - Analytics                   │
└─────────────────────────────────┘
```

### Feature Component Template
```
Feature: [Feature Name]
Screens:
  - [ScreenName]Screen (main entry point)
  - [ScreenName]DetailScreen (detail view)
Widgets:
  - [WidgetName]Card (reusable component)
  - [WidgetName]List (reusable component)
State Management:
  - [FeatureName]Notifier (state provider)
  - [FeatureName]State (state model)
Repositories:
  - [FeatureName]Repository (data access)
Services Used:
  - [ServiceName] (for what purpose)
```

### Validation Criteria
- [ ] Architecture pattern is chosen and justified
- [ ] All features from Stage 1 have component hierarchies defined
- [ ] Layer responsibilities are clear and non-overlapping
- [ ] Dependency flow is unidirectional (no circular dependencies)
- [ ] Service boundaries are well-defined
- [ ] Folder structure supports the architecture

### Next Step
Once the system architecture is defined, create **contracts** between layers.

---

## Stage 5: API/Interface Design ✅

**Status**: Complete  
**Location**: [`docs/architecture/`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/)

### Purpose
Define **contracts** between layers and external services.

### Deliverables
- [x] Repository interfaces (abstract data access) - [interfaces.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/interfaces.md)
- [x] Service interfaces (external integrations) - [interfaces.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/interfaces.md#service-interfaces-infrastructure-layer)
- [x] State management contracts (providers, notifiers) - [interfaces.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/interfaces.md#provider-organization)
- [x] Data transfer objects (DTOs) - [interfaces.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/interfaces.md#data-transfer-objects-dtos)
- [x] Error handling contracts - [error_handling.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/error_handling.md)

### Repository Interface Template
```dart
abstract class GoalRepository {
  /// Fetches all goals for the current user
  Future<List<Goal>> getGoals();
  
  /// Creates a new goal
  Future<Goal> createGoal(Goal goal);
  
  /// Updates an existing goal
  Future<Goal> updateGoal(Goal goal);
  
  /// Deletes a goal by ID
  Future<void> deleteGoal(String goalId);
  
  /// Gets the currently active goal
  Future<Goal?> getActiveGoal();
}
```

### Service Interface Template
```dart
abstract class TrainingPlanService {
  /// Generates a training plan based on goal and user profile
  Future<TrainingPlan> generatePlan({
    required Goal goal,
    required UserProfile profile,
  });
  
  /// Adjusts an existing plan based on feedback
  Future<TrainingPlan> adjustPlan({
    required TrainingPlan plan,
    required List<WorkoutFeedback> feedback,
  });
}
```

### Validation Criteria
- [ ] All repositories have defined interfaces
- [ ] All services have defined interfaces
- [ ] Method signatures are clear and well-documented
- [ ] Error cases are handled in contracts
- [ ] Interfaces are implementation-agnostic (no concrete dependencies)

### Next Step
Once interfaces are defined, you can **implement** the actual code.

---

## Stage 6: Implementation (Functions & Code) ⚠️

**Status**: Partially Started (Premature)  
**Location**: `lib/` (Flutter code), [`docs/architecture/data_processing/`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/data_processing/)

### Purpose
Write the actual code that brings the design to life.

### Deliverables
- [ ] Implement data models (Drift tables)
- [ ] Implement repositories (concrete classes)
- [ ] Implement services (API clients, AI integration)
- [ ] Implement state management (providers, notifiers)
- [ ] Implement UI components (widgets, screens)
- [ ] Write unit tests for business logic
- [ ] Write widget tests for UI components
- [ ] Write integration tests for user flows

### Implementation Order
1. **Foundation** (Core services, database setup)
2. **Data Layer** (Repositories, data sources)
3. **Domain Layer** (Models, business logic)
4. **Business Logic Layer** (State management)
5. **UI Layer** (Screens, widgets)
6. **Integration** (Connect all layers)
7. **Testing** (Unit, widget, integration tests)

### Validation Criteria
- [ ] Code follows architecture defined in Stage 4
- [ ] All interfaces from Stage 5 are implemented
- [ ] Data models from Stage 3 are implemented
- [ ] UI matches wireframes from Stage 2
- [ ] All features from Stage 1 are functional
- [ ] Tests cover critical paths
- [ ] Code is documented and maintainable

---

## 🎯 Current Status Summary

| Stage | Status | Completion | Blocker |
|-------|--------|------------|---------|
| 1. Product Spec | ✅ Complete | 100% | None |
| 2. UI/UX Journeys | ✅ Phase 1 Complete | 60% | Phase 2+ journeys pending |
| 3. Data Models | ✅ Complete | 100% | None |
| 4. System Architecture | ✅ Complete | 100% | None |
| 5. API/Interface Design | ✅ Complete | 100% | None |
| 6. Implementation | ⚠️ Premature | 10% | Should pause until Stage 4 complete |

---

## 🚨 Recommended Actions

### Immediate (This Week)
1. ✅ ~~**Create user journey maps** for core features (Stage 2)~~ - Phase 1 Complete
2. ✅ ~~**Build screen inventory** listing all screens needed~~ - 23 screens identified
3. **Validate data models** against screen requirements (Stage 3) - **CURRENT TASK**

### Short-term (Next Week)
4. **Define system architecture** (Flutter pattern, layers, folder structure) (Stage 4)
5. **Create component hierarchies** for each feature
6. **Design repository and service interfaces** (Stage 5)

### Medium-term (Following Week)
7. **Implement foundation** (database, core services) (Stage 6)
8. **Build out features** following the architecture
9. **Write tests** as you go

---

## 📚 Related Documents

- [Product Specification](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/_index.md)
- [Data Models](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/data_models/_index.md)
- [Data Processing](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/data_processing/_index.md)
- [GEMINI.md (Project Knowledge)](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/GEMINI.md)

---

**Last Updated**: 2025-12-29
