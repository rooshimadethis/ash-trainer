# Data Processing & AI Integration Plan

## Goal
Design a data processing strategy that prioritizes on-device calculation to minimize AI API costs, while ensuring long-term AI coherence and effective planning capabilities using an MCP-style tool approach.

## 1. Hybrid Architecture: On-Device vs. Cloud

To minimize costs and latency, we will adopt a **Local-First, Cloud-Augmented** approach.

### **A. On-Device Training Engine (The "Cortex")**
Instead of asking an LLM "What should I do if I missed my run?", we build a deterministic Dart logic engine.

*   **UI-First Strategy**:
    *   To minimize AI calls, the UI will prioritize explicit action buttons over chat.
    *   **Example**: "Skip Day" button triggers the `TrainingEngine` to push workouts +1 day immediately. No AI conversation required.
    *   **Reasoning**: Faster for the user, 0 cost, deterministic outcome. Use Chat only for "Why?" or complex negotiation.
*   **Responsibility**:
    *   **Schedule Management**: Moving workouts, detecting conflicts.
    *   **Quantifiable Math**: Calculating "Goal Confidence", pace adjustments, volume ramp-up (10% rule). **Run these calculations aggressively** (e.g., on every app open or data modification) to ensure AI context is fresh.
    *   **Simple Adjustments**: "If user skips X, move to Y" (Rule-based heuristics).
*   **Tech Stack**:
    *   **Language**: Pure Dart.
    *   **Storage**: SQLite (Drift) or Hive for fast, structured access to plans and history.

### **B. Cloud AI (The "Coach")**
The LLM is reserved for complex, qualitative, or creative tasks. We will use a **Tiered Model Strategy**:

1.  **Fast/Cheap Model (e.g., Gemini Flash)**:
    *   **Use Cases**: Daily motivation, simple "Explain this run" chats, quick empathetic check-ins.
    *   **Latency**: Low.
2.  **Reasoning/Complex Model (e.g., Gemini Pro/Ultra)**:
    *   **Use Cases**: Major plan reworks ("I broke my leg"), deep analysis of monthly progress.
    *   **Trigger**: User explicitly requests a "Plan Rework" or the engine detects a major failure state.

### **C. Plan Lifecycle: Pause & Reset**
*   **Problem**: Dragging a "broken" plan forward confuses the AI context.
*   **Solution**:
    *   **Pause Option**: For indeterminate breaks (vacation, illness). Stops the clock.
    *   **Reset/Remake**: For life events.
        *   **Action**: Redirects user to the **Onboarding Flow** (same as signup).
        *   **Trigger**: User request ("I need a fresh start") OR AI detection ("It sounds like your goals have fundamentally changed. Should we restart your plan?").
        *   **Benefit**: Re-establishes baseline without "baggage" from the failed plan.

---

## 2. MCP-Style Tools for the AI
We will define strict "Tools" that the AI can call. Whether we use an actual MCP server (for external agents) or just function calling (for the in-app AI), the structure is identical.

### **Core Tool Definitions**

1.  **`get_training_context`**
    *   **Purpose**: Gives the AI the current snapshot.
    *   **Returns**: Current Goal, Phase (Base/Build/Peak), Recent Adherence %, Fatigue Level, Upcoming Constraints.
    *   **Why**: Prevents dumping the entire database into the prompt.

2.  **`reschedule_workout`**
    *   **Params**: `workout_id`, `new_date`, `reason`.
    *   **Action**: Moves a workout in the local DB.
    *   **Logic**: The *Engine* validates the move (e.g., checks for conflicts) and returns success/fail to the AI.

3.  **`adjust_intensity`**
    *   **Params**: `workout_id`, `factor` (e.g., 0.8 for 80% intensity).
    *   **Action**: Scales distance/pace.

4.  **`log_biomarker`**
    *   **Params**: `type` (pain, mood, energy), `value`, `note`.
    *   **Action**: Records subjective feedback for long-term tracking.

---

## 3. Tiered Context Architecture (The "Coach's Memory")

To maintain coherence without oversaturating the context window, we will use a **Time-Horizon Tiered Strategy**. This allows the AI to see high-fidelity data for immediate decisions while retaining high-level patterns for long-term consistency.

### **A. The Three Tiers**

#### **1. Long-Term (Historical Narrative)**
*   **Timeframe**: > 1 month ago.
*   **Content**: High-level summary of the user's journey.
*   **Example**:
    > "User is planning a marathon on Oct 12. Started at beginner level. Increases volume ~15% weekly. Consistently skips strength training but does mobility. Has chronic left knee issue that responds well to unilateral work."
*   **Usage**: Ensures the AI doesn't forget the "Big Picture" or recurring habits. Used for general projections (2+ weeks out).

#### **2. Medium-Term (Recent Trends)**
*   **Timeframe**: 7 days to 1 month ago.
*   **Content**: Recent deviations, events, and adherence patterns.
*   **Example**:
    > "User returned from vacation on Dec 5. Ramped back up but is missing 30% of running workouts (higher than average). Knee reported as 2/10 pain last week."
*   **Usage**: Contextualizes current performance. Explains *why* the user might be struggling right now.

#### **3. Short-Term (Immediate Context)**
*   **Timeframe**: Last 7 days + Next 7 days.
*   **Content**: High-fidelity logs. Specific exercises, exact paces, sleep scores, upcoming calendar blocks.
*   **Example**:
    > "Monday: Missed. Tuesday: 5k @ 6:00/km (Easy). Wednesday: Rest. Upcoming: Busy work block on Thursday."
*   **Usage**: Weighted heavily for immediate planning (next 1-2 weeks). This is the "working memory" for specific schedule adjustments.

### **B. Context Synthesis**
The On-Device Engine is responsible for generating this JSON structure *before* the AI request.

```json
{
  "context": {
    "long_term_summary": "...text block...",
    "medium_term_trends": "...text block...",
    "short_term_detail": [
       { "day": -2, "activity": "Run", "status": "Completed" },
       { "day": -1, "activity": "Strength", "status": "Skipped" }
    ]
  }
}
```

The AI is instructed to prioritize `short_term_detail` for immediate schedule changes, while checking `long_term_summary` to ensure new plans align with the overall goal strategy.

---

## 4. Implementation Stages

### **Phase 1: The Foundation (Data & Engine)**
*   [ ] define **Drift (SQLite) Schema**: `Workouts`, `Plans`, `DailyLogs`.
*   [ ] Implement **`TrainingEngine` class**: logic for `moveWorkout`, `completionRate`, `confidenceScore`.
*   [ ] Create **`MockDataService`**: For testing the engine without real user data.

### **Phase 2: The "Tools" Layer**
*   [ ] Define **interface abstract class `AiTools`**.
*   [ ] Implement wrapper methods that bridge the AI requests to the `TrainingEngine`.

### **Phase 3: The Brain (AI Integration)**
*   [ ] specialized Prompts that understand the `Coach's Notebook` structure.
*   [ ] Function Calling setup (Gemini/OpenAI) mapped to `AiTools`.
