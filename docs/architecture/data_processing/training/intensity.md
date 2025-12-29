# Intensity & RPE Management

> **Implements**: [Intensity & Zones](../../ux/product_spec/training/intensity.md)  
> **Data Models**: [Workouts](../data_models/_index.md)  
> **Dependencies**: [Load Management](../cross_cutting/load_mgmt.md)

**Purpose**: Calculate RPE zones, implement autoregulation, and adjust intensity based on biomarkers.

## RPE Zone Definitions

### Standard RPE Scale (1-10)

| RPE | Zone | Description | Use Case |
|-----|------|-------------|----------|
| 1-2 | Recovery | Very easy, conversational | Active recovery |
| 3-4 | Easy | Comfortable, can talk easily | Base building, long runs |
| 5-6 | Moderate | Somewhat hard, can talk in short sentences | Tempo runs, aerobic development |
| 7-8 | Hard | Hard effort, minimal talking | Intervals, threshold work |
| 9-10 | Max | All-out, cannot talk | Race pace, max efforts |

## Autoregulation Logic

### Daily Intensity Adjustment

```dart
int adjustRPEBasedOnBiomarkers({
  required int targetRPE,
  required Biomarkers biomarkers,
  required double acwr,
}) {
  int adjustment = 0;
  
  // Poor sleep adjustment
  if (biomarkers.sleepQuality < 6) {
    adjustment -= 1;
  }
  
  // Elevated RHR adjustment
  if (biomarkers.rhr > biomarkers.baselineRHR + 5) {
    adjustment -= 1;
  }
  
  // Low HRV adjustment
  if (biomarkers.hrv < biomarkers.baselineHRV * 0.85) {
    adjustment -= 1;
  }
  
  // High ACWR adjustment
  if (acwr > 1.3) {
    adjustment -= 1;
  }
  
  // Low motivation adjustment
  if (biomarkers.motivation < 4) {
    adjustment -= 1;
  }
  
  return (targetRPE + adjustment).clamp(1, 10);
}
```

### Workout Modification Based on RPE Adjustment

```dart
PlannedWorkout modifyWorkoutIntensity({
  required PlannedWorkout workout,
  required int rpeAdjustment,
}) {
  if (rpeAdjustment == 0) return workout;
  
  if (rpeAdjustment < 0) {
    // Reduce intensity
    workout.targetRPE = (workout.targetRPE + rpeAdjustment).clamp(1, 10);
    
    if (workout.type == 'intervals') {
      // Convert to tempo or easy run
      workout.type = workout.targetRPE <= 5 ? 'easy' : 'tempo';
    }
    
    // Reduce duration by 15-20%
    workout.duration = (workout.duration * 0.85).round();
  }
  
  return workout;
}
```

## Pace Zone Calculation

### Estimated Pace from RPE

```dart
double estimatePaceFromRPE({
  required int rpe,
  required double easyPace, // User's comfortable pace (min/km)
}) {
  // Easy pace (RPE 3-4) is the baseline
  Map<int, double> paceMultipliers = {
    1: 1.3,  // 30% slower than easy
    2: 1.2,  // 20% slower
    3: 1.0,  // Easy pace
    4: 1.0,
    5: 0.95, // 5% faster
    6: 0.90, // 10% faster
    7: 0.85, // 15% faster (tempo)
    8: 0.80, // 20% faster (threshold)
    9: 0.75, // 25% faster (intervals)
    10: 0.70, // 30% faster (race pace)
  };
  
  return easyPace * (paceMultipliers[rpe] ?? 1.0);
}
```

## Environmental Adjustments

### Weather-Based Intensity Modifications

```dart
int adjustRPEForWeather({
  required int targetRPE,
  required WeatherForecast weather,
}) {
  int adjustment = 0;
  
  // Extreme heat
  if (weather.temperature > 32) {
    adjustment -= 1;
  }
  
  // Poor air quality
  if (weather.aqi > 150) {
    adjustment -= 2; // Significant reduction
  }
  
  // Extreme cold with wind chill
  if (weather.windChill < 0) {
    adjustment -= 1;
  }
  
  return (targetRPE + adjustment).clamp(1, 10);
}
```

## Related Tools

| Tool | Purpose | Called In |
|------|---------|-----------|
| `adjust_intensity` | Scale workout difficulty | Daily check-in, biomarker-based |
| `calculate_pace_zones` | Generate pace targets | Plan generation |
| `check_weather` | Get forecast for adjustments | Daily training loop |

## 🗄️ Data Models

| Entity | Schema Definition |
|--------|-------------------|
| Workouts | [Workouts](../data_models/_index.md) |
| Biomarkers | [Biomarkers](../data_models/_index.md) |
