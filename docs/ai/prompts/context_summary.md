# Context Summarization Prompts

**Purpose**: Prompts for generating medium-term and long-term context summaries to manage AI memory efficiently.

**Last Updated**: 2025-12-29

---

## System Prompt

```text
You are Ash, an AI Running Coach with expertise in analyzing training data and patterns.

Your task is to summarize training history and user interactions into concise, actionable context summaries.

**Summarization Principles**:
- Be concise but comprehensive (target 200-300 tokens)
- Focus on actionable insights, not raw data
- Identify patterns and trends
- Flag concerns (injuries, overtraining, adherence issues)
- Maintain coaching tone (supportive, not clinical)

**Output Requirements**:
- Return structured JSON with summary sections
- Include key metrics (adherence, average RPE, concerns)
- Highlight important events (PRs, injuries, time off)
```

---

## Summary Types

### 1. Medium-Term Summary (Weekly)

**Trigger**: Weekly cron job (Sunday evening) or major event

**Purpose**: Summarize last 7-14 days for use in daily coaching and adjustments

**Prompt Template**:
```text
Summarize the user's training over the past {num_days} days.

**Workouts Completed**:
{list_of_workouts}

**Workouts Skipped**:
{list_of_skipped_workouts}

**User Messages/Feedback**:
{recent_messages}

**Biomarkers** (if available):
{sleep_quality, hrv, rhr}

Provide:
1. Overall summary (2-3 sentences)
2. Adherence rate and quality assessment
3. Patterns or concerns (injuries, fatigue, motivation)
4. Key achievements or milestones

Target length: 200-300 tokens
```

**Example Input**:
```json
{
  "period": "2025-12-22 to 2025-12-29",
  "workoutsCompleted": [
    {"date": "2025-12-23", "type": "easy", "duration": 30, "rpe": 5},
    {"date": "2025-12-25", "type": "tempo", "duration": 40, "rpe": 7},
    {"date": "2025-12-27", "type": "easy", "duration": 35, "rpe": 6},
    {"date": "2025-12-29", "type": "long", "duration": 60, "rpe": 7}
  ],
  "workoutsSkipped": [
    {"date": "2025-12-24", "type": "intervals", "reason": "knee pain"}
  ],
  "userMessages": [
    {"date": "2025-12-24", "message": "Knees ache today"},
    {"date": "2025-12-29", "message": "Felt strong on long run!"}
  ]
}
```

**Example Output**:
```json
{
  "summary": "Completed 4/5 workouts this week with good quality. Skipped intervals due to knee pain but successfully completed long run. Overall strong week with no major concerns.",
  "adherenceRate": 0.8,
  "averageRPE": 6.25,
  "patterns": [
    "Knee pain during intervals (12/24) - monitored, resolved by long run"
  ],
  "concerns": [],
  "achievements": [
    "Longest run of training cycle (60min)"
  ],
  "recommendation": "Continue monitoring knee. If pain returns, consider swapping intervals for tempo runs."
}
```

---

### 2. Long-Term Summary (Monthly or on Goal Creation)

**Trigger**: New goal created, monthly cron job, or manual refresh

**Purpose**: Stable user profile and training history for context caching

**Prompt Template**:
```text
Create a comprehensive summary of the user's profile and training history.

**User Profile**:
{age, gender, experience_level, injury_history}

**Active Goal**:
{goal_type, target, deadline}

**Training History** (last 30-90 days):
{summary_of_workouts}

**Key Patterns**:
{adherence_trends, injury_patterns, performance_trends}

Provide:
1. User profile summary (demographics, experience, injury history)
2. Goal context (what they're training for, timeline)
3. Training philosophy (intensity distribution, flexibility level)
4. Historical patterns (strengths, weaknesses, tendencies)

Target length: 300-500 tokens (this is cached, so can be longer)
```

**Example Input**:
```json
{
  "user": {
    "age": 32,
    "gender": "female",
    "experienceLevel": "intermediate",
    "yearsRunning": 5,
    "injuryHistory": ["IT band syndrome (2023)", "Plantar fasciitis (2022)"]
  },
  "goal": {
    "type": "time_performance",
    "distance": "5K",
    "targetTime": "30:00",
    "deadline": "2025-03-15",
    "currentPace": "6:30/km"
  },
  "trainingHistory": {
    "last90Days": {
      "totalWorkouts": 45,
      "averageWeeklyMileage": 25,
      "adherenceRate": 0.85,
      "averageRPE": 6.2
    }
  }
}
```

**Example Output**:
```json
{
  "userProfile": "32-year-old female intermediate runner with 5 years experience. History of IT band syndrome and plantar fasciitis, both resolved. Currently averaging 25km/week with strong adherence (85%).",
  "goalContext": "Training for sub-30 minute 5K by March 15, 2025. Current pace is 6:30/km, so needs ~30-second improvement. 12 weeks available for training.",
  "trainingPhilosophy": "Time performance goal requires polarized 80/20 training. Medium flexibility on key workouts (intervals/tempo are critical). Focus on injury prevention given history.",
  "patterns": {
    "strengths": ["Consistent adherence", "Good recovery (low average RPE)"],
    "weaknesses": ["Injury-prone (IT band, plantar fasciitis)", "Limited speed work history"],
    "tendencies": ["Prefers morning runs", "Responds well to structured plans"]
  },
  "injuryConsiderations": "Monitor IT band and plantar fascia. Avoid sudden mileage increases. Include strengthening exercises."
}
```

---

### 3. Event Summary (After Major Events)

**Trigger**: Race completion, injury, time off >7 days, goal change

**Purpose**: Capture important events that affect future training

**Prompt Template**:
```text
Summarize this major training event.

**Event Type**: {event_type}
**Event Date**: {date}
**Details**: {event_details}
**User Feedback**: {user_messages}

Provide:
1. Event summary (what happened)
2. Impact on training (positive or negative)
3. Lessons learned or adjustments needed

Target length: 100-200 tokens
```

**Example: Race Completion**
```json
{
  "eventType": "race",
  "date": "2025-03-15",
  "details": {
    "distance": "5K",
    "time": "29:45",
    "goalTime": "30:00",
    "conditions": "Cool, ideal"
  },
  "userFeedback": "Felt amazing! Negative split strategy worked perfectly."
}
```

**Output**:
```json
{
  "summary": "Completed 5K in 29:45, beating goal by 15 seconds. Negative split strategy executed well. Cool conditions were ideal.",
  "impact": "Goal achieved! User demonstrated strong pacing discipline and fitness gains from polarized training.",
  "lessonsLearned": "Negative splits work well for this user. Confidence boost for future goals.",
  "nextSteps": "Celebrate achievement. Discuss next goal (maintenance or new performance target)."
}
```

**Example: Injury**
```json
{
  "eventType": "injury",
  "date": "2025-02-10",
  "details": {
    "type": "IT band syndrome",
    "severity": "moderate",
    "timeOff": 14
  },
  "userFeedback": "Pain started during long run. Took 2 weeks off, doing PT exercises."
}
```

**Output**:
```json
{
  "summary": "IT band syndrome recurrence on Feb 10 during long run. Took 14 days off, completed PT exercises.",
  "impact": "Lost 2 weeks of training. Need to rebuild volume conservatively (50% reduction, then 10% weekly increase).",
  "lessonsLearned": "IT band is recurring issue. Need to prioritize strengthening and avoid rapid mileage increases.",
  "nextSteps": "Return to running with 50% volume reduction. Add IT band strengthening to routine. Monitor closely."
}
```

---

## Response Schema

### Medium-Term Summary
```json
{
  "type": "object",
  "required": ["summary", "adherenceRate", "averageRPE", "patterns", "concerns"],
  "properties": {
    "summary": {"type": "string"},
    "adherenceRate": {"type": "number"},
    "averageRPE": {"type": "number"},
    "patterns": {"type": "array", "items": {"type": "string"}},
    "concerns": {"type": "array", "items": {"type": "string"}},
    "achievements": {"type": "array", "items": {"type": "string"}},
    "recommendation": {"type": "string"}
  }
}
```

### Long-Term Summary
```json
{
  "type": "object",
  "required": ["userProfile", "goalContext", "trainingPhilosophy", "patterns"],
  "properties": {
    "userProfile": {"type": "string"},
    "goalContext": {"type": "string"},
    "trainingPhilosophy": {"type": "string"},
    "patterns": {
      "type": "object",
      "properties": {
        "strengths": {"type": "array", "items": {"type": "string"}},
        "weaknesses": {"type": "array", "items": {"type": "string"}},
        "tendencies": {"type": "array", "items": {"type": "string"}}
      }
    },
    "injuryConsiderations": {"type": "string"}
  }
}
```

---

## Compression Strategies

### Token Budget Targets

| Summary Type | Target Tokens | Max Tokens |
|--------------|---------------|------------|
| Medium-Term (Weekly) | 200-300 | 400 |
| Long-Term (Cached) | 300-500 | 600 |
| Event Summary | 100-200 | 250 |

### Compression Techniques

1. **Aggregate metrics**: "Completed 4/5 workouts" not "Completed workout on 12/23, 12/25, 12/27, 12/29"
2. **Patterns over details**: "Knee pain during high-impact workouts" not "Knee pain on 12/24 during intervals, 12/28 during hills"
3. **Actionable insights**: "Monitor knee, consider tempo instead of intervals" not "User reported knee pain"
4. **Omit redundant info**: Don't repeat user profile in every summary

---

## Regeneration Triggers

### Medium-Term Summary
- **Weekly**: Every Sunday at 8pm
- **Major Event**: Injury, race, time off >3 days
- **User Request**: User asks to replan

### Long-Term Summary
- **New Goal**: User creates new goal
- **Profile Update**: User updates age, injury history, etc.
- **Monthly**: First Sunday of each month
- **Manual**: User or admin triggers refresh

---

## Related Documentation

- **[AI Integration](../../architecture/ai_integration.md)** - 3-tier context architecture
- **[Data Models](../../architecture/data_models/entities.md)** - ContextSummary entity
- **[Coaching](../../ux/product_spec/training/coaching.md)** - Coaching feature spec

---

**Last Updated**: 2025-12-29
