# Biomarker Processing & Recovery Tracking

> **Implements**: [Biomarkers & Recovery](../../ux/product_spec/athlete_markers/biomarkers.md)  
> **Data Models**: [Biomarkers](../data_models/_index.md)  
> **Dependencies**: [Load Management](../cross_cutting/load_mgmt.md), [Context Engine](../cross_cutting/context_engine.md)

**Purpose**: Process automated health data, detect burnout patterns, and implement environmental adaptations.

---

## Data Dependencies

### Tables Required
- **`biomarkers`**: Sleep duration, RHR, HRV, motivation scores, energy levels
- **`workout_logs`**: Status (completed/skipped), actual duration, planned duration, target RPE, actual RPE
- **`microcycles`**: For ACWR calculation (via Load Management)
- **`weather_cache`**: Temperature, wind chill, AQI (optional, for environmental adaptations)

### Computed Fields
- **7-day RHR baseline**: Rolling average of resting heart rate
- **7-day HRV baseline**: Rolling average of heart rate variability
- **14-day sleep baseline**: Rolling average of sleep duration
- **ACWR**: Acute:Chronic Workload Ratio (from [Load Management](../cross_cutting/load_mgmt.md))

---

## Functions

### 1. Sleep Processing

#### `processSleepData()` - **LOCAL**

**Purpose**: Adjust today's workout based on last night's sleep quality compared to the user's baseline.

**Algorithm**:
1. Compare sleep duration to user's 14-day baseline
2. If < 6 hours OR 1.5+ hours below baseline → reduce intensity by 1 RPE and duration by 15%
3. If 3+ consecutive poor nights detected → flag for recovery week
4. Return adjustment with user-facing message

**Inputs**:
- `sleepDuration`: double (hours slept last night)
- `baselineSleep`: double (14-day rolling average)
- `workout`: PlannedWorkout (today's scheduled workout)

**Outputs**:
- `WorkoutAdjustment` (intensity/duration changes + message)

**Data Source**: Local DB query (`biomarkers` table)

**Pseudocode**:
```dart
WorkoutAdjustment processSleepData({
  required double sleepDuration,
  required double baselineSleep,
  required PlannedWorkout workout,
}) {
  // Poor sleep (< 6 hours or significant drop from baseline)
  if (sleepDuration < 6 || sleepDuration < baselineSleep - 1.5) {
    return WorkoutAdjustment(
      intensityReduction: 1, // Reduce RPE by 1
      durationReduction: 0.15, // Shorten by 15-20%
      message: "Looks like you didn't sleep great. Let's keep it easy today.",
    );
  }
  
  // Consistently poor sleep (3+ nights)
  if (hasConsistentPoorSleep(sleepDuration, baselineSleep)) {
    return WorkoutAdjustment(
      triggerRecoveryWeek: true,
      message: "Your sleep has been poor lately. Let's take a recovery week.",
    );
  }
  
  return WorkoutAdjustment.none();
}
```

---

### 2. Heart Rate Processing

#### `processHeartRateData()` - **LOCAL**

**Purpose**: Adjust today's workout based on RHR/HRV deviations from baseline, which indicate stress, fatigue, or illness.

**Algorithm**:
1. Compare current RHR to 7-day baseline
   - +5-7 bpm → reduce intensity by 1 RPE
   - +10+ bpm → force easy day or rest
2. Compare current HRV to 7-day baseline
   - < 85% of baseline → reduce volume by 25% and intensity by 1 RPE
3. Return adjustment with user-facing message

**Inputs**:
- `currentRHR`: double (this morning's resting heart rate)
- `baselineRHR`: double (7-day rolling average)
- `currentHRV`: double (this morning's heart rate variability)
- `baselineHRV`: double (7-day rolling average)
- `workout`: PlannedWorkout (today's scheduled workout)

**Outputs**:
- `WorkoutAdjustment` (intensity/volume changes + message)

**Data Source**: Local DB query (`biomarkers` table)

**Pseudocode**:
```dart
WorkoutAdjustment processHeartRateData({
  required double currentRHR,
  required double baselineRHR,
  required double currentHRV,
  required double baselineHRV,
  required PlannedWorkout workout,
}) {
  // Elevated RHR (+5-7 bpm above 7-day average)
  if (currentRHR > baselineRHR + 5 && currentRHR <= baselineRHR + 10) {
    return WorkoutAdjustment(
      intensityReduction: 1,
      message: "Your body might need more recovery time.",
    );
  }
  
  // Significantly elevated RHR (+10+ bpm)
  if (currentRHR > baselineRHR + 10) {
    return WorkoutAdjustment(
      forceEasyDay: true,
      message: "Your resting heart rate is elevated. Let's take it easy today.",
    );
  }
  
  // Low HRV (significant drop from baseline)
  if (currentHRV < baselineHRV * 0.85) {
    return WorkoutAdjustment(
      volumeReduction: 0.25, // Reduce by 25%
      intensityReduction: 1,
      message: "Your HRV suggests you need more recovery.",
    );
  }
  
  return WorkoutAdjustment.none();
}
```

---

### 3. Motivation & Adherence Tracking

#### `detectSkipPattern()` - **LOCAL**

**Purpose**: Analyze workout adherence patterns over the last 2 weeks to identify motivation issues or selective avoidance.

**Algorithm**:
1. Count skipped workouts in last 14 days
2. If ≤ 2 skips → normal, no action
3. If ≥ 3 skips:
   - Check if only hard workouts (RPE ≥ 7) are being skipped → `selective` pattern
   - Otherwise → `concerning` pattern
4. Return pattern enum

**Inputs**:
- `recentLogs`: List<WorkoutLog> (last 14 days)

**Outputs**:
- `SkipPattern` enum (`none`, `occasional`, `concerning`, `selective`)

**Data Source**: Local DB query (`workout_logs` table)

**Pseudocode**:
```dart
enum SkipPattern {
  none,
  occasional,      // 1-2 skips, normal
  concerning,      // 3+ skips in 2 weeks
  selective,       // Skipping only hard workouts
}

SkipPattern detectSkipPattern(List<WorkoutLog> recentLogs) {
  int skippedCount = recentLogs.where((log) => log.status == 'skipped').length;
  
  if (skippedCount <= 2) return SkipPattern.none;
  if (skippedCount >= 3) {
    // Check if only hard workouts are being skipped
    bool onlyHardSkipped = recentLogs
        .where((log) => log.status == 'skipped')
        .every((log) => log.targetRPE >= 7);
    
    return onlyHardSkipped ? SkipPattern.selective : SkipPattern.concerning;
  }
  
  return SkipPattern.occasional;
}
```

---

### 4. Burnout Detection

#### `detectBurnout()` - **HYBRID** (Local → AI)

**Purpose**: Identify mental fatigue patterns by analyzing multiple signals (skip patterns, motivation, recovery, workout completion). Generate personalized intervention recommendation.

**Algorithm**:
1. Count burnout signals:
   - Skip pattern (concerning or selective)
   - Low motivation scores (avg < 4/10)
   - Poor recovery metrics (sleep < 6 hours)
   - Cutting workouts short (< 80% of planned duration)
2. Calculate severity:
   - 3+ signals → High severity, force recovery week
   - 2 signals → Moderate severity, suggest reduced volume
   - < 2 signals → Low severity, monitor closely
3. Send signals + context to AI for empathetic messaging
4. Return assessment with severity, signals, and recommendation

**Inputs**:
- `skipPattern`: SkipPattern enum
- `recentBiomarkers`: List<Biomarker> (last 14 days)
- `acwr`: double (current acute:chronic workload ratio)
- `recentLogs`: List<WorkoutLog> (last 14 days)

**Outputs**:
- `BurnoutAssessment` (severity, signals list, recommendation string)

**Data Source**: 
- **Local**: Fetch biomarkers, logs, ACWR from DB
- **AI**: Generate empathetic message based on signals (future enhancement)

**Pseudocode**:
```dart
BurnoutAssessment detectBurnout({
  required SkipPattern skipPattern,
  required List<Biomarker> recentBiomarkers,
  required double acwr,
  required List<WorkoutLog> recentLogs,
}) {
  int burnoutSignals = 0;
  List<String> signals = [];
  
  // Signal 1: Skip pattern
  if (skipPattern == SkipPattern.concerning || skipPattern == SkipPattern.selective) {
    burnoutSignals++;
    signals.add("Frequent workout skipping");
  }
  
  // Signal 2: Low motivation
  double avgMotivation = recentBiomarkers
      .where((b) => b.type == 'motivation')
      .map((b) => b.value)
      .fold(0.0, (a, b) => a + b) / recentBiomarkers.length;
  
  if (avgMotivation < 4) {
    burnoutSignals++;
    signals.add("Low motivation scores");
  }
  
  // Signal 3: Poor sleep + Low HRV
  bool poorRecovery = recentBiomarkers.any((b) => 
    b.type == 'sleep' && b.value < 6
  );
  
  if (poorRecovery) {
    burnoutSignals++;
    signals.add("Poor recovery metrics");
  }
  
  // Signal 4: Cutting workouts short
  bool cuttingShort = recentLogs.any((log) => 
    log.actualDuration < log.plannedDuration * 0.8
  );
  
  if (cuttingShort) {
    burnoutSignals++;
    signals.add("Consistently cutting workouts short");
  }
  
  return BurnoutAssessment(
    severity: burnoutSignals >= 3 ? 'high' : burnoutSignals >= 2 ? 'moderate' : 'low',
    signals: signals,
    recommendation: _getBurnoutRecommendation(burnoutSignals),
  );
}

String _getBurnoutRecommendation(int signals) {
  if (signals >= 3) {
    return "Force recovery week, check for overtraining";
  } else if (signals >= 2) {
    return "Suggest recovery week or reduced volume";
  }
  return "Monitor closely";
}
```

---

### 5. Environmental Adaptations

#### `adjustForWeather()` - **LOCAL**

**Purpose**: Modify workout based on extreme weather conditions (heat, cold, air quality) to ensure safety and performance.

**Algorithm**:
1. Check temperature:
   - > 32°C (90°F) → reduce intensity by 1 RPE, suggest early/late timing
2. Check wind chill:
   - < 0°C → reduce duration by 20%, warn about warm-up
3. Check air quality (AQI):
   - > 150 → force indoor workout
4. Return adjustment with user-facing message

**Inputs**:
- `workout`: PlannedWorkout (today's scheduled workout)
- `weather`: WeatherForecast (temperature, wind chill, AQI)

**Outputs**:
- `WorkoutAdjustment` (intensity/duration changes, indoor flag + message)

**Data Source**: Local weather cache (synced from weather API)

**Pseudocode**:
```dart
WorkoutAdjustment adjustForWeather({
  required PlannedWorkout workout,
  required WeatherForecast weather,
}) {
  // Extreme heat (> 90°F / 32°C)
  if (weather.temperature > 32) {
    return WorkoutAdjustment(
      intensityReduction: 1,
      message: "It's hot today - reduce intensity by 1 RPE. Consider early/late timing.",
    );
  }
  
  // Extreme cold (below freezing with wind chill)
  if (weather.windChill < 0) {
    return WorkoutAdjustment(
      durationReduction: 0.20,
      message: "Extreme cold - shorten duration and ensure proper warm-up.",
    );
  }
  
  // Poor air quality (AQI > 150)
  if (weather.aqi > 150) {
    return WorkoutAdjustment(
      moveIndoors: true,
      message: "Air quality is poor. Move all outdoor activity indoors.",
    );
  }
  
  return WorkoutAdjustment.none();
}
```

---

## Function Summary

| Function | Type | Purpose | Registry |
|----------|------|---------|----------|
| `processSleepData()` | LOCAL | Adjust workout based on sleep quality | [Link](../cross_cutting/function_registry.md#processsleepdata) |
| `processHeartRateData()` | LOCAL | Adjust workout based on RHR/HRV | [Link](../cross_cutting/function_registry.md#processheartratedata) |
| `detectSkipPattern()` | LOCAL | Analyze workout adherence patterns | [Link](../cross_cutting/function_registry.md#detectskippattern) |
| `detectBurnout()` | HYBRID | Identify mental fatigue and recommend intervention | [Link](../cross_cutting/function_registry.md#detectburnout) |
| `adjustForWeather()` | LOCAL | Modify workout for extreme weather | [Link](../cross_cutting/function_registry.md#adjustforweather) |
