# Race & Event Management

**Purpose**: Manage race events, implement taper protocols, and schedule appropriate recovery.

## Race Types

| Type | Pre-Race Adjustment | Post-Race Recovery |
|------|---------------------|-------------------|
| Goal Race | 1-3 week taper (distance-dependent) | Full recovery week |
| Tune-Up Race | Reduce training 2-3 days before | 2-3 easy days |
| Fun Run | Slight intensity reduction day before | 1 easy day |
| Non-Running Event | No adjustment | No adjustment |

## Taper Protocols by Distance

| Distance | Duration | Week 1 | Week 2 | Week 3 |
|----------|----------|--------|--------|--------|
| 5K | 7-10 days | -30% | -50% final 3-4 days | - |
| 10K | 10-14 days | -30% | -50% | - |
| Half Marathon | 2 weeks | -30% | -50% | - |
| Marathon | 3 weeks | -20% | -40% | -60% |

> [!NOTE]
> All tapers maintain intensity with short, sharp sessions while reducing volume.

## Related Tools

| Tool | Purpose | Key Params | Logic | Called In |
|------|---------|------------|-------|----------|
| `add_race_event` | Add event to calendar | `date`, `type`, `distance`, `name`, `notes` | Initiates appropriate taper protocol and schedules post-race recovery | Onboarding - Goal setting, Calendar add event |
| `trigger_taper` | Start taper protocol | `race_id`, `race_distance` | Implements distance-specific volume reductions while maintaining intensity | Race Day Preparation - Automatic at 3 weeks before race |

## 🗄️ Data Models

| Entity | Schema Definition |
|--------|-------------------|
| Race Events | [goals.md](../data_models/goals.md) |

