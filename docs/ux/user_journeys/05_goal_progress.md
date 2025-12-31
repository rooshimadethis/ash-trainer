# Goal Progress Tracking

**User Goal**: Understand progress toward goal, see confidence level, and identify what actions improve success likelihood

**Source**: [`training/goals.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/goals.md)

**Journey Type**: Core Journey (Phase 1 - Foundation)

---

## Entry Points
- Home screen (Today View) confidence widget tap
- Goal detail screen from settings
- Weekly summary notification
- Low confidence alert notification

## User Flow

### Screen 1: Goal Progress Dashboard

**User Sees**:
- **Goal Header**:
  - Goal name (e.g., "Sub-30 minute 5K")
  - Goal type badge (Distance/Time/Event/Maintenance)
  - Target date (if applicable) with countdown (e.g., "12 weeks to go")
- **Confidence Score** (large, prominent):
  - Percentage (0-100%)
  - Color-coded circle/gauge:
    - 🟢 90%+ : "Crushing it!"
    - 🟡 75-89%: "On track"
    - 🟠 60-74%: "Needs attention"
    - 🔴 <60%: "Let's regroup"
  - Trend indicator (↑ improving, → stable, ↓ declining)
- **Confidence Breakdown** (4 factors):
  - **Adherence (40%)**: 
    - Score: X/10
    - Description: "Completed 8 of 10 workouts"
    - Icon: ✓ checkmark
  - **Quality (30%)**:
    - Score: X/10
    - Description: "Hitting target paces and RPE"
    - Icon: ⚡ lightning
  - **Consistency (15%)**:
    - Score: X/10
    - Description: "12 days in a row with activity"
    - Icon: 🔥 streak
  - **Recovery (15%)**:
    - Score: X/10
    - Description: "ACWR in safe zone"
    - Icon: 💚 heart
- **Historical Trend Graph**:
  - Line chart showing confidence over last 4 weeks
  - Annotations for key events (missed workouts, PRs, etc.)
- **Recent Changes**:
  - "Confidence increased 8% this week due to:"
    - "✓ Completed all key workouts"
    - "✓ Hit target pace on tempo run"
  - Or: "Confidence dropped 5% due to:"
    - "✗ Missed 2 workouts"
    - "⚠ Elevated injury risk (ACWR)"
- **Action Items** (if confidence < 80%):
  - Specific recommendations to improve confidence
  - "Complete your next 3 workouts to boost adherence"
  - "Focus on hitting Zone 2 pace on easy runs"

**User Can**:
- Tap confidence score → Opens detailed explanation modal
- Tap any factor (Adherence/Quality/Consistency/Recovery) → Opens factor detail screen
- Tap trend graph → Opens full historical view
- Tap "Change Goal" → Opens goal switching flow (Journey #13)
- Tap "View Plan" → Goes to Calendar (Journey #4)
- Swipe down → Closes, returns to previous screen

**Data Displayed**:
- `Goal.name`, `Goal.type`, `Goal.targetDate`, `Goal.confidence`
- `Goal.adherenceScore`, `Goal.qualityScore`, `Goal.consistencyScore`, `Goal.recoveryScore`
- `Goal.confidenceHistory` (array of {date, confidence} for last 4 weeks)
- `Goal.recentChanges` (array of change events with descriptions)
- `Workouts[]` (for adherence calculation)
- `ACWR` (Acute:Chronic Workload Ratio, for recovery score)

**Data Collected**:
- None (display only)

**Edge Cases**:
- **New goal (<1 week old)**: Show "Building your baseline..." with limited data
- **No workouts completed yet**: Show "Complete your first workout to see progress"
- **Confidence = 100%**: Show "Perfect! Keep it up 🎉" with celebration animation
- **Confidence < 50%**: Show "Let's talk" prompt to adjust goal or plan
- **Goal deadline passed**: Show "Goal completed" or "Goal missed" summary

---

### Screen 2: Factor Detail Screen

**Triggered by**: Tapping any of the 4 confidence factors

**User Sees** (example for Adherence):
- **Factor Header**:
  - Factor name: "Adherence"
  - Current score: 8/10 (40% of total confidence)
  - Description: "How consistently you complete planned workouts"
- **Detailed Breakdown**:
  - Last 4 weeks: 32 planned workouts, 28 completed (87.5%)
  - This week: 3 of 4 completed (75%)
  - Longest streak: 12 days
  - Current streak: 5 days
- **Visual Timeline**:
  - Calendar view showing completed (✓), missed (✗), and skipped (○) workouts
- **Impact on Confidence**:
  - "Your adherence is strong! Completing 90%+ workouts would boost confidence by 3%"
  - Or: "Missing workouts is lowering your confidence. Complete the next 3 to recover."
- **Tips to Improve**:
  - "Schedule workouts in your calendar"
  - "Set reminders 30 min before workouts"
  - "Start with shorter sessions if time is tight"

**User Can**:
- Scroll through timeline
- Tap specific workout → Opens workout detail (Journey #4)
- Tap "Back" → Returns to Goal Progress Dashboard

**Data Displayed**:
- `Workouts[]` (all workouts for goal, filtered by date range)
- Computed: Adherence %, streaks, completion rate
- Factor-specific tips (from AI or predefined)

**Data Collected**:
- None (display only)

**Edge Cases**:
- **All workouts completed**: Show celebration, no improvement tips needed
- **No workouts in period**: Show "No data yet"

---

### Screen 3: Confidence Explanation Modal

**Triggered by**: Tapping the confidence score

**User Sees**:
- **Modal Title**: "How confidence works"
- **Explanation**:
  - "Your confidence score predicts your likelihood of hitting your goal based on what you're doing right now."
  - "It's calculated from 4 factors:"
- **Factor Weights**:
  - Adherence (40%): Completing planned workouts
  - Quality (30%): Hitting target paces and intensities
  - Consistency (15%): Training frequency and streaks
  - Recovery (15%): Injury risk and workload management
- **What Changes Confidence**:
  - "✓ Completing workouts → Increases adherence"
  - "✓ Hitting target paces → Increases quality"
  - "✗ Missing workouts → Decreases adherence"
  - "⚠ High ACWR → Decreases recovery score"
- **Transparency Note**:
  - "You'll always see exactly what's affecting your confidence and why it changed."

**User Can**:
- Tap "Got it" → Closes modal
- Swipe down → Closes modal

**Data Displayed**:
- Static educational content
- Current factor weights (40/30/15/15)

**Data Collected**:
- None

---

### Screen 4: Full Historical Trend View

**Triggered by**: Tapping the trend graph

**User Sees**:
- **Graph Header**:
  - "Confidence History"
  - Date range selector (Last 4 weeks, Last 8 weeks, All time)
- **Detailed Line Chart**:
  - Confidence % over time
  - Annotated events:
    - 📈 "Completed long run PR"
    - 📉 "Missed 3 workouts"
    - 🎯 "Started new goal"
  - Color zones (green >80%, yellow 60-80%, red <60%)
- **Key Milestones**:
  - Highest confidence: 95% on [date]
  - Lowest confidence: 62% on [date]
  - Average confidence: 78%
- **Insights**:
  - "Your confidence tends to drop on Mondays (missed workouts)"
  - "Completing long runs boosts your confidence by 5-8%"

**User Can**:
- Pinch to zoom on graph
- Tap any point → See details for that date
- Change date range → Updates graph
- Tap "Back" → Returns to Goal Progress Dashboard

**Data Displayed**:
- `Goal.confidenceHistory` (full array, not just 4 weeks)
- `Workouts[]` (for event annotations)
- Computed: Averages, highs, lows, patterns

**Data Collected**:
- None (display only)

**Edge Cases**:
- **<2 weeks of data**: Show "Not enough data yet" with simplified view
- **Flat line (no changes)**: Show "Steady progress!" message

---

## Exit Points

### Primary Exits:
- **Calendar View** (Journey #4) - From "View Plan" button
- **Goal Switching** (Journey #13) - From "Change Goal" button
- **Workout Detail** (Journey #4) - From factor detail timeline

### Alternative Exits:
- **Settings** - From header settings icon
- **Home** - Swipe down or back button

---

## Success Criteria
- [ ] User can understand their confidence score at a glance
- [ ] Factor breakdown is clear and actionable
- [ ] Trend graph shows meaningful patterns
- [ ] Recent changes explain why confidence went up/down
- [ ] Action items are specific and achievable
- [ ] All data loads in <2 seconds
- [ ] Confidence calculation is transparent (no black box)
- [ ] Low confidence (<60%) triggers helpful intervention, not discouragement

---

## Data Model Requirements

### Goal Table
- `id` (primary key)
- `userId` (foreign key)
- `name` (text)
- `type` (enum: distance_milestone, time_performance, event, maintenance)
- `targetDate` (date, nullable)
- `confidence` (number, 0-100)
- `adherenceScore` (number, 0-10)
- `qualityScore` (number, 0-10)
- `consistencyScore` (number, 0-10)
- `recoveryScore` (number, 0-10)
- `isActive` (boolean)
- `createdAt` (timestamp)

### GoalConfidenceHistory Table (new)
- `id` (primary key)
- `goalId` (foreign key)
- `date` (date)
- `confidence` (number, 0-100)
- `adherenceScore` (number, 0-10)
- `qualityScore` (number, 0-10)
- `consistencyScore` (number, 0-10)
- `recoveryScore` (number, 0-10)
- `changeReason` (text, nullable) - e.g., "Completed all workouts this week"

### Workout Table (for adherence calculation)
- `id`, `goalId`, `scheduledDate`, `status`, `rpe`, `actualPace`, etc.
- Used to calculate adherence %, quality score

### ACWR Table (for recovery score)
- `id` (primary key)
- `userId` (foreign key)
- `date` (date)
- `acuteLoad` (number) - Last 7 days average
- `chronicLoad` (number) - Last 28 days average
- `ratio` (number) - Acute/Chronic
- `riskLevel` (enum: low, moderate, high)

---

## Confidence Calculation Logic

### Adherence Score (40%)
```
adherence = (completed_workouts / planned_workouts) * 10
```

### Quality Score (30%)
```
quality = average(
  rpe_accuracy: how close actual RPE is to target,
  pace_accuracy: how close actual pace is to target,
  duration_accuracy: how close actual duration is to planned
) * 10
```

### Consistency Score (15%)
```
consistency = (
  training_frequency: days_with_activity / 7,
  streak_bonus: current_streak > 7 ? +2 : 0
) * 10
```

### Recovery Score (15%)
```
recovery = (
  acwr_safety: 0.8 < ACWR < 1.3 ? 10 : penalize,
  injury_status: has_active_injury ? -5 : 0,
  sleep_quality: avg_sleep_quality_last_7_days
) * 10
```

### Total Confidence
```
confidence = (
  adherence * 0.40 +
  quality * 0.30 +
  consistency * 0.15 +
  recovery * 0.15
) * 10  // Scale to 0-100
```

---

## Related Journeys
- **Before**: Journey #1 (Onboarding) - Creates initial goal
- **After**: 
  - Journey #4 (Calendar View) - View plan to improve adherence
  - Journey #13 (Goal Switching) - Change goal if confidence is low
- **Alternative**: 
  - Journey #2 (Daily Check-In) - Daily actions affect confidence
  - Journey #3 (Workout Logging) - Completing workouts improves adherence

---

## Notes
- **Transparency is key**: Users must understand WHY confidence changed
- **Actionable insights**: Don't just show numbers, tell users what to do
- **Positive framing**: Even low confidence should be encouraging, not discouraging
- **Real-time updates**: Confidence should update immediately after workout completion
- **Historical context**: Trend graph helps users see long-term patterns
- **Factor weights are fixed**: 40/30/15/15 split is based on sports science research
- **Confidence ≠ Guarantee**: Make clear this is a prediction, not a promise

---

**Last Updated**: 2025-12-29
