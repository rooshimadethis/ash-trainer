# Function Registry

**Purpose**: Central index of all functions across data processing features. Check this registry before creating new functions to identify reusable components.

---

## How to Use This Registry

1. **Before documenting a new function**: Search this file to see if similar logic exists
2. **When adding a function**: Add it here with location and brief description
3. **Organization**: Functions are grouped by category (Load Management, Recovery, Planning, etc.)

---

## Load Management

### `calculateWeeklyVolume(weekId)` - **LOCAL**
- **Location**: [load_mgmt.md](./load_mgmt.md#calculateweeklyvolume)
- **Purpose**: Sum all training load for a given week
- **Used By**: Goals, Weekly Planning, Biomarkers, Injury Management

### `getACWR(currentWeek)` - **LOCAL**
- **Location**: [load_mgmt.md](./load_mgmt.md#getacwr)
- **Purpose**: Calculate acute:chronic workload ratio (injury risk indicator)
- **Used By**: Weekly Planning, Biomarkers, Injury Management

---

## Recovery & Health

### `processSleepData(sleepDuration, baseline, workout)` - **LOCAL**
- **Location**: [athlete_markers/biomarkers.md](../athlete_markers/biomarkers.md#processsleepdata)
- **Purpose**: Adjust workout based on sleep quality vs baseline
- **Used By**: Biomarkers, Daily Workout Generation

### `processHeartRateData(currentRHR, baselineRHR, currentHRV, baselineHRV, workout)` - **LOCAL**
- **Location**: [athlete_markers/biomarkers.md](../athlete_markers/biomarkers.md#processheartratedata)
- **Purpose**: Adjust workout based on RHR/HRV deviations from baseline
- **Used By**: Biomarkers, Daily Workout Generation

### `detectSkipPattern(recentLogs)` - **LOCAL**
- **Location**: [athlete_markers/biomarkers.md](../athlete_markers/biomarkers.md#detectskippattern)
- **Purpose**: Analyze workout adherence patterns to identify motivation issues
- **Used By**: Biomarkers, Burnout Detection

### `detectBurnout(skipPattern, biomarkers, acwr, logs)` - **HYBRID**
- **Location**: [athlete_markers/biomarkers.md](../athlete_markers/biomarkers.md#detectburnout)
- **Purpose**: Identify mental fatigue patterns and recommend intervention
- **Used By**: Biomarkers, Weekly Planning

---

## Environmental Adaptations

### `adjustForWeather(workout, weather)` - **LOCAL**
- **Location**: [athlete_markers/biomarkers.md](../athlete_markers/biomarkers.md#adjustforweather)
- **Purpose**: Modify workout based on temperature, wind chill, air quality
- **Used By**: Biomarkers, Daily Workout Generation

---

## Planning & Scheduling

*(To be populated as we document Goals, Weekly Planning, etc.)*

---

## Injury Management

*(To be populated as we document Injury Management)*

---

## Context & AI

*(To be populated as we document Context Engine)*

---

## Legend

- **LOCAL**: Pure database query/calculation, no AI needed
- **AI**: Requires LLM API call for generation/reasoning
- **HYBRID**: Fetches data locally, sends to AI, saves result locally
