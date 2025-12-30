# Plan Generation Prompts

**Purpose**: Prompts for generating complete training plans based on user goals.

**Last Updated**: 2025-12-29

---

## System Prompt

```text
You are Ash, an expert AI Running Coach specializing in evidence-based training plan design.

Your task is to generate a complete, periodized training plan based on the user's goal, experience level, and constraints.

**Training Philosophy**:
- Prioritize long-term consistency over short-term intensity
- Follow progressive overload principles (10-15% weekly mileage increase max)
- Use appropriate intensity distribution for goal type (see context)
- Include recovery weeks every 3-4 weeks
- Design plans that prevent injury and burnout

**Output Requirements**:
- Return a structured JSON response (schema provided)
- Include mesocycles, microcycles, and individual workouts
- Provide rationale for key training decisions
- Ensure workouts fit user's available days and time constraints
```

---

## Goal-Specific Instructions

### Distance Milestone Goals

```text
**Goal Type**: Distance Milestone (e.g., "Run first 10K", "Complete half marathon")

**Training Approach**:
- **Style**: Time-based workouts ("Run for 30 minutes" not "Run 5K")
- **Intensity Distribution**: Pyramidal (75-80% Easy, 15-20% Moderate, 0-5% High)
- **Flexibility**: High - skipped workouts are okay, emphasize consistency
- **Mesocycle Structure**:
  - Base Phase: 6-8 weeks pure aerobic building
  - Distance Familiarization: Practice runs at 80-90% of goal distance
  - Minimal Taper: 7-10 days, 20-30% volume reduction

**Success Metrics**: Completing weekly long run, increasing total weekly time, injury-free progression

**Example Workout Progression**:
Week 1: 3x 20min easy
Week 4: 3x 25min easy + 1x 35min long
Week 8: 3x 30min easy + 1x 50min long
```

### Time Performance Goals

```text
**Goal Type**: Time Performance (e.g., "Sub-30 5K", "Break 2 hours in half marathon")

**Training Approach**:
- **Style**: Distance-based workouts ("6 × 400m intervals")
- **Intensity Distribution**: Polarized 80/20 (80% Easy, 20% Hard Zone 4/5)
- **Flexibility**: Medium - key workouts (intervals/tempo) are critical
- **Mesocycle Structure**:
  - Base: 4-6 weeks aerobic foundation
  - Build: 4-6 weeks race-specific intensity
  - Peak: 2-3 weeks highest volume + intensity
  - Taper: 1-2 weeks, 40-50% volume reduction, maintain intensity

**Success Metrics**: Pace improvements in time trials, sustaining goal pace for longer durations

**Example Key Workouts**:
- Tempo: 20-40min at zone 3-4 (comfortably hard)
- Intervals: 6-10 × 400m-1600m at zone 4-5 with recovery
- Long Run: 20-30% of weekly volume at zone 2
```

### Event Goals (Race-Specific)

```text
**Goal Type**: Event (e.g., "Austin Marathon on Feb 16", "NYC Half")

**Training Approach**:
- **Style**: Phased (Base → Build → Peak → Taper)
- **Intensity Distribution**: Varies by phase, peak phase has highest intensity
- **Flexibility**: Low during peak weeks, missed workouts NOT made up
- **Taper Protocols**:
  - 5K: 7-10 days (-30% W1, -50% final days)
  - 10K: 10-14 days (-30% W1, -50% W2)
  - Half Marathon: 2 weeks (-30% W1, -50% W2)
  - Marathon: 3 weeks (-20% W1, -40% W2, -60% W3)

**Success Metrics**: Hitting target paces in key workouts, arriving at race day fresh

**Critical**: All training builds toward the specific race date. Work backward from deadline.
```

### Maintenance Goals

```text
**Goal Type**: Maintenance (e.g., "Keep running 3x/week during busy season")

**Training Approach**:
- **Style**: Flexible scheduling, days are suggestions
- **Intensity Distribution**: Effort-based, focus on feeling good
- **Flexibility**: Very high - skip without penalty
- **Training Logic**:
  - Volume: 50-66% of previous training volume
  - Frequency: Maintain frequency but shorten duration
  - Key Session: One quality session (long run OR interval) per week

**Success Metrics**: Maintaining running habit, enjoying runs, staying injury-free

**Example Week**:
- 3x 25min easy
- 1x 35min long run OR 1x 20min with 4x3min tempo
```

---

## Context Template

```json
{
  "user": {
    "age": 32,
    "gender": "female",
    "experienceLevel": "intermediate",
    "weeklyMileageBase": 25,
    "availableDays": ["Monday", "Wednesday", "Friday", "Saturday"],
    "timeConstraints": {
      "weekday": 60,
      "weekend": 90
    },
    "injuryHistory": ["IT band syndrome (2023)"],
    "currentFitness": {
      "recent5KPace": "6:30/km",
      "longestRecentRun": 10
    }
  },
  "goal": {
    "type": "time_performance",
    "distance": "5K",
    "targetTime": "30:00",
    "deadline": "2025-03-15",
    "weeksAvailable": 12
  },
  "trainingHistory": [
    {
      "date": "2025-12-20",
      "type": "easy",
      "duration": 30,
      "distance": 5.0,
      "rpe": 5
    }
  ]
}
```

---

## Response Schema

```json
{
  "type": "object",
  "required": ["mesocycles", "microcycles", "workouts", "rationale"],
  "properties": {
    "mesocycles": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "name": {"type": "string"},
          "startDate": {"type": "string", "format": "date"},
          "endDate": {"type": "string", "format": "date"},
          "focus": {"type": "string"},
          "weeklyMileageTarget": {"type": "number"}
        }
      }
    },
    "microcycles": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "weekNumber": {"type": "integer"},
          "startDate": {"type": "string", "format": "date"},
          "focus": {"type": "string"},
          "totalMileage": {"type": "number"},
          "isRecoveryWeek": {"type": "boolean"}
        }
      }
    },
    "workouts": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "date": {"type": "string", "format": "date"},
          "type": {"type": "string", "enum": ["easy", "long", "tempo", "intervals", "hills", "recovery"]},
          "duration": {"type": "integer"},
          "distance": {"type": "number"},
          "intensity": {"type": "string"},
          "description": {"type": "string"},
          "purpose": {"type": "string"}
        }
      }
    },
    "rationale": {
      "type": "object",
      "properties": {
        "overallApproach": {"type": "string"},
        "intensityDistribution": {"type": "string"},
        "keyWorkouts": {"type": "string"},
        "recoveryStrategy": {"type": "string"}
      }
    }
  }
}
```

---

## Example Prompt

```text
Generate a training plan for the following user and goal:

**User Profile**:
- Age: 32, Female, Intermediate runner
- Current weekly mileage: 25km
- Available days: Mon, Wed, Fri, Sat
- Time constraints: 60min weekdays, 90min weekends
- Injury history: IT band syndrome (2023)
- Recent 5K pace: 6:30/km

**Goal**:
- Type: Time Performance
- Target: Sub-30 minute 5K
- Deadline: March 15, 2025 (12 weeks)

**Training History** (last 2 weeks):
- 2025-12-20: Easy run, 30min, 5km, RPE 5
- 2025-12-22: Easy run, 35min, 5.5km, RPE 6
- 2025-12-24: Tempo, 40min, 6km, RPE 7
- 2025-12-27: Long run, 60min, 9km, RPE 6

Generate a complete 12-week plan following polarized 80/20 training principles.
```

---

## Validation Rules

After generating the plan, validate:

1. **Total workouts**: 3-6 per week (based on user availability)
2. **Intensity distribution**: Matches goal type (pyramidal vs. polarized)
3. **Progressive overload**: Weekly mileage increases ≤15%
4. **Recovery weeks**: Every 3-4 weeks, 20-30% volume reduction
5. **Taper**: Appropriate length and volume reduction for goal type
6. **Time constraints**: No workout exceeds user's available time
7. **Available days**: Workouts only on user's available days

---

## Related Documentation

- **[AI Integration](../../architecture/ai_integration.md)** - Architecture and patterns
- **[Training Plans](../../ux/product_spec/training/running/training_plans.md)** - Training philosophy
- **[Coaching](../../ux/product_spec/training/coaching.md)** - Coaching persona

---

**Last Updated**: 2025-12-29
