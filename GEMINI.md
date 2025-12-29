# Ash Trainer - Project Documentation

Welcome to the **Ash Trainer** project knowledge base. This file serves as the central index (Map of Content) for our documentation.

## 📂 Documentation Structure

All documentation is located in the `docs/` directory.

### 🧠 AI & Personality
* **[Prompts & Persona](docs/ai/prompts.md)** (`docs/ai/prompts.md`): System prompts, personality guidelines ("Ash"), and LLM strategy.
* **[AI Backlog](docs/ai/backlog.md)** (`docs/ai/backlog.md`): Implementation checklist, missing components, and AI-specific technical debt.

### 🏗️ Architecture & Data
* **[Data Models](docs/architecture/data_models/_index.md)** (`docs/architecture/data_models/_index.md`): Schema definitions, core entities (User, Goals, Workouts), and database strategy.
* **[Data Processing Plan](docs/architecture/data_processing/_index.md)** (`docs/architecture/data_processing/_index.md`): Hybrid local/cloud architecture, "Training Engine" logic, and memory tiering strategy.

### 📱 Product & Features
* **[Product Specification](docs/ux/product_spec/_index.md)** (`docs/ux/product_spec/_index.md`): Core vision, feature definitions (Goal Setting, Calendar, Coaching), and UI/UX philosophy.
* **[Features Folder](docs/features/)** (`docs/features/`): Breakdown of complex features into atomic documents (Currently empty, intended for new feature specs).

## 🔄 Workflows & Knowledge Management

### 1. Atomic Documentation
To prevent "idea sprawl," we follow an **atomic documentation** principle:
* **One Feature, One File**: When brainstorming a large feature (e.g., "Voice Mode"), create a new file in `docs/features/voice_mode.md` rather than appending to the giant Product Spec.
* **Link, Don't Duplicate**: Use Markdown links to reference the Persona or Architecture docs instead of repeating those details.

### 2. The Documentation Graph (One-Way Flow)
To ensure context is easy to follow for both humans and AI, we enforce a strict **one-way linking flow**:

1.  **Product Spec** (`docs/ux/product_spec/*.md`)
    *   **Content**: The "What" (Features) and the "Why" (Training Philosophy).
    *   **Links To**: `Data Processing` docs for implementation details.
2.  **Data Processing** (`docs/architecture/data_processing/*.md`)
    *   **Content**: The "How" (Algorithms, Business Logic, Queries).
    *   **Structure**: Mirrors product_spec with feature-aligned files (`training/`, `athlete_markers/`, `lifecycle/`) plus `cross_cutting/` for shared algorithms.
    *   **Links To**: `Data Models` for schema definitions, and sideways to `cross_cutting` for shared logic.
3.  **Data Models** (`docs/architecture/data_models/*.md`)
    *   **Content**: The "Truth" (Database Schemas, Field Definitions).
    *   **Links To**: None (Leaf nodes).

### 3. Cross-Linking
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

## 🛠️ Editor Recommendations
For the best experience browsing this documentation:
* **VS Code**: Use the *Markdown Preview* and *Wiki Link* extensions.
* **Obsidian / Logseq**: Open the repository root as a "Vault" or "Graph" to visualize connections between these files.
