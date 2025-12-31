# Training Plan Generation & Periodization

> **Implements**: [Running Training Plans](../../../ux/product_spec/training/running/training_plans.md)  
> **Data Models**: [Training Plans](../../data_models/_index.md), [Goals](../../data_models/_index.md)  
> **Dependencies**: [Pillar Coordination](../../cross_cutting/pillar_coordination.md), [Load Management](../../cross_cutting/load_mgmt.md)

**Purpose**: Generate periodized training plans for each goal type, implement taper protocols, and manage race events.

## Plan Generation by Goal Type

### 1. Distance Milestone Goals

**Philosophy**: Gradual volume progression with conservative intensity.

```dart
TrainingPlan generateDistanceMilestonePlan({
  required Goal goal,
  required UserProfile user,
}) {
  int weeks = calculateWeeksToGoal(goal.deadline);
  double startingVolume = user.currentWeeklyVolume;
  double targetVolume = calculateTargetVolume(goal.targetDistance);
  
  // Conservative 10% weekly increase
  double weeklyIncrease = 0.10;
  
  // 3:1 ratio (3 build weeks, 1 recovery week)
  return generatePyramidalPlan(
    weeks: weeks,
    startVolume: startingVolume,
    targetVolume: targetVolume,
    weeklyIncrease: weeklyIncrease,
    recoveryFrequency: 4, // Every 4th week
  );
}
```

### 2. Time Performance Goals

**Philosophy**: Structured intensity work with speed development.

```dart
TrainingPlan generatePerformancePlan({
  required Goal goal,
  required UserProfile user,
}) {
  int weeks = calculateWeeksToGoal(goal.deadline);
  
  // Phases: Base (40%) → Build (40%) → Peak (15%) → Taper (5%)
  return generatePhasedPlan(
    weeks: weeks,
    phases: [
      Phase(name: 'base', percentage: 0.40, focus: 'volume'),
      Phase(name: 'build', percentage: 0.40, focus: 'intensity'),
      Phase(name: 'peak', percentage: 0.15, focus: 'race_pace'),
      Phase(name: 'taper', percentage: 0.05, focus: 'recovery'),
    ],
  );
}
```

### 3. Event Goals (Race-Specific)

**Philosophy**: Peak for specific race date with structured taper.

```dart
TrainingPlan generateEventPlan({
  required Goal goal,
  required RaceEvent race,
  required UserProfile user,
}) {
  int weeks = calculateWeeksToGoal(race.date);
  int taperWeeks = getTaperDuration(race.distance);
  
  // Work backwards from race date
  return generateReverseChronologicalPlan(
    raceDate: race.date,
    taperWeeks: taperWeeks,
    buildWeeks: weeks - taperWeeks,
    raceDistance: race.distance,
  );
}
```

### 4. Maintenance Goals

**Philosophy**: Minimum effective dose to sustain fitness.

```dart
TrainingPlan generateMaintenancePlan({
  required Goal goal,
  required UserProfile user,
}) {
  // Fixed volume, no progression
  double sustainVolume = user.currentWeeklyVolume * 0.7;
  
  return generateSteadyStatePlan(
    weeklyVolume: sustainVolume,
    frequency: 3, // 3 runs per week
    intensityMix: {'easy': 0.8, 'moderate': 0.2},
  );
}
```

## Taper Protocols by Distance

### Taper Duration & Volume Reduction

| Distance | Duration | Week 1 | Week 2 | Week 3 |
|----------|----------|--------|--------|--------|
| 5K | 7-10 days | -30% | -50% final 3-4 days | - |
| 10K | 10-14 days | -30% | -50% | - |
| Half Marathon | 2 weeks | -30% | -50% | - |
| Marathon | 3 weeks | -20% | -40% | -60% |

> [!NOTE]
> All tapers maintain intensity with short, sharp sessions while reducing volume.

### Taper Implementation

```dart
void applyTaper({
  required TrainingPlan plan,
  required RaceEvent race,
}) {
  int taperWeeks = getTaperDuration(race.distance);
  DateTime taperStart = race.date.subtract(Duration(days: taperWeeks * 7));
  
  List<double> volumeReductions = getVolumeReductions(race.distance);
  
  for (int i = 0; i < taperWeeks; i++) {
    Week week = plan.getWeek(taperStart.add(Duration(days: i * 7)));
    week.reduceVolume(volumeReductions[i]);
    week.maintainIntensity(); // Keep RPE targets, reduce duration
  }
}
```

## Race & Event Management

### Race Types

| Type | Pre-Race Adjustment | Post-Race Recovery |
|------|---------------------|-------------------|
| Goal Race | 1-3 week taper (distance-dependent) | Full recovery week |
| Tune-Up Race | Reduce training 2-3 days before | 2-3 easy days |
| Fun Run | Slight intensity reduction day before | 1 easy day |
| Non-Running Event | No adjustment | No adjustment |

### Post-Race Recovery Protocol

```dart
void schedulePostRaceRecovery({
  required RaceEvent race,
  required TrainingPlan plan,
}) {
  int recoveryDays = getRecoveryDays(race.type, race.distance);
  
  for (int i = 1; i <= recoveryDays; i++) {
    DateTime recoveryDate = race.date.add(Duration(days: i));
    plan.clearWorkout(recoveryDate);
    
    if (i <= 2) {
      plan.addOptionalWorkout(recoveryDate, type: 'easy_recovery');
    }
  }
}

int getRecoveryDays(RaceType type, String distance) {
  if (type == RaceType.goalRace) {
    return {
      '5K': 3,
      '10K': 5,
      'Half': 7,
      'Marathon': 14,
    }[distance] ?? 7;
  }
  return 2; // Tune-up or fun run
}
```

## Mesocycle & Microcycle Structure

### 3:1 Pyramidal Pattern (Default)

```
Week 1: Build (+10% volume)
Week 2: Build (+10% volume)
Week 3: Build (+10% volume)
Week 4: Recovery (-20% volume)
```

### 2:1 Pattern (Aggressive)

Used for advanced athletes or time-crunched plans:
```
Week 1: Build (+15% volume)
Week 2: Build (+15% volume)
Week 3: Recovery (-20% volume)
```

## Related Tools

| Tool | Purpose | Called In |
|------|---------|-----------|
| `add_race_event` | Add event to calendar | User action or onboarding |
| `trigger_taper` | Start taper protocol | Automatic at taper start date |
| `generate_training_plan` | Create initial plan | Onboarding or goal change |

## 🗄️ Data Models

| Entity | Schema Definition |
|--------|-------------------|
| Training Plans | [Training Plans](../../data_models/_index.md) |
| Race Events | [Goals](../../data_models/_index.md) |
