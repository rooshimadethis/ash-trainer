# Goal Processing & Confidence Tracking

> **Implements**: [Goals & Progress](../../ux/product_spec/training/goals.md)  
> **Data Models**: [Goals](../data_models/_index.md)  
> **Dependencies**: [Context Engine](../cross_cutting/context_engine.md), [Load Management](../cross_cutting/load_mgmt.md)

**Purpose**: Calculate goal confidence, track progress, and detect performance plateaus.

## Goal Confidence Calculation

### Confidence Algorithm

The confidence score is a weighted algorithm combining multiple factors:

```dart
double calculateGoalConfidence({
  required double adherence,        // 0.0-1.0
  required double quality,          // 0.0-1.0
  required double consistency,      // 0.0-1.0
  required double recoveryStatus,   // 0.0-1.0 (based on ACWR)
  required int daysRemaining,
  required int totalDays,
}) {
  // Weights
  const adherenceWeight = 0.40;
  const qualityWeight = 0.30;
  const consistencyWeight = 0.15;
  const recoveryWeight = 0.15;
  
  // Base confidence
  double baseConfidence = (
    (adherence * adherenceWeight) +
    (quality * qualityWeight) +
    (consistency * consistencyWeight) +
    (recoveryStatus * recoveryWeight)
  );
  
  // Time pressure penalty (if too close to deadline with low progress)
  double timeRatio = daysRemaining / totalDays;
  if (timeRatio < 0.3 && adherence < 0.7) {
    baseConfidence *= 0.85; // 15% penalty for time crunch
  }
  
  return (baseConfidence * 100).clamp(0, 100);
}
```

### Calculation Factors

1. **Adherence (40%)**: Completed vs Planned workouts
   - Calculated over last 4 weeks
   - Key sessions weighted higher than optional sessions

2. **Quality (30%)**: Hitting target RPE/Distances
   - Did user complete prescribed intensity?
   - Did user hit target distances?
   - Consistency in pacing

3. **Consistency (15%)**: Frequency of training
   - Days per week with activity
   - Streaks matter (even if short workouts)

4. **Recovery Status (15%)**: ACWR status
   - Safe zone (0.8-1.3): Full score
   - Moderate risk (1.3-1.5): 70% score
   - High risk (>1.5): 40% score
   - Injury risk lowers confidence

### Transparency & Feedback

Users see exactly what's affecting their confidence:
- "Confidence increased 8% due to completing all key workouts this week"
- "Confidence dropped 5% due to missed long run and elevated injury risk"
- "Consistency improving - 12 days in a row with activity"

## Plateau Detection

**Purpose**: Identify performance stagnation and implement evidence-based interventions.

### Detection Logic

```dart
enum PlateauType {
  none,
  fatigue,      // Accumulated fatigue, need deload
  adaptation,   // Body adapted, need variation
  volume,       // Need more stimulus
}

PlateauType detectPlateau({
  required List<WorkoutLog> recentLogs,
  required double currentACWR,
}) {
  // Check for stagnant performance over 3+ weeks
  bool performanceStagnant = checkPerformanceStagnation(recentLogs);
  
  if (!performanceStagnant) return PlateauType.none;
  
  // Determine cause
  if (currentACWR > 1.2) {
    return PlateauType.fatigue; // High load, need recovery
  } else if (hasConsistentWorkoutTypes(recentLogs)) {
    return PlateauType.adaptation; // Same stimulus, need variety
  } else {
    return PlateauType.volume; // Need more work
  }
}
```

### Intervention Protocols

| Plateau Type | Duration | Adjustments | Use Case |
|--------------|----------|-------------|----------|
| Fatigue | 1 week | -40% volume, maintain intensity | Accumulated fatigue |
| Adaptation | 2-3 weeks | Swap exercises, change rep ranges | Body adapted to stimulus |
| Volume | 3-4 weeks | +20-30% volume, lower intensity (+1 RIR/RPE) | Need more stimulus |

## Goal Switching Logic

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

## Related Tools

| Tool | Purpose | Called In |
|------|---------|-----------|
| `calculate_goal_confidence` | Multi-factor analysis | Background calculation (aggressive) |
| `detect_plateau` | Analyze performance | Background analysis |
| `switch_goal_type` | Change goal mid-plan | User-initiated or AI-suggested |

## 🗄️ Data Models

| Entity | Schema Definition |
|--------|-------------------|
| Goals | [Goals](../data_models/_index.md) |
| Workout Logs | [Workouts](../data_models/_index.md) |
