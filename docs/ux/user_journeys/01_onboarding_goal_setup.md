# Onboarding & Goal Setup

**User Goal**: Set up profile, choose first running goal, and receive a personalized Week 1 training plan

**Source**: [`lifecycle/onboarding_flow.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/lifecycle/onboarding_flow.md), [`training/goals.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/goals.md)

**Journey Type**: Core Journey (Phase 1 - Foundation)

> [!NOTE]
> **Design Change (2025-12-29)**: The "Training History" question has been removed from onboarding. Instead, the user's fitness level will be inferred from their baseline workout performance (Step 9: First Workout Prompt). This prevents misclassification of beginners who might be overtraining.

---

## Entry Points
- App first launch (new user)
- Account creation complete

## User Flow

### Step 1: Welcome Screen
**User Sees**:
- Ash branding and logo
- Welcome message: "Hey there! I'm Ash, your AI running coach 👋"
- Brief value proposition:
  - "Personalized training plans that adapt to YOU"
  - "Smart coaching that learns from every run"
  - "Your goals, your schedule, your pace"
- "Let's do this!" button

**User Can**:
- Tap "Get Started" → Goes to Step 2

**Data Displayed**:
- Static content (no user data yet)

**Data Collected**:
- None

**Edge Cases**:
- None (static screen)

---

### Step 2: Availability Screen
**User Sees**:
- Question: "When are you NOT available to train?"
- Weekly calendar with selectable days (Mon-Sun)
- Helper text: "Tap any days that are off-limits (work, family time, Netflix binges... we get it)"
- Progress indicator (Step 1 of 4)

**User Can**:
- Tap days to select/deselect unavailable days → Updates selection
- Tap "Next" → Goes to Step 3 (if at least 2 days remain available)
- Tap "Skip" → Goes to Step 3 (assumes all days available)
- Tap "Back" → Goes to Step 1

**Data Displayed**:
- None

**Data Collected**:
- `User.unavailableDays` (array of day names)
- Computed: `User.availableDays` = all days minus unavailable days

**Edge Cases**:
- No days selected: Treated as "all days available"
- 6+ days selected: Show warning "Only 1 training day available. We recommend at least 2-3 days per week"
- All 7 days selected: Show error "You need at least one day available for training"

---

### Step 3: Constraints Check Screen
**User Sees**:
- Question: "Anything I should know about? (Injuries, time limits, etc.)"
- Text input field (optional)
- Examples: "Knee gets cranky after 5K", "Max 30 min per session", "All good!"
- Helper text: "This helps me keep you healthy and realistic"
- Progress indicator (Step 2 of 4)

**User Can**:
- Type constraints (optional)
- Tap "Next" → Goes to Step 4
- Tap "Skip" → Goes to Step 4 (no constraints recorded)
- Tap "Back" → Goes to Step 2

**Data Displayed**:
- None

**Data Collected**:
- `User.constraints` (text, nullable)

**Edge Cases**:
- Empty input: Treated as "no constraints"
- Long text: Character limit at 500 chars

---

### Step 4: Goal Type Selection Screen
**User Sees**:
- Question: "Alright, what's the dream? What are we chasing together?"
- Four goal type cards with icons and descriptions:
  - **Distance Milestone**: "Conquer a new distance 🎯" (First 10K, half marathon, etc.)
  - **Time Performance**: "Get faster ⚡" (PR that 5K, crush your time)
  - **Event**: "Race day ready 🏁" (Specific race, specific date)
  - **Maintenance**: "Stay consistent 🔄" (Keep the habit alive)
- Progress indicator (Step 3 of 4)

**User Can**:
- Tap a goal type card → Highlights selection
- Tap "Next" → Goes to Step 5 (goal-specific details)
- Tap "Back" → Goes to Step 3

**Data Displayed**:
- None

**Data Collected**:
- `Goal.type` (enum: distance_milestone, time_performance, event, maintenance)

**Edge Cases**:
- No selection: "Next" button disabled
- User changes selection: Previous selection unhighlights

---

### Step 5a: Distance Milestone Details Screen
*(Shown only if user selected "Distance Milestone" in Step 4)*

**User Sees**:
- Question: "What distance are we conquering?"
- Dropdown/picker with common distances:
  - 5K (3.1 miles) - "Perfect starting point!"
  - 10K (6.2 miles) - "Classic challenge"
  - Half Marathon (13.1 miles) - "Now we're talking!"
  - Marathon (26.2 miles) - "Bold. I like it."
  - Custom distance - "Something special?"
- Optional: "Got a target date in mind?" (date picker, nullable)
- Helper text: "No pressure - we can adjust this anytime"
- Progress indicator (Step 5 of 5)

**User Can**:
- Select distance → Updates selection
- Select custom → Shows distance input field
- Set target date (optional)
- Tap "Next" → Goes to Step 7 (Health Permissions)
- Tap "Back" → Goes to Step 5

**Data Displayed**:
- None

**Data Collected**:
- `Goal.targetDistance` (number, in km)
- `Goal.targetDate` (date, nullable)

**Edge Cases**:
- Custom distance: Validate reasonable range (1-200km)
- No target date: Treated as "no deadline"
- Date picker initial date: Defaults to distance-based estimate (8w for 5K, 12w for 10K, 16w for Half, 20w for Full)

---

### Step 6b: Time Performance Details Screen
*(Shown only if user selected "Time Performance" in Step 5)*

**User Sees**:
- Question: "What time are we chasing?"
- Distance dropdown (5K, 10K, Half Marathon, Marathon, Custom)
- Target time input (hours:minutes:seconds)
- Current best time input (optional, for baseline) - "What's your current PR? (helps me plan better)"
- Progress indicator (Step 5 of 5)

**User Can**:
- Select distance → Updates selection
- Enter target time → Validates format
- Enter current time (optional)
- Tap "Next" → Goes to Step 7
- Tap "Back" → Goes to Step 5

**Data Displayed**:
- None

**Data Collected**:
- `Goal.targetDistance` (number, in km)
- `Goal.targetTime` (duration, in seconds)
- `Goal.currentBestTime` (duration, nullable)

**Edge Cases**:
- Invalid time format: Show validation error
- Target time slower than current best: Show warning "Your target is slower than your current best. Is this correct?"

---

### Step 6c: Event Details Screen
*(Shown only if user selected "Event" in Step 5)*

**User Sees**:
- Question: "Tell me about this race!"
- Event name input (e.g., "Austin Marathon") - "What's it called?"
- Race date picker (required) - "When's the big day?"
- Distance dropdown (5K, 10K, Half Marathon, Marathon, Custom)
- Optional target time - "Got a time goal? (totally optional)"
- Progress indicator (Step 5 of 5)

**User Can**:
- Enter event name
- Select race date → Opens date picker (defaults to distance-based estimate; 16w if none selected)
- Select distance
- Enter target time (optional)
- Tap "Next" → Goes to Step 7
- Tap "Back" → Goes to Step 5

**Data Displayed**:
- None

**Data Collected**:
- `Goal.eventName` (text)
- `Goal.eventDate` (date, required)
- `Goal.targetDistance` (number, in km)
- `Goal.targetTime` (duration, nullable)

**Edge Cases**:
- Race date in past: Show error "Race date must be in the future"
- Race date < 4 weeks away: Show warning "That's soon! We'll create an accelerated plan"
- Race date > 1 year away: Show warning "That's far out! We'll start with base building"

---

### Step 6d: Maintenance Details Screen
*(Shown only if user selected "Maintenance" in Step 5)*

**User Sees**:
- Question: "What does 'staying consistent' mean to you?"
- Frequency selector (1-7 runs per week) - "How often?"
- Typical run duration (15-90 minutes) - "How long per run?"
- Optional: "Maintaining until...?" (date picker, nullable) - "Or just keeping it rolling?"
- Progress indicator (Step 5 of 5)

**User Can**:
- Select frequency → Updates selection
- Select duration → Updates selection
- Set end date (optional)
- Tap "Next" → Goes to Step 7
- Tap "Back" → Goes to Step 5

**Data Displayed**:
- None

**Data Collected**:
- `Goal.maintenanceFrequency` (number, runs per week)
- `Goal.maintenanceDuration` (number, minutes per run)
- `Goal.endDate` (date, nullable)

**Edge Cases**:
- Frequency < 2: Show tip "Consider at least 2 runs per week to maintain fitness"
- No end date: Treated as "ongoing maintenance"
- Date picker initial date: Defaults to 8 weeks in the future

---

### Step 7: Health Permissions Screen
**User Sees**:
- Explanation: "Let's connect to your health data so I can track your runs automatically!"
- Benefits list:
  - ✓ No manual logging (I'll grab your workouts for you)
  - ✓ Track heart rate, pace, and distance
  - ✓ Monitor recovery from sleep and HRV
- "Connect Health Data" button
- "I'll do this later" option
- Helper text: "Don't worry - your data stays private and secure 🔒"

**User Can**:
- Tap "Grant Permissions" → Opens system health permissions dialog
- After granting → Goes to Step 8
- Tap "Skip for now" → Goes to Step 8 (manual logging only)
- Tap "Back" → Goes to Step 6 (goal-specific screen)

**Data Displayed**:
- None

**Data Collected**:
- `User.healthPermissionsGranted` (boolean)

**Edge Cases**:
- User denies permissions: Show "No problem! You can enable this later in Settings"
- Permissions already granted: Skip this screen, go directly to Step 8

---

### Step 8: Plan Generation Screen (Loading)
**User Sees**:
- Loading animation
- Message: "Hang tight! I'm building your custom plan..."
- Progress messages (rotate every 2-3 seconds):
  - "Crunching your training history..."
  - "Finding the perfect days for your schedule..."
  - "Balancing hard work with smart recovery..."
  - "Almost there..."

**User Can**:
- Wait (no interaction)

**Data Displayed**:
- None (loading state)

**Data Collected**:
- None

**Edge Cases**:
- API timeout (>30 seconds): Show error "Taking longer than expected. Retry?" with retry button
- API error: Show error message with retry option

**Background Processing**:
- Call AI API with:
  - `User.trainingHistory`
  - `User.unavailableDays` (compute available days)
  - `User.constraints`
  - `Goal.type` + goal-specific details
  - **Special instruction**: "Create a benchmark easy run (20 min, Zone 2) as the first workout for calibration"
- Generate Week 1 training plan
- Create initial `Microcycle` and `Workouts`
- **First workout must be**: Easy Run, 20 minutes, Zone 2, purpose: "Establish baseline"
- Calculate initial `Goal.confidence` (default: 85%)

---

### Step 9: Plan Review Screen
**User Sees**:
- Success message: "Your plan is ready! Here's Week 1 🎉"
- Weekly calendar view showing 7 days with workout badges:
  - Each day shows workout type (Easy Run, Tempo, Rest, etc.)
  - Duration and distance displayed
  - Color-coded by workout type
- Summary stats:
  - Total weekly volume (e.g., "15 km across 3 runs")
  - Time commitment (e.g., "About 2.5 hours total")
- "Let's go!" button
- "Tweak this" option (future feature)

**User Can**:
- Scroll through week → View all workouts
- Tap a workout → See workout details (modal)
- Tap "Looks good!" → Goes to Step 10
- Tap "Adjust plan" → Opens adjustment options (future feature, for now shows "Coming soon")
- Tap "Back" → Goes to Step 7

**Data Displayed**:
- `Workouts[]` for Week 1 (from generated plan)
- `Goal.confidence` (initial value)

**Data Collected**:
- None (plan already generated)

**Edge Cases**:
- No workouts generated: Show error "Plan generation failed. Please try again"
- User's available days conflict with plan: Show warning "We've adjusted the plan to fit your schedule"

---

### Step 10: First Workout Prompt Screen
**User Sees**:
- Message: "One more thing - let's do a quick baseline run!"
- Explanation: "This helps me learn your pace and how you feel at different intensities. Think of it as our 'getting to know you' run."
- First workout details:
  - Type: Easy Run
  - Duration: 20 minutes
  - Intensity: Zone 2 (you should be able to chat comfortably)
  - Purpose: "Establish your baseline"
- "Let's do it!" button
- "I'll do this later" option

**User Can**:
- Tap "Start now" → Goes to Step 11 (workout tracking)
- Tap "I'll do this later" → Goes to Exit (Home page)

**Data Displayed**:
- First `Workout` from Week 1 plan

**Data Collected**:
- None

**Edge Cases**:
- User skips: First workout remains in "planned" status on calendar

---

### Step 11: Workout Tracking Screen
*(This is a simplified version for onboarding - full workout tracking is Journey #3)*

**User Sees**:
- Timer (counting up from 00:00)
- Current workout details (20 min easy run)
- "Finish Workout" button
- "Cancel" option

**User Can**:
- Wait for workout completion
- Tap "Finish Workout" → Goes to Step 12
- Tap "Cancel" → Confirms cancellation → Goes to Exit

**Data Displayed**:
- `Workout` details
- Elapsed time

**Data Collected**:
- `Workout.actualDuration` (from timer)

**Edge Cases**:
- User cancels: Workout marked as "skipped"
- Health data syncs during workout: Auto-populate distance/pace

---

### Step 12: Post-Workout Feedback Screen
**User Sees**:
- Congratulations message: "Nice work! That's one in the books 🎉"
- Workout summary:
  - Duration: [actual time]
  - Distance: [from health data or manual input]
  - Pace: [calculated]
- RPE question: "How hard did that feel?" (1-10 scale)
  - 1-3: "Easy peasy"
  - 4-6: "Comfortably challenging"
  - 7-9: "Tough but doable"
  - 10: "Absolutely brutal"
- Pain check: "Anything hurting?" (optional) - "Be honest - I'm here to keep you healthy"

**User Can**:
- Rate RPE (1-10) → Updates selection
- Report pain (optional) → Opens body map selector
- Tap "Done" → Goes to Exit (Home page)

**Data Displayed**:
- `Workout.actualDuration`
- `Workout.actualDistance` (from health data)

**Data Collected**:
- `Workout.rpe` (number, 1-10)
- `Workout.completedAt` (timestamp)
- `InjuryRecord` (if pain reported)

**Edge Cases**:
- No health data: Prompt user to manually enter distance
- RPE not selected: "Done" button disabled

---

## Exit Points

### Primary Exit (After completing onboarding):
- **Home Page (Today View)** with:
  - Active goal displayed at top
  - Today's workout (or next upcoming workout)
  - Week 1 plan visible
  - Confidence score widget (85% initial)

### Alternative Exits:
- **Weekly Calendar View** (swipe left from home)
- **Monthly Summary View** (swipe left twice from home)

### Early Exit (User skips first workout):
- **Home Page (Today View)** with:
  - Prompt to complete first workout
  - "Start your first workout" CTA

---

## Success Criteria
- [ ] User can complete onboarding in < 5 minutes
- [ ] All required data is collected and saved to database
- [ ] Week 1 plan is generated and displayed correctly
- [ ] Health permissions are requested (if not already granted)
- [ ] First workout can be completed or skipped
- [ ] User lands on Home page with active goal visible
- [ ] Error states are handled gracefully (API failures, validation errors)
- [ ] User can navigate back through onboarding without losing data

---

## Data Model Requirements

### User Table
- `trainingHistory` (deprecated - will be inferred from baseline workout performance)
- `availableDays` (array of strings: ["monday", "tuesday", ...])
- `constraints` (text, nullable)
- `healthPermissionsGranted` (boolean)

### Goal Table
- `type` (enum: distance_milestone, time_performance, event, maintenance)
- `targetDistance` (number, nullable)
- `targetTime` (duration, nullable)
- `targetDate` (date, nullable)
- `eventName` (text, nullable)
- `eventDate` (date, nullable)
- `currentBestTime` (duration, nullable)
- `maintenanceFrequency` (number, nullable)
- `maintenanceDuration` (number, nullable)
- `confidence` (number, 0-100)

### Workout Table
- `scheduledDate` (date)
- `type` (enum: easy_run, tempo, intervals, long_run, rest, strength, mobility)
- `plannedDuration` (duration)
- `plannedDistance` (number, nullable)
- `actualDuration` (duration, nullable)
- `actualDistance` (number, nullable)
- `rpe` (number, 1-10, nullable)
- `completedAt` (timestamp, nullable)
- `status` (enum: planned, completed, skipped)

### InjuryRecord Table
- `location` (text)
- `severity` (number, 1-10)
- `reportedAt` (timestamp)

---

## Related Journeys
- **Before**: None (entry point for new users)
- **After**: 
  - Journey #2: Daily Check-In & Workout Adjustment
  - Journey #3: Workout Logging & Completion
  - Journey #4: Calendar View & Plan Overview
- **Alternative**: 
  - Journey #13: Goal Switching (for existing users creating new goals)

---

## Notes
- This journey is the **first impression** - must be smooth and fast
- Minimize friction: Keep questions simple, provide defaults where possible
- Health permissions are critical for automatic logging - emphasize benefits
- First workout is optional but encouraged (helps calibrate AI)
- Existing users creating new goals skip Steps 1-4 (see Journey #13)

---

**Last Updated**: 2025-12-29
