# Workout Logging & Completion

**User Goal**: Record a completed workout, provide feedback on intensity and pain, and receive AI coaching feedback to close the training loop.

**Source**: [`training/coaching.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/coaching.md), [`athlete_markers/injury_mgmt.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/athlete_markers/injury_mgmt.md), [`athlete_markers/biomarkers.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/athlete_markers/biomarkers.md)

**Journey Type**: Core Journey (Phase 2 - Training Loop)

---

## Entry Points
- **Automatic**: App detects a new workout from Health Connect (Android) or HealthKit (iOS).
- **Manual**: Tap on a planned workout card in [Today View](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/user_journeys/04_calendar_view.md#view-1-today-view-defaulthome) and select "Log Workout".
- **Retroactive**: Long-press a past date in [Weekly View](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/user_journeys/04_calendar_view.md#view-2-weekly-view-swipe-left-from-today) and select "Log Past Workout".
- **Notification**: Tap "Workout detected! Tap here to review and log it."

---

## User Flow

### Step 1: Workout Review (The "Sync" Screen)

**User Sees**:
- **Status Header**: "Great run! Here's what we found..."
- **Data Cards**:
  - Distance (e.g., "8.2 km")
  - Duration (e.g., "45:12")
  - Pace/Intensity (e.g., "5:30 min/km")
  - Heart Rate avg (e.g., "152 bpm")
- **Sync Status**: 
  - "Linked to: Easy Run (Monday, Dec 29)"
  - Or: "Unlinked workout" (if no planned workout matches)
- **Falling Back**: "Not what you did? [Edit Manually] or [Upload Screenshot]"

**User Can**:
- **Confirm Data**: Advance to Step 2.
- **Edit Manually**: Opens manual entry form (overrides synced data).
- **Upload Screenshot**: (Journey #12) If sync failed or data is wrong.
- **Link/Unlink**: Choose which planned workout this completion maps to.

**Data Displayed**:
- `Workout.actualDistance`, `Workout.actualDuration` (from health data)
- `Workout.type` (matched via `scheduledDate` and proximity)

---

### Step 2: Subjective Feedback (RPE)

**User Sees**:
- **RPE Picker**: "How did that feel? (1-10 scale)"
  - 1: Very Easy / Recovery
  - 5-6: Moderate / Aerobic
  - 9: Very Hard / Max Effort
  - 10: Absolute Max
- **Quick Notes**: Text area "Any notes about the effort?"

**User Can**:
- **Slide/Tap**: Select RPE intensity.
- **Type**: Add qualitative notes.
- **Next**: Save and move to pain check.

**Data Collected**:
- `Workout.rpe` (1-10)
- `Workout.notes` (string)

---

### Step 3: Pain Check-In

**User Sees**:
- **Prompt**: "Any areas feeling sore or painful after that workout?"
- **Body Map/List**: Checkboxes for common areas (Knee, Ankle, Hip, Lower Back, Foot, Other).
- **Severity Picker** (if checkbox checked): 1-10 scale.
- **Progression** (if previous pain exists): "How is your [Knee] feeling compared to last time?" (Better | Same | Worse).

**User Can**:
- **Select Areas**: Mark any pain points.
- **Rate Severity**: Indicate intensity of pain.
- **Update Status**: Compare to previous report.

**Data Collected**:
- `PainRecord.location`, `PainRecord.severity`, `PainRecord.trend`

**Edge Case**:
- **No Pain**: User taps "Feeling Great!" → Skips detailed tracking.

---

### Step 4: AI Feedback & Next Steps

**User Sees**:
- **Ash's Message**:
  - **Success**: "Nailed it. You stayed right in Zone 2 as planned. Recovery is key now."
  - **Over-reaching**: "You pushed a bit harder than planned (RPE 8 vs planned 5). I'll adjust tomorrow's session to be lighter."
  - **Pain Alert**: "Ouch, that knee pain is a 4/10. I'm swapping your next run for a low-impact strengthening session."
- **Updated Stats**: Weekly volume progress bar, "X/Y km complete".
- **Next Up**: Preview of the next scheduled session.

**User Can**:
- **Tap "Done"**: Returns to [Today View](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/user_journeys/04_calendar_view.md).
- **Tap "View Trends"**: Goes to [Goal Progress](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/user_journeys/05_goal_progress.md).

**Data Displayed**:
- AI generated `CoachingResponse.message`
- Computed `Goal.progressPercentage`

---

## Exit Points
- **Home Screen (Today View)**: Goal progress updated, workout marked as completed (check icon).
- **Calendar View**: Historical data visible in past days.
- **Injury Management**: (Journey #9) If pain severity > 3, the user's status changes to "Compensating".

---

## Success Criteria
- [ ] Synced data is correctly associated with the correct planned workout.
- [ ] RPE is mandatory for closing the loop.
- [ ] Pain check-in triggers relevant AI adjustments to future workouts.
- [ ] User feels "heard" by Ash immediately after the work is done.
- [ ] Goal confidence percentage updates based on adherence.

---

## Data Model Requirements

### Workout Table Updates
- `actualDistance` (double)
- `actualDuration` (duration)
- `rpe` (int, 1-10)
- `notes` (string)
- `status` (enum: completed)
- `syncedFrom` (enum: health_kit, health_connect, manual, screenshot)

### PainRecord Table
- `id` (PK)
- `workoutId` (FK)
- `location` (enum/string)
- `severity` (int, 1-10)
- `trend` (enum: better, same, worse)
- `timestamp` (DateTime)

---

## Related Journeys
- **Before**: Journey #4 (Calendar) - Finding and starting the workout.
- **During**: Journey #12 (Screenshot Upload) - Fallback for sync issues.
- **After**: Journey #9 (Injury Mgmt) - If pain is reported.
- **After**: Journey #5 (Goal Progress) - Seeing the impact on goal trajectory.

---

**Last Updated**: 2025-12-30
