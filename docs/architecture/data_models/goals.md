# Goals & Training Plans

This document defines the hierarchy of long-term goals, training plans, and the cyclic structures (Mesocycles, Microcycles) that organize them. It also includes Time-Off Days which directly affect the schedule.

## 1. Goal

Represents a user's training objective (e.g., "Run a marathon in 16 weeks").

```dart
@DataClassName('Goal')
class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(UserProfiles, #id)();
  
  // Goal Definition
  TextColumn get goalType => text()(); // 'distance_milestone', 'time_performance', 'maintenance', 'event'
  TextColumn get targetDescription => text()(); // "Complete first 10K", "Sub-30 5K"
  
  // Target Metrics
  RealColumn get targetDistance => real().nullable()(); // in km
  IntColumn get targetTimeSeconds => integer().nullable()(); // for time-based goals
  
  // Timeline
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get targetDate => dateTime().nullable()(); // null = "as soon as possible"
  DateTimeColumn get completedAt => dateTime().nullable()();
  
  // Status
  TextColumn get status => text().withDefault(const Constant('active'))(); // 'active', 'paused', 'completed', 'abandoned'
  RealColumn get confidenceScore => real().withDefault(const Constant(100.0))(); // 0-100%
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
```

### Goal Configuration Reference
Each goal type determines key training parameters. The Training Engine applies these configs automatically:

| Goal Type | Intensity Model | Workout Prescription | ACWR Safe Range | Taper Duration |
|-----------|-----------------|---------------------|-----------------|----------------|
| `distance_milestone` | Pyramidal (75/20/5) | Time-based | 0.8 - 1.2 | 7-10 days |
| `time_performance` | Polarized (80/0/20) | Distance-based | 0.8 - 1.3 | 1-2 weeks |
| `event` | Phase-based (varies) | Mixed | 0.9 - 1.4 | 1-3 weeks (by race distance) |
| `maintenance` | Flat (85/5/10) | Flexible | 0.7 - 1.0 | None |

---

## 2. Race Event

Tracks races and athletic events on the calendar.

> [!NOTE]
> **Goal Relationship:** A `Goal` can have multiple `RaceEvents` (e.g., tune-up races leading to a goal race). The `goalId` field links a race to its associated goal. If `goalId` is null, it's a standalone event (fun run, non-running event).

```dart
@DataClassName('RaceEvent')
class RaceEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get goalId => integer().references(Goals, #id).nullable()(); // null for non-goal races
  IntColumn get userId => integer().references(UserProfiles, #id)();
  
  // Event Details
  TextColumn get eventName => text()();
  TextColumn get eventType => text()(); // 'goal_race', 'tune_up', 'fun_run', 'non_running'
  DateTimeColumn get eventDate => dateTime()();
  
  // Race Specifics
  RealColumn get distance => real().nullable()(); // in km
  TextColumn get raceDistance => text().nullable()(); // '5K', '10K', 'Half', 'Marathon'
  TextColumn get location => text().nullable()();
  TextColumn get notes => text().nullable()(); // "Hilly course, 7am start"
  
  // Goals
  IntColumn get goalTimeSeconds => integer().nullable()();
  RealColumn get goalPacePerKm => real().nullable()();
  
  // Taper Management
  DateTimeColumn get taperStartDate => dateTime().nullable()(); // Auto-calculated based on race distance
  IntColumn get taperDurationDays => integer().nullable()(); // 7-21 days depending on distance
  
  // Results (filled after race)
  IntColumn get actualTimeSeconds => integer().nullable()();
  RealColumn get actualPacePerKm => real().nullable()();
  IntColumn get effortRPE => integer().nullable()(); // 1-10
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

---

## 3. Training Plan

A high-level container for a user's training program (typically 4-16 weeks).

> [!IMPORTANT]
> **Goal Relationship:** While the schema allows multiple plans per goal (for versioning and history), the application enforces **only one active plan per goal** at any time. The `status` field distinguishes between active, paused, and completed plans.

```dart
@DataClassName('TrainingPlan')
class TrainingPlans extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(UserProfiles, #id)();
  IntColumn get goalId => integer().references(Goals, #id).nullable()();
  
  // Plan Structure
  TextColumn get planName => text()(); // "Marathon Base Building", "10K Speed Work"
  TextColumn get periodizationModel => text()(); // 'pyramidal', 'polarized' (auto-selected based on volume)
  TextColumn get currentPhase => text()(); // 'base', 'build', 'peak', 'taper', 'maintenance'
  
  // Timeline
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  IntColumn get totalWeeks => integer()();
  IntColumn get currentWeek => integer().withDefault(const Constant(1))();
  
  // Status
  TextColumn get status => text().withDefault(const Constant('active'))(); // 'active', 'paused', 'completed'
  
  // AI Generation Context (for regeneration)
  TextColumn get generationPrompt => text().nullable()(); // Original AI prompt used
  TextColumn get aiModelUsed => text().nullable()(); // 'gemini-flash-2.0'
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
```

---

## 4. Mesocycle (Month)

A 4-week training block within a plan.

```dart
@DataClassName('Mesocycle')
class Mesocycles extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get planId => integer().references(TrainingPlans, #id)();
  
  // Structure
  IntColumn get weekNumber => integer()(); // 1-4 within the mesocycle
  TextColumn get focusType => text()(); // 'base_volume', 'progression', 'peak', 'recovery'
  
  // Volume Targets
  RealColumn get targetWeeklyDistance => real()(); // in km
  IntColumn get targetSessionCount => integer()();
  RealColumn get volumeAdjustmentFactor => real().withDefault(const Constant(1.0))(); // 1.0 = normal, 0.7 = recovery week
  
  // Dates
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

---

## 5. Microcycle (Week)

A single week of training within a mesocycle.

```dart
@DataClassName('Microcycle')
class Microcycles extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get mesocycleId => integer().references(Mesocycles, #id)();
  
  // Structure
  IntColumn get weekNumber => integer()(); // Global week number in plan
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  
  // Weekly Metrics (calculated)
  RealColumn get plannedDistance => real()();
  RealColumn get actualDistance => real().withDefault(const Constant(0.0))();
  RealColumn get adherenceRate => real().withDefault(const Constant(0.0))(); // 0-100%
  
  // Load Tracking
  RealColumn get plannedLoad => real()(); // Sum of planned session loads
  RealColumn get actualLoad => real().withDefault(const Constant(0.0))(); // Sum of logged session loads
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

---

## 6. Time-Off Day

Tracks individual days when the user has scheduled time off. Supports partial weeks and cross-week time-off periods.

```dart
@DataClassName('TimeOffDay')
class TimeOffDays extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get microcycleId => integer().references(Microcycles, #id)();
  
  // Time-Off Period
  DateTimeColumn get date => dateTime()(); // Specific date that's time off
  TextColumn get notes => text().nullable()(); // "Beach vacation", "Work conference", "Finals week"
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

> [!NOTE]
> **Granular Time-Off Tracking:** This table allows for flexible time-off scheduling:
> - **Partial Weeks**: "Thursday-Sunday long weekend" = 4 TimeOffDay records
> - **Full Weeks**: "1-week vacation" = 7 TimeOffDay records
> - **Cross-Week Periods**: "10-day trip" spans 2 microcycles naturally
> - **Ad-Hoc Workouts**: User can still create PlannedWorkout (with isAdHoc=true) on time-off days
> 
> **Application Logic:**
> - When scheduling time off, create TimeOffDay records for each date
> - Delete any existing PlannedWorkouts for those dates
> - Calendar shows "Time Off" badge instead of empty day
> - Goal confidence calculations skip time-off days (no penalty)
