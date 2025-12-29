# System & Audit Logs

This document defines schema elements for system-level tracking, including the Action Log for AI decision tracking and undo functionality.

## 1. Action Log

Tracks all AI actions with snapshot-based undo support.

> [!NOTE]
> **Time-Limited Undo**: Users can undo AI actions within a short time window (30 seconds for minor changes, 5 minutes for major changes). This prevents conflicts from later modifications while handling immediate regret scenarios.

```dart
@DataClassName('ActionLog')
class ActionLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer().references(UserProfiles, #id)();
  
  // Action Details
  TextColumn get actionType => text()(); // 'reschedule_workout', 'adjust_intensity', 'create_injury', 'adjust_goal'
  TextColumn get impact => text()(); // 'minor', 'major'
  TextColumn get triggeredBy => text()(); // 'ai', 'user', 'system'
  TextColumn get reason => text().nullable()(); // "User reported knee pain"
  
  // Snapshot (JSON)
  TextColumn get beforeState => text()(); // JSON snapshot of affected records before change
  TextColumn get afterState => text()(); // JSON snapshot after change
  TextColumn get affectedRecords => text()(); // JSON: [{"table": "PlannedWorkouts", "ids": [1,2,3]}]
  
  // Undo Support
  DateTimeColumn get undoExpiresAt => dateTime()(); // createdAt + (30s for minor, 5min for major)
  BoolColumn get wasUndone => boolean().withDefault(const Constant(false))();
  DateTimeColumn get undoneAt => dateTime().nullable()();
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

**Undo Time Windows:**
- **Minor actions** (adjust intensity, swap workout type): 30 seconds
- **Major actions** (reschedule week, adjust goal, create injury): 5 minutes

**Example Usage:**
```dart
// Log action with snapshot
final log = ActionLog(
  actionType: 'reschedule_workouts',
  impact: 'major',
  triggeredBy: 'ai',
  reason: 'User scheduled vacation',
  beforeState: jsonEncode({
    'workouts': [
      {'id': 1, 'date': '2024-01-15', 'type': 'tempo'},
      {'id': 2, 'date': '2024-01-16', 'type': 'long_run'}
    ]
  }),
  afterState: jsonEncode({
    'workouts': [] // Cleared for vacation
  }),
  affectedRecords: jsonEncode([
    {'table': 'PlannedWorkouts', 'ids': [1, 2]}
  ]),
  undoExpiresAt: DateTime.now().add(Duration(minutes: 5))
);
```
