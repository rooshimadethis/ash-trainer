# Ash - AI-Powered Running & Training Coach

## 🎯 Vision

**Ash** is an intelligent, adaptive training companion that helps runners achieve their goals through personalized training plans, real-time adjustments, and empathetic coaching. Named after your AI coach, Ash combines cutting-edge AI with sports science to deliver a premium, futuristic training experience.

---

## 🎨 Design Philosophy

### Visual Identity
- **Aesthetic**: Slick, futuristic, yet friendly and approachable
- **Color Palette**: Consider vibrant gradients with athletic energy (e.g., electric blues, energetic oranges, deep purples)
- **Typography**: Modern, clean fonts that convey both technology and warmth
- **UI Elements**: Smooth animations, glassmorphism effects, dynamic progress indicators
- **Personality**: Ash should feel like a supportive friend who happens to be an expert coach

### User Experience Principles
1. **Adaptive Intelligence**: The app learns and adjusts to user feedback
2. **Transparent Progress**: Users always know where they stand with their goals
3. **Flexible Accountability**: Supportive pushback when needed, understanding when circumstances change
4. **Proactive Communication**: Daily check-ins and contextual notifications

---

## 🏃 Core Features

### 1. Goal Setting & Planning

#### Goal Types

Ash supports four distinct goal types, each with a tailored training experience:

---

**🎯 Distance Milestone**
*"I want to complete my first 10K"*

For runners tackling a new distance for the first time. Training focuses on safe progression and building endurance.

| Aspect | What to Expect |
|--------|----------------|
| **Training Style** | Workouts prescribed by time ("run for 30 minutes"), not distance |
| **Intensity** | Mostly easy runs (75-80%), minimal speed work |
| **Progression** | Conservative weekly increases, run/walk intervals for beginners |
| **Success Metric** | Completing the distance—no time pressure |
| **Flexibility** | High—skip workouts without guilt, consistency over perfection |

---

**⏱️ Time Performance**
*"I want to run a sub-30 minute 5K"*

For runners who can already complete the distance but want to get faster. Training focuses on speed development and measurable progress.

| Aspect | What to Expect |
|--------|----------------|
| **Training Style** | Key workouts prescribed by distance ("6 × 400m intervals") |
| **Intensity** | Polarized 80/20 approach—easy days truly easy, hard days truly hard |
| **Progression** | Monthly time trials, structured interval and tempo workouts |
| **Success Metric** | Pace improvements and hitting target times |
| **Flexibility** | Medium—key workouts matter, but easy runs are flexible |

---

**🏆 Event (Race-Specific)**
*"I'm running the Austin Marathon on February 16"*

For runners with a specific race date. Training follows proven periodization with a proper taper leading to race day.

| Aspect | What to Expect |
|--------|----------------|
| **Training Style** | Phases: Base → Build → Peak → Taper, with race simulation workouts |
| **Intensity** | Varies by phase—progressive build with race-specific sharpening |
| **Progression** | Countdown to race day with automatic taper and tune-up races |
| **Success Metric** | Race day performance and goal achievement |
| **Flexibility** | Lower during peak weeks—structured plan tied to race date |

---

**🔄 Maintenance**
*"I want to keep running 3x/week during my busy season"*

For runners who want to maintain fitness without progressive overload—during busy periods, between training cycles, or after a race.

| Aspect | What to Expect |
|--------|----------------|
| **Training Style** | Flexible—one quality session per week, rest is easy running |
| **Intensity** | Mostly easy with short strides to maintain speed |
| **Progression** | Flat week-to-week, no volume increases |
| **Success Metric** | Showing up consistently, staying healthy |
| **Flexibility** | Very high—skip without penalty, no pressure |

---

#### Dynamic Goal Type Switching

Life changes, and so can your goal. Ash automatically suggests goal type transitions:

- **After a race** → Transition to Maintenance for recovery
- **Register for a race** → Switch to Event mode with proper periodization
- **Complete your first distance** → Celebrate! Then shift to Time Performance
- **Life gets busy** → Maintenance mode is always available

You can also manually switch goal types anytime via settings or by chatting with Ash.

---

#### Goal Components
- **Target**: Specific, measurable outcome
- **Deadline**: Target completion date (or "as soon as possible")
- **Current Fitness Level**: Assessed through onboarding questionnaire or initial test runs
- **Constraints**: Cross-training goals, injury history, available training days

#### Training Plan Generation
Ash creates personalized plans based on your goal type:

**All goal types include:**
- **Workout Days**: Runs with appropriate distance/time/pace targets for your goal type
- **Intensity Levels**: Distribution tailored to goal (Pyramidal for distance, Polarized for performance)
- **Rest Days**: Active recovery and complete rest
- **Strength Training**: User-configurable pillar with priority settings (High/Med/Low)
- **Mobility Work**: Stretching routines, dynamic warm-ups, recovery sessions
- **Injury Prevention**: Targeted exercises and movement patterns
- **Low-Impact Alternatives**: Cycling, swimming, elliptical (only for injury recovery)
- **Progression**: Based on goal type—gradual for distance, structured phases for events

---

### 2. Daily Adaptive Coaching

#### Morning Check-In
- **Notification**: "Good morning! Here's what Ash has planned for you today 🏃"
- **Daily Overview**: Workout type, duration, intensity, purpose
- **Contextual Tips**: Weather-based advice, motivational messages

#### Flexible Adjustments
Users can communicate their current state, and Ash adapts:

**Example Scenarios:**

| User Input | Ash Response | Adjustment |
|------------|--------------|------------|
| "I'm feeling a slight ache in my knees" | "Let's swap today's interval session for an easy recovery run and add some knee-strengthening exercises. Your goal confidence remains at 87%." | Reduces impact, adds preventive work |
| "I have an unavoidable social event today" | "No problem! We can move today's long run to tomorrow and shift your rest day to today. This won't affect your goal timeline." | Reschedules within the week |
| "I'm feeling weak today but can still do a little bit" | "I hear you. Let's do a light 20-minute easy run instead of the planned tempo. Recovery is part of training! Goal confidence: 85%." | Reduces intensity while maintaining consistency |
| "I want to skip today" | "I understand wanting a break. You've already had 2 rest days this week though—how about a gentle 15-minute walk instead? If we skip entirely, your goal confidence would drop to 78%. What feels right to you?" | Light pushback with choice |

#### Goal-Type-Specific Coaching Examples

Ash's coaching tone and flexibility adapt based on your goal type:

**Distance Milestone (Flexible)**
> User: "I want to skip today's run"
> Ash: "No problem! Consistency matters more than any single workout. Take the day off—we'll pick back up tomorrow. Your goal is still on track. 👍"

**Time Performance (Balanced)**
> User: "I want to skip today's intervals"
> Ash: "Today's intervals are key for your speed goal. If you're tired, we could shorten them to 4 × 400m instead of 6. Or if you need full rest, we can try to fit them in Friday. What works?"

**Event (Structured)**
> User: "I want to skip today's tempo run"
> Ash: "This tempo is important with your race 3 weeks out. If you're not feeling it, we could do an easier version—20 minutes at moderate pace instead of 30 at tempo. Skipping entirely would drop confidence to 82%. Let me know what feels doable."

**Maintenance (Very Flexible)**
> User: "I want to skip today"
> Ash: "You're in maintenance mode, so flexibility is the name of the game. Skip without guilt—we'll see you when you're ready. 🙌"

#### Conversation Flow
- **Natural Language**: Users can type or speak naturally
- **Empathetic Responses**: Ash acknowledges feelings and circumstances
- **Negotiation**: Back-and-forth to find the best solution
- **Education**: Brief explanations of why certain adjustments are made

---

### 3. Goal Confidence Tracker

#### Visual Indicator
- **Percentage Display**: 0-100% confidence level
- **Color-Coded**: 
  - 90-100%: Green (On track!)
  - 75-89%: Yellow (Slight adjustment needed)
  - 60-74%: Orange (Falling behind)
  - Below 60%: Red (Goal at risk)
- **Trend Graph**: Historical view of confidence over time

#### Factors Affecting Confidence
- **Completed Workouts**: Adherence to plan
- **Workout Quality**: Hitting pace/distance targets
- **Consistency**: Training frequency
- **Recovery**: Adequate rest days
- **Time Remaining**: Proximity to deadline
- **Recent Performance**: Trend analysis

#### Transparency
- **Tap to Expand**: Shows breakdown of confidence calculation
- **Recommendations**: "To get back on track, focus on completing your next 3 easy runs"
- **Goal Adjustment**: Option to modify deadline or target if needed

---

### 4. Training Calendar

#### Visual Planning Overview
A beautiful, interactive calendar that shows users their entire training plan at a glance, with clear visual distinction between planned and completed workouts.

#### Calendar Views

**Weekly View (Default)**
- Horizontal scrollable week-by-week layout
- Each day shows color-coded workout badges
- Compact view perfect for quick daily checks
- Current day highlighted with special border/glow

**Monthly View**
- Traditional calendar grid layout
- Color dots or mini-badges for each workout
- Tap any day to see full workout details
- Swipe between months

#### Color Coding System

Each workout type has a distinct color for instant recognition:

| Workout Type | Color | Example |
|--------------|-------|---------|
| **Easy Run** | Soft Blue | Recovery runs, base building |
| **Tempo Run** | Orange | Sustained effort, lactate threshold |
| **Intervals** | Red | High-intensity speed work |
| **Long Run** | Purple | Weekend long runs |
| **Rest Day** | Light Gray | Complete rest |
| **Strength Training** | Green | Lifting, bodyweight circuits |
| **Mobility** | Teal | Stretching, yoga, foam rolling |
| **Low-Impact Alternative** | Cyan | Cycling, swimming (injury recovery only) |
| **Race Day** | Gold | Goal race or tune-up race |

**Multiple Workouts Per Day:**
- Show multiple color badges stacked or side-by-side
- Example: Morning easy run (blue) + evening strength (green)
- Tap to expand and see all workouts for that day

#### Planned vs. Completed

**Future Days (Planned):**
- Color badges with **outlined/hollow** style
- Subtle, lighter appearance
- Shows what Ash has planned

**Past Days (Completed):**
- Color badges **filled solid**
- Vibrant, bold appearance
- Shows what user actually did
- Checkmark icon overlay for completed workouts

**Past Days (Missed):**
- Grayed out or crossed-out badge
- Shows planned workout that wasn't completed
- Tap to see why (user skipped, rescheduled, etc.)

**Today:**
- Special highlight (border, glow, or background color)
- Shows both planned and completion status
- Updates in real-time as user logs workout

#### Visual Examples

```
WEEKLY VIEW (Horizontal Scroll)
┌─────────────────────────────────────────────────────────┐
│  Mon 12/23   Tue 12/24   Wed 12/25   Thu 12/26   Fri... │
│  ┌────────┐  ┌────────┐  ┌────────┐  ┌────────┐         │
│  │ [BLUE] │  │ [RED]  │  │ [GRAY] │  │ [BLUE] │         │
│  │  ✓ 5K  │  │ ✓ INT  │  │  REST  │  │ ○ 8K   │  ←Today │
│  │ [GREEN]│  │        │  │        │  │ [TEAL] │         │
│  │  ✓ STR │  │        │  │        │  │ ○ MOB  │         │
│  └────────┘  └────────┘  └────────┘  └────────┘         │
│  (completed) (completed)  (rest)     (planned)           │
└─────────────────────────────────────────────────────────┘

MONTHLY VIEW (Grid)
┌──────────────────────────────────────────┐
│         December 2024                    │
│  S   M   T   W   T   F   S              │
│  1   2   3   4   5   6   7              │
│      ●   ●●  ○   ●   ○   ●              │
│  8   9  10  11  12  13  14              │
│  ○   ●   ●   ○   ●●  ○   ●              │
│ 15  16  17  18  19  20  21              │
│  ●   ○   ●   ●   ○   ●   ⭐             │
│ 22  23  24  25  26  27  28              │
│  ●   ●●  ●   ○   ●○  ○   ○              │
│ (● = completed, ○ = planned, ⭐ = race)  │
└──────────────────────────────────────────┘
```

#### Interactive Features

**Tap on a Day:**
- Opens detailed view showing:
  - All workouts for that day (planned and/or completed)
  - Workout details (distance, pace, duration, notes)
  - Option to log workout if not yet completed
  - Option to adjust/reschedule if planned

**Long Press on a Day:**
- Quick actions menu:
  - "Mark as complete"
  - "Skip this workout"
  - "Reschedule to..."
  - "Add note"

**Swipe Gestures:**
- Swipe left/right to navigate weeks/months
- Pull down to refresh from Health Connect

**Filter Options:**
- Toggle workout types on/off (e.g., hide rest days)
- Show only completed workouts
- Show only upcoming workouts
- Highlight specific workout types

#### Workout Badges Design

**Badge Components:**
- **Color**: Workout type
- **Icon**: Small icon representing activity (🏃 run, 💪 strength, 🧘 mobility)
- **Text**: Short label (e.g., "5K Easy", "Intervals", "Rest")
- **Status Indicator**: 
  - ✓ Checkmark for completed
  - ○ Hollow circle for planned
  - ✗ X for missed/skipped

**Example Badge Designs:**

```
Completed Easy Run:
┌──────────────┐
│ 🏃 5K Easy   │  ← Solid blue background
│      ✓       │  ← Checkmark
└──────────────┘

Planned Tempo Run:
┌──────────────┐
│ 🏃 Tempo 8K  │  ← Outlined orange border
│      ○       │  ← Hollow circle
└──────────────┘

Multiple Workouts:
┌──────────────┐
│ 🏃 5K ✓      │  ← Blue (completed)
│ 💪 Strength○ │  ← Green (planned)
└──────────────┘
```

#### Smart Features

**Streak Tracking:**
- Visual indicator of consecutive training days
- "🔥 7-day streak!" badge on calendar
- Encourages consistency

**Progress Indicators:**
- Weekly completion percentage
- "4/5 workouts completed this week"
- Progress bar showing adherence to plan

**Adaptive Highlighting:**
- Highlight weeks with important milestones
- Show taper weeks before races
- Indicate peak training weeks

#### Event Tracking (Race Days & Special Events)

Track important events directly on the calendar to help Ash plan training around them.

**Event Types:**

| Event Type | Icon/Color | Training Impact |
|------------|------------|-----------------|
| **Goal Race** | 🏆 Gold star | Primary goal - all training builds toward this |
| **Tune-Up Race** | 🎯 Gold outline | Practice race - reduced training 2-3 days before |
| **Fun Run / Casual Event** | 🏃 Orange dot | Social run - treated as a workout, not a race |
| **Non-Running Event** | 📅 Purple | Triathlon, obstacle course, hiking trip, etc. |

**Adding Events:**
- **Quick Add**: Tap any date → "Add Event" → Select type
- **From Other Apps**: Import from device calendar (birthday parties, weddings, travel dates)
- **Voice Input**: "I have a 5K race on March 15th"

**Ash's Smart Planning:**
When an event is added:
1. **Goal Race**: Automatic taper period (1-3 weeks before depending on distance: 5K = 7-10 days, 10K = 10-14 days, Half = 2 weeks, Marathon = 3 weeks)
2. **Tune-Up Race**: Light training 2-3 days before, 2-3 easy days after
3. **Fun Run**: Slight intensity reduction day before, 1 easy day after
4. **Recovery**: Easy week scheduled post-race based on event distance and effort

**Event Details View:**
Tap on any event to see:
- Event name and date
- Distance/type
- Notes (e.g., "Flat course, start at 7am")
- Linked training adjustments ("Taper week starts Dec 10")
- Goal time/pace expectations

```
EXAMPLE: Goal Race Entry
┌────────────────────────────────┐
│ 🏆 Austin Marathon             │
│ Sunday, February 16, 2025      │
│ Distance: 26.2 mi              │
│                                │
│ 📝 Notes: Hilly course,        │
│    hotels booked downtown      │
│                                │
│ 🎯 Goal: Sub 4:00:00           │
│                                │
│ 📋 Training Impact:            │
│    • Taper starts: Feb 3       │
│    • Last long run: Feb 2      │
│    • Shake-out run: Feb 15     │
└────────────────────────────────┘
```

#### Time-Off Visualization

Scheduled time off is clearly displayed on the calendar with distinct visual treatment.

**Visual Styling:**
- **Blocked dates**: Diagonal stripe pattern or subtle texture overlay
- **Color**: Muted gray or vacation-themed color (beach teal 🏖️)
- **Label**: "Time Off" with optional user note (e.g., "Beach Vacation", "Work Conference")
- **Icon**: 🏖️ or 📴

**Calendar Display:**

```
MONTHLY VIEW WITH TIME OFF
┌──────────────────────────────────────────┐
│         February 2025                    │
│  S   M   T   W   T   F   S              │
│  2   3   4   5   6   7   8              │
│  ●   ●   ●●  ○   ●   🏖️  🏖️            │
│  9  10  11  12  13  14  15              │
│  🏖️ 🏖️ 🏖️ 🏖️  ●   ○   🏆              │
│                                          │
│ Legend: 🏖️ = Time Off, 🏆 = Race Day    │
└──────────────────────────────────────────┘

WEEKLY VIEW WITH TIME OFF PERIOD
┌─────────────────────────────────────────────────────────┐
│  Feb 6-12: Time Off 🏖️                                 │
│  ┌──────────────────────────────────────────────────┐   │
│  │ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ │   │
│  │ 🏖️ Beach Vacation                                │   │
│  │ "No workouts scheduled. Enjoy your break!"      │   │
│  │ "Open the app anytime to request a workout"     │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

**Interaction with Blocked Dates:**
- **Tap blocked date**: Shows time-off details, option to request ad-hoc workout for that day, option to end early or extend
- **Tap return date**: Shows "Welcome Back" workout (always easy/recovery)
- **Conflict warning**: If adding event during time off, Ash asks for confirmation

**Integration with Event Tracking:**
- Block out travel days around races automatically
- Suggest rest days after goal races
- Warn if time off conflicts with taper period

**Goal Countdown:**
- Show days until goal race/deadline
- "42 days until marathon!" at top of calendar
- Visual progress toward goal date

#### Integration with Other Features

**Goal Confidence:**
- Calendar shows color gradient based on confidence
- Green weeks = on track
- Yellow/orange weeks = falling behind
- Tap to see confidence breakdown

**Time Off:**
- Blocked-out dates shown with special pattern/color
- "🏖️ Time Off" label
- No workouts pre-scheduled during this time
- Ad-hoc workouts available on request

**Injury Prevention:**
- Warning indicators if training load is too high
- Suggested rest days highlighted
- Recovery weeks visually distinct

---


### 5. Injury Prevention & Recovery

#### Proactive Prevention
- **Warm-Up Routines**: Dynamic stretching before runs
- **Cool-Down Protocols**: Static stretching and foam rolling
- **Strength Training**: Runner-specific exercises (glutes, core, hips)
- **Mobility Work**: Flexibility and range-of-motion exercises
- **Load Management**: Monitoring weekly mileage increases (typically 10% rule)

#### Injury Response
- **Early Detection**: Ash asks about pain/discomfort during check-ins
- **Smart Adjustments**: Reduces load when warning signs appear
- **Recovery Protocols**: Suggests rest, ice, elevation, or professional consultation
- **Return-to-Running**: Gradual progression after injury

---

### 6. Nutrition & Fueling Guidance (General Tips Only)

#### Scope
Ash provides **general hydration and fueling tips**, especially for beginners who may be unfamiliar with endurance nutrition strategies. However, **specific meal planning and nutrition prescriptions are out of scope**.

#### What Ash DOES Provide
- **Hydration Reminders**: "Don't forget to hydrate before your long run!"
- **General Fueling Strategies**: 
  - "For runs over 90 minutes, consider bringing energy gels or chews"
  - "Post-run recovery: aim for protein and carbs within 30-60 minutes"
- **Race Day Basics**: "Avoid trying new foods on race day—stick with what you've practiced"
- **Beginner Education**: Brief explanations of why fueling matters for performance

#### What Ash Does NOT Provide
- ❌ Specific calorie targets or macro breakdowns
- ❌ Meal plans or recipes
- ❌ Weight loss/gain nutrition programs
- ❌ Supplement recommendations beyond general sports nutrition (gels, electrolytes)
- ❌ Medical nutrition advice for health conditions

#### Philosophy
> "I can point you in the right direction for fueling your training, but nutrition is personal. For detailed meal planning, consult a registered dietitian or sports nutritionist."

---

### 7. Schedule Time Off

#### Proactive Planning
Users can schedule time off in advance to prevent interruptions during busy periods or actual vacations.

**Use Cases:**
- **Vacation**: "I'm going on vacation from June 15-22"
- **Work Travel**: "I have a business trip next week, no training"
- **Life Events**: "I have finals week coming up, need to focus on studying"
- **Recovery Periods**: "I want to take a complete rest week after my race"

#### Feature Details

**Scheduling Interface:**
- **Calendar View**: Visual calendar to select date ranges
- **Quick Presets**: "This weekend", "Next week", "Custom range"
- **Recurring Blocks**: "Every Sunday" for religious observance or family time
- **Notes Field**: Optional context ("Beach vacation", "Conference")

**Ash's Response:**
When time off is scheduled, Ash:
1. **Acknowledges**: "Got it! I've blocked out June 15-22 for your vacation 🏖️"
2. **Clears Schedule**: No workouts pre-scheduled during this period
3. **Updates Goal Confidence**: Recalculates based on new timeline
4. **Turns Off Notifications**: No training reminders during this period
5. **Ad-Hoc Exercise Access**: If you open the app during time off, you can request optional exercises for that day

**During Time Off:**
- **No Pre-Scheduled Workouts**: Calendar is completely empty during blocked period
- **No Training Notifications**: Ash stays completely quiet
- **Ad-Hoc Workouts Available**: Open the app anytime to request an exercise for that day
  - Example: "Give me a 20-min hotel room strength workout"
  - Example: "I want to go for an easy run today"
- **No Pressure**: Ad-hoc workouts during time off don't affect goal confidence or adherence metrics
- **Early Return**: "Back early? Tap here to resume your regular training plan"

**Return from Time Off:**
- **Welcome Back**: "Welcome back! Hope you had a great time 🎉"
- **Gentle Restart**: First workout back is always easy/recovery pace
- **Plan Adjustment**: Training plan automatically adjusted based on time off duration
- **Flexibility**: "Feeling rusty? We can ease back in slower if needed."

#### Smart Adjustments

**Short Breaks (1-3 days):**
- Minimal impact on training plan
- Workouts shifted within the same week
- Goal confidence typically unchanged

**Medium Breaks (4-7 days):**
- Week restructured with adjusted intensity
- May add 1-2 days to goal timeline
- Goal confidence may drop 5-10%

**Long Breaks (1-2 weeks):**
- Resume at 80% volume
- Gradual ramp-up period after return
- Goal deadline may need extension
- Ash proactively asks: "Your marathon is in 8 weeks, but you're taking 2 weeks off. Should we push the goal to 10 weeks, or keep the deadline and adjust the target?"

**Very Long Breaks (3-4 weeks):**
- Treated as "Training Break"
- Resume at 60% volume for first week back
- May require fitness re-assessment
- Plan automatically adjusts timeline and goal confidence

**Extended Breaks (2+ months):**
- Restart from Week 1 of current mesocycle
- Treat as new baseline

---


## 🔔 Notification Strategy

### Daily Notifications
- **Morning Briefing**: Training plan for the day (customizable time)
- **Pre-Workout Reminder**: 1-2 hours before scheduled workout (optional)
- **Encouragement**: Mid-day motivation if workout not yet completed
- **Evening Check-In**: Log workout or explain why it was skipped

### Milestone Notifications
- **Weekly Summary**: Progress recap every Sunday evening
- **Achievement Unlocks**: Longest run, fastest pace, consistency streaks
- **Goal Milestones**: "You're 50% through your training plan!"
- **Confidence Alerts**: If confidence drops below 80%

### Adaptive Timing
- **Learn User Patterns**: Optimal notification times based on user behavior
- **Do Not Disturb**: Respect user's sleep and focus time settings

---

## 🧠 AI Coaching Intelligence

### Personalization Factors
- **Training History**: Past workouts and performance
- **User Feedback**: Responses to daily check-ins
- **Physiological Data**: Heart rate, pace, distance (if available via integrations)
- **Environmental Factors**: Weather, terrain, altitude
- **Life Context**: Work schedule, travel, stress levels
- **Pillar Priorities**: User-defined importance of Running, Strength, and Mobility

### Coaching Personality
- **Supportive**: Celebrates wins, empathizes with struggles
- **Knowledgeable**: Explains training science in accessible terms
- **Adaptive**: Learns user preferences (strict vs. flexible, detailed vs. simple)
- **Motivational**: Provides encouragement with light pushback when helpful
- **Honest**: Transparent about goal feasibility and progress
- **Pattern-Aware**: Detects when frequent skipping signals deeper issues

### Coaching Tone Strategy
- **First Skip**: Empathetic exploration ("What's going on?")
- **Light Pushback**: Shows impact with choice ("This would drop confidence to 78%—what feels right?")
- **Frequent Pattern**: Dig deeper into root causes (motivation, burnout, goal misalignment)
- **Never Guilt-Trip**: Focus on solutions, not blame

### Learning & Improvement
- **Feedback Loop**: Users can rate workouts and Ash's suggestions
- **Pattern Recognition**: Identifies what works best for each user
- **Continuous Optimization**: Refines plans based on outcomes

---

## 📱 Key User Flows

### Onboarding Flow
1. **Welcome**: Introduction to Ash and app philosophy
2. **Current Fitness**: Questionnaire or benchmark test
3. **Goal Setting**: Define target, deadline, constraints
4. **Training Preferences**: Days available, preferred workout times, cross-training interests
5. **Plan Generation**: Ash creates initial training plan
6. **Review & Adjust**: User can request modifications
7. **Start Training**: First workout scheduled

### Daily Training Flow
1. **Morning Notification**: Receive daily plan
2. **Pre-Workout**: Review workout details, warm-up routine
3. **During Workout**: Track run (integration with fitness apps/watches)
4. **Post-Workout**: Log completion, rate difficulty, note any issues
5. **Ash Feedback**: Encouragement and next steps

### Adjustment Flow
1. **User Reports Issue**: "I'm feeling tired/injured/busy"
2. **Ash Asks Questions**: Clarifies severity and context
3. **Proposes Solutions**: Multiple options with trade-offs
4. **User Selects**: Chooses preferred adjustment
5. **Plan Updated**: Calendar reflects changes
6. **Confidence Updated**: New goal confidence displayed

---

## 🎯 Success Metrics

### User Engagement
- Daily active users
- Workout completion rate
- Average session duration
- Notification response rate

### Goal Achievement
- Percentage of users hitting their goals
- Average goal confidence score
- Time to goal completion vs. predicted

### User Satisfaction
- App store ratings and reviews
- Net Promoter Score (NPS)
- Feature usage analytics
- Retention rates (30-day, 90-day, 1-year)

---

---

## 📊 Data Integration & Wearable Sync

### Integration Strategy

Ash needs access to workout data to provide intelligent coaching. For Android + Suunto users, there are several integration pathways:

---

### Option 1: Health Connect (Recommended for MVP)

**What is Health Connect?**
- Google's centralized health data hub for Android
- Unified API for reading/writing health and fitness data
- User controls permissions granularly

**Implementation:**
- **Flutter Package**: Use `health` or `flutter_health_connect` package
- **Data Flow**: Suunto App → Health Connect → Ash App
- **Bridge Required**: Use third-party app like **Health Sync** to sync Suunto data to Health Connect

**Pros:**
- ✅ Standardized Android API
- ✅ Works with multiple wearable brands (future-proof)
- ✅ User privacy controls built-in
- ✅ No need for Suunto Partner Program access
- ✅ Can access data from Google Fit, Samsung Health, etc.

**Cons:**
- ❌ Requires users to install Health Sync (extra step)
- ❌ Not real-time (sync happens periodically)
- ❌ Suunto doesn't officially support Health Connect yet

**Available Data:**
- Distance, duration, pace
- Heart rate data
- Calories burned
- GPS tracks (via FIT/GPX files)
- Steps, sleep data (24/7 metrics)

**Setup Flow for Users:**
1. Install Suunto App (already done)
2. Install Health Sync app
3. Configure Health Sync to sync Suunto → Health Connect
4. Grant Ash permissions to read Health Connect data
5. Workouts automatically flow to Ash

---

### Option 2: Manual FIT/GPX File Import

**What is it?**
- Users manually export workout files from Suunto App
- Ash imports and parses the files

**Implementation:**
- **File Formats**: FIT (preferred) or GPX
- **Export**: User exports from Suunto App → shares to Ash
- **Parsing**: Use FIT/GPX parsing libraries in Flutter

**Pros:**
- ✅ No API access needed
- ✅ Works immediately
- ✅ User has full control
- ✅ Good for MVP testing

**Cons:**
- ❌ Manual process (poor UX)
- ❌ Not scalable
- ❌ Users will forget to import
- ❌ No 24/7 data (steps, sleep)

---

### Recommended Approach for MVP

**Phase 1: Multi-Path Support**
Implement multiple integration options to maximize compatibility:

1. **Primary**: Health Connect integration (works with any wearable)
2. **Alternative**: Manual FIT/GPX import (fallback, testing) + screenshot upload

---

### Health Connect: Sync Behavior & Capabilities

**Example Use Cases:**
- **App Startup**: Pull last 7 days of workouts to show recent activity
- **Manual Refresh**: User swipes down to refresh and get latest data
- **Goal Setting**: Pull historical data to assess current fitness level
- **Plan Adjustment**: Fetch recent workouts to recalculate training plan

**Important Considerations:**
- **Historical Data Permission**: By default, apps can only read data from the last 30 days. To access older data, you need to request `PERMISSION_READ_HEALTH_DATA_HISTORY` permission (requires Health Connect v1.1+)
- **Rate Limits**: Health Connect has API rate limits to prevent abuse. Design efficient queries (don't pull all data every time)
- **Battery Impact**: Frequent large data pulls can drain battery. Cache data locally and only fetch new/changed data

**Recommended Strategy:**
1. **Initial Setup**: Pull last 30 days of data to establish baseline
2. **Daily Sync**: Pull yesterday's data each morning
3. **Manual Refresh**: Allow user to trigger full sync if needed
4. **Local Caching**: Store data locally to minimize API calls

---

### Health Connect: Data Limitations & Gaps

While Health Connect provides comprehensive basic metrics, some advanced training data is **not available** or **not standardized**:

#### ❌ Missing / Limited Data

**1. Heart Rate Zones**
- **What's Missing**: Personalized HR zone definitions (Z1-Z5), time-in-zone analysis
- **What's Available**: Raw heart rate data (continuous series during workouts, max HR, avg HR)
- **Impact**: Ash will need to calculate HR zones based on user's max HR or use standard formulas (e.g., 220 - age)
- **Workaround**: Ask user for max HR during onboarding, or estimate from workout data

**2. Training Load / Stress Scores**
- **What's Missing**: Proprietary metrics like Suunto's Training Load, Garmin's Training Stress Score (TSS), Strava's Suffer Score
- **What's Available**: Basic workout metrics (distance, duration, HR)
- **Impact**: Ash can't directly see how "hard" a workout was from the watch's perspective
- **Workaround**: Calculate our own training load using HR data, pace, and duration

**3. Recovery Metrics**
- **What's Missing**: Suunto's Recovery Time, Garmin's Body Battery, Whoop's Recovery Score
- **What's Available**: Sleep data (duration, stages if available), resting HR
- **Impact**: Limited insight into user's readiness to train
- **Workaround**: Use sleep quality and resting HR trends as proxy for recovery

**4. Workout Structure**
- **What's Missing**: Interval details (warm-up, intervals, recovery, cool-down segments)
- **What's Available**: Overall workout summary
- **Impact**: Can't see if user completed structured workouts as prescribed
- **Workaround**: Rely on user feedback ("Did you complete the intervals?")

#### ✅ What Health Connect DOES Provide

For reference, here's what we **can** reliably get:

**Activity Metrics:**
- Distance, duration, pace, speed
- Active calories burned, total calories
- Steps (daily and per-workout)
- Elevation gained
- Exercise type (running, walking, cycling, etc.)
- GPS routes (if available)

**Heart Rate:**
- Continuous HR series during workouts
- Average HR, max HR per workout
- Resting HR (daily)

**Recovery Data:**
- Sleep duration and stages (light, deep, REM)
- Daily steps and activity

**Planned Workouts:**
- Health Connect supports `PlannedExerciseSessionRecord` for training plans
- We can write planned workouts to Health Connect for other apps to read

---

### Screenshot Upload Feature

To bridge the gap between Health Connect's limitations and advanced training data, we should offer **screenshot uploads** for supplementary information.

#### Use Cases

**1. Advanced Metrics from Watch App**
Users can upload screenshots showing:
- Training load / stress scores
- Recovery metrics
- VO2 max estimates
- Lactate threshold
- Running dynamics (cadence, vertical oscillation)

**2. Race Results**
- Official race times and splits
- Race photos with bib numbers
- Finish line screenshots

**3. Injury Documentation**
- Pain location diagrams
- Physical therapy exercises
- Doctor's notes or recommendations

#### Implementation

**Upload Flow:**
1. User taps "Add Context" or "Upload Screenshot"
2. Select image from gallery or take photo
3. Optional: Add text description
4. Ash uses image recognition (OCR + AI vision) to extract data
5. User confirms extracted data is correct
6. Data stored and used for coaching decisions

**AI Processing:**
- **OCR**: Extract text from screenshots (numbers, labels)
- **Vision AI**: Identify chart types, metrics, trends
- **Structured Data**: Convert to usable format (e.g., "Training Load: 85")
- **Fallback**: If AI can't parse, user manually enters key data

**Privacy:**
- Images are NOT persisted after data extraction
- Only extracted structured data is stored
- Temporary processing only, deleted immediately after parsing

**Example Interaction:**
```
User: *uploads screenshot of Suunto app showing Training Load: 92*

Ash: "I see your training load is 92 - that's pretty high! 
You've been pushing hard this week. Let's make tomorrow a 
recovery day to avoid overtraining. Sound good?"
```
---

### Data We Need from Workouts

**Essential (MVP):**
- **Distance**: Total distance run
- **Duration**: Total time
- **Date/Time**: When the workout occurred
- **Pace**: Average pace (or calculate from distance/duration)
- **Type**: Run, walk, cross-training, etc.

**Important (Phase 2):**
- **Heart Rate**: Average and max HR
- **GPS Track**: Route visualization
- **Elevation**: Gain/loss for terrain analysis
- **Splits**: Per-mile or per-km pacing

---

### Privacy & Data Handling

**User Control:**
- Users explicitly grant permissions
- Clear explanation of what data is accessed and why
- Option to disconnect integrations anytime
- Data deletion on account removal

**Data Storage:**
- Encrypted at rest and in transit
- Minimal data retention (only what's needed for coaching)
- Comply with GDPR, HIPAA (if applicable)
- No selling or sharing user data

**Transparency:**
- Show users what data Ash has access to
- Explain how data improves coaching
- Privacy policy in plain language

---

## 🛠️ Technical Considerations

### AI/ML Components
- **Natural Language Processing**: Understanding user messages
- **Training Plan Generation**: Algorithm based on sports science
- **Adaptive Learning**: Personalization engine
- **Confidence Calculation**: Multi-factor analysis

### Data Requirements
- **User Profile**: Demographics, fitness level, goals
- **Workout History**: Completed runs, performance metrics
- **Feedback Data**: User responses to check-ins
- **Environmental Data**: Weather, location (optional)

### Privacy & Security
- **Data Encryption**: All user data encrypted at rest and in transit
- **GDPR Compliance**: User data control and deletion rights
- **Health Data**: Special handling per HIPAA/health data regulations
- **Transparency**: Clear privacy policy and data usage explanation

---

## 7. Technical Architecture & Data Processing

Ash uses a **Hybrid Local-First Architecture** to balance cost, performance, and AI intelligence.

### **1. On-Device "Training Engine" (The Cortex)**
*   **Role**: Deterministic logic engine (Pure Dart).
*   **Responsibilities**:
    *   Schedule management (moving dates, detecting conflicts).
    *   Hard math (Goal confidence calculation, 10% volume rules).
    *   Heuristic adjustments (Simple "Skip Day" actions).
*   **Benefit**: Zero API cost, instant UI updates, offline capable.

### **2. Cloud AI (The Coach)**
*   **Role**: Empathetic reasoning and complex planning.
*   **Model Strategy**: Tiered approach (Fast/Cheap for chat vs. Reasoning/Expensive for deep replanning).
*   **Responsibilities**:
    *   Motivation & Chat.
    *   Complex injury replanning.
    *   Analysis of subjective feedback.

### **3. Tiered Context Memory**
To maintain long-term coherence without token overload, Ash uses a 3-tier memory system:
*   **Long-Term**: Narratives of user journey (>1 month).
*   **Medium-Term**: Recent trends & deviations (7-30 days).
*   **Short-Term**: High-fidelity logs for immediate planning (Last/Next 7 days).

### **4. "Reset" Flow**
If a user's life changes drastically (injury, long break), Ash avoids "sunk cost" errors by offering a **Reset Flow**. This redirects the user back to Onboarding to establish a fresh baseline plan.

See [Data Processing Plan](../architecture/data_processing.md) for full details.

---

## 📝 Next Steps

### Immediate Actions
1. **Design Mockups**: Create UI/UX designs for core flows
2. **Technical Architecture**: Define tech stack and infrastructure
3. **MVP Scope**: Prioritize features for initial release
4. **Prototype**: Build working prototype for testing

### Questions to Explore
- What fitness tracking integrations are essential for MVP?
- Should Ash have a visual avatar or remain text-based?
- How much training science education should be included?

### Future Feature Ideas
- **Voice Check-ins**: Morning audio messages from Ash using Text-to-Speech (TTS) for a more personal, engaging experience. TTS APIs are cost-effective (~$15/1M characters) and dramatically increase perceived personality and connection with the AI coach.

---

**Let's build something amazing! 🚀**
