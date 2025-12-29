# User Journey Inventory

TODO: 
 - [ ] Go through the product spec to review if all journeys are captured.

This document catalogs user journeys needed for the Ash app, extracted from the [Product Specification](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/_index.md).

**Purpose**: Ensure every feature has a defined user flow before moving to system architecture (Stage 4).

---

## 📊 Journey Categories

Journeys are organized into three categories:

1. **🎯 Core Journeys** - Essential MVP flows that define the app's value
2. **🔧 Supporting Journeys** - Important features that enhance core functionality
3. **🔄 Lifecycle Journeys** - Onboarding, maintenance, and edge cases

---

## 📋 Journey Prioritization for MVP

Based on the [Design Progression Tracker](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/design_progression.md), here's the recommended order for documenting journeys:

### Phase 1: Foundation (Week 1)
1. **Onboarding & Goal Setup** (#1) - Users need to get started
2. **Calendar View & Plan Overview** (#4) - Primary navigation hub

### Phase 2: Core Training Loop (Week 1-2)
3. **Daily Check-In & Workout Adjustment** (#2) - Daily engagement
4. **Workout Logging & Completion** (#3) - Close the training loop

### Phase 3: Enhanced Features (Week 2-3)
5. **Goal Progress Tracking** (#5) - Motivation and transparency
6. **Pillar Priority Configuration** (#6) - Differentiation
7. **Injury Management & Pain Tracking** (#9) - Safety and trust
8. **Time Off Scheduling** (#11) - Flexibility

### Phase 4: Polish & Completeness (Week 3-4)
9. **Strength Training Logging** (#7)
10. **Biomarker Monitoring** (#10)
11. **Weekly Summary** (#15)
12. **Goal Switching** (#13) - Simplified version of onboarding
13. **Mobility Tracking** (#8)
14. **Return from Sickness** (#14)
15. **Workout Screenshot Upload** (#12) - Fallback for sync failures

### Phase 5: Future Enhancements
16. **Voice Check-ins** - TTS-based morning messages from Ash

### Cloud Sync Journeys (Document Now, Implement Phase 2+)
17. **Account Setup & Sign-In** (#16) - Google/Apple auth (Phase 1 implementation)
18. **Email/Password Auth** (#17) - Traditional auth (Phase 2 implementation)
19. **Multi-Device Sync** (#18) - Device switching and conflict resolution (Phase 2 implementation)

---

## 🎯 Core Journeys (MVP Critical)

These journeys represent the fundamental value proposition of Ash.

### 1. Onboarding & Goal Setup
**Source**: [`lifecycle/onboarding_flow.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/lifecycle/onboarding_flow.md), [`training/goals.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/goals.md)

**User Need**: Set up profile, set first running goal, and receive a personalized training plan

**Key Interactions**:
- Answer onboarding questions (training history, availability, constraints)
- Select goal type (Distance Milestone, Time Performance, Event, Maintenance)
- Input goal-specific details (target distance, target time, race date, etc.)
- Grant Health Connect/HealthKit permissions (for automatic workout sync)
- Review AI-generated Week 1 plan
- Complete "First Date" benchmark workout to calibrate RPE
- Accept or request adjustments to plan
- View goal on calendar

**Entry Points**: 
- App first launch
- Account creation

**Exit Points**:
- Home page (Today view) with active goal and first workout displayed
- Weekly calendar view (swipe left from home)
- Monthly summary view (swipe left twice from home)

**Status**: ✅ **[Documented](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/user_journeys/01_onboarding_goal_setup.md)**

**Note**: Existing users creating new goals follow a simplified version of this flow (skip onboarding questions, go straight to goal selection)

---

### 2. Daily Check-In & Workout Adjustment
**Source**: [`training/coaching.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/coaching.md)

**User Need**: See today's workout and adjust based on current state

**Key Interactions**:
- Receive daily notification
- View today's planned workout
- Communicate current state (tired, injured, energized, etc.)
- Receive adjusted workout recommendation
- Accept or further modify workout
- Start workout

**Entry Points**:
- Daily notification tap
- Home screen "Today" section. "Check in" card at the top if the user has not checked in yet

**Exit Points**:
- Workout logging screen if workout started.
- Home Page if workout was skipped.
- Skip/reschedule confirmation

**Status**: ⚠️ Not documented

---

### 3. Workout Logging & Completion
**Source**: [`training/coaching.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/coaching.md), [`athlete_markers/injury_mgmt.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/athlete_markers/injury_mgmt.md), [`athlete_markers/biomarkers.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/athlete_markers/biomarkers.md)

**User Need**: Record completed workout and provide feedback

**Key Interactions**:
- **Automatic sync**: Workout data (distance, duration, pace, heart rate) automatically synced from Health Connect (Android) or HealthKit (iOS)
- **Fallback**: If data doesn't sync after a few minutes, option to upload screenshot from other apps (see Journey #16)
- **Manual input**: Option to manually enter workout details if preferred
- Rate workout difficulty (RPE)
- Report any pain or discomfort (post-training pain check-in)
- Receive AI feedback and next steps
- View updated progress toward goal

**Entry Points**:
- Automatic detection after workout completion (via health data sync)
- Manual entry from calendar
- "Log past workout" option
- Post-workout notification

**Exit Points**:
- Home screen with updated stats
- Calendar with marked completion
- Goal progress view

**Status**: ⚠️ Not documented

---

### 4. Calendar View & Plan Overview
**Source**: [`training/calendar.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/calendar.md)

**User Need**: See upcoming workouts and training plan at a glance

**Key Interactions**:
- Swipe between three views:
  - **Today View** (center): Today's workout and daily summary
  - **Weekly View** (swipe left): Horizontal scroll showing week's plan with workout badges
  - **Monthly View** (swipe left again): Summary of last week + current week + next 2 weeks
- Tap on specific workout for details
- See workout status (planned, completed, missed)
- Identify workout types by color coding
- Navigate to specific dates

**Entry Points**:
- Home page (default view is Today)
- Swipe gestures from any of the three views
- Notification deep link

**Exit Points**:
- Workout detail screen (tap on any workout)
- Daily check-in flow (from Today view)
- Goal adjustment flow

**Status**: ⚠️ Not documented

---

### 5. Goal Progress Tracking
**Source**: [`training/goals.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/goals.md)

**User Need**: Understand progress toward goal and confidence level

**Key Interactions**:
- View confidence percentage and trend
- See factors affecting confidence (adherence, quality, consistency, recovery)
- Review historical confidence graph
- Understand what actions improve confidence
- Receive alerts when confidence drops

**Entry Points**:
- Home screen confidence widget
- Goal detail screen
- Weekly summary notification

**Exit Points**:
- Workout detail (to improve adherence)
- Goal adjustment flow (if confidence is low)
- Calendar view

**Status**: ⚠️ Not documented

---

## 🔧 Supporting Journeys (Important Features)

These enhance the core experience and differentiate Ash from competitors.

### 6. Pillar Priority Configuration
**Source**: [`training/pillars.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/pillars.md)

**User Need**: Customize training balance across Running, Strength, and Mobility

**Key Interactions**:
- View current pillar priorities
- Adjust priority levels (High/Med/Low)
- See suggested defaults based on goal type
- Understand scheduling constraints (48-hour recovery, etc.)
- Preview how changes affect weekly schedule

**Entry Points**:
- Settings/Preferences
- Goal setup flow
- Calendar "Customize" option

**Exit Points**:
- Calendar with updated schedule
- Settings confirmation

**Status**: ⚠️ Not documented

---

### 7. Strength Training Logging
**Source**: [`training/strength/strength.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/strength/strength.md)

**User Need**: Log strength workouts and track progression

**Key Interactions**:
- View prescribed strength workout
- Log exercises, sets, reps, weight
- Mark workout as complete
- Provide RPE feedback
- See strength progression over time

**Entry Points**:
- Calendar strength workout
- "Log Strength" quick action
- Daily check-in

**Exit Points**:
- Calendar with completion
- Home screen
- Strength history view

**Status**: ⚠️ Not documented

---

### 8. Mobility Session Tracking
**Source**: [`training/pillars.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/pillars.md)

**User Need**: Complete and track mobility work

**Key Interactions**:
- View mobility routine (dynamic stretching, yoga, foam rolling)
- Follow guided routine (if provided)
- Mark as complete
- Log duration and type

**Entry Points**:
- Calendar mobility session
- "Quick Mobility" option
- Recovery day suggestion

**Exit Points**:
- Calendar with completion
- Home screen

**Status**: ⚠️ Not documented

---

### 9. Injury Management & Pain Tracking
**Source**: [`athlete_markers/injury_mgmt.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/athlete_markers/injury_mgmt.md)

**User Need**: Report pain and receive modified training plan

**Key Interactions**:
- Report pain location and severity (post-training check-in)
- Track pain progression (better/same/worse)
- Receive "Compensate" logic adjustments (low-impact swaps)
- See escalation protocol timeline
- Receive medical referral recommendation if needed

**Entry Points**:
- Post-workout pain check-in
- "Report Pain" quick action
- Daily check-in

**Exit Points**:
- Modified workout plan
- Calendar with swapped workouts
- Medical disclaimer screen

**Status**: ⚠️ Not documented

---

### 10. Biomarker Monitoring & Recovery Insights
**Source**: [`athlete_markers/biomarkers.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/athlete_markers/biomarkers.md)

**User Need**: Understand recovery status and training readiness

**Key Interactions**:
- View automated health data (sleep, HRV, RHR)
- See recovery score and trend
- Understand how biomarkers affect today's workout
- Receive burnout warnings
- Adjust health data sync settings

**Entry Points**:
- Home screen recovery widget
- Daily check-in
- Settings > Health Data

**Exit Points**:
- Workout adjustment flow
- Settings
- Home screen

**Status**: ⚠️ Not documented

---

### 11. Time Off Scheduling
**Source**: [`lifecycle/time_off.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/lifecycle/time_off.md), [`training/calendar.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/calendar.md)

**User Need**: Schedule vacation or break and manage training around it

**Key Interactions**:
- Select time off dates on calendar
- Confirm time off mode (clears schedule, suppresses notifications)
- Request ad-hoc workouts during time off (optional)
- Return from time off with adjusted volume
- See return-to-training plan

**Entry Points**:
- Calendar "Schedule Time Off"
- Settings > Time Off
- Daily check-in "I need a break"

**Exit Points**:
- Calendar with cleared dates
- Confirmation screen
- Return-to-training plan

**Status**: ⚠️ Not documented

---

### 12. Workout Screenshot Upload (Fallback)
**Source**: [`athlete_markers/biomarkers.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/athlete_markers/biomarkers.md)

**User Need**: Upload workout data when automatic Health Connect/HealthKit sync fails

**Key Interactions**:
- Detect that workout data hasn't synced after reasonable time (5-10 minutes)
- Prompt user: "Workout data not syncing? Upload a screenshot from your running app"
- User takes/uploads screenshot from Strava, Garmin, etc.
- AI extracts workout data from screenshot (distance, duration, pace, heart rate)
- User confirms extracted data or makes corrections
- Workout logged with extracted data

**Entry Points**:
- Workout logging screen (when auto-sync fails)
- "Upload Screenshot" option in manual entry
- "Missing workout" prompt

**Exit Points**:
- Home screen with logged workout
- Calendar with marked completion
- Workout detail view

**Status**: ⚠️ Not documented

**Note**: This is a Phase 4 feature (polish) - nice-to-have fallback for sync issues

---

## 🔄 Lifecycle Journeys (Onboarding & Edge Cases)

These handle first-time users, special circumstances, and app lifecycle.

### 13. Goal Switching (Existing Users)
**Source**: [`training/goals.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/goals.md)

**User Need**: Change goal type or adjust current goal (simplified version of Journey #1 for existing users)

**Key Interactions**:
- View current goal and progress
- Select new goal type or modify existing
- Understand impact on training plan
- Confirm goal switch
- Receive new/adjusted plan

**Entry Points**:
- Goal detail screen "Change Goal"
- Ash recommendation (low confidence, burnout, etc.)
- Settings > Goals

**Exit Points**:
- Home page (Today view) with new plan
- Goal detail screen

**Status**: ⚠️ Not documented

**Note**: This is a streamlined version of Journey #1 (Onboarding & Goal Setup) for users who already have a profile

---

### 14. Return from Sickness
**Source**: [`lifecycle/time_off.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/lifecycle/time_off.md)

**User Need**: Resume training safely after illness

**Key Interactions**:
- Report sickness type (mild, moderate, severe)
- Receive forced rest protocol
- Confirm symptom-free status
- Receive return-to-training plan with reduced volume
- Gradually ramp back up

**Entry Points**:
- Daily check-in "I'm sick"
- Manual report
- Extended absence detection

**Exit Points**:
- Calendar with adjusted plan
- Home screen
- Confirmation screen

**Status**: ⚠️ Not documented

---

### 15. Weekly Summary & Milestones
**Source**: [`training/coaching.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/training/coaching.md)

**User Need**: Review weekly progress and celebrate achievements

**Key Interactions**:
- Receive weekly summary notification
- View completed workouts and stats
- See achievements (longest run, fastest pace, etc.)
- Review confidence trend
- Plan for next week

**Entry Points**:
- Sunday evening notification
- Home screen "Weekly Summary"
- Calendar week view

**Exit Points**:
- Home screen
- Calendar
- Share achievement (future)

**Status**: ⚠️ Not documented

---

### 16. Account Setup & Sign-In (Google/Apple)
**Source**: [`cloud_sync.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/cloud_sync.md)

**User Need**: Create account and sign in using Google or Apple to enable cloud sync

**Key Interactions**:
- Choose sign-in method (Google or Apple)
- Authenticate with selected provider
- Grant app permissions
- Sync existing data (if returning user on new device)
- Continue to onboarding or home page

**Entry Points**:
- App first launch (new user)
- "Sign In" from settings (existing user, new device)
- After uninstalling/reinstalling app

**Exit Points**:
- Onboarding flow (new user)
- Home page with synced data (returning user)

**Status**: ⚠️ Not documented

**Implementation**: Phase 1 (MVP)

---

### 17. Email/Password Authentication
**Source**: [`cloud_sync.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/cloud_sync.md)

**User Need**: Create account or sign in using email/password for users without Google/Apple accounts

**Key Interactions**:
- Enter email and password
- Verify email address (new users)
- Reset password (forgot password flow)
- Sign in and sync data

**Entry Points**:
- Sign-in screen "Use email instead" option
- Settings > Account > Add email/password

**Exit Points**:
- Onboarding flow (new user)
- Home page with synced data (returning user)
- Email verification screen

**Status**: ⚠️ Not documented

**Implementation**: Phase 2 (Enhanced Auth)

---

### 18. Multi-Device Sync & Conflict Resolution
**Source**: [`cloud_sync.md`](file:///Users/rooshi/Documents/programming/flutter/ash-trainer/docs/ux/product_spec/cloud_sync.md)

**User Need**: Use app on multiple devices with seamless data sync and handle conflicts when editing on different devices

**Key Interactions**:
- Sign in on new device
- View sync status (synced, syncing, offline, error)
- Receive real-time updates from other devices
- Resolve conflicts when same data edited on multiple devices
- Manage connected devices in settings

**Entry Points**:
- Sign in on second device
- Sync status indicator tap
- Settings > Devices

**Exit Points**:
- Home page with synced data
- Conflict resolution dialog
- Device management screen

**Status**: ⚠️ Not documented

**Implementation**: Phase 2 (Enhanced Auth & Multi-Device)

---

## ☁️ Cloud Sync Journeys (Phase 2+)

These journeys support cloud sync and multi-device functionality. They are **documented now** (Stage 2) but **implemented starting in Phase 2**.





---

## 🎯 Next Steps

1. **Create journey map template** (see below)
2. **Document Phase 1 journeys** (3 journeys)
3. **Validate data models** against journey requirements
4. **Create screen inventory** from all journeys
5. **Proceed to Stage 4** (System Architecture)

---

## 📝 Journey Map Template

When documenting each journey, use this template in `docs/ux/user_journeys/[journey_name].md`:

```markdown
# [Journey Name]

**User Goal**: [What the user wants to accomplish]

**Source**: [Link to product spec file]

---

## Entry Points
- [How users access this flow]
- [Alternative entry points]

## User Flow

### Step 1: [Screen Name]
**User Sees**:
- [UI Element 1]
- [UI Element 2]

**User Can**:
- [Action 1] → Goes to Step 2
- [Action 2] → Goes to Step X
- [Action 3] → Exits flow

**Data Displayed**:
- [Data Entity.field]
- [Computed value from X]

**Data Collected**:
- [Form field] → [Data Entity.field]

**Edge Cases**:
- [Empty state]
- [Error state]
- [Loading state]

---

### Step 2: [Screen Name]
[Repeat structure]

---

## Exit Points
- [Where users go after completion]
- [Alternative exits]

## Success Criteria
- [ ] User can complete flow without confusion
- [ ] All data is properly saved
- [ ] Error states are handled gracefully
- [ ] Flow is accessible and performant

## Related Journeys
- [Journey that comes before]
- [Journey that comes after]
- [Alternative journey]
```

---

**Last Updated**: 2025-12-29
