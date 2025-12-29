# Calendar & Scheduling

## 1. Training Calendar

### Visual Planning Overview
A beautiful, interactive calendar that shows users their entire training plan at a glance.

### Views
- **Weekly View (Default)**: Horizontal scroll, badges for workout types.
- **Monthly View**: Grid layout, dots/mini-badges for overview.

### Color Coding
| Workout Type | Color |
|--------------|-------|
| Easy Run | Blue |
| Tempo | Orange |
| Intervals | Red |
| Long Run | Purple |
| Rest | Gray |
| Strength | Green |
| Mobility | Teal |
| Race Day | Gold |

### Badges
- **Status Indicators**:
  - ✓ Checkmark (Completed - Solid fill)
  - ○ Hollow circle (Planned - Outlined)
  - ✗ X (Missed/Skipped)

## 2. Schedule Time Off

### Proactive Planning
Users can schedule time off in advance (vacation, work travel, life events).

### Behavior
- **Visuals**: Blocked dates with "Time Off" badge/pattern (🏖️)
- **Training Impact**: See [Time Off & Recovery Protocols](../lifecycle/time_off.md) for detailed behavior, including:
  - Schedule clearing and notification suppression
  - Ad-hoc workout requests during time off
  - Return-to-training volume adjustments based on duration

## 🛠️ Technical Logic

| Feature | Logic Engine |
|---------|--------------|
| Time-Off Logic | [time_off.md](../../../architecture/data_processing/time_off.md) |
| Race Logic | [events_taper.md](../../../architecture/data_processing/events_taper.md) |

