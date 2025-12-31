# Workouts

This document defines the schema for planned training sessions and the logs of completed workouts.

## 1. Planned Workout

A single scheduled training session.

```dart
@DataClassName('PlannedWorkout')
class PlannedWorkouts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get microcycleId => integer().references(Microcycles, #id)();
  
  // Scheduling
  DateTimeColumn get scheduledDate => dateTime()();
  IntColumn get dayOfWeek => integer()(); // 1=Monday, 7=Sunday
  BoolColumn get isKeySession => boolean().withDefault(const Constant(false))(); // High priority
  BoolColumn get isAdHoc => boolean().withDefault(const Constant(false))(); // Ad-hoc workout (e.g., during time off)
  
  // Workout Type
  TextColumn get pillar => text()(); // 'running', 'strength', 'mobility'
  TextColumn get workoutType => text()(); // 'easy_run', 'tempo', 'intervals', 'long_run', 'full_body', 'upper_lower'
  TextColumn get sessionName => text()(); // "Easy Aerobic Run", "Interval Session"
  
  // Prescription
  IntColumn get targetDurationMinutes => integer().nullable()();
  RealColumn get targetDistanceKm => real().nullable()();
  IntColumn get targetRPE => integer().nullable()(); // 1-10
  TextColumn get intensityZone => text().nullable()(); // 'easy', 'moderate', 'threshold', 'vo2max'
  
  // Detailed Instructions (JSON)
  TextColumn get workoutStructure => text().nullable()(); // JSON: intervals, sets, reps
  TextColumn get coachingNotes => text().nullable()(); // "Focus on form, keep it conversational"
  
  // Status
  TextColumn get status => text().withDefault(const Constant('planned'))(); // 'planned', 'completed', 'skipped', 'rescheduled'
  IntColumn get completedAsLogId => integer().references(WorkoutLogs, #id).nullable()();
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
```

> [!NOTE]
> **isAdHoc Flag:** Marks workouts created on-demand during time-off periods. These are still added to the current microcycle but don't affect adherence metrics or goal confidence.

**Workout Structure JSON Example (Intervals):**
```json
{
  "warmup": { "duration_min": 10, "rpe": 3 },
  "intervals": [
    { "duration_min": 4, "rpe": 9, "recovery_min": 2 }
  ],
  "repeat": 5,
  "cooldown": { "duration_min": 10, "rpe": 3 }
}
```

---

## 2. Workout Log

Records a completed training session with actual performance data.

```dart
@DataClassName('WorkoutLog')
class WorkoutLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get plannedWorkoutId => integer().references(PlannedWorkouts, #id)();
  
  // Timing
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
  IntColumn get durationMinutes => integer()();
  
  // Workout Details
  TextColumn get pillar => text()(); // 'running', 'strength', 'mobility', 'yoga', etc.
  TextColumn get workoutType => text()();
  
  // Subjective Metrics (Universal)
  IntColumn get rpe => integer()(); // 1-10 (required)
  RealColumn get sessionLoad => real()(); // RPE × Duration
  
  // Pillar-Specific Data (JSON)
  TextColumn get pillarData => text()(); // JSON: structure varies by pillar type
  
  // Health Connect Integration
  TextColumn get healthConnectRecordId => text().nullable()();
  TextColumn get sourceApp => text().nullable()(); // 'suunto', 'strava', 'manual'
  
  // Notes
  TextColumn get userNotes => text().nullable()();
  TextColumn get painReported => text().nullable()(); // JSON: [{"location": "knee", "severity": 3}]
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

**Session Load Calculation:**
```
Session Load = RPE × Duration (minutes)
Example: 7 RPE × 60 min = 420 AU
```

### Pillar Data JSON Structure

The `pillarData` field stores pillar-specific metrics in JSON format. Structure varies by workout type:

**Running:**
```json
{
  "distanceKm": 5.2,
  "avgPacePerKm": 330,
  "avgHeartRate": 145,
  "maxHeartRate": 165,
  "elevationGainMeters": 120,
  "splits": [
    {"km": 1, "pacePerKm": 325},
    {"km": 2, "pacePerKm": 335}
  ]
}
```

**Strength:**
```json
{
  "exercises": [
    {
      "name": "Back Squat",
      "movementPattern": "squat",
      "sets": [
        {"reps": 10, "weightKg": 60, "rir": 2},
        {"reps": 8, "weightKg": 65, "rir": 1}
      ]
    },
    {
      "name": "Bench Press",
      "movementPattern": "push",
      "sets": [
        {"reps": 8, "weightKg": 50, "rir": 2}
      ]
    }
  ]
}
```

**Mobility/Yoga:**
```json
{
  "poses": ["Downward Dog", "Warrior II", "Child's Pose", "Pigeon"],
  "focusAreas": ["hips", "shoulders", "hamstrings"],
  "breathwork": true,
  "meditationMinutes": 5
}
```

**Cycling (Future):**
```json
{
  "distanceKm": 25.0,
  "avgPowerWatts": 180,
  "avgCadence": 85,
  "avgHeartRate": 140,
  "elevationGainMeters": 300
}
```

> [!NOTE]
> **Flexibility**: The JSON structure allows adding new pillars (swimming, hiking, etc.) without schema migrations. Dart models can deserialize `pillarData` into type-safe classes based on the `pillar` field.
