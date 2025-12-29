# Validation Rules

This document defines input validation and business logic rules for all data entities.

---

## 1. User Profile Domain

### Table: `users`

#### Field Validation

| Field | Rule | Error Message |
|-------|------|---------------|
| `availableDays` | Must be valid JSON array of day names | "Invalid day selection" |
| `availableDays` | Must have at least 1 day available | "You need at least one day available for training" |
| `constraints` | Max 500 characters | "Constraints too long (max 500 characters)" |

#### Business Logic

- **One user per device**: Enforced at application layer (single-user app assumption)
- **Available days**: Parsed from JSON, validated against `["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]`

---

## 2. Training Domain

### Table: `goals`

#### Field Validation

| Field | Rule | Error Message |
|-------|------|---------------|
| `type` | Must be one of: `distance_milestone`, `time_performance`, `event`, `maintenance` | "Invalid goal type" |
| `name` | Required, 1-100 characters | "Goal name required" |
| `targetDistance` | If provided, must be 1-200 km | "Distance must be between 1-200 km" |
| `targetTime` | If provided, must be > 0 seconds | "Target time must be positive" |
| `currentBestTime` | If provided, must be > 0 seconds | "Current best time must be positive" |
| `eventDate` | If provided, must be in the future | "Event date must be in the future" |
| `eventDate` | If < 4 weeks away, show warning | "That's soon! We'll create an accelerated plan" |
| `eventDate` | If > 1 year away, show warning | "That's far out! We'll start with base building" |
| `maintenanceFrequency` | If provided, must be 1-7 | "Frequency must be 1-7 runs per week" |
| `maintenanceDuration` | If provided, must be 15-180 minutes | "Duration must be 15-180 minutes" |
| `confidence` | Must be 0-100 | "Confidence out of range" |
| `adherenceScore` | Must be 0-10 | "Score out of range" |
| `qualityScore` | Must be 0-10 | "Score out of range" |
| `consistencyScore` | Must be 0-10 | "Score out of range" |
| `recoveryScore` | Must be 0-10 | "Score out of range" |

#### Business Logic

- **One active goal**: Only one goal can have `isActive = true` at a time (enforced at application layer)
- **Goal type validation**: 
  - `distance_milestone` requires `targetDistance`
  - `time_performance` requires `targetDistance` and `targetTime`
  - `event` requires `eventName`, `eventDate`, and `targetDistance`
  - `maintenance` requires `maintenanceFrequency` and `maintenanceDuration`
- **Target time vs. current best**: If `targetTime` > `currentBestTime`, show warning: "Your target is slower than your current best. Is this correct?"

---

### Table: `mesocycles`

#### Field Validation

| Field | Rule | Error Message |
|-------|------|---------------|
| `phase` | Must be one of: `base`, `build`, `peak`, `taper`, `recovery` | "Invalid phase" |
| `intensityDistribution` | Must be one of: `pyramidal`, `polarized`, `threshold` | "Invalid intensity distribution" |
| `mesocycleNumber` | Must be unique per goal | "Mesocycle number already exists for this goal" |
| `endDate` | Must be after `startDate` | "End date must be after start date" |
| `endDate` - `startDate` | Typically 21-28 days | Warning if outside range |
| `targetWeeklyVolume` | Must be > 0 | "Weekly volume must be positive" |
| `targetWeeklyDuration` | Must be > 0 | "Weekly duration must be positive" |

#### Business Logic

- **Mesocycle duration**: Typically 3-4 weeks (21-28 days)
- **Phase progression**: Base → Build → Peak → Taper → Recovery (enforced at application layer)

---

### Table: `microcycles`

#### Field Validation

| Field | Rule | Error Message |
|-------|------|---------------|
| `weekNumber` | Must be unique per mesocycle | "Week number already exists for this mesocycle" |
| `weekNumber` | Must be 1-4 (within mesocycle) | "Week number must be 1-4" |
| `endDate` | Must be after `startDate` | "End date must be after start date" |
| `endDate` - `startDate` | Must be exactly 7 days | "Microcycle must be 7 days" |
| `adherencePercentage` | Must be 0-100 | "Adherence out of range" |

#### Business Logic

- **Week duration**: Exactly 7 days (Monday-Sunday)
- **Computed stats**: `totalVolume`, `totalDuration`, `adherencePercentage` updated by application layer after workouts complete

---

### Table: `workouts`

#### Field Validation

| Field | Rule | Error Message |
|-------|------|---------------|
| `type` | Must be one of: `easy_run`, `tempo`, `intervals`, `long_run`, `rest`, `strength`, `mobility` | "Invalid workout type" |
| `name` | Required, 1-100 characters | "Workout name required" |
| `plannedDuration` | Must be > 0 seconds | "Duration must be positive" |
| `plannedDistance` | If provided, must be > 0 km | "Distance must be positive" |
| `status` | Must be one of: `planned`, `in_progress`, `completed`, `skipped`, `missed` | "Invalid status" |
| `rpe` | If provided, must be 1-10 | "RPE must be 1-10" |
| `actualPace` | If provided, must be > 0 min/km | "Pace must be positive" |

#### Business Logic

- **Status transitions**: 
  - `planned` → `in_progress` → `completed`
  - `planned` → `skipped` (user choice)
  - `planned` → `missed` (system marks if not completed by end of day)
- **Completion validation**: `completedAt` required if `status = completed`
- **RPE validation**: Required for completed workouts (enforced at UI layer)

---

## 3. Health & Recovery Domain

### Table: `biomarkers`

#### Field Validation

| Field | Rule | Error Message |
|-------|------|---------------|
| `date` | Must be unique per user | "Biomarker record already exists for this date" |
| `sleepDuration` | If provided, must be 0-720 minutes (12 hours) | "Sleep duration out of range" |
| `sleepQuality` | If provided, must be 1-10 | "Sleep quality must be 1-10" |
| `hrv` | If provided, must be > 0 ms | "HRV must be positive" |
| `rhr` | If provided, must be 30-200 bpm | "RHR out of range" |
| `energyLevel` | If provided, must be 1-10 | "Energy level must be 1-10" |
| `stressLevel` | If provided, must be 1-10 | "Stress level must be 1-10" |
| `recoveryScore` | If provided, must be 0-100 | "Recovery score out of range" |

#### Business Logic

- **Daily updates**: One record per user per day, **UPDATED** as new health data syncs
- **Recovery score calculation**: Computed from sleep, HRV, RHR, energy, and stress (application layer)

---

### Table: `injury_records`

#### Field Validation

| Field | Rule | Error Message |
|-------|------|---------------|
| `location` | Required, 1-100 characters | "Injury location required" |
| `severity` | Must be 1-10 | "Severity must be 1-10" |
| `status` | Must be one of: `active`, `recovering`, `resolved` | "Invalid status" |
| `description` | Max 500 characters | "Description too long" |

#### Business Logic

- **Status lifecycle**: `active` → `recovering` → `resolved`
- **Resolution**: `resolvedAt` required if `status = resolved`
- **Workout association**: `workoutId` optional (for post-workout pain check-ins)

---

### Table: `acwr_records`

#### Field Validation

| Field | Rule | Error Message |
|-------|------|---------------|
| `date` | Must be unique per user | "ACWR record already exists for this date" |
| `acuteLoad` | Must be ≥ 0 | "Acute load must be non-negative" |
| `chronicLoad` | Must be > 0 | "Chronic load must be positive" |
| `ratio` | Must be ≥ 0 | "Ratio must be non-negative" |
| `riskLevel` | Must be one of: `low`, `moderate`, `high` | "Invalid risk level" |

#### Business Logic

- **Safe ACWR range**: 0.8 - 1.3
- **Risk levels**:
  - `low`: 0.8 ≤ ratio ≤ 1.3
  - `moderate`: 0.5 ≤ ratio < 0.8 or 1.3 < ratio ≤ 1.5
  - `high`: ratio < 0.5 or ratio > 1.5
- **Daily updates**: One record per user per day, **UPDATED** as workouts complete

---

## 4. Analytics Domain

### Table: `goal_confidence_history`

#### Field Validation

| Field | Rule | Error Message |
|-------|------|---------------|
| `confidence` | Must be 0-100 | "Confidence out of range" |
| `adherenceScore` | Must be 0-10 | "Score out of range" |
| `qualityScore` | Must be 0-10 | "Score out of range" |
| `consistencyScore` | Must be 0-10 | "Score out of range" |
| `recoveryScore` | Must be 0-10 | "Score out of range" |
| `changeReason` | Max 200 characters | "Reason too long" |

#### Business Logic

- **Daily snapshots**: One record per goal per day (enforced at application layer)
- **Snapshot creation**: Created daily after midnight or when confidence changes significantly (>5%)

---

## Validation Enforcement Strategy

### Database-Level Constraints
- Primary keys, foreign keys, unique constraints
- NOT NULL constraints
- CHECK constraints for enum values (where supported by SQLite)

### Application-Level Validation
- Input validation before database writes
- Business logic rules (e.g., one active goal)
- Complex constraints (e.g., goal type requirements)
- User-friendly error messages

### UI-Level Validation
- Real-time input validation (e.g., date pickers prevent past dates)
- Form field requirements
- Immediate feedback to user

---

**Last Updated**: 2025-12-29
