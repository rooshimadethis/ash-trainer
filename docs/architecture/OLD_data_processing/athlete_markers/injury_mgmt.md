# Injury Management & Pain Response

> **Implements**: [Injury Management](../../ux/product_spec/athlete_markers/injury_mgmt.md)  
> **Data Models**: [Injuries](../data_models/_index.md)  
> **Dependencies**: [Load Management](../cross_cutting/load_mgmt.md)

**Purpose**: Track pain and injuries, implement response algorithms, and trigger training modifications.

## Pain Tracking & Lifecycle Management

### Injury Severity Classification

| Severity | Description | Response |
|----------|-------------|----------|
| 1-2 | Minor soreness, no impact on movement | Monitor, no adjustment |
| 3-4 | Noticeable discomfort, slight impact | Reduce intensity, modify exercises |
| 5-6 | Moderate pain, affects performance | Swap activities, reduce volume |
| 7-8 | Significant pain, limits movement | Force rest, suggest medical consultation |
| 9-10 | Severe pain, cannot perform activity | Immediate rest, medical attention required |

### Pain Response Algorithm

```dart
InjuryResponse processPainReport({
  required String location,
  required int severity,
  required String type, // 'soreness', 'sharp', 'dull', 'chronic'
  required List<PlannedWorkout> upcomingWorkouts,
}) {
  if (severity <= 2) {
    return InjuryResponse(
      action: 'monitor',
      message: "Minor soreness noted. Let me know if it gets worse.",
    );
  }
  
  if (severity >= 3 && severity <= 4) {
    return InjuryResponse(
      action: 'modify',
      workoutAdjustments: _getModifications(location, upcomingWorkouts),
      message: "Let's modify your workouts to avoid aggravating this.",
    );
  }
  
  if (severity >= 5 && severity <= 6) {
    return InjuryResponse(
      action: 'swap',
      workoutAdjustments: _swapActivities(location, upcomingWorkouts),
      message: "Let's swap to activities that won't stress your $location.",
    );
  }
  
  if (severity >= 7) {
    return InjuryResponse(
      action: 'rest',
      clearWorkouts: true,
      medicalFlag: true,
      message: "This sounds serious. Please rest and consider seeing a medical professional.",
    );
  }
  
  return InjuryResponse.none();
}
```

### Injury Lifecycle States

```dart
enum InjuryStatus {
  active,      // Currently experiencing pain
  recovering,  // Pain decreasing, modified training
  resolved,    // No pain for 7+ days
}

void updateInjuryStatus(InjuryRecord injury, int newSeverity) {
  if (newSeverity == 0 && injury.daysSinceLastReport >= 7) {
    injury.status = InjuryStatus.resolved;
    injury.resolvedAt = DateTime.now();
  } else if (newSeverity < injury.previousSeverity) {
    injury.status = InjuryStatus.recovering;
  } else {
    injury.status = InjuryStatus.active;
  }
}
```

## Training Modifications by Injury Location

### Common Running Injuries

```dart
Map<String, List<String>> getInjuryModifications(String location) {
  return {
    'knee': [
      'Reduce running volume by 30-50%',
      'Avoid hills and stairs',
      'Add single-leg strength work',
      'Increase hip mobility focus',
      'Consider swimming or cycling',
    ],
    'achilles': [
      'Reduce running volume by 50%',
      'Avoid speed work and hills',
      'Add calf strengthening (eccentric)',
      'Increase ankle mobility',
      'Consider pool running',
    ],
    'shin': [
      'Reduce impact activities',
      'Avoid hard surfaces',
      'Add tibialis strengthening',
      'Increase calf flexibility',
      'Consider cycling or swimming',
    ],
    'hip': [
      'Reduce running volume',
      'Add hip strengthening (glute med focus)',
      'Increase hip mobility',
      'Avoid long runs temporarily',
      'Consider elliptical or cycling',
    ],
  }[location] ?? ['Reduce volume', 'Monitor closely'];
}
```

## ACWR-Based Injury Risk

### Integration with Load Management

```dart
InjuryRisk assessInjuryRisk({
  required double acwr,
  required List<InjuryRecord> activeInjuries,
  required GoalType goalType,
}) {
  // Get ACWR thresholds for goal type
  ACWRThresholds thresholds = getACWRThresholds(goalType);
  
  String riskLevel;
  if (acwr < thresholds.safeMin) {
    riskLevel = 'detraining';
  } else if (acwr >= thresholds.safeMin && acwr <= thresholds.safeMax) {
    riskLevel = 'safe';
  } else if (acwr > thresholds.safeMax && acwr <= 1.5) {
    riskLevel = 'moderate';
  } else {
    riskLevel = 'high';
  }
  
  // Increase risk if active injuries present
  if (activeInjuries.isNotEmpty && riskLevel != 'safe') {
    riskLevel = 'high';
  }
  
  return InjuryRisk(
    level: riskLevel,
    acwr: acwr,
    activeInjuries: activeInjuries.length,
    recommendation: _getRiskRecommendation(riskLevel),
  );
}
```

## Post-Training Pain Check-In

### Proactive Pain Tracking

```dart
void triggerPostWorkoutPainCheckIn(WorkoutLog completedWorkout) {
  // Wait 2-4 hours after workout
  DateTime checkInTime = completedWorkout.endTime.add(Duration(hours: 3));
  
  scheduleNotification(
    time: checkInTime,
    message: "How are you feeling after your ${completedWorkout.type}? Any pain or discomfort?",
    options: [
      "Feeling great!",
      "Some soreness (normal)",
      "Noticeable pain (need to report)",
    ],
  );
}
```

## Related Tools

| Tool | Purpose | Called In |
|------|---------|-----------|
| `report_pain` | Track pain/injury | User-initiated or post-workout check-in |
| `modify_for_injury` | Adjust workouts | After pain report |
| `check_injury_status` | Update injury lifecycle | Background analysis |

## 🗄️ Data Models

| Entity | Schema Definition |
|--------|-------------------|
| Injuries | [Injuries](../data_models/_index.md) |
| Workouts | [Workouts](../data_models/_index.md) |
