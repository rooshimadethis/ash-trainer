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

## Feature Breakdown by Phase

### Phase 1: MVP (Foundation) ✅ COMPLETE

#### Core Navigation & Views
- [x] **Three-view swipe navigation** (Today → Weekly → Monthly)
  - [x] Horizontal swipe gestures
  - [x] Smooth transitions between views
  - [x] Tab indicator in header
- [x] **Today View**
  - [x] Current date header with settings icon
  - [x] Today's workout card with type badge
  - [x] Workout details (duration, distance, intensity, description)
  - [x] "Log Workout" button (conditional on date)
  - [x] Goal progress widget (countdown card)
  - [x] Upcoming preview (next 2-3 days)
- [x] **Weekly View**
  - [x] Week range header with navigation
  - [x] 7-day horizontal scrollable grid
  - [x] Day cards with workout badges
  - [x] Status icons (completed, planned, missed)
  - [x] Week summary stats (volume, time, adherence)
- [x] **Monthly View**
  - [x] Month/year header with navigation
  - [x] 4-week summary grid (28 days)
  - [x] Mini workout badges per day
  - [x] Weekly volume totals
  - [x] Adherence indicators (color-coded)

#### Workout Detail Screen
- [x] **Modal presentation** (triggered from any workout card)
  - [x] Workout header (type, name, date, status)
  - [x] Full workout details (duration, distance, intensity, purpose)
  - [x] Sticky bottom action bar (conditional "Log Workout" button)
  - [x] Back navigation to previous view
- [x] **Workout logging integration**
  - [x] "Log Workout" button (only for today's workouts)
  - [x] Opens workout logging flow (Journey #3)
  - [x] Updates workout status to completed
  - [x] Records actuals (duration, distance, RPE, completedAt)
- [x] **Undo logging functionality**
  - [x] Confirmation dialog for already-completed workouts
  - [x] Reverts status from completed → planned
  - [x] Clears all actuals data
  - [x] Recalculates aggregate stats

#### Visual Design & Styling
- [x] **Modern UI aesthetics**
  - [x] Updated to modern blue brand color
  - [x] Consistent border radius (12px) across cards
  - [x] Premium typography and spacing
  - [x] Full-width buttons where appropriate
- [x] **Workout type color coding**
  - [x] Color-coded workout card backgrounds
  - [x] Color-coded workout card borders
  - [x] Circular status indicators (checkbox style)
  - [x] Consistent colors across all views
- [x] **Training block integration**
  - [x] Block color indicators above dates
  - [x] Block name display in exercise lists
  - [x] Block info badge with consistent styling
- [x] **Status visualization**
  - [x] Completed workouts appear grayed out
  - [x] Status icons (✓ completed, ○ planned)
  - [x] Visual distinction between states
- [x] **Calendar selection states**
  - [x] Orange text for current day (today)
  - [x] White border for selected day
  - [x] White text for selected tab in header
  - [x] No white tint on today (removed)

#### Data Integration
- [x] **Workout data display**
  - [x] Fetch workouts by date/range from database
  - [x] Display planned vs actual data
  - [x] Show workout status correctly
  - [x] Handle multiple workouts per day
- [x] **Training block data**
  - [x] Fetch blocks for date ranges
  - [x] Display block information with workouts
  - [x] Color-code by block phase
- [x] **Goal progress data**
  - [x] Active goal provider
  - [x] Goal stats calculation (total/completed workouts)
  - [x] Countdown to target date
  - [x] Real-time updates (not mock data)

#### Edge Cases (Basic)
- [x] **Rest days**: Show "Rest Day" card with appropriate styling
- [x] **Completed workouts**: Show checkmark and stats
- [x] **No active goal**: Handle gracefully (though startup flow prevents this)
- [x] **Empty days**: Display appropriately in calendar grids

---

### Phase 2: Enhanced Features (Next Priority)

#### Today View Enhancements
- [ ] **Daily check-in card**
  - [ ] "Good morning! How are you feeling today?" prompt
  - [ ] Quick check-in button
  - [ ] Integration with Journey #2 (Daily Check-In)
  - [ ] Conditional display (hide if already checked in)
- [ ] **Recovery widget** (MVP: Display raw health data only)
  - [x] Display HRV (Heart Rate Variability)
  - [x] Display sleep duration
  - [x] Display RHR (Resting Heart Rate)
  - [x] Auto-update when health data syncs
  - [x] "Connect Health Connect" prompt if no permissions
  
  **Implementation Details**: See [implementation_plan.md](file:///Users/rooshi/.gemini/antigravity/brain/447231aa-97e6-4495-9cc1-bd1d32f7ae60/implementation_plan.md)
  
  **Architecture References**:
  - **Data Model**: [Biomarkers Table](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/data_models/entities.md#table-biomarkers) - Stores sleep, HRV, RHR
  - **Repository**: [BiomarkerRepository](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/interfaces.md#biomarker-repository) - `watchTodaysBiomarkers()`, `saveBiomarkers()`
  - **Service**: [HealthService](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/architecture/interfaces.md#health-service) - `requestPermissions()`, `fetchTodaysHealthData()`
  
  **Key Components**:
  - `BiomarkerDao` - Database access with `watchTodaysBiomarkers()` stream
  - `HealthServiceImpl` - Integrates with `health` package for Health Connect/HealthKit
  - `SyncHealthData` use case - Auto-syncs on app open
  - `RecoveryWidget` - Displays metrics in Today View
  
  **Data Flow**: Health Connect → HealthService → SyncHealthData → BiomarkerRepository → Database → Stream → UI
  
- [ ] **Enhanced goal progress widget**
  - [ ] Confidence percentage with color coding
  - [ ] Mini trend sparkline
  - [ ] Tap to view goal detail screen (Journey #5)

#### Workout Detail Enhancements
- [ ] **Workout adjustments**
  - [ ] "Adjust" button for planned workouts
  - [ ] Adjustment dialog (modify duration/distance/intensity)
  - [ ] Save adjustments to database
- [ ] **Rescheduling**
  - [ ] "Reschedule" button
  - [ ] Date picker integration
  - [ ] Update scheduledDate in database
  - [ ] Recalculate plan if needed
- [ ] **Skip functionality**
  - [ ] "Skip" button with confirmation
  - [ ] Mark as intentional skip vs missed
  - [ ] Update plan adherence calculations
- [ ] **Related info display**
  - [ ] Weather forecast (for future workouts)
  - [ ] Previous similar workout stats (for comparison)
  - [ ] Warm-up/cool-down instructions (if applicable)

#### Weekly View Enhancements
- [ ] **Quick actions**
  - [ ] Long-press day card for quick menu
  - [ ] Quick reschedule option
  - [ ] Quick skip option
  - [ ] Duplicate workout option
- [ ] **Enhanced navigation**
  - [ ] Swipe left/right on week grid to navigate weeks
  - [ ] Smooth week-to-week transitions
  - [ ] Week number display (e.g., "Week 3 of 12")

#### Monthly View Enhancements
- [ ] **Monthly stats panel**
  - [ ] Total distance this month
  - [ ] Total workouts completed
  - [ ] Average adherence percentage
  - [ ] Longest run/workout
- [ ] **Race day highlighting**
  - [ ] Special badge for race days
  - [ ] Visual prominence in calendar
- [ ] **Time off periods**
  - [ ] Clear visualization of scheduled time off
  - [ ] "Time Off" badge on affected days

#### Edge Cases (Enhanced)
- [ ] **Workout in progress**: Show "Resume Workout" button
- [ ] **Past workout not logged**: Prompt to log retroactively
- [ ] **Workout conflicts with time off**: Show warning
- [ ] **Missed workouts**: Show "Missed workout" with reschedule option
- [ ] **First week/month of plan**: Disable "previous" navigation appropriately
- [ ] **Future weeks**: Disable "complete" actions, show as planned only
- [ ] **Empty weeks**: Show "No workouts scheduled" with "Add workout" option

---

### Phase 3: Advanced Features (Future)

#### Performance & Offline
- [ ] **Performance optimization**
  - [ ] Today View loads in <1 second
  - [ ] Weekly/Monthly views load in <2 seconds
  - [ ] Lazy loading for large date ranges
  - [ ] Image/data caching
- [ ] **Offline support**
  - [ ] Show cached data when offline
  - [ ] Offline indicator in UI
  - [ ] Sync when connection restored
  - [ ] Queue actions for later sync

#### Advanced Interactions
- [ ] **Notification deep links**
  - [ ] Deep link to specific workout from notification
  - [ ] Navigate to correct view (Today/Weekly/Monthly)
  - [ ] Highlight target workout
- [ ] **Gesture enhancements**
  - [ ] Pull-to-refresh on all views
  - [ ] Haptic feedback on swipes
  - [ ] Smooth scroll physics tuning
- [ ] **Accessibility**
  - [ ] Screen reader support
  - [ ] Color-blind friendly palette
  - [ ] Adjustable text sizes
  - [ ] High contrast mode

#### Analytics & Insights
- [ ] **Detailed analytics** (from monthly stats tap)
  - [ ] Trend charts (volume over time)
  - [ ] Adherence patterns
  - [ ] Workout type distribution
  - [ ] Personal records tracking
- [ ] **Smart suggestions**
  - [ ] AI-suggested workout adjustments
  - [ ] Recovery-based recommendations
  - [ ] Weather-based suggestions

#### Integration Features
- [ ] **Time off scheduling** (Journey #11)
  - [ ] Long-press calendar to schedule time off
  - [ ] Adjust plan around time off
  - [ ] Visual indication in all views
- [ ] **Health data integration**
  - [ ] Apple Health / Google Fit sync
  - [ ] Auto-populate biomarkers
  - [ ] Real-time recovery scores
- [ ] **Weather integration**
  - [ ] Forecast display in workout details
  - [ ] Weather-based workout suggestions
  - [ ] Outdoor safety alerts

---

### Implementation Notes

**Phase 1 Status**: ✅ **COMPLETE** (as of 2025-12-30)
- All core navigation, views, and workout detail functionality implemented
- Modern UI styling with color-coding and status indicators complete
- Data integration with database fully functional
- Workout logging and undo logging working correctly
- Training block integration complete

**Phase 2 Priority**: 
1. Daily check-in card (depends on Journey #2)
2. Recovery widget (depends on health data integration)
3. Workout adjustment/rescheduling functionality
4. Enhanced goal progress widget (depends on Journey #5)

**Phase 3 Considerations**:
- Performance optimization should be continuous
- Offline support is critical for runners (high priority within Phase 3)
- Analytics features depend on sufficient historical data
- Integration features depend on external APIs and services

---

**Last Updated**: 2025-12-30
