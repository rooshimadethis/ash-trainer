# Three-Pillar Training

Ash treats **Running**, **Strength**, and **Mobility** as first-class citizens. A balanced athlete needs all three.

## 1. Priority & Scheduling Logic

Users independently set a priority (High/Med/Low) for each pillar based on their **day-to-day training preferences**. This is separate from their goal selection.

**Priority Rule**: Only one pillar can be set to "High" priority to maintain focus and prevent overtraining.

### Suggested Defaults (Based on Goal Type)
While users can customize their pillar priorities, Ash suggests the following starting points:

| Goal Type | Running | Strength | Mobility |
|-----------|---------|----------|------------|
| **Distance Milestone** | **High** | Medium | Medium |
| **Time Performance** | **High** | Medium-High | Medium |
| **Event (Peak Phase)** | **High** | Low | High |
| **Maintenance** | Medium | Medium-High | Medium-High |

*Users can override these suggestions to match their personal preferences and constraints.*

### Scheduling Constraints
1.  **48-Hour Recovery**: Key sessions (Intervals, Heavy Lower Body) must be separated by 48 hours.
2.  **Cross-Pillar Interference**: No Heavy Leg Strength the day before a Long Run.
3.  **Big Rocks First**: High priority sessions get prime calendar slots.

## 2. Pillar Definitions

### 🏃 Running
The primary training modality. Builds cardiovascular fitness, endurance, and running-specific adaptations.

*For specific running strategies (intervals, tempo, easy runs, etc.), see [Goal Types](goal_types.md).*

### 🏋️ Strength
Injury prevention, power production, and structural resilience. Complements running by strengthening muscles, tendons, and connective tissue.

*   **Frequency**: 2-3x/week for most goals
*   **Approach**: Full body or Upper/Lower split depending on schedule
*   **During Taper**: Reduced volume, maintained intensity

### 🧘 Mobility
Longevity, recovery, and movement quality. Maintains range of motion and reduces injury risk.

*   **Active Mobility**: Dynamic stretching, pre-run activation drills
*   **Passive Recovery**: Yoga, foam rolling, post-run cool-down

## 🛠️ Technical Logic

| Feature | Logic Engine |
|---------|--------------|
| Scheduling Algorithm | [pillar_logic.md](../../../architecture/data_processing/pillar_logic.md) |
