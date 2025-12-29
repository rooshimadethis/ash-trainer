# Tool Registry

Comprehensive list of all AI tools (MCP definitions) used by the Ash Training Engine.

## Context & State Tools

| Tool | Purpose | Key Returns | Called In |
|------|---------|-------------|----------|
| `get_training_context` | Get current snapshot | Current goal, phase, adherence %, pillar priorities, ACWR, upcoming constraints, motivation patterns, weather conditions | All AI interactions (pre-request context loading) |
| `get_workout_details` | Fetch full workout object | Complete PlannedWorkout with all fields (structure, RPE, distance, notes, etc.) | When AI needs to modify workouts beyond 7-day detailed window |

## Workout Management Tools

| Tool | Purpose | Key Params | Validation Logic |
|------|---------|------------|------------------|
| `reschedule_workout` | Move workout to new date | `workout_id`, `new_date`, `reason` | Checks 48-hour rule, conflicts, vacation |
| `adjust_intensity` | Scale workout difficulty | `workout_id`, `factor` | Respects RPE targets and recovery |
| `swap_workout` | Replace workout type | `workout_id`, `new_type` | Validates pillar coordination |

## Calculation & Analysis Tools

| Tool | Purpose | Key Params | Returns/Actions |
|------|---------|------------|-----------------|
| `calculate_acwr` | Calculate injury risk | None | ACWR value, risk status |
| `log_session_rpe` | Record workout intensity | `workout_id`, `rpe`, `duration` | Updates weekly load totals and ACWR |
| `detect_skip_pattern` | Analyze adherence patterns | None | Skip frequency, pattern type, intervention |
| `detect_plateau` | Analyze recent performance | None | Plateau status, affected pillar, duration |
| `calculate_goal_confidence` | Multi-factor goal analysis | None | Confidence % with breakdown |

## Lifecycle Tools

| Tool | Purpose | Key Params | Logic |
|------|---------|------------|-------|
| `schedule_time_off` | Block out dates | `start_date`, `end_date`, `notes` | Clears schedule, suppresses notifications |
| `return_from_break` | Safe return protocol | `break_type`, `duration`, `severity` | Adjusts training plan based on break type |
| `add_race_event` | Add event to calendar | `date`, `type`, `distance` | Initiates taper and recovery |
| `switch_goal_type` | Change goal type mid-plan | `goal_id`, `new_type`, `reason` | Restructures plan, updates priorities |

## External & Utility Tools

| Tool | Purpose | Key Params | Returns/Actions |
|------|---------|------------|-----------------|
| `check_weather` | Get weather forecast | `date`, `location` | Temp, AQI, recommendation |
| `process_screenshot` | Extract data from images | `image_data` | Structured metrics from OCR/Vision |
