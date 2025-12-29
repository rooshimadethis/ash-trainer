# Data Processing & AI Integration Plan

## Goal
Design a data processing strategy that prioritizes on-device calculation to minimize AI API costs, while ensuring long-term AI coherence and effective planning capabilities using an MCP-style tool approach.

## 1. Architecture Overview

### Hybrid Architecture: Local-First, Cloud-Augmented

```mermaid
graph TB
    User[User] --> UI[UI Layer]
    UI --> Engine[Training Engine<br/>On-Device Cortex]
    UI --> AI[Cloud AI<br/>The Coach]
    
    Engine --> DB[(SQLite/Drift<br/>Local Storage)]
    Engine --> Tools[AI Tools Interface]
    
    AI --> Tools
    Tools --> Engine
    
    AI --> FastModel[Fast Model<br/>Gemini Flash]
    AI --> ReasoningModel[Reasoning Model<br/>Gemini Pro/Ultra]
    
    style Engine fill:#4CAF50
    style AI fill:#2196F3
    style DB fill:#FFC107
```

### Core Architectural Decisions

#### 1. **UI-First Strategy**
- **Principle**: Prioritize explicit action buttons over chat to minimize AI calls
- **Example**: "Skip Day" button → Training Engine pushes workouts +1 day (no AI needed)
- **Benefit**: Faster UX, zero cost, deterministic outcomes
- **When to use Chat**: Complex negotiations, "Why?" questions, empathetic exploration

#### 2. **On-Device Training Engine ("The Cortex")**
- **Technology**: Pure Dart logic
- **Storage**: SQLite (Drift) or Hive
- **Responsibilities**:
  - Schedule management (moving workouts, detecting conflicts)
  - Quantifiable math (goal confidence, pace adjustments, volume ramp-up)
  - Simple rule-based adjustments
  - Validation logic for all AI tool calls
- **Execution Strategy**: Run calculations aggressively (on every app open or data modification) to ensure AI context is always fresh

#### 3. **Cloud AI ("The Coach")**
- **Tiered Model Strategy**:
  
  | Model Type | Use Cases | Latency | Cost |
  |------------|-----------|---------|------|
  | **Fast/Cheap**<br/>(Gemini Flash) | Daily motivation, simple explanations, quick check-ins | Low | Low |
  | **Reasoning/Complex**<br/>(Gemini Pro) | Major plan reworks, deep progress analysis, injury assessment | Medium | High |

- **Trigger Logic**: Use Reasoning model when user explicitly requests "Plan Rework" OR engine detects major failure state

#### 4. **Plan Lifecycle Management**
- **Pause**: For indeterminate breaks (vacation, illness) - stops the clock
- **Reset/Remake**: For restarts after long breaks or life events - redirects to onboarding flow to re-establish baseline without "baggage"

#### 5. **MCP-Style Tools Architecture**
- **Structure**: Strict tool definitions that AI can call (function calling or actual MCP server)
- **Validation**: Engine validates all tool calls before execution
- **Error Handling**: Returns structured errors to AI with explanations

---

## 2. Data Flow Patterns

### Onboarding → First Plan Generation

```mermaid
sequenceDiagram
    participant User
    participant UI
    participant Repository
    participant Engine as Training Engine
    participant AI as AI Service
    participant DB as Drift DB
    
    User->>UI: Complete onboarding
    UI->>Repository: Save UserProfile
    Repository->>DB: INSERT UserProfile
    
    UI->>Repository: Request initial plan
    Repository->>Engine: Get user baseline
    Engine->>DB: Query UserProfile
    Engine-->>Repository: User context JSON
    
    Repository->>AI: Generate plan (context + philosophy)
    AI-->>Repository: Plan structure (JSON)
    
    Repository->>DB: INSERT TrainingPlan
    Repository->>DB: INSERT Mesocycles (4 weeks)
    Repository->>DB: INSERT Microcycles (4 weeks)
    Repository->>DB: INSERT PlannedWorkouts (28 days)
    
    Repository-->>UI: Plan ready
    UI->>User: Show Week 1
```

### Daily Check-In → Workout Adjustment

```mermaid
sequenceDiagram
    participant User
    participant UI
    participant Repository
    participant Engine as Training Engine
    participant AI as AI Service
    participant DB as Drift DB
    
    User->>UI: "I'm feeling tired today"
    UI->>Repository: Send user input
    
    Repository->>Engine: Get current context
    Engine->>DB: Query recent logs, ACWR, today's workout
    Engine-->>Repository: Context JSON
    
    Repository->>AI: Request (message + context)
    AI-->>Repository: Response + suggested actions
    
    alt User accepts adjustment
        Repository->>Engine: Execute adjustment
        Engine->>DB: UPDATE PlannedWorkout (reduce intensity)
        Engine->>DB: INSERT ActionLog (snapshot)
        Engine->>DB: Recalculate confidence score
        Engine->>DB: UPDATE Goal (new confidence)
    end
    
    Repository-->>UI: Updated plan + confidence
    UI->>User: Show adjusted workout
```

### Post-Workout Logging → Load Calculation

```mermaid
sequenceDiagram
    participant User
    participant UI
    participant Repository
    participant Engine as Training Engine
    participant DB as Drift DB
    
    User->>UI: Complete workout + rate RPE
    UI->>Repository: Log workout
    
    Repository->>DB: INSERT WorkoutLog
    Repository->>DB: UPDATE PlannedWorkout (status = completed)
    
    Repository->>Engine: Recalculate metrics
    Engine->>DB: Query last 7 days (Acute Load)
    Engine->>DB: Query last 28 days (Chronic Load)
    Engine-->>Repository: ACWR = 1.15 (safe zone)
    
    Engine->>DB: UPDATE UserProfile (chronicLoad)
    Engine->>DB: UPDATE Goal (confidenceScore)
    
    Repository-->>UI: Updated stats
    UI->>User: "Great work! Confidence: 92%"
```

---

## 3. AI Integration Strategy

### System Prompt Structure

1. **Ash Personality**: Empathetic, knowledgeable, adaptive coach persona
2. **Context Window Management**: 3-tier memory system instructions
3. **Tool Calling Instructions**: When and how to use each tool
4. **Edge Case Handling**: Injury, motivation, weather, vacation protocols

### Conversation Flow Logic

```mermaid
graph TD
    Start[User Interaction] --> Type{Interaction Type}
    
    Type -->|Simple Action| UI[UI Button]
    Type -->|Complex Question| Chat[Chat Interface]
    
    UI --> Engine[Training Engine]
    Engine --> Execute[Execute Action]
    
    Chat --> Context[Load Context]
    Context --> Model{Model Selection}
    
    Model -->|Simple/Quick| Fast[Fast Model<br/>Gemini Flash]
    Model -->|Complex/Deep| Reasoning[Reasoning Model<br/>Gemini Pro]
    
    Fast --> Tools[Call Tools]
    Reasoning --> Tools
    
    Tools --> Engine
    Engine --> Validate{Validation}
    
    Validate -->|Pass| Execute
    Validate -->|Fail| Error[Return Error to AI]
    Error --> Tools
    
    Execute --> Update[Update Context]
    Update --> Response[Return to User]
    
    style UI fill:#4CAF50
    style Engine fill:#4CAF50
    style Fast fill:#2196F3
    style Reasoning fill:#9C27B0
```

### Token Budget Management

- **Cache context synthesis results** to avoid regenerating on every request
- **Optimize database queries** to minimize context generation time
- **Smart caching**: Reuse context if no data changes since last AI call
- **Minimize AI calls**: Use UI-first strategy to handle 80% of interactions deterministically
