# Goals & Progress Tracking

Ash helps you set meaningful goals and tracks your progress toward achieving them through intelligent metrics and transparent feedback.

## Goal Types

Ash supports four distinct goal types, each with a tailored training experience:

### 1. Distance Milestone Goals
*Examples: "Run my first 10K", "Complete a half marathon", "Run 5 miles without stopping"*

**Philosophy:** Completion over speed. Build endurance safely and prevent injury.

**Best For:**
- Beginners or returning runners
- Building to a new distance
- Prioritizing consistency over performance

**Pillar Focus:** Running (High), Strength (Med), Mobility (Med)

*For detailed training approach, see [Running Training Plans](running/training_plans.md#1-distance-milestone-goals)*

---

### 2. Time Performance Goals
*Examples: "Sub-30 minute 5K", "Break 2 hours in the half marathon"*

**Philosophy:** Improve speed and efficiency. Track quantifiable progress.

**Best For:**
- Experienced runners seeking PRs
- Athletes with specific time targets
- Those who thrive on structured training

**Pillar Focus:** Running (High), Strength (Med-High), Mobility (Med)

*For detailed training approach, see [Running Training Plans](running/training_plans.md#2-time-performance-goals)*

---

### 3. Event Goals (Race-Specific)
*Examples: "Austin Marathon on Feb 16", "NYC Half Marathon"*

**Philosophy:** Peak performance on a specific date. All training builds toward race day.

**Best For:**
- Registered for a specific race
- Want to peak for a particular event
- Committed to structured periodization

**Pillar Focus:** Running (High), Strength (Low in taper), Mobility (High in taper)

*For detailed training approach, see [Running Training Plans](running/training_plans.md#3-event-goals-race-specific)*

---

### 4. Maintenance Goals
*Examples: "Keep running 3x/week during busy season"*

**Philosophy:** Sustain fitness with minimal effective dose. Reduce pressure, increase enjoyment.

**Best For:**
- Off-season maintenance
- Busy life periods
- Prioritizing other fitness pillars

**Pillar Focus:** Running (Med), Strength (High), Mobility (High)

*For detailed training approach, see [Running Training Plans](running/training_plans.md#4-maintenance-goals)*

---

## Goal Confidence Tracker

A predictive metric that tells users: *"Based on what you're doing, here is the likelihood of hitting your goal."*

The system shows both the confidence percentage **and the specific factors** that caused it to change (e.g., "Confidence dropped 5% due to missed workouts and low adherence").

### Visual Indicator
*   **Percentage**: 0-100% confidence level
*   **Color-Coded**:
    *   🟢 **90%+**: On Track (Green)
    *   🟡 **75-89%**: At Risk (Yellow)
    *   🟠 **60-74%**: Needs Attention (Orange)
    *   🔴 **<60%**: Critical (Red)
*   **Trend Graph**: Shows historical confidence over the last 4 weeks

### Calculation Factors
The confidence score is a weighted algorithm of:
1.  **Adherence (40%)**: Completed vs Planned workouts
2.  **Quality (30%)**: Hitting target RPE/Distances
3.  **Consistency (15%)**: Frequency of training (even if short)
4.  **Recovery Status (15%)**: ACWR status (Injury risk lowers confidence)

### Transparency
Users see exactly what's affecting their confidence:
- "Confidence increased 8% due to completing all key workouts this week"
- "Confidence dropped 5% due to missed long run and elevated injury risk"
- "Consistency improving - 12 days in a row with activity"

This transparency helps users understand which behaviors have the biggest impact on their success.

---

## Goal Switching & Adjustments

### When to Switch Goals
Users can change their goal type when:
- **Life circumstances change**: Busy season → switch to Maintenance
- **Race registration**: Switch to Event goal with specific date
- **Achievement unlocked**: Completed Distance Milestone → switch to Time Performance
- **Burnout prevention**: Performance training → switch to Maintenance for mental break

### Ash's Recommendations
Ash may suggest goal adjustments based on:
- **Consistent underperformance**: "You've missed 60% of workouts. Consider switching to Maintenance mode?"
- **Overtraining signals**: "Your recovery metrics suggest scaling back. Want to adjust your goal?"
- **Unexpected progress**: "You're crushing this plan! Ready to set a more ambitious goal?"

---

## 🛠️ Technical Logic

| Feature | Logic Engine |
|---------|--------------|
| Confidence Algorithm | [context_engine.md](../../architecture/data_processing/context_engine.md) |
| Goal Adaptation | [pillar_logic.md](../../architecture/data_processing/pillar_logic.md) |
