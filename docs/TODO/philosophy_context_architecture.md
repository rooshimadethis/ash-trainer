# Philosophy Context Architecture

**Purpose**: Design structured context models to replace the single-string `trainingPhilosophy` field, enabling the AI to receive precise, operation-specific guidance from our training philosophy documents.

---

## 1. Current Problem

**Current State:**
```dart
trainingPhilosophy: "Focus on gradual volume increase. Pyramidal intensity distribution: 80% easy, 20% moderate."
```

**Issues:**
- Too simplistic - doesn't capture nuance from our 400+ line philosophy docs
- One-size-fits-all - same string for plan generation, adjustments, coaching chat
- Hard to maintain - changes require code updates
- Doesn't leverage structured data for AI decision-making

---

## 2. Proposed Architecture

### **Core Principle: Context-Specific Philosophy**

Different AI operations need different philosophy guidance:

| AI Operation | Philosophy Needs |
|--------------|------------------|
| **Plan Generation** | Intensity distribution, phase structure, volume progression, taper protocols |
| **Plan Adjustment** | Sliding rules, ACWR thresholds, return-to-training coefficients |
| **Injury Management** | Diagnosis protocol, escalation timeline, low-impact alternatives |
| **Coaching Chat** | Tone guidelines, honesty protocol, mental health responses |

---

## 3. Context Model Design

### **A. Plan Generation Philosophy Context**

**Purpose**: Guide initial plan creation with goal-specific training strategies.

> [!IMPORTANT]
> **Design Principle**: Provide **constraints and principles**, not **prescriptions**. The AI should reason about optimal plan structure, not fill in templates.

**What We Provide** (Guardrails & Principles):
- ✅ Safety constraints (max volume increase, recovery frequency)
- ✅ Intensity principles (pyramidal vs. polarized with percentages)
- ✅ Coordination rules (pillar scheduling constraints)
- ✅ Goal-specific guidance (training focus, workout style)
- ✅ Taper approach (strategy and duration range)

**What We Don't Provide** (Let AI Decide):
- ❌ Exact phase structures (no "Base: 6-8 weeks" templates)
- ❌ Specific workout types per phase
- ❌ Exact taper percentages
- ❌ Predetermined phase durations

```dart
@freezed
class PlanGenerationPhilosophy with _$PlanGenerationPhilosophy {
  const factory PlanGenerationPhilosophy({
    // RUNNING GUIDANCE
    // PRINCIPLE: Intensity distribution strategy
    required IntensityStrategy intensityStrategy,
    required Map<String, double> intensityBreakdown,
    
    // CONSTRAINT: Volume safety limits
    required double maxWeeklyVolumeIncrease,  // 0.10 = max 10% increase
    
    // CONSTRAINT: Recovery frequency
    required int minWeeksBetweenRecovery,     // 3 = at least 3 weeks
    required int maxWeeksBetweenRecovery,     // 5 = at most 5 weeks
    required double recoveryVolumeReduction,  // 0.25 = 25% reduction
    
    // CONSTRAINT: Pillar coordination rules
    required List<String> pillarConstraints,
    
    // GUIDANCE: Taper approach (only for event goals)
    TaperGuidance? taperGuidance,
    
    // GUIDANCE: Goal-specific principles
    required String trainingFocus,     // "Completion over speed" or "Speed development"
    required String workoutStyle,      // "time_based" or "distance_based"
    required String flexibilityLevel,  // "high", "medium", "low"
    
    // STRENGTH GUIDANCE (Phase 1 - MVP)
    required StrengthGuidance strengthGuidance,
    
    // MOBILITY GUIDANCE (Phase 1 - MVP)
    required MobilityGuidance mobilityGuidance,
  }) = _PlanGenerationPhilosophy;
}

enum IntensityStrategy {
  pyramidal,  // 70-80% Easy, 15-25% Moderate, 0-5% High
  polarized,  // 80% Low (RPE 3-4), 20% High (RPE 8-10)
  maintenance // 85% Easy, 5% Moderate, 10% High
}

@freezed
class TaperGuidance with _$TaperGuidance {
  const factory TaperGuidance({
    required String strategy,        // "progressive_volume_reduction"
    required int minDurationDays,    // 7 for 5K
    required int maxDurationDays,    // 21 for marathon
    required bool maintainIntensity, // true = keep intensity, reduce volume
    // NO exact percentages - let AI decide based on race distance and user fitness
  }) = _TaperGuidance;
}

@freezed
class StrengthGuidance with _$StrengthGuidance {
  const factory StrengthGuidance({
    required int weeklyFrequency,        // 1-4 based on priority
    required int sessionDurationMinutes, // 10-20 for Phase 1
    required String weeklyFocus,         // "single_leg_core", "hip_glute_posterior", "plyometric_core", "single_leg_hip_glute"
    required int setsPerExercise,        // 2-3 based on priority
    required String repRange,            // "8-12" or "30-45s" for core
  }) = _StrengthGuidance;
}

@freezed
class MobilityGuidance with _$MobilityGuidance {
  const factory MobilityGuidance({
    required int weeklyFrequency,        // 2-7 based on priority
    required int sessionDurationMinutes, // 10-30 based on priority
    required List<String> sessionTypes,  // ["active_pre_run", "passive_post_run", "recovery_deep"]
    required List<String> focusAreas,    // ["hip_mobility", "ankle_mobility", "thoracic_spine", "hamstrings"]
    required bool increaseDuringTaper,   // true for event goals
  }) = _MobilityGuidance;
}
```

**Builder Logic:**
```dart
PlanGenerationPhilosophy buildPlanPhilosophy(
  Goal goal, 
  double weeklyVolume,
  int currentWeekNumber,
) {
  final intensityStrategy = _selectIntensityStrategy(goal.type, weeklyVolume);
  final taperGuidance = goal.type == GoalType.event 
      ? _buildTaperGuidance(goal.targetDistance)
      : null;
  
  return PlanGenerationPhilosophy(
    // Running guidance
    intensityStrategy: intensityStrategy,
    intensityBreakdown: _getIntensityBreakdown(intensityStrategy),
    maxWeeklyVolumeIncrease: 0.10,
    minWeeksBetweenRecovery: 3,
    maxWeeksBetweenRecovery: 5,
    recoveryVolumeReduction: 0.25,
    pillarConstraints: [
      "No hard leg strength the day before a long run",
      "48-hour recovery between hard efforts in same pillar",
      "Hard days hard, easy days easy"
    ],
    taperGuidance: taperGuidance,
    trainingFocus: _getTrainingFocus(goal.type),
    workoutStyle: _getWorkoutStyle(goal.type),
    flexibilityLevel: _getFlexibilityLevel(goal.type),
    
    // Strength guidance (Phase 1 - MVP)
    strengthGuidance: _buildStrengthGuidance(
      goal.type,
      goal.strengthPriority,
      currentWeekNumber,
    ),
    
    // Mobility guidance (Phase 1 - MVP)
    mobilityGuidance: _buildMobilityGuidance(
      goal.type,
      goal.mobilityPriority,
    ),
  );
}

// Running helpers
IntensityStrategy _selectIntensityStrategy(GoalType goalType, double weeklyVolume) {
  if (goalType == GoalType.maintenance) return IntensityStrategy.maintenance;
  if (weeklyVolume < 30) return IntensityStrategy.pyramidal;
  if (weeklyVolume >= 40) return IntensityStrategy.polarized;
  return IntensityStrategy.pyramidal; // Default to safer approach
}

TaperGuidance _buildTaperGuidance(double? targetDistance) {
  if (targetDistance == null || targetDistance <= 5) {
    return TaperGuidance(
      strategy: "progressive_volume_reduction",
      minDurationDays: 7,
      maxDurationDays: 10,
      maintainIntensity: true,
    );
  } else if (targetDistance <= 10) {
    return TaperGuidance(
      strategy: "progressive_volume_reduction",
      minDurationDays: 10,
      maxDurationDays: 14,
      maintainIntensity: true,
    );
  } else if (targetDistance <= 21.1) {
    return TaperGuidance(
      strategy: "progressive_volume_reduction",
      minDurationDays: 14,
      maxDurationDays: 14,
      maintainIntensity: true,
    );
  } else {
    return TaperGuidance(
      strategy: "progressive_volume_reduction",
      minDurationDays: 14,
      maxDurationDays: 21,
      maintainIntensity: true,
    );
  }
}

String _getTrainingFocus(GoalType goalType) {
  switch (goalType) {
    case GoalType.distanceMilestone:
      return "Completion over speed - build endurance safely and prevent injury";
    case GoalType.timePerformance:
      return "Speed development - improve race pace and efficiency";
    case GoalType.event:
      return "Peak performance on race day - periodized training with race-specific work";
    case GoalType.maintenance:
      return "Sustain fitness with minimal effective dose - prioritize enjoyment";
  }
}

String _getWorkoutStyle(GoalType goalType) {
  switch (goalType) {
    case GoalType.distanceMilestone:
      return "time_based"; // "Run for 30 minutes" reduces pressure
    case GoalType.timePerformance:
    case GoalType.event:
      return "distance_based"; // "6 x 400m" for specific targets
    case GoalType.maintenance:
      return "effort_based"; // "Easy 30 min or 5K, whatever feels good"
  }
}

String _getFlexibilityLevel(GoalType goalType) {
  switch (goalType) {
    case GoalType.distanceMilestone:
      return "high";
    case GoalType.timePerformance:
      return "medium";
    case GoalType.event:
      return "low";
    case GoalType.maintenance:
      return "very_high";
  }
}

// Strength helpers
StrengthGuidance _buildStrengthGuidance(
  GoalType goalType,
  String strengthPriority,
  int weekNumber,
) {
  int frequency = _getStrengthFrequency(strengthPriority, goalType);
  int duration = strengthPriority == 'high' ? 20 : (strengthPriority == 'medium' ? 15 : 10);
  int sets = strengthPriority == 'high' ? 3 : 2;
  
  return StrengthGuidance(
    weeklyFrequency: frequency,
    sessionDurationMinutes: duration,
    weeklyFocus: _getStrengthWeeklyFocus(weekNumber),
    setsPerExercise: sets,
    repRange: "8-12",
  );
}

int _getStrengthFrequency(String priority, GoalType goalType) {
  // Maintenance goals boost strength if running is low
  if (goalType == GoalType.maintenance) return 3;
  
  switch (priority) {
    case 'high': return 4;
    case 'medium': return 3;
    case 'low': return 2;
    default: return 2;
  }
}

String _getStrengthWeeklyFocus(int weekNumber) {
  // 4-week rotation pattern
  switch (weekNumber % 4) {
    case 1: return "single_leg_core";
    case 2: return "hip_glute_posterior";
    case 3: return "plyometric_core"; // Only if user is intermediate+
    case 0: return "single_leg_hip_glute";
    default: return "single_leg_core";
  }
}

// Mobility helpers
MobilityGuidance _buildMobilityGuidance(
  GoalType goalType,
  String mobilityPriority,
) {
  int frequency = _getMobilityFrequency(mobilityPriority);
  int duration = mobilityPriority == 'high' ? 30 : (mobilityPriority == 'medium' ? 20 : 15);
  
  return MobilityGuidance(
    weeklyFrequency: frequency,
    sessionDurationMinutes: duration,
    sessionTypes: ["active_pre_run", "passive_post_run", "recovery_deep"],
    focusAreas: ["hip_mobility", "ankle_mobility", "thoracic_spine", "hamstrings"],
    increaseDuringTaper: goalType == GoalType.event,
  );
}

int _getMobilityFrequency(String priority) {
  switch (priority) {
    case 'high': return 6;
    case 'medium': return 4;
    case 'low': return 3;
    default: return 3;
  }
}
```

**System Prompt Strategy:**

Phase structure reasoning lives in the **system prompt**, not the context:

```
RUNNING PRESCRIPTION:

PHASE STRUCTURE PRINCIPLES:
- Distance Milestone: Gradual volume building (50-60% base, 20-30% familiarization, 10-20% taper)
- Time Performance: Base → Build → Peak → Taper (40-50% / 30-40% / 15-20% / 7-14 days)
- Event: Periodized phases arriving fresh on race day
- Maintenance: No traditional phases - consistent moderate effort

TAPER DESIGN:
- Calculate reduction percentages based on race distance and user fitness
- Longer tapers for longer races (5K: 7-10d, Half: 14d, Marathon: 14-21d)
- Final week should be 40-60% of peak volume

STRENGTH PRESCRIPTION (Phase 1 - MVP):

FREQUENCY & VOLUME:
- High priority: 3-4x/week, 15-20 min sessions, 3 sets per exercise
- Medium priority: 2-3x/week, 10-15 min sessions, 2-3 sets per exercise
- Low priority: 1-2x/week, 10 min sessions, 2 sets per exercise
- Maintenance goals: Boost to 3x/week if running is low priority

4-WEEK ROTATION:
- Week 1: Single-leg stability + Core (e.g., Single-Leg Glute Bridge, Plank)
- Week 2: Hip/Glute strength + Posterior chain (e.g., Clamshells, Single-Leg RDL)
- Week 3: Plyometrics + Core (e.g., Single-Leg Hops, Bird Dogs) - intermediate+ only
- Week 4: Single-leg stability + Hip/Glute strength (e.g., Bulgarian Split Squat, Lateral Lunges)

PRESCRIPTION FORMAT:
- 2-3 bodyweight exercises per session
- 8-12 reps or 30-45 seconds for core
- RPE 7 (2-3 RIR - moderate effort)
- Rest 60-90 seconds between sets

SCHEDULING RULES:
- 48h recovery before key runs (intervals, tempo, long runs)
- Can stack with easy runs (run first, strength after)
- Never stack hard leg strength + hard running on consecutive days
- Reduce to 1-2x/week during taper, 40% volume reduction

MOBILITY PRESCRIPTION (Phase 1 - MVP):

FREQUENCY & VOLUME:
- High priority: 5-7x/week, 20-30 min sessions
- Medium priority: 3-5x/week, 15-20 min sessions
- Low priority: 2-3x/week, 10-15 min sessions
- Event taper: INCREASE to 5-7x/week

SESSION TYPES:
- Active Mobility (10-15 min): Pre-run dynamic stretches, movement prep
  * Leg swings, walking lunges, high knees, hip circles
  * Do before key workouts
- Passive Mobility (15-20 min): Post-run static stretches, foam rolling
  * Foam roll calves/IT band, hip flexor stretch, hamstring stretch, figure-4 stretch
  * Hold each stretch 60 seconds
  * Do after all runs, especially long runs
- Recovery Deep (20-30 min): Longer holds (90s), full-body focus
  * 1-2x per week on rest days

FOCUS AREAS:
- Hip mobility (hip flexors, glutes, external rotators)
- Ankle mobility (dorsiflexion, calf flexibility)
- Thoracic spine (upper back rotation)
- Hamstring flexibility

SCHEDULING RULES:
- Active mobility before key workouts (5-10 min)
- Passive mobility after all runs (10-15 min)
- Can be done daily - consistency over intensity
- No equipment needed (bodyweight or household items)

PILLAR COORDINATION:
- High-priority pillars get scheduled first ("Big Rocks")
- Hard leg strength NOT scheduled day before long run or intervals
- Mobility sessions can fill gaps between hard efforts
- Recovery weeks: Running volume -20%, Strength volume -40%, Mobility frequency +1-2x/week

You have creative freedom to design the optimal plan within the safety constraints.
```

---

### **B. Adjustment Philosophy Context**

**Purpose**: Guide plan adjustments for missed workouts, schedule changes, and disruptions.

```dart
@freezed
class AdjustmentPhilosophy with _$AdjustmentPhilosophy {
  const factory AdjustmentPhilosophy({
    // Missed Workout Logic
    required SlidingRules slidingRules,
    
    // ACWR Thresholds
    required ACWRThresholds acwrThresholds,
    
    // Return-to-Training Coefficients
    required List<ReturnCoefficient> returnCoefficients,
    
    // Goal-specific flexibility
    required WorkoutFlexibility flexibility,
  }) = _AdjustmentPhilosophy;
}

@freezed
class SlidingRules with _$SlidingRules {
  const factory SlidingRules({
    required int maxAutoSlideDays, // 2 = auto-slide up to 2 missed sessions
    required bool respectPhaseBoundaries, // true = don't slide into next phase
    required int strategicRepairThreshold, // 3 = trigger AI repair after 3+ days missed
  }) = _SlidingRules;
}

@freezed
class ACWRThresholds with _$ACWRThresholds {
  const factory ACWRThresholds({
    required double safeMin, // 0.8
    required double safeMax, // 1.3
    required double deloadTrigger, // 1.3 = trigger early recovery block
    required double undertrainingThreshold, // 0.8 = can safely increase volume
  }) = _ACWRThresholds;
}

@freezed
class ReturnCoefficient with _$ReturnCoefficient {
  const factory ReturnCoefficient({
    required int breakDurationDays,
    required double volumeCoefficient, // 0.75 = return at 75% volume
    required String progressionLogic, // "3-day recovery ramp before resuming intensity"
  }) = _ReturnCoefficient;
}

@freezed
class WorkoutFlexibility with _$WorkoutFlexibility {
  const factory WorkoutFlexibility({
    required String level, // "high", "medium", "low"
    required bool canSkipKeyWorkouts,
    required bool canRescheduleKeyWorkouts,
    required String missedWorkoutStrategy, // "skip_entirely", "reschedule_if_fresh", "attempt_light_version"
  }) = _WorkoutFlexibility;
}
```

**Builder Logic:**
```dart
AdjustmentPhilosophy buildAdjustmentPhilosophy(GoalType goalType) {
  return AdjustmentPhilosophy(
    slidingRules: SlidingRules(
      maxAutoSlideDays: 2,
      respectPhaseBoundaries: true,
      strategicRepairThreshold: 3,
    ),
    acwrThresholds: ACWRThresholds(
      safeMin: 0.8,
      safeMax: 1.3,
      deloadTrigger: 1.3,
      undertrainingThreshold: 0.8,
    ),
    returnCoefficients: [
      ReturnCoefficient(breakDurationDays: 3, volumeCoefficient: 1.0, progressionLogic: "Resume as planned"),
      ReturnCoefficient(breakDurationDays: 7, volumeCoefficient: 0.75, progressionLogic: "3-day recovery ramp"),
      ReturnCoefficient(breakDurationDays: 14, volumeCoefficient: 0.50, progressionLogic: "1 full week of base building"),
      ReturnCoefficient(breakDurationDays: 28, volumeCoefficient: 0.40, progressionLogic: "Scrutinize goal (Honesty Protocol)"),
    ],
    flexibility: _getFlexibility(goalType),
  );
}

WorkoutFlexibility _getFlexibility(GoalType goalType) {
  // From training_plans.md lines 161-165
  switch (goalType) {
    case GoalType.distanceMilestone:
      return WorkoutFlexibility(
        level: "high",
        canSkipKeyWorkouts: true,
        canRescheduleKeyWorkouts: false,
        missedWorkoutStrategy: "skip_entirely",
      );
    case GoalType.timePerformance:
      return WorkoutFlexibility(
        level: "medium",
        canSkipKeyWorkouts: false,
        canRescheduleKeyWorkouts: true,
        missedWorkoutStrategy: "reschedule_if_fresh",
      );
    case GoalType.event:
      return WorkoutFlexibility(
        level: "low",
        canSkipKeyWorkouts: false,
        canRescheduleKeyWorkouts: true,
        missedWorkoutStrategy: "attempt_light_version",
      );
    case GoalType.maintenance:
      return WorkoutFlexibility(
        level: "very_high",
        canSkipKeyWorkouts: true,
        canRescheduleKeyWorkouts: true,
        missedWorkoutStrategy: "skip_without_guilt",
      );
  }
}
```

---

### **C. Injury Management Philosophy Context**

**Purpose**: Guide AI responses to pain/injury reports.

```dart
@freezed
class InjuryPhilosophy with _$InjuryPhilosophy {
  const factory InjuryPhilosophy({
    // Diagnosis Protocol
    required List<String> diagnosisQuestions,
    
    // Escalation Timeline
    required List<EscalationStage> escalationStages,
    
    // Low-Impact Alternative Rules
    required LowImpactRules lowImpactRules,
    
    // Medical Disclaimer Triggers
    required List<String> medicalDisclaimerTriggers,
  }) = _InjuryPhilosophy;
}

@freezed
class EscalationStage with _$EscalationStage {
  const factory EscalationStage({
    required int daysSincePainStart,
    required String action,
    required String message,
  }) = _EscalationStage;
}

@freezed
class LowImpactRules with _$LowImpactRules {
  const factory LowImpactRules({
    required bool offerByDefault, // false = only offer when user requests
    required int daysBeforeOffering, // 3 = offer after 3 days of pain
    required String philosophy, // "Injury recovery only, not regular programming"
  }) = _LowImpactRules;
}
```

**Builder Logic:**
```dart
InjuryPhilosophy buildInjuryPhilosophy() {
  // From training_philosophy.md lines 233-262
  return InjuryPhilosophy(
    diagnosisQuestions: [
      "What makes it worse? (Running/Lifting/Walking)",
      "What makes it better?",
      "Where exactly does it hurt?",
      "Is it sharp pain or dull ache?",
    ],
    escalationStages: [
      EscalationStage(
        daysSincePainStart: 1,
        action: "Reduce running intensity/volume, add mobility/rehab work",
        message: "Let's dial back the intensity and see how it feels tomorrow.",
      ),
      EscalationStage(
        daysSincePainStart: 3,
        action: "Suggest low-impact alternatives if user requests",
        message: "If you want to maintain cardio, we could try cycling or swimming temporarily.",
      ),
      EscalationStage(
        daysSincePainStart: 5,
        action: "Recommend medical consultation, pause running",
        message: "This has been going on for a while. I'd recommend seeing a healthcare professional.",
      ),
    ],
    lowImpactRules: LowImpactRules(
      offerByDefault: false,
      daysBeforeOffering: 3,
      philosophy: "Low-impact alternatives are for injury recovery only, not regular programming",
    ),
    medicalDisclaimerTriggers: [
      "Pain persists beyond 5 days",
      "Pain worsens despite modifications",
      "Sharp pain during activity",
      "Swelling or visible injury",
    ],
  );
}
```

---

### **D. Coaching Chat Philosophy Context**

**Purpose**: Guide AI tone, responses, and mental health handling in chat conversations.

```dart
@freezed
class CoachingPhilosophy with _$CoachingPhilosophy {
  const factory CoachingPhilosophy({
    // Tone Guidelines
    required ToneGuidelines toneGuidelines,
    
    // Honesty Protocol
    required HonestyProtocol honestyProtocol,
    
    // Mental Health Response Patterns
    required Map<String, String> mentalHealthResponses,
    
    // Autoregulation Philosophy
    required String autoregulationMessage,
  }) = _CoachingPhilosophy;
}

@freezed
class ToneGuidelines with _$ToneGuidelines {
  const factory ToneGuidelines({
    required List<String> corePrinciples,
    required Map<String, String> exampleResponses,
  }) = _ToneGuidelines;
}

@freezed
class HonestyProtocol with _$HonestyProtocol {
  const factory HonestyProtocol({
    required double missedSessionThreshold, // 0.40 = 40% sessions missed
    required String triggerMessage,
    required String pivotOffer,
  }) = _HonestyProtocol;
}
```

**Builder Logic:**
```dart
CoachingPhilosophy buildCoachingPhilosophy() {
  // From training_philosophy.md lines 370-386, 290-327
  return CoachingPhilosophy(
    toneGuidelines: ToneGuidelines(
      corePrinciples: [
        "Celebrate consistency over performance",
        "Normalize setbacks",
        "Reframe rest as training",
        "No guilt, ever",
        "Encourage autoregulation",
      ],
      exampleResponses: {
        "after_tough_session": "That was a hard effort—well done for pushing through!",
        "after_missed_workout": "No worries, we'll keep the plan moving forward.",
        "during_plateau": "Progress isn't always linear. Let's try a new approach.",
        "during_deload": "This week is about recovery, not slacking. Trust the process.",
      },
    ),
    honestyProtocol: HonestyProtocol(
      missedSessionThreshold: 0.40,
      triggerMessage: "Hey, we've missed a few key sessions. At this rate, hitting our original goal might not be safe for your legs.",
      pivotOffer: "I can adjust our target to a 'Strong Finish' goal, which reduces the intensity but ensures we get you to the finish line healthy. What do you think?",
    ),
    mentalHealthResponses: {
      "exhausted": "Suggest rest day or light mobility. Check ACWR—may trigger early deload week.",
      "stressed": "Offer a 'mood boost' workout: short, easy, feel-good (e.g., 20-min walk or light yoga). No pressure.",
      "not_motivated": "Explore further: 'Is it this specific workout, or training in general right now?'",
      "workout_boring": "Offer swap: different exercise, outdoor vs. gym, music/podcast suggestion.",
      "feels_pointless": "Revisit goals: 'Let's check in on what you're training for. Has anything changed?'",
    },
    autoregulationMessage: "Hit the prescribed RPE, not the prescribed pace/weight. If feeling strong, push harder; if fatigued, dial back.",
  );
}
```

---

## 4. System Prompt vs. Context Data

### **System Prompt** (Static, defines Ash's identity)
**File**: `prompts.dart` → `AIPrompts.ashPersona`

**Content:**
- Ash's personality ("supportive partner, not drill sergeant")
- Core coaching principles (consistency > perfection, normalize setbacks)
- Communication style (empathetic, encouraging, no guilt)
- Out-of-scope boundaries (no nutrition plans, no medical diagnosis)

**Example:**
```
You are Ash, a supportive AI running coach. Your role is to help users train consistently and enjoyably while preventing injury. You celebrate effort over results, normalize setbacks, and never make users feel guilty about missed workouts. You focus on running, strength, and mobility training—not nutrition plans or medical diagnosis.
```

---

### **Context Data** (Dynamic, operation-specific)
**Sent with each API call**

**Content:**
- Structured philosophy models (PlanGenerationPhilosophy, AdjustmentPhilosophy, etc.)
- User-specific data (current volume, goal type, training history)
- Calculated metrics (ACWR, adherence rate, days until goal)

**Example for Plan Generation:**
```json
{
  "philosophy": {
    "intensityStrategy": "polarized",
    "intensityBreakdown": {"easy": 0.80, "high": 0.20},
    "maxWeeklyVolumeIncrease": 0.10,
    "recoveryBlockFrequency": 4,
    "phaseTemplates": [
      {
        "phaseName": "Base",
        "minWeeks": 4,
        "maxWeeks": 6,
        "focus": "Aerobic foundation",
        "keyWorkoutTypes": ["long_run", "easy_run"]
      }
    ],
    "pillarConstraints": [
      "No hard leg strength the day before a long run",
      "48-hour recovery between hard efforts"
    ]
  }
}
```

---

## 5. Implementation Roadmap

### **Phase 1: Core Models** (Week 1)
1. Create Freezed models for all philosophy contexts
2. Run `build_runner` to generate code
3. Update [context_models.dart](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/lib/features/shared/domain/entities/ai/context_models.dart) to include new models

### **Phase 2: Builder Logic** (Week 1-2)
4. Implement builder functions for each philosophy type
5. Map philosophy doc sections to structured data
6. Add unit tests for builder logic

### **Phase 3: Integration** (Week 2)
7. Update [PlanGenerationContext](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/lib/features/shared/domain/entities/ai/context_models.dart#7-19) to include `PlanGenerationPhilosophy`
8. Update [BuildPlanGenerationContext](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/lib/features/training/application/usecases/build_plan_generation_context.dart#7-134) use case to build philosophy
9. Update AI service to send philosophy in context

### **Phase 4: Prompts** (Week 2-3)
10. Refactor system prompts to reference structured context
11. Update task prompts to use philosophy fields
12. Test with real AI calls

### **Phase 5: Expand** (Week 3+)
13. Add AdjustmentPhilosophy to adjustment use cases
14. Add InjuryPhilosophy to injury management flows
15. Add CoachingPhilosophy to chat context

---

## 6. Benefits

✅ **Maintainability**: Philosophy changes update in one place (builder logic)  
✅ **Precision**: AI gets exact rules, not vague sentences  
✅ **Testability**: Can unit test philosophy selection logic  
✅ **Flexibility**: Different operations get different context  
✅ **Scalability**: Easy to add new philosophy types (e.g., StrengthPhilosophy)  
✅ **Transparency**: Clear mapping from docs → code → AI context  

---

## 7. Example: Full Plan Generation Context

**Before:**
```dart
PlanGenerationContext(
  user: UserContext(...),
  goal: GoalContext(...),
  trainingHistory: [...],
  trainingPhilosophy: "Focus on gradual volume increase. Pyramidal intensity distribution: 80% easy, 20% moderate.",
)
```

**After:**
```dart
PlanGenerationContext(
  user: UserContext(...),
  goal: GoalContext(...),
  trainingHistory: [...],
  philosophy: PlanGenerationPhilosophy(
    intensityStrategy: IntensityStrategy.pyramidal,
    intensityBreakdown: {"easy": 0.80, "moderate": 0.15, "high": 0.05},
    maxWeeklyVolumeIncrease: 0.10,
    recoveryBlockFrequency: 4,
    recoveryVolumeReduction: 0.25,
    phaseTemplates: [
      PhaseTemplate(
        phaseName: "Base",
        minWeeks: 6,
        maxWeeks: 8,
        focus: "Pure aerobic building",
        keyWorkoutTypes: ["long_run", "easy_run", "strides"],
      ),
      // ... more phases
    ],
    taperProtocol: null, // Not an event goal
    pillarConstraints: [
      "No hard leg strength the day before a long run",
      "48-hour recovery between hard efforts in same pillar",
    ],
  ),
)
```

---

## Next Steps

1. **Review this design** - Does the structure make sense?
2. **Prioritize implementation** - Which philosophy context should we build first?
3. **Define scope** - Should we implement all 4 contexts, or start with PlanGenerationPhilosophy?
4. **Update prompts** - How should the AI task prompts reference these structured fields?

Let me know your thoughts and we can start implementing!
