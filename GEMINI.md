# Ash Trainer - Project Documentation

Welcome to the **Ash Trainer** project knowledge base. This file serves as the central index (Map of Content) for our documentation.

## 📂 Documentation Structure

All documentation is located in the `docs/` directory.

### 🧠 AI & Personality
* **[Prompts & Persona](docs/ai/prompts.md)** (`docs/ai/prompts.md`): System prompts, personality guidelines ("Ash"), and LLM strategy.
* **[AI Backlog](docs/ai/backlog.md)** (`docs/ai/backlog.md`): Implementation checklist, missing components, and AI-specific technical debt.
* **[Philosophy Context Architecture](docs/TODO/philosophy_context_architecture.md)** (`docs/TODO/philosophy_context_architecture.md`): Structured philosophy guidance for AI plan generation, replacing single-string approach with principle-based context models.

#### Philosophy Context Strategy
The AI receives structured philosophy guidance through context models rather than a single string. This enables:
* **Principle-based guidance**: Provides constraints and principles, not prescriptions - AI reasons about optimal plan structure
* **Three-pillar integration**: Running, strength (Phase 1 MVP), and mobility (Phase 1 MVP) prescription logic
* **AI autonomy**: AI has creative freedom within safety constraints (max volume increase, recovery frequency, pillar coordination)

**Key Philosophy Docs**:
* Running: `docs/ux/training_philosophy.md`, `docs/ux/product_spec/training/running/training_plans.md`
* Strength (Phase 1): `docs/ux/product_spec/training/strength/strength_philosophy_phase1.md`
* Mobility (Phase 1): `docs/ux/product_spec/training/mobility/mobility_philosophy_phase1.md`

**Context Models**: `PlanGenerationPhilosophy` includes `StrengthGuidance` and `MobilityGuidance` for balanced three-pillar plans.

### 🏗️ Architecture & Data
* **[Data Models](docs/architecture/data_models/_index.md)** (`docs/architecture/data_models/_index.md`): Schema definitions, core entities (User, Goals, Workouts), and database strategy.
* **[System Architecture](docs/architecture/system_architecture.md)** (`docs/architecture/system_architecture.md`): High-level overview of the 5-layer Clean Architecture and component interaction.
* **[Interfaces & Contracts](docs/architecture/interfaces.md)** (`docs/architecture/interfaces.md`): Definitions for cross-layer communication, repository patterns, and service contracts.
* **[Folder Structure](docs/architecture/folder_structure.md)** (`docs/architecture/folder_structure.md`): Logical and physical organization of the codebase.
* **[Error Handling](docs/architecture/error_handling.md)** (`docs/architecture/error_handling.md`): Global strategy for exception management, state recovery, and user feedback.


### 📱 Product & Features
* **[Product Specification](docs/ux/product_spec/_index.md)** (`docs/ux/product_spec/_index.md`): Core vision, feature definitions (Goal Setting, Calendar, Coaching), and UI/UX philosophy.
* **[User Journey Inventory](docs/ux/user_journeys/user_journey_inventory.md)** (`docs/ux/user_journeys/user_journey_inventory.md`): Master list of all user flows, categorized by persona and lifecycle stage.
* **[Individual Journeys](docs/ux/user_journeys/)** (`docs/ux/user_journeys/`): Detailed step-by-step walkthroughs for specific tasks (e.g., Onboarding, Logging a Workout).

## 🔄 Workflows & Knowledge Management

### 1. Atomic Documentation
To prevent "idea sprawl," we follow an **atomic documentation** principle:
* **One Feature, One File**: When brainstorming a large feature (e.g., "Voice Mode"), create a new file in `docs/ux/product_spec/voice_mode.md` rather than appending to the giant Product Spec.
* **Link, Don't Duplicate**: Use Markdown links to reference the Persona or Architecture docs instead of repeating those details.

### 2. Cross-Linking
We use relative Markdown links to keep the graph connected while maintaining the flow.

## 🛠️ Engineering & Implementation Guidelines

Follow these standards to maintain architectural integrity and code quality.

### 1. Architecture: Riverpod + Clean Architecture
We use a **5-layer Clean Architecture** approach to ensure separation of concerns and testability:
*   **Presentation**: Widgets and Riverpod Providers/Notifiers. Handles UI and user interaction.
*   **Application**: Use Cases. Orchestrates business logic across repositories and services.
*   **Domain**: Basic Entities, Repository Interfaces, and Service Interfaces. The "pure" core of the app.
*   **Data**: Repository Implementations, DAOs, and DTOs. Handles data persistence (Drift).
*   **Infrastructure**: Service Implementations (e.g., AI Service, Health Service). Handles external integrations.

### 2. State Management (Riverpod)
*   **Providers**: Default to `Provider` for dependencies (Repos, Services).
*   **Notifiers**: Use `StateNotifierProvider` or `AsyncNotifier` (Riverpod 2.0+) for complex screen state.
*   **Logic Location**: Keep business logic in **Use Cases** (Application layer), not in Providers/Notifiers.

### 3. Data Patterns
*   **Offline-First**: Drift (SQLite) is the source of truth.
*   **DTO Mapping**: Always use DTOs to map database tables to Domain Entities. Use `toEntity()` and `fromEntity()` extensions.
*   **Immutability**: Domain Entities should be immutable (using `final` fields and `copyWith`).

### 4. Folder Structure
Follow the **Feature-First + Layered** structure:
```text
lib/
├── core/               # App-wide utilities, themes, error handling
├── features/           # Feature-specific logic (e.g., goal_setup, calendar)
│   └── shared/         # Common widgets, entities used across multiple features
└── data/               # Persistent storage logic (Drift database, DAOs)
```
Each feature folder should contain: `presentation/`, `application/`, `domain/`.

### 5. Error Handling
*   Return **Failures** from Repositories (Domain layer types like `DatabaseFailure`).
*   Throw **Exceptions** only for unexpected system errors.
*   Use `AsyncValue` in the UI to handle loading/error states gracefully.

### 6. Code Standards
*   **Purity**: Keep Domain functions pure where possible.
*   **Documentation**: Summarize large modules in their respective `README.md`.
*   **Analysis**: Always run `flutter analyze` after changes (see `flutter-rules.md`).

---