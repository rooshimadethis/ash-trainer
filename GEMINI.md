# Ash Trainer - Project Documentation

Welcome to the **Ash Trainer** project knowledge base. This file serves as the central index (Map of Content) for our documentation.

## 📂 Documentation Structure

All documentation is located in the `docs/` directory.

### 🧠 AI & Personality
* **[Prompts & Persona](docs/ai/prompts.md)** (`docs/ai/prompts.md`): System prompts, personality guidelines ("Ash"), and LLM strategy.
* **[AI Backlog](docs/ai/backlog.md)** (`docs/ai/backlog.md`): Implementation checklist, missing components, and AI-specific technical debt.

### 🏗️ Architecture & Data
* **[Data Processing Plan](docs/architecture/data_processing.md)** (`docs/architecture/data_processing.md`): Hybrid local/cloud architecture, "Training Engine" logic, and memory tiering strategy.

### 📱 Product & Features
* **[Product Specification](docs/product_spec.md)** (`docs/product_spec.md`): Core vision, feature definitions (Goal Setting, Calendar, Coaching), and UI/UX philosophy.
* **[Features Folder](docs/features/)** (`docs/features/`): Breakdown of complex features into atomic documents (Currently empty, intended for new feature specs).

## 🔄 Workflows & Knowledge Management

### 1. Atomic Documentation
To prevent "idea sprawl," we follow an **atomic documentation** principle:
* **One Feature, One File**: When brainstorming a large feature (e.g., "Voice Mode"), create a new file in `docs/features/voice_mode.md` rather than appending to the giant Product Spec.
* **Link, Don't Duplicate**: Use Markdown links to reference the Persona or Architecture docs instead of repeating those details.

### 2. Cross-Linking
We use relative Markdown links to keep the graph connected.
* Example: The [Product Spec](docs/product_spec.md) might link to the [Data Plan](docs/architecture/data_processing.md) for technical feasibility details.

## 🛠️ Editor Recommendations
For the best experience browsing this documentation:
* **VS Code**: Use the *Markdown Preview* and *Wiki Link* extensions.
* **Obsidian / Logseq**: Open the repository root as a "Vault" or "Graph" to visualize connections between these files.
