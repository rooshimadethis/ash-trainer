# Entity Definitions - Phase 1

This document provides detailed Drift table definitions for all 9 entities in the Phase 1 database schema.

**Technology**: Drift (SQLite) for offline-first local storage

**Design Assumptions**:
- Single-user app (one user per device installation)
- Offline-first with optional cloud sync in later phases

---

### 1. User Profile Domain

#### Table: `users`

**Purpose**: Store user profile, preferences, and onboarding data.

**Fields**:
```dart
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Personal information
  IntColumn get age => integer().nullable()();
  TextColumn get gender => text().nullable()();
  RealColumn get weight => real().nullable()(); // Always stored in KG
  TextColumn get preferredWeightUnit => text().withDefault(const Constant('kg'))(); // UI display preference: 'kg' or 'lb'
  RealColumn get height => real().nullable()(); // Always stored in CM
  TextColumn get preferredHeightUnit => text().withDefault(const Constant('cm'))(); // UI display preference: 'cm' or 'in'
  TextColumn get preferredDistanceUnit => text().withDefault(const Constant('km'))(); // UI display preference: 'km' or 'mi'
  
  // Onboarding data (Journey #1)
  TextColumn get trainingHistory => text()(); // 'beginner' | 'casual' | 'regular' | 'advanced'
  TextColumn get availableDays => text()(); // JSON array: ["monday", "tuesday", ...]
  TextColumn get constraints => text().nullable()(); // Optional constraints text
  
  // Health permissions
  BoolColumn get healthPermissionsGranted => boolean().withDefault(const Constant(false))();
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
```

**Relationships**:
- One user has many goals (1:N)
- One user has many biomarkers (1:N)
- One user has many injury records (1:N)
- One user has many ACWR records (1:N)

**Notes**:
- `availableDays` stored as JSON array for flexibility
- `trainingHistory` field is deprecated - fitness level will be inferred from baseline workout (see Journey #1 feedback)
- **Weight/Height Storage**: Always stored in metric units (KG/CM) for consistency in calculations
- **Preferred Units**: `preferredWeightUnit`, `preferredHeightUnit`, and `preferredDistanceUnit` are UI display preferences only
  - Weight: 'kg' or 'lb' (Health Connect uses KG, HealthKit supports both)
  - Height: 'cm' or 'in' (Health Connect uses CM, HealthKit supports both)
  - Distance: 'km' or 'mi' (used for weekly volume input in Training Context)
- When syncing from HealthKit, values are converted to KG/CM for storage

**Constraints**:
- `trainingHistory` must be one of: `beginner`, `casual`, `regular`, `advanced`
- `availableDays` stored as JSON array, parsed in application layer

---

### 2. Training Domain

#### Table: `goals`

**Purpose**: Store user goals and confidence tracking.

**Fields**:
```dart
class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  
  // Goal type and basic info
  TextColumn get type => text()(); // 'distance_milestone' | 'time_performance' | 'event' | 'maintenance'
  TextColumn get name => text()(); // Display name, e.g., "Sub-30 minute 5K"
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  
  // Distance Milestone fields
  RealColumn get targetDistance => real().nullable()(); // in km
  DateTimeColumn get targetDate => dateTime().nullable()();
  
  // Time Performance fields
  IntColumn get targetTime => integer().nullable()(); // in seconds
  IntColumn get currentBestTime => integer().nullable()(); // in seconds
  
  // Event fields
  TextColumn get eventName => text().nullable()();
  DateTimeColumn get eventDate => dateTime().nullable()();
  
  // Maintenance fields
  IntColumn get maintenanceFrequency => integer().nullable()(); // runs per week
  IntColumn get maintenanceDuration => integer().nullable()(); // minutes per run
  DateTimeColumn get endDate => dateTime().nullable()();
  
  // Training Context (from onboarding Step 4)
  IntColumn get initialTrainingFrequency => integer().nullable()(); // days per week
  RealColumn get initialWeeklyVolume => real().nullable()(); // in km
  BoolColumn get isFirstTime => boolean().nullable()(); // For distance milestone goals
  TextColumn get runningPriority => text().nullable()(); // 'Low' | 'Medium' | 'High'
  TextColumn get strengthPriority => text().nullable()(); // 'Low' | 'Medium' | 'High'
  TextColumn get mobilityPriority => text().nullable()(); // 'Low' | 'Medium' | 'High'
  
  // Confidence tracking (Journey #5)
  RealColumn get confidence => real().withDefault(const Constant(85.0))(); // 0-100
  RealColumn get adherenceScore => real().withDefault(const Constant(8.0))(); // 0-10
  RealColumn get qualityScore => real().withDefault(const Constant(8.0))(); // 0-10
  RealColumn get consistencyScore => real().withDefault(const Constant(8.0))(); // 0-10
  RealColumn get recoveryScore => real().withDefault(const Constant(8.0))(); // 0-10
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
```

**Relationships**:
- Many goals belong to one user (N:1)
- One goal has many phases (1:N)
- One goal has many confidence history records (1:N)

**Constraints**:
- `type` must be one of: `distance_milestone`, `time_performance`, `event`, `maintenance`
- Only one goal can have `isActive = true` at a time (enforced in application layer)
- `confidence` range: 0-100
- Score fields range: 0-10
- Pillar priorities must be one of: `Low`, `Medium`, `High` (nullable)
- Only one pillar should be set to `High` at a time (enforced in UI)

---

#### Table: `phases`
 
 **Purpose**: Store high-level training phases (Base/Build/Peak/Taper) that define the goal journey.
 
 **Fields**:
 ```dart
 class Phases extends Table {
   IntColumn get id => integer().autoIncrement()();
   IntColumn get goalId => integer().references(Goals, #id)();
   
   // Phase identification
   IntColumn get phaseNumber => integer()(); // 1, 2, 3, etc.
   DateTimeColumn get startDate => dateTime().nullable()(); // Populated by App (Hydration)
   DateTimeColumn get endDate => dateTime().nullable()(); // Populated by App (Hydration)
   
   // AI-provided duration
   IntColumn get durationWeeks => integer()(); 
   
   // Periodization phase
   TextColumn get phaseType => text()(); // 'base' | 'build' | 'peak' | 'taper' | 'recovery'
   
   // Training distribution strategy
   TextColumn get intensityDistribution => text()(); // 'pyramidal' | 'polarized' | 'threshold'
   
   // Volume targets
   RealColumn get targetWeeklyVolume => real()(); // in km
   IntColumn get targetWeeklyDuration => integer()(); // in seconds
   
   // Computed stats
   RealColumn get actualVolume => real().withDefault(const Constant(0.0))(); 
   IntColumn get actualDuration => integer().withDefault(const Constant(0))(); 
   
   // Metadata
   DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
   DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
 }
 ```
 
 **Relationships**:
 - Many phases belong to one goal (N:1)
 - One phase has many training blocks (1:N)
 
 **Constraints**:
 - `phaseType` must be one of: `base`, `build`, `peak`, `taper`, `recovery`
 - `intensityDistribution` must be one of: `pyramidal`, `polarized`, `threshold`
 - `phaseNumber` must be unique per goal

**Phase Definitions** (from product spec):
- **Base**: 4-8 weeks of aerobic foundation building (75-80% easy running)
- **Build**: 4-6 weeks introducing race-specific intensity
- **Peak**: 2-3 weeks of highest volume + intensity
- **Taper**: 1-3 weeks reducing volume 20-60% while maintaining intensity
- **Recovery**: 1 week active recovery after goal completion

---

#### Table: `workouts`

**Purpose**: Store individual workout sessions (planned and completed).

**Fields**:
```dart
class Workouts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  IntColumn get goalId => integer().references(Goals, #id)();
  IntColumn get phaseId => integer().nullable().references(Phases, #id)();
  IntColumn get blockId => integer().nullable().references(TrainingBlocks, #id)();
  
  // Scheduling
  DateTimeColumn get scheduledDate => dateTime()();
  
  // Workout details
  TextColumn get type => text()(); // 'easy_run' | 'tempo' | 'intervals' | 'long_run' | 'rest' | 'strength' | 'mobility'
  TextColumn get name => text()(); // e.g., "Easy Run", "Tempo Run"
  IntColumn get plannedDuration => integer()(); // in seconds
  RealColumn get plannedDistance => real().nullable()(); // in km
  TextColumn get intensity => text().nullable()(); // e.g., "Zone 2", "RPE 5-6"
  TextColumn get description => text().nullable()(); // Purpose/instructions
  
  // Completion data
  TextColumn get status => text().withDefault(const Constant('planned'))(); // 'planned' | 'in_progress' | 'completed' | 'skipped' | 'missed'
  IntColumn get actualDuration => integer().nullable()(); // in seconds
  RealColumn get actualDistance => real().nullable()(); // in km
  RealColumn get actualPace => real().nullable()(); // min/km
  IntColumn get rpe => integer().nullable()(); // 1-10
  DateTimeColumn get completedAt => dateTime().nullable()();
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
```

**Relationships**:
- Many workouts belong to one user (N:1)
- Many workouts belong to one goal (N:1)
- Many workouts belong to one phase (N:1, optional)
- Many workouts belong to one training block (N:1, optional)

**Constraints**:
- `type` must be one of: `easy_run`, `tempo`, `intervals`, `long_run`, `rest`, `strength`, `mobility`
- `status` must be one of: `planned`, `in_progress`, `completed`, `skipped`, `missed`
- `rpe` range: 1-10 (nullable)

**Indexes**:
- `scheduledDate` (for calendar queries)
- `userId, scheduledDate` (composite for user's daily workouts)
- `goalId, status` (for adherence calculations)

---

#### Table: `training_blocks`
 
 **Purpose**: Store logical clusters of workouts (3-10 days) within a phase.
 
 **Fields**:
 ```dart
 class TrainingBlocks extends Table {
   IntColumn get id => integer().autoIncrement()();
   IntColumn get phaseId => integer().references(Phases, #id)();
   
   // Block identification
   IntColumn get blockNumber => integer()(); // 1, 2, 3, etc.
   DateTimeColumn get startDate => dateTime().nullable()(); // Populated by App
   DateTimeColumn get endDate => dateTime().nullable()(); // Populated by App
   
   // AI-provided intent
   TextColumn get intent => text()(); // 'intro' | 'progression' | 'peak' | 'recovery'
   
   // Computed stats
   RealColumn get totalVolume => real().withDefault(const Constant(0.0))(); 
   IntColumn get totalDuration => integer().withDefault(const Constant(0))(); 
   RealColumn get adherencePercentage => real().withDefault(const Constant(0.0))(); 
   
   // Metadata
   DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
   DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
 }
 ```
 
 **Relationships**:
 - Many training blocks belong to one phase (N:1)
 - One training block has many workouts (1:N)
 
 **Constraints**:
 - `blockNumber` must be unique per phase

---

### 3. Health & Recovery Domain

#### Table: `biomarkers`

**Purpose**: Store daily health metrics from Health Connect/HealthKit.

**Fields**:
```dart
class Biomarkers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  
  // Date (one record per day)
  DateTimeColumn get date => dateTime()();
  
  // Sleep metrics
  IntColumn get sleepDuration => integer().nullable()(); // in minutes
  RealColumn get sleepQuality => real().nullable()(); // 1-10 scale
  
  // Heart metrics
  RealColumn get hrv => real().nullable()(); // Heart Rate Variability (ms)
  IntColumn get rhr => integer().nullable()(); // Resting Heart Rate (bpm)
  
  // Subjective metrics (from check-ins)
  RealColumn get energyLevel => real().nullable()(); // 1-10 scale
  RealColumn get stressLevel => real().nullable()(); // 1-10 scale
  
  // Computed recovery score
  RealColumn get recoveryScore => real().nullable()(); // 0-100
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
```

**Relationships**:
- Many biomarkers belong to one user (N:1)

**Constraints**:
- `date` must be unique per user (one record per day)
- Score fields range: 1-10 (nullable)
- `recoveryScore` range: 0-100 (nullable)

**Indexes**:
- `userId, date` (composite for daily lookups)

---

#### Table: `injury_records`

**Purpose**: Track pain, injuries, and recovery status.

**Fields**:
```dart
class InjuryRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  IntColumn get workoutId => integer().nullable().references(Workouts, #id)(); // If reported post-workout
  
  // Injury details
  TextColumn get location => text()(); // e.g., "left knee", "right ankle"
  IntColumn get severity => integer()(); // 1-10 scale
  TextColumn get description => text().nullable()(); // User notes
  
  // Lifecycle
  TextColumn get status => text().withDefault(const Constant('active'))(); // 'active' | 'recovering' | 'resolved'
  DateTimeColumn get reportedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
```

**Relationships**:
- Many injury records belong to one user (N:1)
- Many injury records can reference one workout (N:1, optional)

**Constraints**:
- `severity` range: 1-10
- `status` must be one of: `active`, `recovering`, `resolved`

---

#### Table: `acwr_records`

**Purpose**: Track Acute:Chronic Workload Ratio for injury prevention.

**Fields**:
```dart
class AcwrRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(Users, #id)();
  
  // Date
  DateTimeColumn get date => dateTime()();
  
  // Load calculations
  RealColumn get acuteLoad => real()(); // Last 7 days average
  RealColumn get chronicLoad => real()(); // Last 28 days average
  RealColumn get ratio => real()(); // Acute / Chronic
  
  // Risk assessment
  TextColumn get riskLevel => text()(); // 'low' | 'moderate' | 'high'
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

**Relationships**:
- Many ACWR records belong to one user (N:1)

**Constraints**:
- `date` must be unique per user (one record per day)
- `riskLevel` must be one of: `low`, `moderate`, `high`
- Safe ACWR range: 0.8 - 1.3

**Indexes**:
- `userId, date` (composite for daily lookups)

---

### 4. Analytics Domain

#### Table: `goal_confidence_history`

**Purpose**: Track daily confidence score changes for trending (Journey #5).

**Fields**:
```dart
class GoalConfidenceHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get goalId => integer().references(Goals, #id)();
  
  // Date
  DateTimeColumn get date => dateTime()();
  
  // Snapshot of scores
  RealColumn get confidence => real()(); // 0-100
  RealColumn get adherenceScore => real()(); // 0-10
  RealColumn get qualityScore => real()(); // 0-10
  RealColumn get consistencyScore => real()(); // 0-10
  RealColumn get recoveryScore => real()(); // 0-10
  
  // Change explanation
  TextColumn get changeReason => text().nullable()(); // e.g., "Completed all workouts this week"
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

**Relationships**:
- Many confidence history records belong to one goal (N:1)

**Constraints**:
- `confidence` range: 0-100
- Score fields range: 0-10
- One record per goal per day (enforced in application layer)

**Indexes**:
- `goalId, date` (composite for historical queries)

---

**Last Updated**: 2025-12-30 (Added Training Context fields)
