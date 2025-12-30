# Design Doc: Hydrated Phases & Adaptive Planning

## Core Concepts

### 1. The "Phase List" (Big Picture)
To ensure the AI doesn't "lose the forest for the trees," we maintain a high-level map of the training journey.
- **Phases**: A top-down list of all phases from onboarding to the deadline (e.g., `[Phase 1: Base (6w), Phase 2: Build (4w), Phase 3: Taper (2w)]`).
- **AI Strategic Control**: Every time the AI repairs a plan, it sees the complete phase list. It is empowered to **change phase types** and **re-balance durations** to ensure the user reaches the goal safely.
- **The Honesty Protocol**: If a safe return is mathematically impossible within the remaining time, the AI MUST flag this to the user: *"We can't hit a Sub-4 Marathon safely with the time left. I've shifted our goal to a 'Strong Finish' to prevent injury."*

### 2. Strategic Repair vs. Execution Sliding
How we handle disruptions:

| Magnitude | Mechanic | Logic |
| :--- | :--- | :--- |
| **Minor (< 3 days)** | **App-Side Slide** | The App moves the block forward. **Constraint**: If a slide causes a block to overlap with the *next Phase boundary*, it triggers a **Strategic Repair**. |
| **Major (3+ days)** | **Strategic Repair** | The AI **re-generates the internal blocks** for the current and future phases. It rethink the workout selection (e.g., replacing a high-intensity session with a recovery ramp). |
| **Pillar Shift (Injury)** | **Intra-Phase Pivot** | The AI maintains the phase intent but swaps the pillar volume (e.g., `Run -80%, Mobility +200%`) until the injury flag is removed. |

---

## Technical Implementation

### 1. Data Model Additions
- **Phase**: Stores `phaseType`, `durationWeeks`, `targetWeeklyVolume`, and `targetWeeklyDuration`. AI provides these skeletons; App hydrates `startDate`/`endDate`.
- **TrainingBlock**: Logical clusters (3-10 days) with an `intent` (Intro, Progression, Peak, Recovery).
- **Workout**: Relinked to `PhaseId` and `BlockId`.

### 2. Proposed Additions to `training_philosophy.md`
We will add **"Section 6: Adaptive Resiliency Protocols"** covering:
- **The "Sunk Cost" Rule**: Never double up missed volume.
- **The "Boundary Repair" Trigger**: Automated handover from App-sliding to AI-repair when phase goals are at risk.
- **The Honesty Protocol**: AI's mandate to downgrade goals if training consistency drops below 60% in a key phase.

### 3. AI Prompt Updates
The `taskPrompt` for plan generation and repair will be updated with:
- **Phase Skeleton Awareness**: "You must respect the `PhaseList` provided in the context. If the user is in a 'Build' phase, ensure workouts align with that phase's intent."
- **The Honesty Protocol**: "If the user's workload history (ACWR) or consistency makes the goal unsafe, you MUST warn them and propose a safer alternative goal."
- **Goal-Specific Heuristics**: 
  - *Event*: "Protect the 21-day taper. Prioritize Long Runs over all else."
  - *Distance*: "Check previous 2 blocks before increasing volume."

## User Review Required

> [!IMPORTANT]
> **Sliding Boundary Logic**: Does the automated shift to AI-repair when a "slide" hits a Phase Boundary feel right? It ensures the app doesn't accidentally slide a marathon peak into the race-day week.

## Verification Plan

### Manual Verification
- **Scenario A**: User skips 4 days of a Half-Marathon "Build" phase. **The Sliding Rule** moves sessions within the block until a Phase Boundary is hit, triggering an AI **Strategic Repair**.
- **Scenario B**: User reports shin splints. AI pivots the current **Training Block** to low-impact "Pillar: Strength/Mobility" while maintaining the overall **Phase Skeleton**.
- **Scenario C**: User misses 2 weeks during "Peak" Phase. AI triggers the **Honesty Protocol**, downgrading the goal type (e.g., Time Performance -> Distance Milestone) for safety.
