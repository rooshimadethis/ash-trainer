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
    *   **Links To**: `Data Models` for schema definitions.
3.  **Data Models** (`docs/architecture/data_models/*.md`)
    *   **Content**: The "Truth" (Database Schemas, Field Definitions).
    *   **Links To**: None (Leaf nodes).

### 3. Cross-Linking
We use relative Markdown links to keep the graph connected while maintaining the flow.

## 🛠️ Editor Recommendations
For the best experience browsing this documentation:
* **VS Code**: Use the *Markdown Preview* and *Wiki Link* extensions.
* **Obsidian / Logseq**: Open the repository root as a "Vault" or "Graph" to visualize connections between these files.
