# Time Constraints Feature

**Status**: FUTURE FEATURE - Not implementing in initial release  
**Created**: 2025-12-30  
**Priority**: LOW - Nice to have, but adds onboarding complexity

---

## Overview

Allow users to specify different time constraints for different days of the week, enabling more realistic workout scheduling that accounts for varying daily schedules.

## Problem Statement

Currently, users can only specify which days they're available for training, but not how much time they have on each day. This leads to:
- Workouts scheduled on busy weekdays that are too long
- Underutilization of weekend time when users have more availability
- Frustration when workouts don't fit into actual available time slots

## Proposed Solution

### User Experience

Add a "Time Availability" screen during onboarding (after day selection) where users can:
1. Set default weekday duration (e.g., 60 minutes)
2. Set default weekend duration (e.g., 90 minutes)
3. Optionally override specific days (e.g., "Wednesdays I only have 45 minutes")

### UI Mockup (Text Description)

```
┌─────────────────────────────────────┐
│  How much time do you have?         │
├─────────────────────────────────────┤
│                                     │
│  Weekdays (Mon-Fri)                 │
│  [  60  ] minutes                   │
│                                     │
│  Weekends (Sat-Sun)                 │
│  [  90  ] minutes                   │
│                                     │
│  ☐ Customize specific days          │
│                                     │
│  [Back]              [Next]         │
└─────────────────────────────────────┘
```

If "Customize specific days" is checked:
```
┌─────────────────────────────────────┐
│  Customize Time by Day              │
├─────────────────────────────────────┤
│  Monday      [  60  ] min           │
│  Tuesday     [  60  ] min           │
│  Wednesday   [  45  ] min ← edited  │
│  Thursday    [  60  ] min           │
│  Friday      [  60  ] min           │
│  Saturday    [  90  ] min           │
│  Sunday      [  90  ] min           │
│                                     │
│  [Back]              [Next]         │
└─────────────────────────────────────┘
```

---

## Data Model

### User Entity Extension

```dart
class User {
  // ... existing fields ...
  
  // Time constraints
  final Map<String, int> timeConstraints; // minutes per day type
  
  // Example:
  // {
  //   'weekday': 60,
  //   'weekend': 90,
  //   'Monday': 60,
  //   'Wednesday': 45,  // override
  //   'Saturday': 120   // override
  // }
}
```

### Database Schema

```dart
class Users extends Table {
  // ... existing columns ...
  
  TextColumn get timeConstraints => text().nullable()(); // JSON map
}
```

---

## AI Integration

### Context Building

```dart
// In BuildPlanGenerationContext
final timeConstraints = user.timeConstraints ?? {
  'weekday': 60,
  'weekend': 90,
};

// Pass to AI
context['user']['timeConstraints'] = timeConstraints;
```

### AI Prompt Enhancement

```markdown
**Time Constraints**:
User has the following time availability:
- Weekdays: 60 minutes
- Weekends: 90 minutes
- Wednesday override: 45 minutes

Ensure NO workout exceeds the available time for its scheduled day.
If a key workout (e.g., long run) requires more time than available, suggest:
1. Moving it to a day with more time
2. Splitting it across multiple days
3. Adjusting the workout to fit the constraint
```

---

## Implementation Notes

### Phase 1: Basic Implementation
1. Add UI screen to onboarding flow
2. Store time constraints in User entity
3. Pass to AI context during plan generation
4. AI uses constraints to schedule workouts appropriately

### Phase 2: Advanced Features
1. **Smart Defaults**: Infer time constraints from user's goal and experience level
2. **Dynamic Adjustment**: Allow users to update time constraints mid-plan
3. **Conflict Detection**: Warn if time constraints make goal unrealistic
4. **Calendar Integration**: Sync with device calendar to detect busy days

---

## Why Deferred?

1. **Onboarding Complexity**: Adds another screen and decision point
2. **Diminishing Returns**: Most users have consistent schedules (weekday vs. weekend is usually enough)
3. **Workaround Exists**: Users can manually adjust workouts after plan generation
4. **AI Can Infer**: AI can make reasonable assumptions based on goal type and day of week

---

## Future Considerations

- **Integration with Calendar**: Auto-detect busy days from device calendar
- **Time of Day**: Not just duration, but preferred workout times (morning/evening)
- **Seasonal Variation**: Different constraints for different times of year

---

## Related Documentation

- [AI Context Gap Analysis](../../TODO/ai_context_gap_analysis.md) - Where this feature was identified
- [Onboarding User Journey](../user_journeys/01_onboarding_goal_setup.md) - Current onboarding flow
- [User Data Model](../../architecture/data_models/_index.md) - User entity definition
