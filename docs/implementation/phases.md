# Ash Trainer - Phased Implementation Plan

This document outlines a phased approach to building Ash Trainer, prioritizing user feedback and iterative development while maintaining database flexibility.

---

## 🎯 Implementation Philosophy

**Core Principles:**
- **Start small, iterate fast** - Get to user feedback quickly
- **Additive schema changes** - Design for easy migrations
- **Validate assumptions early** - Build features users actually want
- **Minimize AI costs during development** - Use UI-first approach

**Database Strategy:**
- Use Drift's built-in migration system
- Leverage JSON fields for flexible data
- Add "future-proof" columns early (low cost, high value)
- Defer complex tables until features are validated

---

## Phase 1: MVP Core (Weeks 1-4)

**Goal:** Get users training with basic adaptive planning and validate core UX hypothesis.

### Database Schema

#### Tables to Implement

**`goals`**
```dart
class Goals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()(); // 'distance' | 'performance' | 'fitness'
  TextColumn get target => text()(); // "Run a 5K" | "Sub-25 min 5K"
  DateTimeColumn get deadline => dateTime().nullable()();
  IntColumn get confidence => integer().withDefault(const Constant(50))();
  TextColumn get pillarPriorities => text().map(const JsonConverter())(); // JSON: {"running": "high", "strength": "medium", "mobility": "low"}
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
```

**`workouts`**
```dart
class Workouts extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get goalId => integer().references(Goals, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get pillar => text()(); // 'running' | 'strength' | 'mobility' - FUTURE-PROOF
  TextColumn get type => text()(); // 'easy_run' | 'tempo' | 'strength_upper' | 'mobility_flow'
  RealColumn get distance => real().nullable()(); // km
  IntColumn get duration => integer().nullable()(); // minutes
  RealColumn get pace => real().nullable()(); // min/km
  IntColumn get targetRpe => integer().nullable()(); // 1-10
  TextColumn get status => text().withDefault(const Constant('planned'))(); // 'planned' | 'completed' | 'skipped' | 'rescheduled'
  TextColumn get notes => text().nullable()();
  TextColumn get details => text().map(const JsonConverter()).nullable()(); // JSON: pillar-specific data (sets/reps, pace zones, etc.)
  IntColumn get mesocycleWeek => integer().nullable()(); // FUTURE-PROOF for Phase 2
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
```

**`daily_logs`**
```dart
class DailyLogs extends Table {
  DateTimeColumn get date => dateTime()();
  IntColumn get workoutId => integer().references(Workouts, #id).nullable()();
  IntColumn get sessionRpe => integer().nullable()(); // 1-10
  IntColumn get duration => integer().nullable()(); // actual minutes
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {date};
}
```

### Features to Implement

#### 1. Onboarding Flow
- [User Flow Reference](../ux/user_flows.md#1-new-user-onboarding--first-workout)
- Screens 1-8 from user flows
- Simplified goal setting (no race events yet)
- Basic pillar prioritization
- Generate first week of workouts (deterministic algorithm, no AI)

#### 2. Daily Training Loop
- [User Flow Reference](../ux/user_flows.md#2-daily-training-loop-the-core-experience)
- Morning notification (local notifications)
- Today's workout screen
- Manual reschedule button (simple date picker)
- Post-workout logging (RPE slider)
- Basic Ash chat (simple Q&A, no complex tool calling)

#### 3. Calendar View
- Week view (default)
- Color-coded workout badges by pillar
- Tap day → Workout details
- Mark complete/skip actions

### AI Integration (Minimal)

**Model:** Gemini Flash only (fast, cheap)

**Tools Needed:**
- `get_training_context` (basic version - just returns current goal, recent workouts)
- `reschedule_workout` (validates date, updates DB)
- `log_session_rpe` (stores RPE, updates daily log)

**Chat Capabilities:**
- Answer "Why this workout?" questions
- Provide encouragement/motivation
- Simple adjustments (e.g., "I'm tired" → suggest easier workout)

**What's NOT in Phase 1:**
- ❌ Complex tool calling
- ❌ Multi-turn planning conversations
- ❌ ACWR calculations
- ❌ Goal confidence scoring
- ❌ Taper protocols

### Success Metrics

- [ ] User completes onboarding in < 5 minutes
- [ ] User logs first workout
- [ ] User reschedules a workout successfully
- [ ] User has a basic chat conversation with Ash
- [ ] Zero database migration errors

---

## Phase 2: Goal Management & Intelligence (Weeks 5-8)

**Goal:** Add goal tracking, load management, and pillar coordination.

### Database Schema Changes

#### New Tables

**`plans`**
```dart
class Plans extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get goalId => integer().references(Goals, #id)();
  TextColumn get phase => text()(); // 'base' | 'build' | 'peak' | 'taper' | 'recovery'
  IntColumn get weekNumber => integer()(); // Overall week in plan
  IntColumn get mesocycleWeek => integer()(); // Week within 4-week mesocycle (1-4)
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

**`load_tracking`**
```dart
class LoadTracking extends Table {
  DateTimeColumn get date => dateTime()();
  IntColumn get goalId => integer().references(Goals, #id)();
  RealColumn get acuteLoad => real()(); // Last 7 days
  RealColumn get chronicLoad => real()(); // Avg of last 28 days
  RealColumn get acwr => real()(); // Acute / Chronic
  TextColumn get injuryRisk => text()(); // 'low' | 'moderate' | 'high'
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {date, goalId};
}
```

#### Migrations

**Migration 1: Populate `mesocycle_week` in existing workouts**
```dart
// Backfill mesocycleWeek based on workout date
// Week 1-4 = mesocycle 1, Week 5-8 = mesocycle 2, etc.
```

### Features to Implement

#### 1. Goal Confidence Tracker
- [User Flow Reference](../ux/user_flows.md#5-goal-confidence-monitoring--adjustment)
- Dashboard widget showing confidence %
- Breakdown screen (tap to expand)
- Alert when confidence drops below 80%

#### 2. Pillar Coordination
- [Architecture Reference](../architecture/data_processing.md#2-pillar-coordination-running-strength-mobility)
- 48-hour rule enforcement
- Cross-pillar conflict detection
- Recovery week adjustments

#### 3. Load Management (ACWR)
- [Architecture Reference](../architecture/data_processing.md#3-load-management--injury-prevention)
- Background calculation (runs on app open)
- Injury risk alerts
- Deload recommendations

### AI Integration (Enhanced)

**Tools Added:**
- `calculate_acwr` (returns ACWR value, risk status)
- `calculate_goal_confidence` (multi-factor analysis)
- `adjust_intensity` (scale workout difficulty)
- `swap_workout` (replace workout type with validation)

**Chat Capabilities:**
- Explain confidence drops
- Suggest plan adjustments
- Proactive intervention when ACWR > 1.3

### Success Metrics

- [ ] Goal confidence updates in real-time
- [ ] ACWR calculation runs without errors
- [ ] Users understand confidence breakdown
- [ ] Pillar coordination prevents conflicts

---

## Phase 3: Events & Time Management (Weeks 9-12)

**Goal:** Handle race events, vacation scheduling, and taper protocols.

### Database Schema Changes

#### New Tables

**`race_events`**
```dart
class RaceEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get goalId => integer().references(Goals, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get type => text()(); // 'goal_race' | 'tune_up' | 'fun_run' | 'non_running'
  TextColumn get distance => text().nullable()(); // '5K' | '10K' | 'Half' | 'Marathon'
  TextColumn get name => text()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get taperStartDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

**`time_off_blocks`**
```dart
class TimeOffBlocks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get goalId => integer().references(Goals, #id)();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

### Features to Implement

#### 1. Race/Event Management
- [User Flow Reference](../ux/user_flows.md#6-race-day-preparation--taper)
- Add race to calendar
- Automatic taper protocol initiation
- Pre-race checklist
- Post-race recovery week

#### 2. Vacation/Time-Off Scheduling
- [User Flow Reference](../ux/user_flows.md#3-vacationtime-off-scheduling)
- Block out dates
- Suppress notifications during time off
- Ad-hoc workout requests
- Return-from-break protocols

#### 3. Taper Protocols
- [Architecture Reference](../architecture/data_processing.md#4-race--event-management)
- Distance-specific volume reductions
- Maintain intensity with short sessions
- Recovery week scheduling

### AI Integration (Event-Aware)

**Tools Added:**
- `add_race_event` (initiates taper, updates confidence)
- `trigger_taper` (implements distance-specific protocol)
- `schedule_time_off` (clears schedule, updates confidence)
- `request_adhoc_workout` (generates single workout)
- `return_from_break` (safe return protocol)

**Chat Capabilities:**
- Race strategy advice
- Taper week reassurance
- Pre-race pep talks
- Post-race celebration

### Success Metrics

- [ ] Taper protocol reduces volume correctly
- [ ] Time-off blocks suppress notifications
- [ ] Ad-hoc workouts generate successfully
- [ ] Return-from-break adjusts volume safely

---

## Phase 4: Advanced Intelligence (Weeks 13-16)

**Goal:** Injury management, motivation tracking, plateau detection, and environmental adaptations.

### Database Schema Changes

#### New Tables

**`biomarkers`**
```dart
class Biomarkers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get goalId => integer().references(Goals, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get type => text()(); // 'pain' | 'mood' | 'energy' | 'sleep'
  IntColumn get value => integer()(); // 1-10 scale
  TextColumn get location => text().nullable()(); // For pain: 'knee' | 'ankle' | 'back'
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

**`motivation_logs`**
```dart
class MotivationLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get goalId => integer().references(Goals, #id)();
  DateTimeColumn get date => dateTime()();
  IntColumn get level => integer()(); // 1-10
  TextColumn get reason => text().nullable()(); // 'tired' | 'stressed' | 'bored' | 'excited'
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

**`weather_cache`** (optional - can use API directly)
```dart
class WeatherCache extends Table {
  DateTimeColumn get date => dateTime()();
  TextColumn get location => text()();
  RealColumn get temperature => real()();
  RealColumn get heatIndex => real().nullable()();
  IntColumn get aqi => integer().nullable()();
  TextColumn get conditions => text()(); // 'clear' | 'rain' | 'snow'
  DateTimeColumn get cachedAt => dateTime().withDefault(currentDateAndTime)();
  
  @override
  Set<Column> get primaryKey => {date, location};
}
```

### Features to Implement

#### 1. Injury Management
- [User Flow Reference](../ux/user_flows.md#4-injury-management--recovery)
- Pain reporting interface
- Escalation protocol (Day 1 → Day 5+)
- Swap to low-impact alternatives
- Return-to-training protocol

#### 2. Motivation Tracking
- [Architecture Reference](../architecture/data_processing.md#6-motivation--mental-health)
- Log motivation state
- Detect skip patterns (3+ in 2 weeks)
- Intervention conversations
- Offer plan adjustments

#### 3. Plateau Detection
- [Architecture Reference](../architecture/data_processing.md#7-plateau-detection--intervention)
- Analyze recent performance trends
- Trigger deload/variation/volume protocols
- Proactive Ash conversation

#### 4. Weather-Based Adjustments
- [Architecture Reference](../architecture/data_processing.md#8-environmental-adaptations)
- Check weather forecast
- Adjust for extreme heat/cold/AQI
- Suggest indoor alternatives
- Smart notification timing

### AI Integration (Proactive)

**Model Strategy:**
- **Gemini Flash:** Quick check-ins, weather alerts
- **Gemini Pro:** Deep injury assessment, plateau analysis

**Tools Added:**
- `log_biomarker` (track pain, mood, energy, sleep)
- `log_motivation` (record motivation state)
- `detect_skip_pattern` (analyze adherence)
- `detect_plateau` (performance analysis)
- `trigger_plateau_protocol` (implement intervention)
- `check_weather` (get forecast)
- `adjust_for_weather` (modify workout)
- `process_screenshot` (OCR + AI vision for external data)

**Chat Capabilities:**
- Empathetic injury exploration
- Burnout intervention
- Plateau protocol explanation
- Weather-based suggestions

### Success Metrics

- [ ] Pain tracking triggers appropriate escalation
- [ ] Skip pattern detection works accurately
- [ ] Plateau protocols improve performance
- [ ] Weather adjustments prevent missed workouts

---

## Migration Strategy

### General Principles

**Safe Migrations:**
1. **Always additive** - Add columns/tables, don't remove
2. **Nullable by default** - New columns should be nullable or have defaults
3. **Backfill carefully** - Populate existing rows with sensible defaults
4. **Test migrations** - Use Drift's schema verification in tests

### Phase Transition Checklist

**Before Each Phase:**
- [ ] Export user data (backup)
- [ ] Write migration script
- [ ] Test migration on sample database
- [ ] Document breaking changes (if any)

**During Migration:**
- [ ] Run migration
- [ ] Verify data integrity
- [ ] Check foreign key constraints
- [ ] Validate indexes

**After Migration:**
- [ ] Smoke test core features
- [ ] Monitor error logs
- [ ] Rollback plan ready

### Example Migration: Phase 1 → Phase 2

```dart
@override
MigrationStrategy get migration => MigrationStrategy(
  onCreate: (Migrator m) async {
    await m.createAll();
  },
  onUpgrade: (Migrator m, int from, int to) async {
    if (from == 1 && to == 2) {
      // Add Plans table
      await m.createTable(plans);
      
      // Add LoadTracking table
      await m.createTable(loadTracking);
      
      // Backfill mesocycleWeek in Workouts
      await customStatement('''
        UPDATE workouts
        SET mesocycle_week = ((julianday(date) - julianday((SELECT MIN(date) FROM workouts))) / 7) % 4 + 1
      ''');
    }
  },
);
```

---

## Feature Flags (Optional)

If you want to test features with a subset of users:

```dart
class FeatureFlags {
  static const bool enableGoalConfidence = true; // Phase 2
  static const bool enableRaceEvents = false; // Phase 3
  static const bool enableInjuryTracking = false; // Phase 4
}
```

Use in code:
```dart
if (FeatureFlags.enableGoalConfidence) {
  // Show confidence widget
}
```

---

## Testing Strategy

### Phase 1 Tests
- [ ] Onboarding flow (integration test)
- [ ] Workout CRUD operations (unit tests)
- [ ] Daily log creation (unit tests)
- [ ] Basic chat conversation (integration test)

### Phase 2 Tests
- [ ] ACWR calculation accuracy (unit tests)
- [ ] Goal confidence formula (unit tests)
- [ ] Pillar coordination rules (unit tests)
- [ ] Migration from Phase 1 → Phase 2 (migration test)

### Phase 3 Tests
- [ ] Taper protocol volume reductions (unit tests)
- [ ] Time-off block scheduling (unit tests)
- [ ] Ad-hoc workout generation (integration test)

### Phase 4 Tests
- [ ] Pain escalation logic (unit tests)
- [ ] Skip pattern detection (unit tests)
- [ ] Weather API integration (integration test)
- [ ] Screenshot OCR accuracy (integration test)

---

## Timeline Summary

| Phase | Duration | Core Deliverable | Key Risk |
|-------|----------|------------------|----------|
| **Phase 1** | 4 weeks | Users can train with basic Ash coaching | UX validation |
| **Phase 2** | 4 weeks | Goal tracking and load management | ACWR calculation accuracy |
| **Phase 3** | 4 weeks | Race prep and vacation handling | Taper protocol complexity |
| **Phase 4** | 4 weeks | Advanced injury/motivation intelligence | AI cost management |

**Total:** 16 weeks to full feature set

---

## Decision Points

### After Phase 1
**Question:** Is the core UX compelling?
- ✅ **Yes** → Proceed to Phase 2
- ❌ **No** → Iterate on onboarding/daily loop before adding complexity

### After Phase 2
**Question:** Are users engaging with goal confidence?
- ✅ **Yes** → Proceed to Phase 3
- ❌ **No** → Simplify confidence UI or rethink feature

### After Phase 3
**Question:** Do users need advanced injury/plateau features?
- ✅ **Yes** → Proceed to Phase 4
- ❌ **No** → Focus on polish and performance

---

## Next Steps

1. **Review this plan** - Confirm phases align with your priorities
2. **Set up Drift** - Initialize database with Phase 1 schema
3. **Create task.md** - Break down Phase 1 into implementation tasks
4. **Start building** - Begin with onboarding flow

**Ready to start Phase 1?** Let me know if you want me to:
- Create the Drift schema files for Phase 1
- Break down Phase 1 into a detailed task.md
- Set up the initial project structure
