# Load Management & Injury Prevention

**Purpose**: Track training load and prevent overtraining injuries using ACWR (Acute:Chronic Workload Ratio).

## ACWR Calculation

```dart
double calculateACWR(List<WorkoutLog> logs) {
  final now = DateTime.now();
  
  // Acute Load: Last 7 days
  final acuteLoad = logs
      .where((log) => log.startTime.isAfter(now.subtract(Duration(days: 7))))
      .fold(0.0, (sum, log) => sum + log.sessionLoad);
  
  // Chronic Load: Last 28 days
  final chronicLoad = logs
      .where((log) => log.startTime.isAfter(now.subtract(Duration(days: 28))))
      .fold(0.0, (sum, log) => sum + log.sessionLoad) / 4.0; // Average per week
  
  if (chronicLoad == 0) return 1.0;
  return acuteLoad / chronicLoad;
}
```

**Formula**: Acute Load (last 7 days) ÷ Chronic Load (avg of last 3-4 weeks)

## ACWR Zones by Goal Type

ACWR thresholds vary based on goal type to allow appropriate training stimulus:

| Goal Type | Safe Min | Safe Max | Rationale |
|-----------|----------|----------|-----------|
| `distance_milestone` | 0.8 | 1.2 | Conservative - prevent injury in newer runners |
| `time_performance` | 0.8 | 1.3 | Standard - allow intensity blocks |
| `event` | 0.9 | 1.4 | Allow higher peaks during build/peak phases |
| `maintenance` | 0.7 | 1.0 | Intentionally low - no progressive overload |

## Related Tools

| Tool | Purpose | Key Params | Returns/Actions | Called In |
|------|---------|------------|-----------------|----------|
| `calculate_acwr` | Calculate injury risk | None | ACWR value, risk status, recommendation | Background calculation (aggressive), displayed in context |
| `log_session_rpe` | Record workout intensity | `workout_id`, `rpe` (1-10), `duration_minutes` | Updates weekly load totals and ACWR | Daily Training Loop - Post-workout logging |
| `log_biomarker` | Track general health feedback | `type` (energy/sleep/stress/motivation), `value`, `reason`, `note` | Flags patterns (low energy streaks, poor sleep, declining motivation) | Daily Training Loop - Daily check-in |
| `report_pain` | Track pain/injury | `injury_type`, `location`, `severity`, `note` | Creates/updates InjuryRecord, triggers plan adjustments | Injury Management - Pain reporting |

## 🗄️ Data Models

| Entity | Schema Definition |
|--------|-------------------|
| Workouts | [workouts.md](../data_models/workouts.md) |
| Injuries | [health.md](../data_models/health.md) |

