# Workout Logging & Completion

**User Goal**: Record a completed workout, provide feedback on intensity and pain, and receive AI coaching feedback to close the training loop.

**Source**: [`training/coaching.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/coaching.md), [`athlete_markers/injury_mgmt.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/athlete_markers/injury_mgmt.md), [`athlete_markers/biomarkers.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/athlete_markers/biomarkers.md)

**Journey Type**: Core Journey (Phase 2 - Training Loop)

---

## Entry Points
- **Manual (Priority)**: Tap on a planned workout card in [Today View](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/user_journeys/04_calendar_view.md#view-1-today-view-defaulthome), then tap "Log Workout" on the [Workout Detail Screen](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/user_journeys/04_calendar_view.md#workout-detail-screen).
- **Automatic (Phase 3+)**: App detects a new workout from Health Connect (Android) or HealthKit (iOS).
- **Retroactive**: Tap on a past workout card in [Weekly View](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/user_journeys/04_calendar_view.md#view-2-weekly-view-swipe-left-from-today).
- **Notification**: Tap "Workout detected! Tap here to review and log it." (Phase 3+)

---

## User Flow

### Step 1: Workout Review & Metric Input

**User Sees**:
- **Type-Specific Layout**: The input form varies based on the `Workout.type`:
  - **Running**: Fields for Distance (km/mi), Duration (hh:mm:ss), and optional Avg Heart Rate.
  - **Strength & Mobility**: Field for `actualDuration`.
- **Status Header**: "Great session! Let's log your stats."
- **Confirmation Button**: "Continue to Feedback"

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

## 🗺️ Feature Roadmap

Based on the user journey above, here is the phased implementation plan for the Workout Logging system.

### Phase 2: Core Training Loop (MVP)
*Goal: Enable manual logging and completion tracking.*

**Features**:
- [x] **Workout Detail Screen**: Full-screen view with conditional "Log Workout" today button.
- [x] **Simple RPE Picker**: 1-10 slider for subjective intensity measurement.
- [x] **Manual Data Entry**: Form for distance, duration, and pace.
- [x] **Dashboards Update**: Reflect completed status in Today and Weekly views.

**Model & Logic**:
- [x] **Workout Table**: Add `actualDistance`, `actualDuration`, `rpe`, `status`, `syncedFrom`, `actualPace`, `completedAt`.
- [x] **Operations**: `logWorkout(workoutId, ...)`, `watchWorkout(workoutId)`.
- [x] **Side Effects**: Increment `actualVolume` and `actualDuration` in `Phase` and `TrainingBlock` after logging.

### Phase 3: Intelligence & Safety
*Goal: Add Health APIs and safety logic.*

**Features**:
- [ ] **Health API Integration**: Passive sync for distance, duration, and HR.
- [ ] **Pain Check-In Flow**: Body-part selection and severity tracking (1-10).
- [ ] **AI Coaching Feedback**: Real-time evaluation of the workout.
- [ ] **Dynamic Adjustments**: "Compensate" logic based on load/pain.

**Model & Logic**:
- [ ] **PainRecord Table**: Add `id`, `workoutId`, `location`, `severity`, `trend`, `timestamp`.
- [ ] **Operations**: `reportPain(...)`, `getCoachingFeedback(workoutId)`.
- [ ] **Side Effects**: Trigger `recalculateLoad(userId)` for ACWR calculation.

### Phase 4: Polish & Robustness
*Goal: Eliminate friction and provide deep insights.*

**Features**:
- [ ] **Screenshot OCR Fallback**: Extact workout stats from uploaded images.
- [ ] **Pain Visualization**: Charts showing pain trends for specific body parts.
- [ ] **Post-Workout Recovery Advice**: Intensity-based mobility drills.
- [ ] **Weekly Summary Integration**: Aggregating completion data into progress recaps.
- [ ] **Workout Journaling**: Add `notes` field for qualitative session logs.

---

## 🛡️ Data Integrity & Side Effect Strategy

To ensure that `actualVolume` and `adherencePercentage` remain accurate even when workouts are edited, deleted, or retroactive-logged, we use a **Centralized Recalculation Pattern**:

### 1. Atomic Transactions
Every function that modifies a `Workout` (Create/Update/Delete/Log) MUST be wrapped in a database **Transaction**. This ensures that the workout change and the stat update succeed or fail together.

### 2. The `syncStatsForBlock(blockId)` Hook
Instead of manually incrementing/decrementing values (which leads to drift over time), the repository will trigger a full recalculation of the parent `TrainingBlock` and `Phase` whenever a child workout is touched.
- **Logic**: `SELECT sum(actualDistance), sum(actualDuration) FROM workouts WHERE block_id = ? AND status = 'completed'`
- **Trigger**: Called automatically within the transaction at the end of `logWorkout`, `deleteWorkout`, or `adjustWorkout`.

### 3. Reactive UI Updates
By using Drift's `watch` capabilities, the UI providers will automatically refresh the "Today" and "Weekly" views the moment the transaction commits. The user never has to "pull to refresh" to see their updated volume totals.

---

## Related Journeys
- **Before**: Journey #4 (Calendar) - Finding and starting the workout.
- **During**: Journey #12 (Screenshot Upload) - Fallback for sync issues.
- **After**: Journey #9 (Injury Mgmt) - If pain is reported.
- **After**: Journey #5 (Goal Progress) - Seeing the impact on goal trajectory.

---

**Last Updated**: 2025-12-30
