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

### **D. Pillar Coordination (Running, Strength, Mobility)**
The Training Engine must intelligently schedule workouts across all three pillars while respecting recovery principles.

*   **Priority-Based Scheduling**:
    *   User sets priority (High/Med/Low) for each pillar during onboarding.
    *   **"Big Rocks First"**: High-priority pillar workouts are scheduled first, then medium, then low.
    *   **Example**: User wants "High Run, Med Strength, Low Mobility" → 4 runs/week, 2 strength sessions, 1 mobility session.

*   **Recovery Rules**:
    *   **48-Hour Rule**: Allow 48 hours between hard efforts in the same pillar.
        *   Example: Tuesday Intervals → Friday next hard run (not Wednesday).
    *   **Cross-Pillar Conflicts**: Avoid hard leg strength the day before a key run.
        *   Example: No heavy squats on Friday if Saturday is Long Run day.
    *   **Hard Days Hard, Easy Days Easy**: Never stack high-intensity sessions back-to-back across pillars.

*   **Recovery Week Adjustments**:
    *   Run volume drops -20%.
    *   Strength switches to *maintenance* (lower volume, same intensity).
    *   Mobility priority **INCREASES** (extra sessions to aid recovery).

*   **Validation Logic**:
    *   When `reschedule_workout` or `swap_workout` is called, the Engine checks:
        1. Does this violate the 48-hour rule?
        2. Does this create a cross-pillar conflict?
        3. Is this during a vacation block?
        4. Does this conflict with a race taper period?
    *   If validation fails, return error to AI with explanation.

---

## 2. MCP-Style Tools for the AI
We will define strict "Tools" that the AI can call. Whether we use an actual MCP server (for external agents) or just function calling (for the in-app AI), the structure is identical.

### **Core Tool Definitions**

#### **Context & State Management**

1.  **`get_training_context`**
    *   **Purpose**: Gives the AI the current snapshot.
    *   **Returns**: 
        *   Current Goal, Phase (Base/Build/Peak/Taper), Recent Adherence %
        *   Pillar Priorities (Running/Strength/Mobility: High/Med/Low)
        *   ACWR (Acute:Chronic Workload Ratio) and injury risk status
        *   Upcoming Constraints (vacation blocks, race dates, busy periods)
        *   Recent motivation patterns and skip frequency
        *   Weather conditions for next 7 days
    *   **Why**: Prevents dumping the entire database into the prompt while providing comprehensive context.

#### **Workout Management**

2.  **`reschedule_workout`**
    *   **Params**: `workout_id`, `new_date`, `reason`.
    *   **Action**: Moves a workout in the local DB.
    *   **Logic**: The *Engine* validates the move (checks for pillar conflicts, 48-hour recovery rule, vacation blocks) and returns success/fail to the AI.

3.  **`adjust_intensity`**
    *   **Params**: `workout_id`, `factor` (e.g., 0.8 for 80% intensity).
    *   **Action**: Scales distance/pace/duration while maintaining workout type.
    *   **Logic**: Ensures adjustments respect RPE targets and don't violate recovery principles.

4.  **`swap_workout`**
    *   **Params**: `workout_id`, `new_type` (e.g., "Easy Run" → "Upper Body Strength").
    *   **Action**: Replaces workout type while maintaining schedule slot.
    *   **Logic**: Validates pillar coordination (e.g., no hard leg day before long run).

#### **Load Management & Recovery**

5.  **`calculate_acwr`**
    *   **Purpose**: Calculate Acute:Chronic Workload Ratio for injury risk assessment.
    *   **Returns**: 
        *   Current ACWR value
        *   Risk status (Safe: 0.8-1.3, High: >1.3, Undertraining: <0.8)
        *   Recommendation (deload, maintain, increase volume)
    *   **Logic**: Acute Load (last 7 days) ÷ Chronic Load (avg of last 3-4 weeks).

6.  **`log_session_rpe`**
    *   **Params**: `workout_id`, `rpe` (1-10 scale), `duration_minutes`.
    *   **Action**: Records session RPE and calculates session load (RPE × Duration).
    *   **Logic**: Updates weekly load totals and ACWR calculations.

7.  **`log_biomarker`**
    *   **Params**: `type` (pain, mood, energy, sleep_quality), `value`, `location` (for pain), `note`.
    *   **Action**: Records subjective feedback for long-term tracking.
    *   **Logic**: Flags patterns (e.g., recurring knee pain, consecutive low energy days).

#### **Race & Event Management**

8.  **`add_race_event`**
    *   **Params**: `date`, `type` (Goal Race, Tune-Up, Fun Run, Non-Running), `distance`, `name`, `notes`.
    *   **Action**: Adds event to calendar and triggers appropriate planning.
    *   **Logic**: 
        *   Goal Race: Initiates taper protocol (1-3 weeks based on distance)
        *   Tune-Up Race: Reduces training 2-3 days before
        *   Fun Run: Slight intensity reduction day before
        *   Schedules recovery week post-race based on distance

9.  **`trigger_taper`**
    *   **Params**: `race_id`, `race_distance` (5K, 10K, Half, Marathon).
    *   **Action**: Initiates taper protocol with distance-specific volume reductions.
    *   **Logic**: 
        *   5K: 7-10 days, -30% W1, -50% final 3-4 days
        *   10K: 10-14 days, -30% W1, -50% W2
        *   Half: 2 weeks, -30% W1, -50% W2
        *   Marathon: 3 weeks, -20% W1, -40% W2, -60% W3
        *   Maintains intensity with short, sharp sessions

#### **Vacation & Time-Off Management**

10. **`schedule_vacation`**
    *   **Params**: `start_date`, `end_date`, `mode` (Complete Rest, Maintenance, Flexible), `notes`.
    *   **Action**: Blocks out dates, suppresses notifications, adjusts training plan.
    *   **Logic**: 
        *   Complete Rest: No scheduled workouts, ad-hoc exercises available on request
        *   Maintenance: 2-3 key sessions per week at 50% volume
        *   Flexible: Dotted outline, optional workouts suggested
        *   Updates goal confidence and timeline based on duration

11. **`return_from_break`**
    *   **Params**: `break_type` (vacation, illness, injury, life_break), `duration_days`, `severity` (mild, moderate, major).
    *   **Action**: Adjusts training plan for safe return.
    *   **Logic**: 
        *   Illness (mild): Resume at 50% volume, progress 10-20%/week
        *   Illness (moderate): Wait 3-5 days symptom-free, resume at 30%, progress 15%/week
        *   Injury (minor, 1-2 weeks): Resume at 60% for affected activities
        *   Injury (major, 4+ weeks): Treat as beginner for that movement
        *   Life break (1-2 weeks): Resume at 80%, (3-4 weeks): 60%, (2+ months): Restart Week 1

#### **Motivation & Mental Health**

12. **`log_motivation`**
    *   **Params**: `level` (1-10), `reason` (tired, stressed, not_motivated, bored, pointless), `note`.
    *   **Action**: Records motivation state and detects patterns.
    *   **Logic**: 
        *   First skip: Empathetic exploration
        *   Pattern (3+ skips in 2 weeks): Dig deeper, suggest adjustments
        *   Offers: shorter sessions, reduced frequency, variety changes, goal revisit

13. **`detect_skip_pattern`**
    *   **Purpose**: Analyze recent workout adherence for concerning patterns.
    *   **Returns**: 
        *   Skip frequency (last 7, 14, 30 days)
        *   Pattern type (random, specific_workout_type, specific_day, consecutive)
        *   Suggested intervention (rest, motivation check, goal realignment)

#### **Plateau Detection & Intervention**

14. **`detect_plateau`**
    *   **Purpose**: Analyze recent performance for stagnation.
    *   **Returns**: 
        *   Plateau status (yes/no)
        *   Affected pillar (Running, Strength)
        *   Duration of plateau (weeks)
        *   Suggested intervention (deload, variation, volume block)
    *   **Logic**: Compares recent performance metrics to previous 4-8 weeks.

15. **`trigger_plateau_protocol`**
    *   **Params**: `pillar` (Running, Strength), `protocol_type` (deload, variation, volume).
    *   **Action**: Implements 2-3 week intervention block.
    *   **Logic**: 
        *   Deload: -40% volume, maintain intensity
        *   Variation: Swap exercises/workout types, change rep ranges
        *   Volume: +20-30% volume, lower intensity (+1 RIR/RPE)

#### **Environmental Adaptations**

16. **`check_weather`**
    *   **Params**: `date`, `location`.
    *   **Returns**: 
        *   Temperature, heat index, wind chill
        *   Air quality index
        *   Precipitation
        *   Recommendation (safe, adjust, move indoors)
    *   **Logic**: 
        *   Extreme heat (>90°F/32°C): Reduce intensity by 1 RPE, suggest early/late timing
        *   Extreme cold (below freezing with wind chill): Shorten duration, indoor warm-up
        *   Poor air quality: Move all outdoor activity indoors
        *   No safe outdoor space: Suggest hotel gym, bodyweight circuits

17. **`adjust_for_weather`**
    *   **Params**: `workout_id`, `weather_condition`.
    *   **Action**: Modifies workout based on environmental factors.
    *   **Logic**: Swaps outdoor runs for treadmill, reduces intensity, or changes workout type.

#### **Advanced Data Processing**

18. **`process_screenshot`**
    *   **Params**: `image_data`, `expected_type` (training_load, recovery_metrics, race_results, injury_doc).
    *   **Action**: Uses OCR + AI vision to extract structured data from uploaded images.
    *   **Returns**: Extracted metrics (e.g., Training Load: 92, Recovery Score: 65).
    *   **Logic**: Validates extracted data, asks user for confirmation, stores for coaching decisions.

19. **`calculate_goal_confidence`**
    *   **Purpose**: Multi-factor analysis of goal achievement likelihood.
    *   **Returns**: Confidence percentage (0-100%) with breakdown.
    *   **Factors**: 
        *   Completed workouts (adherence %)
        *   Workout quality (hitting pace/distance targets)
        *   Consistency (training frequency)
        *   Recovery (adequate rest, ACWR status)
        *   Time remaining (proximity to deadline)
        *   Recent performance trends

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
    > "User returned from vacation on Dec 5. Ramped back up but is missing 30% of running workouts (higher than average). Knee reported as 2/10 pain last week. ACWR trending high (1.25) - approaching injury risk zone. Skipped 2 strength sessions citing 'not motivated' - possible burnout pattern emerging."
*   **Usage**: Contextualizes current performance. Explains *why* the user might be struggling right now.

#### **3. Short-Term (Immediate Context)**
*   **Timeframe**: Last 7 days + Next 7 days.
*   **Content**: High-fidelity logs. Specific exercises, exact paces, sleep scores, upcoming calendar blocks, race events, weather conditions.
*   **Example**:
    > "Monday: Missed (reported 'tired'). Tuesday: 5k @ 6:00/km (Easy, RPE 4). Wednesday: Rest. Thursday: Strength - Upper Body (completed, RPE 6). Upcoming: Busy work block Thursday, Tune-Up 5K race Saturday (taper adjustments active), Weather alert: Extreme heat Friday (38°C). ACWR: 1.15 (safe zone). Next goal race in 3 weeks (taper starts in 10 days)."
*   **Usage**: Weighted heavily for immediate planning (next 1-2 weeks). This is the "working memory" for specific schedule adjustments.

### **B. Context Synthesis**
The On-Device Engine is responsible for generating this JSON structure *before* the AI request.

```json
{
  "context": {
    "long_term_summary": "...text block...",
    "medium_term_trends": "...text block...",
    "short_term_detail": [
       { "day": -2, "activity": "Run", "status": "Completed", "rpe": 4, "notes": "Easy 5K" },
       { "day": -1, "activity": "Strength", "status": "Skipped", "reason": "Not motivated" }
    ],
    "pillar_priorities": {
      "running": "High",
      "strength": "Medium",
      "mobility": "Low"
    },
    "load_management": {
      "acwr": 1.15,
      "acwr_status": "Safe",
      "weekly_load": 420,
      "chronic_load": 365,
      "injury_risk": "Low"
    },
    "upcoming_events": [
      { "date": "2025-01-15", "type": "Tune-Up Race", "distance": "5K", "name": "Parkrun" },
      { "date": "2025-02-16", "type": "Goal Race", "distance": "Marathon", "name": "Austin Marathon", "taper_starts": "2025-02-03" }
    ],
    "vacation_blocks": [
      { "start": "2025-01-20", "end": "2025-01-27", "mode": "Complete Rest", "notes": "Beach vacation" }
    ],
    "motivation_flags": {
      "recent_skips": 2,
      "skip_pattern": "strength_workouts",
      "last_motivation_log": { "level": 5, "reason": "not_motivated", "date": "2025-01-10" }
    },
    "weather_alerts": [
      { "date": "2025-01-12", "condition": "Extreme Heat", "temp": 38, "recommendation": "Move to early morning or indoors" }
    ],
    "current_phase": "Build",
    "goal_confidence": 87
  }
}
```

The AI is instructed to prioritize `short_term_detail` for immediate schedule changes, while checking `long_term_summary` to ensure new plans align with the overall goal strategy. The AI should also respect `vacation_blocks`, adjust for `weather_alerts`, and be sensitive to `motivation_flags` when making recommendations.

---

## 4. Implementation Stages

### **Phase 1: The Foundation (Data & Engine)**
*   [ ] Define **Drift (SQLite) Schema**: 
    *   `Workouts` (id, date, type, distance, duration, pace, rpe, status, notes)
    *   `Plans` (id, goal_id, phase, week_number, mesocycle_week)
    *   `DailyLogs` (date, session_rpe, duration, biomarkers, motivation_level)
    *   `Goals` (id, type, target, deadline, confidence, pillar_priorities)
    *   `RaceEvents` (id, date, type, distance, name, notes, taper_start_date)
    *   `VacationBlocks` (id, start_date, end_date, mode, notes)
    *   `LoadTracking` (date, acute_load, chronic_load, acwr, injury_risk)
*   [ ] Implement **`TrainingEngine` class**: 
    *   Core logic: `moveWorkout`, `swapWorkout`, `completionRate`, `confidenceScore`
    *   Load management: `calculateACWR`, `logSessionRPE`, `assessInjuryRisk`
    *   Pillar coordination: `validatePillarConflicts`, `check48HourRule`
    *   Race management: `addRaceEvent`, `triggerTaper`, `scheduleRecoveryWeek`
    *   Vacation handling: `scheduleVacation`, `suppressNotifications`, `returnFromBreak`
    *   Motivation tracking: `logMotivation`, `detectSkipPattern`, `suggestIntervention`
    *   Plateau detection: `detectPlateau`, `triggerPlateauProtocol`
*   [ ] Create **`MockDataService`**: For testing the engine without real user data.

### **Phase 2: The "Tools" Layer**
*   [ ] Define **interface abstract class `AiTools`** with all 19 tool methods.
*   [ ] Implement wrapper methods that bridge the AI requests to the `TrainingEngine`:
    *   Context management: `get_training_context`
    *   Workout operations: `reschedule_workout`, `adjust_intensity`, `swap_workout`
    *   Load tracking: `calculate_acwr`, `log_session_rpe`, `log_biomarker`
    *   Race operations: `add_race_event`, `trigger_taper`
    *   Vacation operations: `schedule_vacation`, `return_from_break`
    *   Motivation tracking: `log_motivation`, `detect_skip_pattern`
    *   Plateau handling: `detect_plateau`, `trigger_plateau_protocol`
    *   Environmental: `check_weather`, `adjust_for_weather`
    *   Advanced: `process_screenshot`, `calculate_goal_confidence`
*   [ ] Implement **error handling and validation** for all tool calls.
*   [ ] Create **tool response schemas** for consistent AI parsing.

### **Phase 3: The Brain (AI Integration)**
*   [ ] Design **specialized Prompts** that understand the `Coach's Notebook` structure:
    *   System prompt with Ash personality and coaching philosophy
    *   Context window management (3-tier memory system)
    *   Tool calling instructions and examples
    *   Edge case handling (injury, motivation, weather, etc.)
*   [ ] Implement **Function Calling setup** (Gemini/OpenAI) mapped to `AiTools`:
    *   Tiered model strategy (Fast/Cheap vs. Reasoning/Complex)
    *   Token budget management
    *   Fallback handling for API failures
*   [ ] Build **conversation flow logic**:
    *   Daily check-ins and adaptive responses
    *   Motivation exploration and pattern detection
    *   Injury assessment and adjustment recommendations
    *   Goal confidence updates and transparency

### **Phase 4: Advanced Features**
*   [ ] **Weather Integration**:
    *   Connect to weather API (OpenWeatherMap, WeatherAPI, etc.)
    *   Implement weather-based workout adjustments
    *   Add weather alerts to daily check-ins
*   [ ] **Screenshot Processing**:
    *   Integrate OCR library (Google ML Kit, Tesseract)
    *   Implement AI vision for metric extraction (Gemini Vision)
    *   Build user confirmation flow for extracted data
*   [ ] **Health Connect Integration**:
    *   Implement data sync from Health Connect
    *   Parse workout data (distance, duration, HR, etc.)
    *   Calculate derived metrics (pace, training load)
*   [ ] **Calendar Visualization**:
    *   Build weekly and monthly calendar views
    *   Implement color-coded workout badges
    *   Add race event and vacation block overlays
    *   Show planned vs. completed workout states

### **Phase 5: Polish & Optimization**
*   [ ] **Performance Optimization**:
    *   Cache context synthesis results
    *   Optimize database queries
    *   Minimize AI API calls through smart caching
*   [ ] **Testing**:
    *   Unit tests for TrainingEngine logic
    *   Integration tests for AI tool calling
    *   End-to-end tests for critical user flows
*   [ ] **Documentation**:
    *   API documentation for AiTools interface
    *   Training Engine logic documentation
    *   AI prompt engineering guide
