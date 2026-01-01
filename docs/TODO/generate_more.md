# Adaptive Planning Engine (Phase 2)

## Goal
Implement a robust **Adaptive Planning Engine** that handles both *extending* the training plan (Horizon Filling) and *repairing* it when life gets in the way (Strategic Repair). 

Both scenarios share the same core loop: **Context → AI Generation → Database Update**, differing primarily in their *Trigger*, *Starting Point*, and *Objective*.

## Core Concept: The Unified Planning Loop

Instead of separate "Generate" and "Repair" silos, we use a single pipeline:

1.  **Trigger**: What caused the need for planning? (Time passing vs. Missed workouts)
2.  **Context Builder**: Aggregates User + Goal + History + *Specific Trigger Context*.
3.  **AI Generation**: Gemini generates a `TrainingPlan` object (Phases + Blocks + Workouts).
4.  **Application Strategy**: How do we apply this plan? (Append to end vs. Overwrite future).

---

## 1. Triggers & Use Cases

### A. Horizon Filling (The "Infinite Scroll" of Training)
*   **Trigger**: The `last_scheduled_workout_date` is less than **7 days** away.
*   **Objective**: Seamlessly extend the plan without the user noticing.
*   **Start Date**: `last_scheduled_workout_date + 1 day`.
*   **Strategy**: **Append**. Add new blocks to the end.

### B. Strategic Repair (The "Course Correction")
*   **Trigger**: 
    *   **Automatic**: User has missed **3+ consecutive days**.
    *   **Manual**: User clicks "Replan" or "I was sick".
*   **Objective**: Safely ramp the user back into training, then resume progression.
*   **Start Date**: `Tomorrow` (or selected resumption date).
*   **Strategy**: **Overwrite**. 
    1.  *Delete* all "Planned" (future) workouts from `Start Date` onwards.
    2.  *Insert* the new repair plan.

---

## 2. Implementation Plan

### [Component] Domain & Data
#### [MODIFY] [workout_repository.dart](file:///features/shared/domain/repositories/workout_repository.dart)
- **Add `getLastScheduledWorkoutDate(goalId)`**: Returns the date of the furthest out workout.
- **Add `getConsecutiveMissedDays(goalId)`**: Returns count of uncompleted workouts since the last completed one (or today).
- **Add `clearFutureWorkouts(goalId, fromDate)`**: Deletes all workouts with `status == planned` and `date >= fromDate`.

### [Component] Application (The "Context Builder")

We need a unified context builder that can handle the nuances of both modes.

#### [NEW] [build_planning_context.dart](file:///features/training/application/usecases/build_planning_context.dart)
Or expand existing `BuildPlanGenerationContext`.

**Inputs**:
- `OptimizationMode`: `Extend` | `Repair`
- `TargetGoal`
- `History` (Last 4 weeks)

**Context Logic**:
- **Common**: 
    - Current Phase (where are we in the macrocycle?)
    - Recent Load (ACWR if available, or simple volume)
- **Mode: PROGESS (Extend)**:
    - Focus on *progression rules* (e.g., "User just finished Base 2, move to Build 1").
- **Mode: RECOVER (Repair)**:
    - Calculate **Missed Days**.
    - Include **Return-to-Training Coefficients** (from `training_plans.md`).
    - *Prompt Injection*: "User missed X days. Create a bridge block using the 'Return to Training' coefficients, then resume the 'Build' phase."

### [Component] AI Service & Prompts

#### [MODIFY] [prompts.dart](file:///core/constants/prompts.dart)
- **`generateExtensionPrompt`**: Focus on continuity. "You are extending an existing plan..."
- **`generateRepairPrompt`**: Focus on safety. "The user has missed [X] days. The last workout was [Date]. Generate a 'Return to Training' block that starts at [X]% volume and ramps back up."

### [Component] Automation
#### [MODIFY] [automation_provider.dart](file:///features/training/presentation/providers/automation_provider.dart)
- **`checkPlanHealth()`**: Run this after app launch or sync.
    1.  `horizon = repo.getLastScheduledWorkoutDate()`
    2.  `missedDays = repo.getConsecutiveMissedDays()`
    3.  **Logic**:
        - `if (missedDays >= 3)` -> Trigger **Strategic Repair Flow** (might require UI confirmation).
        - `else if (horizon < 7 days)` -> Trigger **Horizon Filling** (Silent background process).

---

## 3. Detailed Flows

### Workflow: Horizon Filling (Silent)
1.  **AutomationProvider** detects `Horizon < 7 days`.
2.  Calls `GenerateNextChunkUseCase(mode: Extend)`.
3.  **UseCase**:
    - Builds context (Current Phase: "Build 1", Last Week Volume: "30km").
    - Calls AI: "Generate next 4 weeks. Keep ramping volume."
    - Receives `TrainingPlan`.
    - **Saves**: Appends phases/blocks/workouts.
4.  **UI**: User scrolls forward and sees new workouts. Notification (Optional): "Your plan has been updated for the next month."

### Workflow: Strategic Repair (Interactive)
1.  **AutomationProvider** detects `MissedasDays >= 3`.
2.  **UI**: Shows "Welcome Back" Dialog.
    - "Looks like life got busy! You've missed 4 days. Want us to adjust your plan?"
    - Options: "Yes, Replan" | "No, I'll catch up" (Not recommended).
3.  User taps "Yes, Replan".
4.  Calls `GenerateNextChunkUseCase(mode: Repair)`.
5.  **UseCase**:
    - Clears future workouts starting `Tomorrow`.
    - Builds context (Missed: 4 days, Reason: "Unknown/Busy").
    - Calls AI: "Create a 1-week bridge block, then resume."
    - Receives `TrainingPlan`.
    - **Saves**: Inserts new plan starting `Tomorrow`.

## 4. Verification Plan

### Automated Tests
- **Unit**: Verify `getLastScheduledWorkoutDate` calculates correctly.
- **Unit**: Verify `clearFutureWorkouts` only touches `planned` status.
- **Integration**: Simulate a 7-day plan, call "Extend", verify plan is now 35 days (approx).

### Manual Verification
1.  **Force Extend**: Dev tool to trigger Extension. Check database for seamless date continuity.
2.  **Force Repair**:
    - Manually set last completed workout to 5 days ago.
    - Trigger "Repair".
    - Verify old future workouts are gone.
    - Verify new "Bridge" block appears with reduced volume.
