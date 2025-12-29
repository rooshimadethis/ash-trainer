# Data Models - Phase 1

This directory contains the database schema design for Phase 1 of the Ash Trainer app.

## 📂 Documentation Structure

- **[_index.md](_index.md)** - Overview, ERD diagram, and entity summary
- **[entities.md](entities.md)** - Detailed table definitions for all 9 entities
- **[validation_rules.md](validation_rules.md)** - Input validation and business logic rules
- **[data_lifecycle.md](data_lifecycle.md)** - Data creation, updates, deletion, and cascade behavior

## 🗂️ Entity Overview

### Training Domain
- **goals** - User goals and confidence tracking
- **mesocycles** - 3-4 week training blocks (Base/Build/Peak/Taper)
- **microcycles** - Individual training weeks
- **workouts** - Planned and completed workout sessions

### User Profile Domain
- **users** - User profile and onboarding data

### Health & Recovery Domain
- **biomarkers** - Daily health metrics (sleep, HRV, RHR)
- **injury_records** - Pain and injury tracking
- **acwr_records** - Acute:Chronic Workload Ratio for injury prevention

### Analytics Domain
- **goal_confidence_history** - Daily confidence score snapshots

## 🔗 Hierarchy

```
User
  └─ Goal (1:N)
      ├─ Mesocycle (1:N)
      │   └─ Microcycle (1:N)
      │       └─ Workout (1:N)
      └─ GoalConfidenceHistory (1:N)
  ├─ Biomarkers (1:N)
  ├─ InjuryRecords (1:N)
  └─ AcwrRecords (1:N)
```

## 📋 Related Documentation

- **User Journeys**: [`docs/ux/user_journeys/`](../../ux/user_journeys/)
- **Product Spec**: [`docs/ux/product_spec/`](../../ux/product_spec/)
- **Data Processing**: [`docs/architecture/data_processing/`](../data_processing/)

---

**Last Updated**: 2025-12-29
