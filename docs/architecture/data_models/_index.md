# Data Models Overview

**Purpose**: Define the database schema for Phase 1 of Ash Trainer, supporting onboarding, calendar view, and goal progress tracking.

**Technology**: Drift (SQLite) for offline-first local storage with optional cloud sync in later phases.

---

## Entity-Relationship Diagram

```mermaid
erDiagram
    USERS ||--o{ GOALS : "has"
    USERS ||--o{ BIOMARKERS : "tracks"
    USERS ||--o{ INJURY_RECORDS : "reports"
    USERS ||--o{ ACWR_RECORDS : "monitors"
    
    GOALS ||--o{ MESOCYCLES : "contains"
    GOALS ||--o{ GOAL_CONFIDENCE_HISTORY : "tracks"
    
    MESOCYCLES ||--o{ MICROCYCLES : "contains"
    
    MICROCYCLES ||--o{ WORKOUTS : "schedules"
    
    WORKOUTS }o--|| USERS : "belongs to"
    WORKOUTS }o--|| GOALS : "belongs to"
    WORKOUTS }o--o| MESOCYCLES : "part of"
    WORKOUTS }o--o| MICROCYCLES : "part of"
    WORKOUTS ||--o{ INJURY_RECORDS : "may cause"
    
    USERS {
        int id PK
        text trainingHistory "deprecated"
        text availableDays "JSON array"
        text constraints "nullable"
        bool healthPermissionsGranted
        datetime createdAt
        datetime updatedAt
    }
    
    GOALS {
        int id PK
        int userId FK
        text type "enum"
        text name
        bool isActive
        real targetDistance "nullable"
        datetime targetDate "nullable"
        int targetTime "nullable"
        int currentBestTime "nullable"
        text eventName "nullable"
        datetime eventDate "nullable"
        int maintenanceFrequency "nullable"
        int maintenanceDuration "nullable"
        datetime endDate "nullable"
        real confidence "0-100"
        real adherenceScore "0-10"
        real qualityScore "0-10"
        real consistencyScore "0-10"
        real recoveryScore "0-10"
        datetime createdAt
        datetime updatedAt
    }
    
    MESOCYCLES {
        int id PK
        int goalId FK
        int mesocycleNumber
        datetime startDate
        datetime endDate
        text phase "enum"
        text intensityDistribution "enum"
        real targetWeeklyVolume
        int targetWeeklyDuration
        real actualVolume
        int actualDuration
        datetime createdAt
        datetime updatedAt
    }
    
    MICROCYCLES {
        int id PK
        int mesocycleId FK
        int weekNumber
        datetime startDate
        datetime endDate
        real totalVolume
        int totalDuration
        real adherencePercentage
        datetime createdAt
        datetime updatedAt
    }
    
    WORKOUTS {
        int id PK
        int userId FK
        int goalId FK
        int mesocycleId FK "nullable"
        int microcycleId FK "nullable"
        datetime scheduledDate
        text type "enum"
        text name
        int plannedDuration
        real plannedDistance "nullable"
        text intensity "nullable"
        text description "nullable"
        text status "enum"
        int actualDuration "nullable"
        real actualDistance "nullable"
        real actualPace "nullable"
        int rpe "nullable"
        datetime completedAt "nullable"
        datetime createdAt
        datetime updatedAt
    }
    
    BIOMARKERS {
        int id PK
        int userId FK
        datetime date "unique per user"
        int sleepDuration "nullable"
        real sleepQuality "nullable"
        real hrv "nullable"
        int rhr "nullable"
        real energyLevel "nullable"
        real stressLevel "nullable"
        real recoveryScore "nullable"
        datetime createdAt
        datetime updatedAt
    }
    
    INJURY_RECORDS {
        int id PK
        int userId FK
        int workoutId FK "nullable"
        text location
        int severity "1-10"
        text description "nullable"
        text status "enum"
        datetime reportedAt
        datetime resolvedAt "nullable"
        datetime createdAt
        datetime updatedAt
    }
    
    ACWR_RECORDS {
        int id PK
        int userId FK
        datetime date "unique per user"
        real acuteLoad
        real chronicLoad
        real ratio
        text riskLevel "enum"
        datetime createdAt
    }
    
    GOAL_CONFIDENCE_HISTORY {
        int id PK
        int goalId FK
        datetime date
        real confidence "0-100"
        real adherenceScore "0-10"
        real qualityScore "0-10"
        real consistencyScore "0-10"
        real recoveryScore "0-10"
        text changeReason "nullable"
        datetime createdAt
    }
```

---

## Entity Summary

| Entity | Purpose | Key Relationships | Records Per User |
|--------|---------|-------------------|------------------|
| **users** | Profile and preferences | Root entity | 1 |
| **goals** | Training goals | 1 user : N goals | ~1-5 |
| **mesocycles** | 3-4 week training blocks | 1 goal : N mesocycles | ~3-5 per goal |
| **microcycles** | Weekly training plans | 1 mesocycle : N microcycles | 3-4 per mesocycle |
| **workouts** | Individual sessions | 1 microcycle : N workouts | ~3-7 per week |
| **biomarkers** | Daily health metrics | 1 user : N biomarkers | 1 per day |
| **injury_records** | Pain tracking | 1 user : N injuries | Variable |
| **acwr_records** | Load management | 1 user : N records | 1 per day |
| **goal_confidence_history** | Confidence trending | 1 goal : N history | 1 per goal per day |

---

## Design Decisions

### Single-User Architecture
- **Assumption**: One user per device installation
- **Rationale**: Simplifies Phase 1 implementation, offline-first design
- **Future**: Multi-user support can be added with authentication tables in Phase 2+

### Offline-First with Drift
- **Technology**: Drift (Flutter's SQLite wrapper)
- **Benefits**: 
  - Works offline by default
  - Fast local queries
  - Optional cloud sync layer in future
- **Trade-offs**: 
  - No built-in multi-device sync (Phase 1)
  - Requires migration strategy for schema changes

### Periodization Hierarchy
- **Structure**: Goal → Mesocycle → Microcycle → Workout
- **Rationale**: Matches sports science periodization model
- **Flexibility**: Workouts can exist without mesocycle/microcycle for ad-hoc sessions

### Daily Aggregated Records
- **Tables**: `biomarkers`, `acwr_records`
- **Pattern**: One record per user per day, **UPDATED** as new data arrives
- **Rationale**: Simplifies queries, reduces storage, matches health data sync patterns

---

## Screen-to-Data Mapping

See [Screen-to-Data Mapping](screen_to_data_mapping.md) for detailed mapping of all 23 Phase 1 screens to database entities.

---

## Related Documentation

- **[Entities](entities.md)** - Detailed table definitions
- **[Validation Rules](validation_rules.md)** - Input validation and business logic
- **[Data Lifecycle](data_lifecycle.md)** - Creation, updates, deletion, and cascade behavior

---

**Last Updated**: 2025-12-29
