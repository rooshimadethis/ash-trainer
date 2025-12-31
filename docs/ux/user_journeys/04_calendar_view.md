# Calendar View & Plan Overview

**User Goal**: See upcoming workouts and training plan at a glance across different time horizons

**Source**: [`training/calendar.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/calendar.md)

**Journey Type**: Core Journey (Phase 1 - Foundation)

---

## Entry Points
- App launch (default view is Today)
- Swipe gestures from any of the three views
- Notification deep link to specific workout
- Bottom navigation "Home" tab

## User Flow

### Core Navigation Pattern

The calendar uses a **horizontal swipe navigation** with three views:
- **Center (Default)**: Today View
- **Swipe Left Once**: Weekly View  
- **Swipe Left Twice**: Monthly View
- **Swipe Right**: Navigate back through views

---

### View 1: Today View (Default/Home)

**User Sees**:
- **Header**:
  - Current date (e.g., "Monday, Dec 29")
  - Settings icon
- **Check-In Card** (if not checked in yet):
  - "Good morning! How are you feeling today?" 
  - Quick check-in button
- **Today's Workout Card**:
  - Workout type badge (color-coded)
  - Workout name (e.g., "Easy Run")
  - Duration and distance
  - Intensity (Zone 2, RPE 5-6, etc.)
  - Purpose/description (e.g., "Build aerobic base")
  - "Start Workout" button
  - "Adjust" option
- **Recovery Widget**:
  - Recovery score (if health data available)
  - Sleep quality indicator
  - HRV trend
- **Goal Progress Widget**:
  - Active goal name
  - Confidence percentage with color
  - Mini trend sparkline
  - Tap to view details
- **Upcoming Preview**:
  - Next 2-3 days of workouts (mini cards)
  - Swipe left hint: "→ See your week"

**User Can**:
- Tap "Check-In" → Opens daily check-in flow (Journey #2)
- Tap "Start Workout" → Opens workout tracking (Journey #3)
- Tap "Adjust" → Opens workout adjustment dialog
- Tap Recovery Widget → Opens biomarker details (Journey #10)
- Tap Goal Progress → Opens goal detail screen (Journey #5)
- Tap upcoming workout → Opens **Workout Detail Screen**
- Swipe left → Goes to Weekly View
- Tap Settings → Opens settings screen

**Data Displayed**:
- `User.name` (for greeting)
- `Workout` for today (from `Workouts` table where `scheduledDate` = today)
  - `type`, `plannedDuration`, `plannedDistance`, `intensity`, `description`
- `Biomarkers` latest (sleep, HRV, RHR)
- `Goal.confidence`, `Goal.name`
- `Workouts[]` for next 2-3 days

**Data Collected**:
- None (display only)

**Edge Cases**:
- **No workout scheduled today**: Show "Rest Day 🧘" card with recovery tips
- **Workout already completed**: Show completion checkmark, stats, and "Log another workout?" option
- **Workout skipped**: Show "Missed workout" with option to reschedule or mark as intentional skip
- **No active goal**: Show "Set a goal" CTA
- **No health data**: Hide recovery widget or show "Connect health data" prompt
- **Offline**: Show cached data with offline indicator

---

### View 2: Weekly View (Swipe Left from Today)

**User Sees**:
- **Header**:
  - Week range (e.g., "Dec 23 - Dec 29")
  - Week number (e.g., "Week 3 of 12")
  - Navigation arrows (previous/next week)
- **Horizontal Scrollable Week**:
  - 7 day cards (Mon-Sun)
  - Each card shows:
    - Day name and date
    - Workout badge (color-coded by type)
    - Status icon (✓ completed, ○ planned, ✗ missed)
    - Duration (e.g., "45 min")
    - Distance (e.g., "8K")
- **Week Summary Stats** (bottom):
  - Total volume (e.g., "25 km across 4 runs")
  - Total time (e.g., "3 hours 15 min")
  - Adherence percentage (e.g., "75% complete")
- **Swipe Hints**:
  - "← Today" (swipe right)
  - "Monthly →" (swipe left)

**User Can**:
- Tap any day card → Opens **Workout Detail Screen**
- Swipe left/right on week → Navigate to previous/next week
- Tap week navigation arrows → Jump weeks
- Swipe right → Goes back to Today View
- Swipe left → Goes to Monthly View
- Long-press day → Quick actions (reschedule, skip, duplicate)

**Data Displayed**:
- `Workouts[]` for current week (7 days)
  - `scheduledDate`, `type`, `plannedDuration`, `plannedDistance`, `status`
- `TrainingBlock.blockNumber` (if using periodization)
- Computed: Total volume, total time, adherence %

**Data Collected**:
- None (display only)

**Edge Cases**:
- **First week of plan**: No "previous week" navigation
- **Future weeks**: Show planned workouts, disable "complete" actions
- **Past weeks**: Show completed/missed status
- **Week with time off**: Show "Time Off" badge on affected days
- **Empty week**: Show "No workouts scheduled" with "Add workout" option

---

### View 3: Monthly View (Swipe Left from Weekly)

**User Sees**:
- **Header**:
  - Month and year (e.g., "December 2025")
  - Navigation arrows (previous/next month)
- **4-Week Summary Grid**:
  - Shows last week + current week + next 2 weeks (28 days total)
  - Each week row shows:
    - Week number (e.g., "Week 3")
    - Mini workout badges (dots/icons for each day)
    - Total volume for week (e.g., "25 km")
    - Adherence indicator (color-coded: green >80%, yellow 60-80%, red <60%)
- **Monthly Stats** (bottom):
  - Total distance this month
  - Total workouts completed
  - Average adherence
  - Longest run
- **Swipe Hints**:
  - "← Weekly" (swipe right)

**User Can**:
- Tap any week row → Jumps to that week in Weekly View
- Tap month navigation arrows → Jump months
- Swipe right → Goes back to Weekly View
- Tap monthly stats → Opens detailed analytics (future feature)

**Data Displayed**:
- `Workouts[]` for 4-week range (28 days)
  - Aggregated by week: total volume, adherence %
- `TrainingBlock[]` for the month
- Computed: Monthly totals, averages, longest run

**Data Collected**:
- None (display only)

**Edge Cases**:
- **First month of training**: Limited historical data
- **Month with race**: Highlight race day with special badge
- **Month with time off**: Show time off periods clearly
- **Future months**: Show projected plan (if generated)

---

## Workout Detail Screen

**Triggered by**: Tapping any workout card from any view

**User Sees**:
- **Navigation Bar**:
  - Back button (always present)
- **Workout Header**:
  - Workout type and name
  - Scheduled date and time
  - Status (planned, completed, missed)
- **Workout Details**:
  - Duration and distance
  - Intensity (zone, RPE, pace)
  - Purpose/description
  - Warm-up/cool-down instructions (if applicable)
- **Sticky Bottom Action Bar** (Conditional):
  - **IF Scheduled for TODAY**: "Log Workout" button
  - **ELSE**: No action button (Back button in nav is the only exit)
- **Related Info**:
  - Weather forecast (if future workout)
  - Previous similar workout stats (for comparison)

**User Can**:
- Tap "Log Workout" (if today) → Opens workout logging flow (Journey #3)
- Tap Back button → Returns to previous calendar view
- Tap "Adjust" (if today/planned) → Opens adjustment dialog
- Tap "Reschedule" → Opens date picker
- Tap "Skip" → Confirms skip, updates plan

**Data Displayed**:
- Full `Workout` record
- Weather data (if integrated)
- Historical `Workouts` of same type (for comparison)

**Data Collected**:
- Workout adjustments (if modified)
- Reschedule date (if rescheduled)

**Edge Cases**:
- **Workout in progress**: Show "Resume Workout" instead of "Start"
- **Past workout, not logged**: Prompt to log retroactively
- **Workout conflicts with time off**: Show warning

---

## Exit Points

### Primary Exits:
- **Daily Check-In Flow** (Journey #2) - From Today View check-in card
- **Workout Tracking** (Journey #3) - From "Start Workout" button
- **Goal Detail Screen** (Journey #5) - From goal progress widget
- **Settings** - From settings icon

### Alternative Exits:
- **Workout Adjustment Dialog** - From "Adjust" option
- **Biomarker Details** (Journey #10) - From recovery widget
- **Time Off Scheduling** (Journey #11) - From calendar long-press

---

## Success Criteria
- [ ] User can navigate between all three views smoothly
- [ ] Swipe gestures are intuitive and responsive
- [ ] All workout data displays correctly with proper status
- [ ] Today View loads in <1 second
- [ ] Weekly/Monthly views load in <2 seconds
- [ ] Offline mode shows cached data
- [ ] Color coding is consistent and accessible
- [ ] Edge cases (rest days, time off, missed workouts) are handled gracefully

---

## Data Model Requirements

### Workout Table
- `id` (primary key)
- `userId` (foreign key)
- `goalId` (foreign key)
- `scheduledDate` (date)
- `type` (enum: easy_run, tempo, intervals, long_run, rest, strength, mobility)
- `plannedDuration` (duration)
- `plannedDistance` (number, nullable)
- `intensity` (text: "Zone 2", "RPE 5-6", etc.)
- `description` (text: purpose/instructions)
- `status` (enum: planned, in_progress, completed, skipped, missed)
- `actualDuration` (duration, nullable)
- `actualDistance` (number, nullable)
- `rpe` (number, 1-10, nullable)
- `completedAt` (timestamp, nullable)

### Training Block Table (for periodization)
- `id` (primary key)
- `goalId` (foreign key)
- `weekNumber` (number)
- `startDate` (date)
- `endDate` (date)
- `phase` (enum: base, build, peak, taper, recovery)
- `totalVolume` (number, computed)

### Biomarkers Table (for recovery widget)
- `id` (primary key)
- `userId` (foreign key)
- `date` (date)
- `sleepDuration` (duration, nullable)
- `sleepQuality` (number, 1-10, nullable)
- `hrv` (number, nullable)
- `rhr` (number, nullable)

### Goal Table (for progress widget)
- `id` (primary key)
- `userId` (foreign key)
- `name` (text)
- `confidence` (number, 0-100)
- `isActive` (boolean)

---

## Related Journeys
- **Before**: Journey #1 (Onboarding) - Creates first workouts
- **After**: 
  - Journey #2 (Daily Check-In) - Accessed from Today View
  - Journey #3 (Workout Logging) - Accessed from workout cards
  - Journey #5 (Goal Progress) - Accessed from progress widget
- **Alternative**: 
  - Journey #11 (Time Off) - Accessed from calendar long-press

---

## Notes
- **Navigation is key**: Swipe gestures must be smooth and intuitive
- **Today View is home**: Most users will spend 80% of time here
- **Weekly View for planning**: Users check upcoming week
- **Monthly View for overview**: Less frequent, but important for long-term perspective
- **Color coding**: Consistent across all views (see product spec for color scheme)
- **Performance**: Today View must be fast (primary screen)
- **Offline support**: Critical for runners who train without connectivity

---

**Last Updated**: 2025-12-29
