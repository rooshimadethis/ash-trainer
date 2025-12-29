# Time-Off Management

> **Implements**: [Time Off](../../ux/product_spec/lifecycle/time_off.md)  
> **Data Models**: [Goals](../data_models/_index.md)  
> **Dependencies**: [Context Engine](../cross_cutting/context_engine.md)

**Purpose**: Handle planned breaks and safe return to training after time off.

## Time-Off Behavior

**During Time Off:**
- **No Pre-Scheduled Workouts**: Calendar is completely empty during blocked period
- **Notifications Suppressed**: No training reminders
- **Ad-Hoc Workouts Available**: User can open app and request a workout for that specific day
- **No Pressure**: Ad-hoc workouts don't affect goal confidence or adherence metrics

**Use Cases:**
- Vacation (beach trip, travel)
- Work travel (business conference)
- Life events (finals week, family emergency)
- Recovery periods (post-race rest week)

## Return-From-Break Protocols

| Break Type | Severity | Resume Volume | Progression Rate |
|------------|----------|---------------|------------------|
| Illness | Mild | 50% | 10-20%/week |
| Illness | Moderate | 30% (after 3-5 days symptom-free) | 15%/week |
| Injury | Minor (1-2 weeks) | 60% for affected activities | Gradual |
| Injury | Major (4+ weeks) | Treat as beginner for that movement | Very gradual |
| Time Off | 1-3 days | 100% (minimal impact) | Normal |
| Time Off | 4-7 days | 80% | Normal |
| Time Off | 1-2 weeks | 70% | Cautious |
| Time Off | 2+ weeks | 50% (treat as training break) | 10-20%/week |

## Related Tools

| Tool | Purpose | Key Params | Logic | Called In |
|------|---------|------------|-------|-----------|
| `schedule_time_off` | Block out dates | `start_date`, `end_date`, `notes` | Clears schedule, suppresses notifications, updates goal confidence | Vacation/Time-Off Scheduling - Add time off flow |
| `request_adhoc_workout` | Request workout during time off | `date`, `workout_type` (optional), `duration` (optional) | Generates single workout for that day, doesn't affect adherence metrics | Time-off period - user opens app and requests workout |
| `return_from_break` | Safe return protocol | `break_type`, `duration_days`, `severity` | Adjusts training plan based on break type and duration | Vacation/Time-Off Scheduling - First workout after break |

## 🗄️ Data Models

| Entity | Schema Definition |
|--------|-------------------|
| Time-Off | [goals.md](../data_models/_index.md) |
