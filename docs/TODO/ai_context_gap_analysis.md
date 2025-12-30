# AI Plan Generation Context - Gap Analysis

**Date**: 2025-12-30  
**Purpose**: Identify missing context needed for AI to generate training plans aligned with our training philosophy

---

## Executive Summary

After analyzing [training_philosophy.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/training_philosophy.md), [training_plans.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/running/training_plans.md), and the current implementation in [build_plan_generation_context.dart](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/lib/features/training/application/usecases/build_plan_generation_context.dart), there are **significant gaps** in the context being provided to the AI.

The AI currently receives basic user/goal information but lacks critical details needed to make informed decisions about:
- Intensity distribution strategy (Pyramidal vs. Polarized)
- Phase structure and duration calculations
- Recovery block placement
- Pillar coordination (Running/Strength/Mobility priorities)
- Adaptive logic triggers

---

## 1. Missing User Context Fields

### Current State
```dart
UserContext(
  age, gender, experienceLevel, availableDays, 
  timeConstraints, injuryHistory, weeklyMileageBase
)
```

### Missing Critical Fields

#### A. Volume & Experience Indicators (WIP)
> [!IMPORTANT]
> The AI needs to determine **Pyramidal vs. Polarized** intensity distribution based on volume/experience.

**Missing**:
- `currentWeeklyVolume` (km/week) - **Critical for intensity distribution decision**
- `currentWeeklyDuration` (minutes/week)
- `trainingFrequency` (sessions/week over last 4 weeks)
- `longestRecentRun` (km or minutes)
- `experienceLevelInference` - Currently hardcoded as "Intermediate"

**Philosophy Reference** ([training_philosophy.md:9-15](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/training_philosophy.md#L9-L15)):
```markdown
- Beginner & Low Volume (<30km/week): Pyramidal (70-80% Easy, 15-25% Moderate)
- Intermediate & Advanced (>40km/week): Polarized 80/20
```

**Current Implementation**: Hardcoded "Intermediate" with no volume calculation.

**Decision**: 
- **New Users**: Ask 2 key questions during onboarding:
  1. "How many days per week do you currently run/train?" (trainingFrequency)
  2. "What's your typical weekly running distance?" (currentWeeklyVolume)
- **Existing Users**: Calculate from database (last 4 weeks of workout data)
- **Action**: Add these questions to onboarding flow before goal type selection

---

#### B. Pillar Priorities (WIP)
> [!WARNING]
> Without pillar priorities, the AI cannot coordinate Running/Strength/Mobility scheduling.

**Missing**:
- `runningPriority` (High/Med/Low)
- `strengthPriority` (High/Med/Low)
- `mobilityPriority` (High/Med/Low)

**Philosophy Reference** ([training_philosophy.md:114-123](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/training_philosophy.md#L114-L123)):
```markdown
User sets priority for each pillar. Ash fills "Big Rocks" (High Priority) first.
Example: "High Run, Med Lift" → 4 Runs (Key sessions protected), 2 Lifts
Constraint: Hard Leg Day should NOT be the day before a Long Run
```

**Current Implementation**: Not captured at all.

**Decision**: 
- **Action**: Add Pillar Priorities screen to onboarding flow BEFORE age/gender details page
- **UI**: Allow users to set High/Med/Low priority for Running, Strength, and Mobility
- **Storage**: Add fields to User entity and database table

---

#### C. Time Constraints (Per Day Type) (Won't do, later phase)
**Current**: Empty map `{}`  
**Needed**:
```dart
timeConstraints: {
  'weekday': 60,      // minutes
  'weekend': 90,
  'specific_days': {  // Optional overrides
    'Monday': 45,
    'Saturday': 120
  }
}
```

**Philosophy Reference**: Workouts must fit user's available time ([plan_generation.md:272](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ai/prompts/plan_generation.md#L272)).

**Decision**: 
- **Status**: FUTURE FEATURE - Not implementing now
- **Action**: Document in `docs/ux/product_spec/lifecycle/time_constraints.md`
- **Rationale**: Good idea but adds complexity to onboarding. Defer to later iteration.

---

#### D. Injury & Pain History (Won't do, later phase)
**Current**: Empty list `[]`  
**Needed**:
- Structured injury history with dates and resolutions
- Current pain/discomfort flags
- Movement restrictions

**Philosophy Reference** ([training_philosophy.md:233-261](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/training_philosophy.md#L233-L261)): Injury management and low-impact alternatives.

**Decision**: 
- **Database Status**: No injury table exists yet
- **Action Required**: 
  1. Create `Injuries` table in Drift database
  2. Add injury tracking to User entity
  3. Build injury history context for AI
- **Priority**: MEDIUM - Important for AI safety decisions but not blocking initial plan generation

---

#### E. Recent Performance Metrics (Won't do)
**Missing**:
- `recent5KPace` (min/km)
- `recentBestEfforts` (map of distance → time)
- `currentFitnessLevel` (inferred from recent workouts)

**Philosophy Reference** ([plan_generation.md:142-145](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ai/prompts/plan_generation.md#L142-L145)): Context template includes `currentFitness`.

---

## 2. Missing Goal Context Fields

### Current State
```dart
GoalContext(
  type, target, deadline, confidence, 
  specialInstructions, currentPace
)
```

### Missing Critical Fields

#### A. Goal-Specific Parameters
**For Distance Milestone Goals**:
- `isFirstTime` (bool) - First time attempting this distance? ✅ **ADD TO GOAL SETUP FLOW**
- ~~`preferredWorkoutStyle`~~ - DEFERRED (not implementing now)

**For Time Performance Goals**:
- `currentBestTime` (for the target distance) (will do)
- `targetPacePerKm` (calculated from target time) (won't do)
- `volumeThreshold` (to determine Pyramidal vs. Polarized) (won't do)

**For Event Goals**:
- `eventName` (e.g., "Austin Marathon")
- `eventDate` (won't do, this is the deadline)
- `raceDistance` (km)

**For Maintenance Goals**:
- `previousTrainingVolume` (to calculate 50-66% reduction)
- `maintenanceDuration` (weeks)

---

#### B. Calculated Timeline Fields
**Missing**:
- `weeksAvailable` (calculated from today to deadline)
- `daysUntilGoal` (for precise phase calculations)
- `minimumWeeksRequired` (based on goal type and user fitness)

**Philosophy Reference** ([training_plans.md:17-21](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/running/training_plans.md#L17-L21)): Phase structure varies by goal type.

---

## 3. Missing Training History Context

### Current State
```dart
List<WorkoutSummary> trainingHistory  // Last 28 days
```

### Missing Aggregated Metrics

The AI receives raw workout data but lacks **pre-calculated insights**:

#### A. Load Management Metrics
> [!IMPORTANT]
> ACWR calculation is **core to adaptive logic** but not provided to AI.

**Missing**:
- `acuteLoad` (last 7 days total load)
- `chronicLoad` (last 28 days average weekly load)
- `currentACWR` (Acute ÷ Chronic)
- `acwrTrend` (increasing/stable/decreasing)

**Philosophy Reference** ([training_philosophy.md:137-143](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/training_philosophy.md#L137-L143)):
```markdown
ACWR = Acute Load ÷ Chronic Load
Safe Zone: 0.8 - 1.3
> 1.3: High injury risk, suggest deload
< 0.8: Undertraining, can safely increase volume
```

**Current Implementation**: AI cannot make ACWR-based decisions without this.

---

#### B. Consistency Metrics
**Missing**:
- `adherenceRate` (% of planned workouts completed in last 4 weeks)
- `consecutiveMissedSessions` (for Honesty Protocol trigger)
- `averageSessionRPE` (last 2 weeks)
- `highRPESessions` (count of RPE ≥ 8 in last 2 weeks)

**Philosophy Reference** ([training_philosophy.md:291-294](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/training_philosophy.md#L291-L294)):
```markdown
If consistency drops >40% sessions missed in High-Priority phase:
→ Trigger Honesty Protocol: "At this rate, hitting our goal might not be safe"
```

---

#### C. Volume Progression Analysis
**Missing**:
- `weeklyVolumeProgression` (last 4 weeks: [20km, 22km, 25km, 23km])
- `volumeIncreaseRate` (% change week-over-week)
- `peakWeeklyVolume` (highest in last 4 weeks)

**Philosophy Reference** ([plan_generation.md:269](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ai/prompts/plan_generation.md#L269)): Weekly mileage increases ≤15%.

---

## 4. Missing Training Philosophy Context

### Current State
```dart
trainingPhilosophy: _getTrainingPhilosophy(goal.type)
// Returns a single sentence per goal type
```

### What's Missing

The AI receives a **one-sentence summary** but needs the **full decision tree**:

#### A. Intensity Distribution Rules
**Current**: "Polarized training: 80% easy, 20% hard intervals"  
**Needed**:
```markdown
IF user.currentWeeklyVolume < 30km:
  → Pyramidal: 70-80% Easy, 15-25% Moderate, 0-5% High
ELSE IF user.currentWeeklyVolume >= 40km:
  → Polarized: 80% Low (RPE 3-4), 20% High (RPE 8-10)
ELSE:
  → Hybrid: Start Pyramidal, transition to Polarized as volume increases
```

**Philosophy Reference** ([training_philosophy.md:9-15](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/training_philosophy.md#L9-L15)).

---

#### B. Phase Structure Templates
**Missing**: Detailed phase duration and structure rules per goal type.

**Example for Event Goals** ([training_plans.md:68-74](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/running/training_plans.md#L68-L74)):
```markdown
Taper Protocols:
- 5K: 7-10 days (-30% W1, -50% final days)
- 10K: 10-14 days (-30% W1, -50% W2)
- Half Marathon: 2 weeks (-30% W1, -50% W2)
- Marathon: 3 weeks (-20% W1, -40% W2, -60% W3)
```

**Current Implementation**: AI must infer this from the one-sentence philosophy.

---

#### C. Recovery Block Placement Logic
**Missing**: When and how to insert recovery blocks.

**Philosophy Reference** ([training_philosophy.md:214-218](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/training_philosophy.md#L214-L218)):
```markdown
1. Intro Block: Onramp and volume stabilization
2. Progression Block: Strategic load increase
3. Peak Block: Intensive adaptation
4. Recovery Block: 20-30% volume reduction (every 3-4 weeks)
```

---

#### D. Pillar Coordination Rules
**Missing**: How to schedule Running/Strength/Mobility to avoid conflicts.

**Philosophy Reference** ([training_philosophy.md:191-194](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/training_philosophy.md#L191-L194)):
```markdown
- Hard Days Hard, Easy Days Easy
- 48-Hour Recovery Rule between hard efforts
- Avoid hard leg strength the day before a key run
```

---

#### E. Maintenance Goal Philosophy
**Missing**: Specific guidance on enjoyment and habit formation.

**Philosophy Reference** ([training_philosophy.md:56-105](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/training_philosophy.md#L56-L105)):
```markdown
Maintenance Goals:
- Reduce pressure, maximize enjoyment
- 85% Easy, 5% Moderate, 10% High
- One quality session per week (Long run OR Intervals, not both)
- Volume: 50-66% of previous training
- Success Metrics: Consistency, enjoyment, injury-free
```

---

## 5. Missing Adaptive Logic Context

### What the AI Needs to Know

The AI should receive **current state flags** that trigger adaptive responses:

#### A. Disruption Signals
**Missing**:
- `consecutiveMissedDays` (for Sliding Rule vs. Strategic Repair)
- `phaseBoundaryRisk` (bool) - Would sliding push workouts into next phase?

**Philosophy Reference** ([training_philosophy.md:226-231](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/training_philosophy.md#L226-L231)):
```markdown
- 48-Hour Slide: App automatically slides 1-2 missed sessions
- Phase Boundary Rule: If slide hits next phase → Strategic Repair
- AI Strategic Repair: For disruptions >3 days, re-evaluate entire Phase Skeleton
```

---

#### B. Fatigue & Recovery Signals
**Missing**:
- `currentACWR` (as mentioned above)
- `recentHighRPESessions` (count in last 7 days)
- `userReportedFatigue` (from recent check-ins)

**Philosophy Reference** ([training_philosophy.md:145-149](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/training_philosophy.md#L145-L149)):
```markdown
If ACWR > 1.3 or multiple consecutive poor sessions:
→ Early Recovery Block (reduce volume 20-30% for 7 days)
```

---

#### C. Return-to-Training Context
**Missing**:
- `daysSinceLastWorkout` (for return-to-training coefficients)
- `breakDuration` (to apply volume ceiling)

**Philosophy Reference** ([training_plans.md:167-176](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/running/training_plans.md#L167-L176)):
```markdown
Return-to-Training Coefficients:
- <3 days: 100% volume
- 1 week: 75-80% volume
- 2 weeks: 50-60% volume
- 4+ weeks: Scrutinize goal (Honesty Protocol)
```

---

## 6. Proposed Context Enhancements

### A. Extend [UserContext](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/lib/features/shared/domain/entities/ai/context_models.dart#20-35)
```dart
@freezed
class UserContext with _$UserContext {
  const factory UserContext({
    // Existing fields
    required int age,
    required String gender,
    required String experienceLevel,
    required List<String> availableDays,
    required Map<String, int> timeConstraints,
    required List<String> injuryHistory,
    double? weeklyMileageBase,
    
    // NEW: Volume & Experience
    required double currentWeeklyVolume,      // km/week (last 4 weeks avg)
    required int currentWeeklyDuration,       // minutes/week
    required int trainingFrequency,           // sessions/week
    required double longestRecentRun,         // km or minutes
    
    // NEW: Pillar Priorities
    required PillarPriority runningPriority,
    required PillarPriority strengthPriority,
    required PillarPriority mobilityPriority,
    
    // NEW: Performance Metrics
    String? recent5KPace,                     // "6:30/km"
    Map<String, String>? recentBestEfforts,   // {"5K": "30:00", "10K": "65:00"}
    
    // NEW: Current State
    int? currentPainLevel,                    // 0-10 scale
    List<InjuryRecord>? structuredInjuryHistory,
  }) = _UserContext;
}

enum PillarPriority { high, medium, low }
```

---

### B. Extend [GoalContext](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/lib/features/shared/domain/entities/ai/context_models.dart#36-50)
```dart
@freezed
class GoalContext with _$GoalContext {
  const factory GoalContext({
    // Existing fields
    required String type,
    required String target,
    required DateTime deadline,
    required double confidence,
    required List<String> specialInstructions,
    String? currentPace,
    
    // NEW: Calculated Timeline
    required int weeksAvailable,
    required int daysUntilGoal,
    required int minimumWeeksRequired,
    
    // NEW: Goal-Specific Parameters
    bool? isFirstTime,                        // For Distance Milestone
    String? preferredWorkoutStyle,            // "time_based" or "distance_based"
    int? currentBestTime,                     // For Time Performance (seconds)
    String? targetPacePerKm,                  // Calculated from target time
    String? eventName,                        // For Event goals
    DateTime? eventDate,                      // Distinct from deadline
    double? raceDistance,                     // km
    bool? isShortNotice,                      // <3 weeks to event
    double? previousTrainingVolume,           // For Maintenance (to calc 50-66%)
    int? maintenanceDuration,                 // weeks
  }) = _GoalContext;
}
```

---

### C. Add `TrainingMetrics` Context
```dart
@freezed
class TrainingMetrics with _$TrainingMetrics {
  const factory TrainingMetrics({
    // Load Management
    required double acuteLoad,                // Last 7 days total load
    required double chronicLoad,              // Last 28 days avg weekly load
    required double currentACWR,              // Acute ÷ Chronic
    required String acwrTrend,                // "increasing" | "stable" | "decreasing"
    
    // Consistency
    required double adherenceRate,            // % completed (last 4 weeks)
    required int consecutiveMissedSessions,
    required double averageSessionRPE,        // Last 2 weeks
    required int highRPESessions,             // Count of RPE ≥8 in last 2 weeks
    
    // Volume Progression
    required List<double> weeklyVolumeProgression,  // Last 4 weeks
    required double volumeIncreaseRate,       // % change week-over-week
    required double peakWeeklyVolume,         // Highest in last 4 weeks
    
    // Disruption Signals
    required int consecutiveMissedDays,
    required bool phaseBoundaryRisk,
    required int daysSinceLastWorkout,
  }) = _TrainingMetrics;
}
```

---

### D. Add `PhilosophyGuidance` Context
```dart
@freezed
class PhilosophyGuidance with _$PhilosophyGuidance {
  const factory PhilosophyGuidance({
    // Intensity Distribution
    required IntensityDistribution intensityStrategy,
    required Map<String, double> intensityBreakdown,  // {"easy": 0.8, "hard": 0.2}
    
    // Phase Structure
    required PhaseTemplate phaseTemplate,
    required Map<String, int> phaseDurations,         // {"base": 6, "build": 4, ...}
    
    // Recovery Logic
    required int recoveryBlockFrequency,              // Every N weeks
    required double recoveryVolumeReduction,          // 0.2-0.3 (20-30%)
    
    // Pillar Coordination
    required List<String> pillarConstraints,          // ["No hard legs before long run"]
    
    // Taper Protocol (if Event goal)
    TaperProtocol? taperProtocol,
  }) = _PhilosophyGuidance;
}

enum IntensityDistribution { pyramidal, polarized, hybrid }
```

---

### E. Update [PlanGenerationContext](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/lib/features/shared/domain/entities/ai/context_models.dart#7-19)
```dart
@freezed
class PlanGenerationContext with _$PlanGenerationContext {
  const factory PlanGenerationContext({
    required UserContext user,
    required GoalContext goal,
    required List<WorkoutSummary> trainingHistory,
    
    // NEW: Pre-calculated metrics
    required TrainingMetrics metrics,
    
    // NEW: Philosophy guidance
    required PhilosophyGuidance philosophy,
    
    // ENHANCED: Full training philosophy (not just one sentence)
    required String trainingPhilosophyDocument,
  }) = _PlanGenerationContext;
}
```

---

## 7. Implementation Recommendations

### Phase 1: High-Priority Additions (Immediate Impact)
1. **Volume Calculation**: Implement `currentWeeklyVolume` inference from `trainingHistory`
2. **ACWR Calculation**: Add `TrainingMetrics` with ACWR fields
3. **Pillar Priorities**: Capture in User entity and pass to context
4. **Timeline Calculations**: Add `weeksAvailable`, `daysUntilGoal` to [GoalContext](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/lib/features/shared/domain/entities/ai/context_models.dart#36-50)

### Phase 2: Medium-Priority Additions
5. **Consistency Metrics**: `adherenceRate`, `consecutiveMissedSessions`
6. **Goal-Specific Parameters**: `isFirstTime`, `isShortNotice`, `previousTrainingVolume`
7. **Performance Metrics**: `recent5KPace`, `recentBestEfforts`

### Phase 3: Advanced Context
8. **Philosophy Guidance**: Create `PhilosophyGuidance` builder that selects rules based on goal type
9. **Structured Injury History**: Replace string list with `InjuryRecord` objects
10. **Adaptive Signals**: `phaseBoundaryRisk`, `daysSinceLastWorkout`

---

## 8. Prompt Enhancement Recommendations

### Current Prompt Issues
The [plan_generation.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ai/prompts/plan_generation.md) prompt:
- Mentions "Honesty Protocol" but doesn't explain **when** to trigger it
- Says "Include Recovery Blocks every 3-4 weeks" but doesn't explain **how** to structure them
- References "Polarized 80/20" but doesn't explain **when** to use it vs. Pyramidal

### Proposed Enhancements
1. **Add Decision Trees**: Include explicit IF/THEN logic for intensity distribution, phase structure
2. **Provide Examples**: Show sample plans for each goal type with rationale
3. **Include Edge Case Handling**: Short-notice races, return-to-training, ACWR triggers
4. **Reference Full Philosophy**: Embed key sections of [training_philosophy.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/training_philosophy.md) directly in prompt

---

## 9. Related Files to Update

| File | Required Changes |
|------|------------------|
| [context_models.dart](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/lib/features/shared/domain/entities/ai/context_models.dart) | Add new fields to [UserContext](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/lib/features/shared/domain/entities/ai/context_models.dart#20-35), [GoalContext](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/lib/features/shared/domain/entities/ai/context_models.dart#36-50); create `TrainingMetrics`, `PhilosophyGuidance` |
| [build_plan_generation_context.dart](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/lib/features/training/application/usecases/build_plan_generation_context.dart) | Implement volume/ACWR calculations, pillar priority mapping |
| [prompts.dart](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/lib/core/constants/prompts.dart) | Expand `generatePlanTask` with decision trees and edge cases |
| [plan_generation.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ai/prompts/plan_generation.md) | Add detailed decision logic, examples, edge case handling |
| [ai_integration.md](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/ai_integration.md) | Document new context models and calculation logic |

---

## 10. Summary of Critical Gaps

> [!CAUTION]
> **Without these fields, the AI cannot follow our training philosophy:**

1. **No volume data** → Cannot choose Pyramidal vs. Polarized intensity
2. **No ACWR** → Cannot trigger adaptive recovery or Honesty Protocol
3. **No pillar priorities** → Cannot coordinate Running/Strength/Mobility
4. **No timeline calculations** → Cannot structure phases correctly
5. **No consistency metrics** → Cannot detect when to suggest goal adjustments
6. **One-sentence philosophy** → Cannot make nuanced decisions about phase structure, recovery blocks, taper protocols

**Bottom Line**: The AI is currently making **blind guesses** about critical training decisions because it lacks the context to apply our documented philosophy.

---

## 11. Action Items Summary

Based on user feedback, here are the prioritized action items:

### Immediate Actions (This Sprint)

1. **Add Volume/Experience Questions to Onboarding**
   - Add 2 questions before goal type selection:
     - "How many days per week do you currently run/train?"
     - "What's your typical weekly running distance?"
   - Store in User entity
   - Use for intensity distribution decision (Pyramidal vs. Polarized)

2. **Add Pillar Priorities Screen to Onboarding**
   - Insert BEFORE age/gender details page
   - UI: 3 dropdowns (Running, Strength, Mobility) with High/Med/Low options
   - Add fields to User entity and database table
   - Pass to AI for workout scheduling coordination

3. **Add `isFirstTime` to Distance Milestone Goal Setup**
   - Add checkbox: "Is this your first time attempting this distance?"
   - Store in Goal entity
   - Pass to AI for appropriate plan difficulty calibration

### Short-Term Actions (Next Sprint)

4. **Create Injury Tracking System**
   - Create `Injuries` Drift table
   - Add injury history to User entity
   - Build injury context for AI safety decisions
   - Priority: MEDIUM (important but not blocking)

5. **Calculate Volume Metrics for Existing Users**
   - Implement `currentWeeklyVolume` calculation from workout history
   - Implement `trainingFrequency` calculation
   - Add to `BuildPlanGenerationContext` use case

### Deferred / Future Features

6. **Time Constraints Feature**
   - Status: Documented in [`time_constraints.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/lifecycle/time_constraints.md)
   - Rationale: Adds onboarding complexity, diminishing returns
   - Revisit after initial launch

7. **Preferred Workout Style**
   - Status: DEFERRED
   - Rationale: AI can default to time-based for Distance Milestone goals
   - Not a critical decision point

---

## 12. Updated Implementation Priorities

### Phase 1: Critical Context (Blocks AI from working correctly)
1. ✅ Volume/Experience questions in onboarding
2. ✅ Pillar Priorities screen in onboarding
3. ✅ `isFirstTime` field for Distance Milestone goals
4. Volume calculation for existing users
5. Timeline calculations (`weeksAvailable`, `daysUntilGoal`)

### Phase 2: Enhanced Context (Improves AI decisions)
6. ACWR calculation and load management metrics
7. Consistency metrics (`adherenceRate`, `consecutiveMissedSessions`)
8. Injury tracking system
9. Performance metrics (`recent5KPace`, `recentBestEfforts`)

### Phase 3: Advanced Context (Nice to have)
10. Philosophy Guidance builder
11. Adaptive signals (`phaseBoundaryRisk`, `daysSinceLastWorkout`)
12. Time constraints feature (if user demand exists)
