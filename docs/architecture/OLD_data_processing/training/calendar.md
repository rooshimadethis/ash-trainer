# Calendar & Schedule Management

> **Implements**: [Calendar](../../ux/product_spec/training/calendar.md)  
> **Data Models**: [Workouts](../data_models/_index.md), [Goals](../data_models/_index.md)  
> **Dependencies**: [Pillar Coordination](../cross_cutting/pillar_coordination.md)

**Purpose**: Manage workout scheduling, resolve conflicts, and handle rescheduling logic.

## Schedule Conflict Resolution

### 48-Hour Rule Validation

```dart
bool validate48HourRule({
  required PlannedWorkout workout,
  required DateTime newDate,
  required List<PlannedWorkout> existingWorkouts,
}) {
  // Find workouts within 48 hours of new date
  List<PlannedWorkout> nearbyWorkouts = existingWorkouts.where((w) {
    int hoursDiff = newDate.difference(w.date).inHours.abs();
    return hoursDiff <= 48 && w.pillar == workout.pillar;
  }).toList();
  
  // Check if any are high intensity
  bool hasConflict = nearbyWorkouts.any((w) => 
    w.targetRPE >= 7 || workout.targetRPE >= 7
  );
  
  return !hasConflict;
}
```

### Cross-Pillar Conflict Detection

```dart
bool validateCrossPillarConflict({
  required PlannedWorkout workout,
  required DateTime newDate,
  required List<PlannedWorkout> existingWorkouts,
}) {
  // Check for hard leg strength before key run
  if (workout.pillar == 'running' && workout.isKeySession) {
    PlannedWorkout? previousDay = existingWorkouts.firstWhereOrNull(
      (w) => w.date == newDate.subtract(Duration(days: 1))
    );
    
    if (previousDay?.pillar == 'strength' && 
        previousDay?.type == 'lower_body' && 
        previousDay?.targetRPE >= 7) {
      return false; // Conflict: hard leg day before key run
    }
  }
  
  return true;
}
```

## Rescheduling Logic

### Automatic Rescheduling

```dart
DateTime? findBestRescheduleDate({
  required PlannedWorkout workout,
  required DateTime preferredDate,
  required List<PlannedWorkout> existingWorkouts,
  required List<TimeOffDay> timeOffDays,
}) {
  // Try preferred date first
  if (isDateAvailable(preferredDate, existingWorkouts, timeOffDays) &&
      validate48HourRule(workout, preferredDate, existingWorkouts) &&
      validateCrossPillarConflict(workout, preferredDate, existingWorkouts)) {
    return preferredDate;
  }
  
  // Try next 7 days
  for (int i = 1; i <= 7; i++) {
    DateTime candidate = preferredDate.add(Duration(days: i));
    
    if (isDateAvailable(candidate, existingWorkouts, timeOffDays) &&
        validate48HourRule(workout, candidate, existingWorkouts) &&
        validateCrossPillarConflict(workout, candidate, existingWorkouts)) {
      return candidate;
    }
  }
  
  return null; // No suitable date found
}
```

### Vacation Block Handling

```dart
bool isDateAvailable({
  required DateTime date,
  required List<PlannedWorkout> existingWorkouts,
  required List<TimeOffDay> timeOffDays,
}) {
  // Check if date is during time off
  bool isDuringTimeOff = timeOffDays.any((timeOff) =>
    date.isAfter(timeOff.startDate.subtract(Duration(days: 1))) &&
    date.isBefore(timeOff.endDate.add(Duration(days: 1)))
  );
  
  if (isDuringTimeOff) return false;
  
  // Check if date already has a workout
  bool hasExistingWorkout = existingWorkouts.any((w) => 
    w.date.year == date.year && 
    w.date.month == date.month && 
    w.date.day == date.day
  );
  
  return !hasExistingWorkout;
}
```

## Calendar View Generation

### Week View Data

```dart
WeekView generateWeekView({
  required DateTime weekStart,
  required List<PlannedWorkout> workouts,
  required List<WorkoutLog> completedWorkouts,
  required List<RaceEvent> events,
}) {
  List<DayView> days = [];
  
  for (int i = 0; i < 7; i++) {
    DateTime day = weekStart.add(Duration(days: i));
    
    PlannedWorkout? planned = workouts.firstWhereOrNull(
      (w) => isSameDay(w.date, day)
    );
    
    WorkoutLog? completed = completedWorkouts.firstWhereOrNull(
      (w) => isSameDay(w.startTime, day)
    );
    
    RaceEvent? event = events.firstWhereOrNull(
      (e) => isSameDay(e.date, day)
    );
    
    days.add(DayView(
      date: day,
      plannedWorkout: planned,
      completedWorkout: completed,
      event: event,
    ));
  }
  
  return WeekView(days: days);
}
```

## Related Tools

| Tool | Purpose | Called In |
|------|---------|-----------|
| `reschedule_workout` | Move workout to new date | User action or AI suggestion |
| `find_available_dates` | Get list of open dates | Rescheduling flow |
| `validate_schedule` | Check for conflicts | Before saving changes |

## 🗄️ Data Models

| Entity | Schema Definition |
|--------|-------------------|
| Workouts | [Workouts](../data_models/_index.md) |
| Time Off | [Goals](../data_models/_index.md) |
