# Health & Injuries

This document defines the schema for tracking subjective health metrics, injuries, and performance benchmarks.

## 1. Biomarker

Tracks subjective health metrics (energy, sleep quality, stress, motivation).

> [!NOTE]
> **Pain is tracked separately**: All pain and injury tracking is handled by `InjuryRecords`. Biomarkers are for general health indicators that affect training readiness.

```dart
@DataClassName('Biomarker')
class Biomarkers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(UserProfiles, #id)();
  
  // Type
  TextColumn get biomarkerType => text()(); // 'energy', 'sleep_quality', 'stress', 'motivation'
  
  // Value
  IntColumn get value => integer()(); // 1-10 scale
  TextColumn get reason => text().nullable()(); // For motivation: 'tired', 'stressed', 'not_feeling_it', 'excited'
  TextColumn get notes => text().nullable()();
  
  // Context
  DateTimeColumn get recordedAt => dateTime()();
  IntColumn get relatedWorkoutId => integer().references(WorkoutLogs, #id).nullable()();
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

**Motivation Pattern Detection:**
When `biomarkerType = 'motivation'`, the Training Engine analyzes these logs to detect skip patterns, low motivation streaks, and burnout indicators.

---

## 2. Injury Record

Tracks all pain and injuries, from minor soreness to major issues, with lifecycle management.

> [!NOTE]
> **Handles all pain tracking**: This table tracks everything from transient soreness ("knee felt tight after run") to diagnosed injuries ("shin splints"). Minor issues can be quickly resolved, while persistent injuries are tracked long-term.

```dart
@DataClassName('InjuryRecord')
class InjuryRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(UserProfiles, #id)();
  
  // Injury Details
  TextColumn get injuryType => text()(); // 'soreness', 'tightness', 'knee_pain', 'shin_splints', 'it_band'
  TextColumn get location => text()(); // 'left_knee', 'right_ankle', 'hamstring'
  IntColumn get severityLevel => integer()(); // 1-10
  
  // Timeline
  DateTimeColumn get firstReportedAt => dateTime()();
  DateTimeColumn get lastReportedAt => dateTime()(); // Updated each time user reports
  DateTimeColumn get resolvedAt => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('active'))(); // 'active', 'recovering', 'resolved'
  
  // Impact
  TextColumn get affectedMovements => text().nullable()(); // JSON: ["running", "squats"]
  TextColumn get recommendedAlternatives => text().nullable()(); // JSON: ["cycling", "swimming"]
  
  // Context
  IntColumn get relatedWorkoutId => integer().references(WorkoutLogs, #id).nullable()(); // Workout that triggered initial report
  
  // Notes
  TextColumn get userNotes => text().nullable()();
  TextColumn get medicalAdvice => text().nullable()(); // From doctor/PT
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
```

---

## 3. Performance Snapshot

Stores periodic snapshots of performance metrics for plateau detection.

```dart
@DataClassName('PerformanceSnapshot')
class PerformanceSnapshots extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(UserProfiles, #id)();
  
  // Snapshot Details
  DateTimeColumn get snapshotDate => dateTime()();
  TextColumn get pillar => text()(); // 'running', 'strength', 'mobility'
  
  // Performance Metrics
  RealColumn get keyMetric => real()(); // Pace for running, weight for strength, etc.
  TextColumn get metricType => text()(); // 'avg_pace_5k', 'squat_1rm', 'flexibility_score'
  IntColumn get sampleSize => integer().withDefault(const Constant(1))(); // Number of workouts used to calculate this metric
  TextColumn get metricContext => text().nullable()(); // JSON: {"distance": "5K", "conditions": "flat_course", "avgHeartRate": 165}
  
  // Trend Analysis
  RealColumn get changeFromPrevious => real().nullable()(); // % change from last snapshot
  TextColumn get trendStatus => text()(); // 'improving', 'plateau', 'declining'
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

**Plateau Detection Logic:**
- Snapshots taken every 2-3 weeks
- Plateau = < 2% improvement over 3 consecutive snapshots
- Triggers intervention protocols (deload, variation, volume block)
