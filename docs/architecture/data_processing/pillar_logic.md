# Pillar Coordination (Running, Strength, Mobility)

**Purpose**: Intelligently schedule workouts across all three pillars while respecting recovery principles.

## Core Principles

- **Priority-Based Scheduling**: "Big Rocks First" - High-priority pillar workouts scheduled first
- **48-Hour Rule**: Allow 48 hours between hard efforts in the same pillar
- **Cross-Pillar Conflicts**: Avoid hard leg strength the day before a key run
- **Hard Days Hard, Easy Days Easy**: Never stack high-intensity sessions back-to-back across pillars

## Pillar Priorities by Goal Type

Different goal types emphasize pillars differently:

| Goal Type | Running | Strength | Mobility | Notes |
|-----------|---------|----------|----------|-------|
| `distance_milestone` | High | Medium | Medium | Balanced approach for new runners |
| `time_performance` | High | Medium-High | Medium | Strength supports speed development |
| `event` | High | Medium → Low | Medium → High | Reduce strength in taper, increase mobility |
| `maintenance` | Medium | High | High | Shift focus to maintain while reducing running |

## Recovery Week Adjustments

| Pillar | Adjustment |
|--------|------------|
| Running | -20% volume |
| Strength | Maintenance mode (lower volume, same intensity) |
| Mobility | Priority INCREASES (extra sessions to aid recovery) |

## Related Tools

| Tool | Purpose | Key Params | Validation Logic | Called In |
|------|---------|------------|------------------|----------|
| `reschedule_workout` | Move workout to new date | `workout_id`, `new_date`, `reason` | Checks 48-hour rule, cross-pillar conflicts, vacation blocks, race taper periods. **Strictness varies by goal type** (strict for Event, flexible for Maintenance) | Daily Training Loop - Reschedule action |
| `adjust_intensity` | Scale workout difficulty | `workout_id`, `factor` (e.g., 0.8) | Ensures adjustments respect RPE targets and recovery principles | Daily Training Loop - Chat adjustment flow (fatigue) |
| `swap_workout` | Replace workout type | `workout_id`, `new_type` | Validates pillar coordination (no hard leg day before long run) | Injury Management - Swap run for strength |

## 🗄️ Data Models

| Entity | Schema Definition |
|--------|-------------------|
| Goal Type | [goals.md](../data_models/goals.md) |
| Workouts | [workouts.md](../data_models/workouts.md) |

