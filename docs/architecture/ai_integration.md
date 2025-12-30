# AI Integration Architecture

**Purpose**: Define the architecture, boundaries, and patterns for integrating AI (Gemini) into the Ash Trainer app.

**Last Updated**: 2025-12-29

---

## Overview

The AI integration serves as the **intelligent coaching layer** that generates training plans, adapts workouts, and provides personalized coaching. This document defines:

- **Service boundaries** - What AI does vs. local logic
- **API call patterns** - When and how to call the AI
- **Context management** - 3-tier memory system
- **Request/response patterns** - Data flow and error handling
- **Optimization strategies** - Caching, cost control, performance

---

## Architecture Principles

### 1. AI as a Service Layer

AI lives in the **Infrastructure Layer** and is accessed through well-defined interfaces:

```
Presentation → Application → Domain ← Data → Infrastructure (AI Service)
```

**Key Principle**: Business logic stays in Use Cases. AI is a **tool** that Use Cases call, not the orchestrator.

### 2. Offline-First with AI Enhancement

```
Local Logic (Always Available) + AI Enhancement (When Available)
```

- **Core functionality works offline** (view workouts, log completion)
- **AI features require network** (plan generation, coaching chat)
- **Graceful degradation** when AI unavailable

### 3. Cost-Conscious Design

Every AI call costs money. Design patterns that minimize unnecessary calls:

- **Cache aggressively** - Reuse context and responses
- **Batch operations** - Generate full plans, not individual workouts
- **Smart triggers** - Only replan when truly needed
- **Tiered models** - Use Flash for simple tasks, Pro for complex

---

## Service Boundaries

### What AI Does ✅

| Feature | AI Responsibility | Trigger |
|---------|------------------|---------|
| **Training Plan Generation** | Generate mesocycles, microcycles, and workouts | Goal creation, major replanning |
| **Workout Adjustments** | Modify individual workouts based on feedback | User requests change, pain/fatigue signals |
| **Workout Rescheduling** | Move workouts within/across micro/mesocycles | Schedule conflicts, injury recovery, time off |
| **Coaching Chat** | Daily check-ins, motivational messages, Q&A | User initiates chat, daily notification |


### What Local Logic Does ✅

| Feature | Local Responsibility | Why |
|---------|---------------------|-----|
| **Confidence Calculation** | Compute adherence, quality, consistency scores | Deterministic algorithm, no AI needed |
| **Confidence Explanations** | Generate natural language explanation of score changes | Template-based, no AI needed |
| **Context Aggregation** | Build aggregated context data for AI calls | Deterministic data transformation |
| **Workout Logging** | Record completion, RPE, distance, pace | Simple CRUD, offline-first |
| **Calendar Display** | Render workouts, handle date navigation | UI logic, no intelligence needed |
| **Load Management** | Calculate ACWR, detect overtraining | Sports science formulas, deterministic |
| **Taper Logic** | Apply volume reduction protocols | Rule-based (see [training_plans.md](../ux/product_spec/training/running/training_plans.md)) |

---

## Gemini API Endpoints

### Available Endpoints

The Gemini API provides multiple interaction patterns. We'll use different endpoints for different use cases:

| Endpoint | Use Case | Why |
|----------|----------|-----|
| **generateContent** | Training plan generation, workout adjustments | Non-interactive, can wait for full response |
| **streamGenerateContent** | Coaching chat | Real-time streaming for better UX |
| **Live API (BidiGenerateContent)** | Future: Voice coaching | Bi-directional streaming for conversational AI |
| **batchGenerateContent** | Future: Bulk operations | Process multiple requests efficiently |
| **embedContent** | Future: Semantic search | Find similar workouts, training patterns |

### Endpoint Selection Strategy

#### 1. Standard Generation (`generateContent`)

**Use for**:
- Training plan generation
- Workout adjustments
- Context aggregation (if we add AI-assisted aggregation later)

**Why**: These are batch operations where we can wait for the complete response. No need for streaming.

**Implementation**:
```dart
final response = await gemini.generateContent(
  systemInstruction: ashPersonality,
  contents: [userMessage],
  responseMimeType: "application/json",
  responseSchema: trainingPlanSchema,
);
```

---

#### 2. Streaming Generation (`streamGenerateContent`)

**Use for**:
- Coaching chat
- Daily check-ins
- Q&A interactions

**Why**: Streaming provides faster perceived response time. Users see tokens as they arrive, making the experience feel more conversational.

**Implementation**:
```dart
final stream = gemini.streamGenerateContent(
  systemInstruction: ashPersonality,
  contents: conversationHistory + [userMessage],
);

await for (final chunk in stream) {
  // Update UI progressively
  updateChatUI(chunk.text);
}
```

---

#### 3. Live API (`BidiGenerateContent`) - Future

**Use for**:
- Voice coaching mode
- Real-time conversational AI

**Why**: WebSocket-based bi-directional streaming enables true conversational experiences with low latency.

**Status**: Not implementing in Phase 1, but architecture should support it.

---

#### 4. Batch Mode (`batchGenerateContent`) - Future

**Use for**:
- Regenerating plans for multiple users (admin operations)
- Bulk context aggregation

**Why**: More efficient for processing multiple requests.

**Status**: Future optimization, not needed for single-user Phase 1.

---

#### 5. Embeddings (`embedContent`) - Future

**Use for**:
- Semantic search for similar workouts
- Finding training patterns
- Workout recommendation engine

**Status**: Advanced feature, not in Phase 1.

---

## Context Builder Pattern

### Architecture

Before making AI calls, we need to **aggregate and structure context data**. This is handled by **Context Builder** functions in the Application layer.

```
Use Case → Context Builder → AI Service → Gemini API
```

### Context Builder Responsibilities

1. **Fetch data** from repositories (user, goal, workouts, etc.)
2. **Aggregate** into structured format
3. **Apply business rules** (e.g., "first workout must be benchmark run")
4. **Include training philosophy** (content from `training_plans.md`)
5. **Format for AI consumption** (JSON, markdown, etc.)

### Example: Plan Generation Context Builder

```dart
class BuildPlanGenerationContext {
  final UserRepository _userRepo;
  final GoalRepository _goalRepo;
  final WorkoutRepository _workoutRepo;
  
  Future<PlanGenerationContext> execute({
    required String goalId,
  }) async {
    final goal = await _goalRepo.getGoal(goalId);
    final user = await _userRepo.getCurrentUser();
    final trainingHistory = await _workoutRepo.getWorkoutsForDateRange(
      startDate: DateTime.now().subtract(Duration(days: 90)),
      endDate: DateTime.now(),
    );
    
    // Aggregate data
    return PlanGenerationContext(
      user: UserContext(
        age: user.age,
        experienceLevel: user.experienceLevel,
        availableDays: user.availableDays,
        timeConstraints: user.timeConstraints,
        injuryHistory: user.injuryHistory,
      ),
      goal: GoalContext(
        type: goal.type,
        target: goal.target,
        deadline: goal.deadline,
        specialInstructions: [
          "First workout MUST be a 20min benchmark run for calibration",
        ],
      ),
      trainingHistory: _summarizeWorkouts(trainingHistory),
      trainingPhilosophy: _getTrainingPhilosophy(goal.type),
    );
  }
  
  String _getTrainingPhilosophy(GoalType type) {
    // Load content from training_plans.md based on goal type
    switch (type) {
      case GoalType.distanceMilestone:
        return '''Time-based workouts, pyramidal intensity (75-80% easy),
                  high flexibility, minimal taper (7-10 days)...''';
      case GoalType.timePerformance:
        return '''Distance-based workouts, polarized 80/20,
                  medium flexibility, 1-2 week taper...''';
      // etc.
    }
  }
}
```

### Context Data Structures

```dart
class PlanGenerationContext {
  final UserContext user;
  final GoalContext goal;
  final List<WorkoutSummary> trainingHistory;
  final String trainingPhilosophy;
  
  // Convert to JSON for AI consumption
  Map<String, dynamic> toJson() => {
    'user': user.toJson(),
    'goal': goal.toJson(),
    'trainingHistory': trainingHistory.map((w) => w.toJson()).toList(),
    'trainingPhilosophy': trainingPhilosophy,
  };
}

class UserContext {
  final int age;
  final String experienceLevel;
  final List<String> availableDays;
  final Map<String, int> timeConstraints;
  final List<String> injuryHistory;
}

class GoalContext {
  final GoalType type;
  final String target;
  final DateTime deadline;
  final List<String> specialInstructions;
}
```

### Flexibility for Future Expansion

The context structure is **flexible** and can grow over time:

**Phase 1** (Initial):
- User profile, goal, training history
- Special instructions (benchmark run)
- Training philosophy

**Phase 2** (Enhanced):
- Sleep patterns, HRV trends
- Injury signals, pain tracking
- User preferences (learned coaching style)
- Weather patterns, location data

**Phase 3** (Advanced):
- Cross-training activities
- Nutrition data
- Race history, performance trends
- Social context (training partners, events)

---

## AI Service Interface

### Core Methods

```dart
abstract class AIService {
  /// Generate a complete training plan
  /// Context is pre-built by BuildPlanGenerationContext use case
  Future<TrainingPlan> generatePlan({
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> context,
    required Map<String, dynamic> responseSchema,
  });
  
  /// Adjust a single workout based on user feedback
  /// Context is pre-built by BuildWorkoutAdjustmentContext use case
  Future<Workout> adjustWorkout({
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> context,
    required Map<String, dynamic> responseSchema,
  });
  
  /// Reschedule workouts within/across micro/mesocycles
  /// Context is pre-built by BuildRescheduleContext use case
  Future<List<Workout>> rescheduleWorkouts({
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> context,
    required Map<String, dynamic> responseSchema,
  });
  
  /// Daily coaching chat (streaming)
  /// Context is pre-built by BuildCoachingChatContext use case
  Stream<String> chatStream({
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> context,
  });
  
  /// Daily coaching chat (non-streaming)
  Future<String> chat({
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> context,
  });
}
```

**Key Changes**:
- **Prompts as parameters**: System and task prompts are passed in, not hardcoded
- **Flexible context**: Context is a `Map<String, dynamic>` that can grow over time
- **Response schemas**: JSON schemas passed as parameters for structured output
- **Streaming support**: `chatStream` for real-time coaching interactions
- **Removed**: `explainConfidenceChange` (now local logic), `summarizeContext` (now direct aggregation)

---

## Function Calling (Tool Use)

### Overview

**Function calling** allows the AI to decide *what action to take* based on user input, not just respond with text. This is critical for making coaching chat interactive and action-oriented.

**Use Cases**:
- User says "Move my long run to Sunday" → AI calls `reschedule_workouts()`
- User says "I can't do this workout" → AI calls `adjust_workout()`
- User says "Why is tempo important?" → AI responds with text (no function call)

### How It Works

```
User Message → AI analyzes intent → Decides: Function Call OR Text Response
                                              ↓
                                    Execute function → Return result to user
```

---

### 1. Defining Available Tools

You provide Gemini with a list of functions (tools) it can call:

```dart
final availableTools = [
  FunctionDeclaration(
    name: 'reschedule_workouts',
    description: 'Move workouts to different dates within the training plan. '
                 'Use when user wants to change workout schedule due to conflicts, '
                 'travel, or other reasons.',
    parameters: {
      'type': 'object',
      'properties': {
        'workout_ids': {
          'type': 'array',
          'items': {'type': 'string'},
          'description': 'IDs of workouts to reschedule'
        },
        'new_dates': {
          'type': 'array',
          'items': {'type': 'string', 'format': 'date'},
          'description': 'New dates for the workouts (ISO format)'
        },
        'reason': {
          'type': 'string',
          'description': 'Why the user wants to reschedule'
        }
      },
      'required': ['workout_ids', 'reason']
    }
  ),
  
  FunctionDeclaration(
    name: 'adjust_workout',
    description: 'Modify a single workout\'s content (duration, intensity, type). '
                 'Use when user reports pain, fatigue, or wants a lighter/harder workout.',
    parameters: {
      'type': 'object',
      'properties': {
        'workout_id': {
          'type': 'string',
          'description': 'ID of the workout to adjust'
        },
        'user_feedback': {
          'type': 'string',
          'description': 'User\'s feedback (e.g., "knees ache", "feeling strong")'
        }
      },
      'required': ['workout_id', 'user_feedback']
    }
  ),
  
  FunctionDeclaration(
    name: 'get_workout_details',
    description: 'Retrieve details about a specific workout. '
                 'Use when user asks about a workout\'s purpose, structure, or pacing.',
    parameters: {
      'type': 'object',
      'properties': {
        'workout_id': {
          'type': 'string',
          'description': 'ID of the workout to retrieve'
        }
      },
      'required': ['workout_id']
    }
  ),
  
  FunctionDeclaration(
    name: 'log_workout_completion',
    description: 'Record that user completed a workout. '
                 'Use when user says they finished a workout.',
    parameters: {
      'type': 'object',
      'properties': {
        'workout_id': {'type': 'string'},
        'duration': {'type': 'integer', 'description': 'Actual duration in minutes'},
        'distance': {'type': 'number', 'description': 'Actual distance in km'},
        'rpe': {'type': 'integer', 'description': 'Rate of perceived exertion (1-10)'}
      },
      'required': ['workout_id']
    }
  ),
];
```

**Best Practices for Tool Definitions**:
- **Clear descriptions**: Explain *when* to use each tool
- **Specific parameters**: Define what each parameter means
- **Required vs optional**: Mark required fields
- **Examples in description**: Help AI understand usage patterns

---

### 2. AI Decision-Making

When user sends a message, AI analyzes intent and decides which tool to call (if any).

#### Example 1: Reschedule Request

**User**: "Can we move my long run to Sunday?"

**AI Response**:
```json
{
  "function_call": {
    "name": "reschedule_workouts",
    "arguments": {
      "workout_ids": ["workout_saturday_long_run"],
      "new_dates": ["2025-12-29"],
      "reason": "User wants to move long run to Sunday"
    }
  }
}
```

**App Execution**:
```dart
final result = await _rescheduleWorkoutsUseCase.execute(
  workoutIds: functionCall.arguments['workout_ids'],
  newDates: functionCall.arguments['new_dates'],
  reason: functionCall.arguments['reason'],
);

return "I've moved your long run to Sunday! 🏃‍♀️";
```

---

#### Example 2: Workout Adjustment

**User**: "Knees ache today, can we adjust?"

**AI Response**:
```json
{
  "function_call": {
    "name": "adjust_workout",
    "arguments": {
      "workout_id": "today_intervals",
      "user_feedback": "knees ache"
    }
  }
}
```

**App Execution**:
```dart
final adjustedWorkout = await _adjustWorkoutUseCase.execute(
  workoutId: functionCall.arguments['workout_id'],
  userFeedback: functionCall.arguments['user_feedback'],
);

return "Let's swap intervals for an easy 30-min run. Your knees will thank you!";
```

---

#### Example 3: Text Response (No Function Call)

**User**: "Why is tempo important?"

**AI Response**:
```json
{
  "text": "Tempo runs improve your lactate threshold—the pace you can sustain before lactic acid builds up. For your sub-30 5K goal, this is key! Tempo runs train your body to clear lactate faster, so you can hold faster paces longer. 🏃‍♀️"
}
```

**App Execution**:
```dart
return response.text; // Just display the text
```

---

### 3. Multi-Turn Conversations with Function Calls

AI can ask for clarification before calling a function:

#### Turn 1: User Request (Ambiguous)

**User**: "I can't do my workout today"

**AI** (text response):
```json
{
  "text": "No problem! Would you like to:\n1. Skip it entirely\n2. Move it to another day\n3. Do a lighter version\n\nWhat works best for you?"
}
```

#### Turn 2: User Clarifies

**User**: "Move it to tomorrow"

**AI** (function call):
```json
{
  "function_call": {
    "name": "reschedule_workouts",
    "arguments": {
      "workout_ids": ["today_workout_id"],
      "new_dates": ["2025-12-30"],
      "reason": "User wants to move to tomorrow"
    }
  }
}
```

**App**: Executes reschedule, confirms to user.

---

### 4. Implementation Pattern

```dart
class CoachingChatUseCase {
  final AIService _aiService;
  final RescheduleWorkoutsUseCase _rescheduleUseCase;
  final AdjustWorkoutUseCase _adjustUseCase;
  final WorkoutRepository _workoutRepo;
  
  Future<String> execute(String userMessage) async {
    // Build context
    final context = await _buildChatContext(userMessage);
    
    // Call AI with available tools
    final response = await _aiService.chatWithTools(
      systemPrompt: ashPersonality,
      taskPrompt: coachingChatPrompt,
      context: context,
      tools: availableTools,
    );
    
    // Handle function call or text response
    if (response.hasFunctionCall) {
      return await _executeFunctionCall(response.functionCall!);
    } else {
      return response.text;
    }
  }
  
  Future<String> _executeFunctionCall(FunctionCall call) async {
    switch (call.name) {
      case 'reschedule_workouts':
        final result = await _rescheduleUseCase.execute(
          workoutIds: call.arguments['workout_ids'],
          newDates: call.arguments['new_dates'],
          reason: call.arguments['reason'],
        );
        return "I've rescheduled your workouts! ${result.summary}";
        
      case 'adjust_workout':
        final result = await _adjustUseCase.execute(
          workoutId: call.arguments['workout_id'],
          userFeedback: call.arguments['user_feedback'],
        );
        return "I've adjusted your workout: ${result.description}";
        
      case 'get_workout_details':
        final workout = await _workoutRepo.getWorkout(
          call.arguments['workout_id']
        );
        return _formatWorkoutDetails(workout);
        
      case 'log_workout_completion':
        await _workoutRepo.logWorkout(
          workoutId: call.arguments['workout_id'],
          duration: call.arguments['duration'],
          distance: call.arguments['distance'],
          rpe: call.arguments['rpe'],
        );
        return "Great job! Workout logged. 💪";
        
      default:
        throw UnknownFunctionException(call.name);
    }
  }
}
```

---

### 5. Error Handling

#### Function Call Fails

```dart
Future<String> _executeFunctionCall(FunctionCall call) async {
  try {
    // Execute function...
  } on WorkoutNotFoundException {
    // Ask AI to handle the error gracefully
    return await _aiService.chat(
      systemPrompt: ashPersonality,
      taskPrompt: "The workout couldn't be found. Apologize and ask user to clarify.",
      context: {'error': 'workout_not_found'},
    );
  } on ReschedulingConflictException catch (e) {
    // AI can suggest alternatives
    return await _aiService.chat(
      systemPrompt: ashPersonality,
      taskPrompt: "Rescheduling failed: ${e.reason}. Suggest alternative dates.",
      context: {'conflict': e.conflictingWorkouts},
    );
  }
}
```

#### Invalid Function Arguments

Gemini's structured output ensures arguments match the schema, but you should still validate:

```dart
if (call.arguments['workout_ids'] == null || 
    call.arguments['workout_ids'].isEmpty) {
  return "I need to know which workout to reschedule. Can you clarify?";
}
```

#### AI Calls Wrong Function

If AI misinterprets intent, log it for review and ask user to clarify:

```dart
if (call.name == 'reschedule_workouts' && userIntentWasAdjust) {
  _analytics.logEvent('function_call_mismatch', {
    'expected': 'adjust_workout',
    'actual': 'reschedule_workouts',
  });
  
  return "Just to confirm: do you want to move the workout to another day, or modify today's workout?";
}
```

---

### 6. Function Call Response Loop

For complex operations, AI can call multiple functions in sequence:

**User**: "I'm injured and need to take a week off"

**AI Turn 1** (function call):
```json
{
  "function_call": {
    "name": "mark_time_off",
    "arguments": {
      "start_date": "2025-12-29",
      "end_date": "2026-01-05",
      "reason": "injury"
    }
  }
}
```

**App**: Marks time off, returns confirmation.

**AI Turn 2** (function call):
```json
{
  "function_call": {
    "name": "reschedule_workouts",
    "arguments": {
      "workout_ids": ["all_workouts_next_week"],
      "reason": "User on injury time off, need to replan"
    }
  }
}
```

**App**: Reschedules workouts, returns new plan.

**AI Turn 3** (text response):
```json
{
  "text": "I've marked you off for the week and rescheduled your plan. When you're ready to return, we'll start with easy runs at 50% volume. Take care! 🩹"
}
```

---

### 7. Tool Use Best Practices

#### Keep Tools Focused

❌ **Bad**: One giant `modify_training_plan()` function
✅ **Good**: Separate `reschedule_workouts()`, `adjust_workout()`, `skip_workout()`

**Why**: AI is better at choosing the right tool when each has a clear, specific purpose.

---

#### Provide Rich Context

```dart
final context = {
  'today_workout': todayWorkout.toJson(),
  'upcoming_workouts': upcomingWorkouts.map((w) => w.toJson()).toList(),
  'recent_feedback': recentMessages,
  'user_constraints': {
    'available_days': user.availableDays,
    'injury_history': user.injuryHistory,
  }
};
```

**Why**: AI makes better decisions when it has full context.

---

#### Validate Function Results

```dart
final rescheduled = await _rescheduleUseCase.execute(...);

if (rescheduled.hasConflicts) {
  // Ask AI to resolve conflicts
  return await _aiService.chat(
    systemPrompt: ashPersonality,
    taskPrompt: "Rescheduling created conflicts: ${rescheduled.conflicts}. Suggest resolution.",
    context: context,
  );
}
```

---

#### Log All Function Calls

```dart
_analytics.logEvent('ai_function_call', {
  'function_name': call.name,
  'arguments': call.arguments,
  'success': success,
  'latency_ms': latency,
});
```

**Why**: Helps you understand which functions are used most, identify errors, and improve prompts.

---

### 8. Updated AIService Interface

```dart
abstract class AIService {
  // ... existing methods ...
  
  /// Chat with function calling support
  Future<AIResponse> chatWithTools({
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> context,
    required List<FunctionDeclaration> tools,
  });
  
  /// Streaming chat with function calling
  Stream<AIResponse> chatStreamWithTools({
    required String systemPrompt,
    required String taskPrompt,
    required Map<String, dynamic> context,
    required List<FunctionDeclaration> tools,
  });
}

class AIResponse {
  final String? text;                // Text response (if no function call)
  final FunctionCall? functionCall;  // Function call (if AI decided to call one)
  final int tokensUsed;
  final DateTime timestamp;
  
  bool get hasFunctionCall => functionCall != null;
  bool get hasText => text != null;
}

class FunctionCall {
  final String name;
  final Map<String, dynamic> arguments;
}
```

---

### 9. Cost Considerations

Function calling adds minimal overhead:

- **Tool definitions**: Sent once per conversation (cached)
- **Function call response**: ~50-100 tokens (just function name + arguments)
- **Text response**: ~200-500 tokens

**Optimization**:
- Cache tool definitions in long-term context
- Limit number of available tools (5-10 max)
- Use structured output to ensure valid function calls

---

### 10. Testing Strategy

#### Unit Tests

```dart
test('AI calls reschedule_workouts for schedule conflict', () async {
  final response = await aiService.chatWithTools(
    systemPrompt: ashPersonality,
    taskPrompt: coachingPrompt,
    context: {'user_message': 'Move my long run to Sunday'},
    tools: availableTools,
  );
  
  expect(response.hasFunctionCall, true);
  expect(response.functionCall!.name, 'reschedule_workouts');
});
```

#### Integration Tests

```dart
test('End-to-end reschedule flow', () async {
  final result = await coachingChatUseCase.execute(
    'Can we move my long run to Sunday?'
  );
  
  expect(result, contains('moved'));
  
  final workout = await workoutRepo.getWorkout('long_run_id');
  expect(workout.date, DateTime(2025, 12, 29)); // Sunday
});
```

#### Mock Function Calls

```dart
class MockAIService implements AIService {
  @override
  Future<AIResponse> chatWithTools(...) async {
    return AIResponse(
      functionCall: FunctionCall(
        name: 'reschedule_workouts',
        arguments: {'workout_ids': ['123'], 'reason': 'test'},
      ),
    );
  }
}
```

---

## Related Documentation

- **[Coaching Chat Prompts](../ai/prompts/coaching_chat.md)** - Prompt templates for coaching interactions
- **[Coaching Feature Spec](../ux/product_spec/training/coaching.md)** - UX for coaching chat

---

## Context Management: 3-Tier Memory

### Architecture

```
┌─────────────────────────────────────────────────┐
│  Long-Term Context (Cached, Rarely Changes)     │
│  - User profile, goal, training philosophy      │
│  - Generated once per plan, cached for 30 days  │
├─────────────────────────────────────────────────┤
│  Medium-Term Context (Weekly Summary)           │
│  - Last 7-14 days of workouts                   │
│  - Recent injuries, fatigue trends              │
│  - Regenerated weekly or on major events        │
├─────────────────────────────────────────────────┤
│  Short-Term Context (Real-Time)                 │
│  - Today's workout, next 7 days, last 20 msgs   │
│  - Current RPE, pain signals                    │
│  - Passed fresh on every AI call                │
└─────────────────────────────────────────────────┘
```

### Context Tiers

#### Tier 1: Long-Term Context (Cached)

**Purpose**: Stable user profile and goal information.

**Contents**:
- User demographics (age, gender, experience level)
- Active goal (type, target, deadline, confidence)
- Training philosophy (intensity distribution, flexibility)
- Injury history (chronic issues, past injuries)
- Adherence history (overall adherence rate from plan start to 14 days ago)
- All race days (past and future events)

**Regeneration Triggers**:
- New goal created
- User profile updated (e.g., new injury)
- Manual cache invalidation

**Storage**: Database table `long_term_context` (Gemini auto-caching will handle optimization)

**Example**:
```json
{
  "user": {
    "age": 32,
    "experience": "intermediate",
    "weeklyMileageBase": 25,
    "injuryHistory": ["IT band syndrome (2023)"]
  },
  "goal": {
    "type": "time_performance",
    "target": "Sub-30 5K",
    "deadline": "2025-03-15",
    "currentPace": "6:30/km"
  }
}
```

---

#### Tier 2: Medium-Term Context (Weekly Aggregation)

**Purpose**: Recent training trends and patterns.

**Contents**:
- Last 7-14 days of workouts (aggregated locally)
- Adherence rate, average RPE
- Fatigue trends, sleep quality
- Recent injuries or pain signals

**Generation Method**: **Local aggregation** (not AI-generated). Use Case computes metrics from workout data.

**Regeneration Triggers**:
- Weekly cron job (Sunday evening)
- Major event (injury, time off, race completion)
- User requests replan

**Storage**: Database table `context_summaries`

**Example**:
```json
{
  "period": "2025-12-22 to 2025-12-29",
  "workoutsCompleted": 4,
  "workoutsPlanned": 5,
  "adherenceRate": 0.8,
  "averageRPE": 6.5,
  "totalDistance": 28.5,
  "concerns": ["Knee pain during long runs"],
  "achievements": ["Longest run: 12km"]
}
```

---

#### Tier 3: Short-Term Context (Real-Time)

**Purpose**: Immediate, actionable information for current interaction.

**Contents**:
- Today's planned workout
- Next 7 days of planned workouts (for rescheduling context)
- Conversation history (last 20 messages in current chat session)
- Current pain/fatigue signals
- Weather, user's current location (if relevant)

**Regeneration**: Constructed fresh on every AI call

**Note**: Workouts are passed as context (not fetched via tool calls). This keeps implementation simple and ensures AI has full visibility for rescheduling decisions.

**Example**:
```json
{
  "todayWorkout": {
    "type": "tempo",
    "duration": 40,
    "intensity": "zone 3-4"
  },
  "recentMessages": [
    {"role": "user", "content": "Knees ache today"},
    {"role": "assistant", "content": "Let's swap for an easy run"}
  ],
  "currentState": {
    "rpe": null,
    "painLevel": 3,
    "sleepQuality": "poor"
  }
}
```

---

## API Call Patterns

### Pattern 1: Plan Generation (Batch)

**Trigger**: User creates a new goal

**Flow**:
```
User creates goal
  ↓
Use Case: GenerateTrainingPlan
  ↓
AI Service: generatePlan()
  ├─ Input: Goal, User, Training History
  ├─ Context: Long-Term (cached) + Medium-Term
  ├─ Output: Full plan (mesocycles, microcycles, workouts)
  ↓
Repository: Save all workouts to DB
  ↓
UI: Display calendar with new plan
```

**Cost Optimization**:
- **Batch generation**: Generate entire plan in one call (not workout-by-workout)
- **Cache long-term context**: Reuse user profile across multiple plans
- **Use Flash model**: Plan generation is structured, doesn't need Pro

**Expected Token Usage**:
- Input: ~2,000 tokens (context + goal)
- Output: ~5,000 tokens (12-week plan)
- **Cost**: ~$0.01 per plan (Flash pricing)

---

### Pattern 2: Workout Adjustment (Single)

**Trigger**: User requests change to today's workout

**Flow**:
```
User: "Knees ache, can we adjust?"
  ↓
Use Case: AdjustWorkout
  ↓
AI Service: adjustWorkout()
  ├─ Input: Planned workout, user feedback, context
  ├─ Context: Short-Term only (today's state)
  ├─ Output: Modified workout
  ↓
Repository: Update workout in DB
  ↓
UI: Display adjusted workout
```

**Cost Optimization**:
- **Minimal context**: Only today's workout + immediate feedback
- **No caching needed**: One-off adjustment
- **Use Flash model**: Simple modification task

**Expected Token Usage**:
- Input: ~500 tokens
- Output: ~200 tokens
- **Cost**: ~$0.001 per adjustment

---

### Pattern 3: Coaching Chat (Conversational)

**Trigger**: User initiates chat or daily check-in

**Flow**:
```
User: "Why is today's workout important?"
  ↓
Use Case: CoachingChat
  ↓
AI Service: chat()
  ├─ Input: User message, conversation history, context
  ├─ Context: Long-Term (cached) + Medium-Term + Short-Term
  ├─ Output: Coaching response
  ↓
Repository: Save message to conversation history
  ↓
UI: Display response in chat
```

**Cost Optimization**:
- **Sliding window**: Keep last 10 messages, summarize older
- **Cache long-term context**: Reuse personality and goal info
- **Use Flash model**: Conversational responses

**Expected Token Usage**:
- Input: ~1,500 tokens (context + history)
- Output: ~300 tokens (response)
- **Cost**: ~$0.002 per message

---


## Request/Response Patterns

### Standard Request Structure

All AI requests follow this pattern:

```dart
class AIRequest {
  final String systemPrompt;        // Ash personality + task-specific instructions
  final ContextSummary longTerm;    // Cached user/goal context
  final ContextSummary? mediumTerm; // Weekly summary (optional)
  final Map<String, dynamic> shortTerm; // Real-time data
  final String userInput;           // User's message or trigger
  
  // Gemini-specific
  final String? cachedContextToken; // For context caching
  final String responseMimeType;    // "application/json" or "text/plain"
  final Map<String, dynamic>? responseSchema; // JSON schema if structured output
}
```

### Standard Response Structure

```dart
class AIResponse<T> {
  final T data;                     // Parsed response (Workout, String, etc.)
  final int tokensUsed;             // For cost tracking
  final String? cachedContextToken; // For next request
  final DateTime timestamp;
}
```

---

## Error Handling

### AI-Specific Failures

```dart
sealed class AIFailure {
  final String message;
  final DateTime timestamp;
}

class NetworkFailure extends AIFailure {
  // No internet connection
}

class RateLimitFailure extends AIFailure {
  // API rate limit exceeded
  final DateTime retryAfter;
}

class InvalidResponseFailure extends AIFailure {
  // AI returned unparseable response
  final String rawResponse;
}

class SafetyBlockFailure extends AIFailure {
  // Gemini safety filters triggered
}

class BudgetExceededFailure extends AIFailure {
  // User exceeded daily/monthly token limit
}
```

### Fallback Strategies

| Failure Type | Fallback Strategy |
|--------------|------------------|
| **NetworkFailure** | Show cached response if available, otherwise "Offline mode" message |
| **RateLimitFailure** | Queue request for retry, show "Try again in X minutes" |
| **InvalidResponseFailure** | Retry once with same prompt, one with simplified prompt, then show error |
| **SafetyBlockFailure** | Log for review, show generic error to user |
| **BudgetExceededFailure** | Disable AI features until next billing cycle, show upgrade prompt |

---

## Optimization Strategies

### 1. Context Caching (Critical!)

**Gemini Context Caching** reduces costs by ~75% for repeated context.

**Implementation**:
```dart
// First request: Cache long-term context
final response1 = await gemini.generateContent(
  systemInstruction: ashPersonality,
  cachedContent: longTermContext, // Cached for 30 days
  contents: [userMessage],
);

// Subsequent requests: Reuse cached context
final response2 = await gemini.generateContent(
  cachedContentToken: response1.cachedToken,
  contents: [nextUserMessage],
);
```

**Cache Invalidation**:
- New goal created
- User profile updated
- Manual invalidation (settings)

---

### 2. Structured Output Mode

Force AI to return JSON for predictable parsing:

```dart
final schema = {
  "type": "object",
  "properties": {
    "workouts": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "date": {"type": "string"},
          "type": {"type": "string"},
          "duration": {"type": "integer"},
          // ...
        }
      }
    }
  }
};

final response = await gemini.generateContent(
  responseMimeType: "application/json",
  responseSchema: schema,
  contents: [prompt],
);
```

**Benefits**:
- No parsing errors
- Faster processing
- Easier testing

---

### 2. Tiered Model Strategy

Use the right model for the task:

| Task | Model | Reasoning |
|------|-------|-----------|
| **All AI Operations** | Gemini 3.0 Flash | Fast, cost-effective, handles all use cases |

**Gemini 3.0 Flash Pricing** (per 1M tokens):
- Input: Check latest pricing
- Output: Check latest pricing
- Note: Gemini 3.0 Flash is significantly faster and more capable than 1.5 Flash

---

### 4. Rate Limiting & Budget Controls

**Per-User Limits**:
- **Daily**: 50 AI calls (generous for normal use)
- **Monthly**: 1,000 AI calls
- **Token budget**: 500K tokens/month (~$0.50/user)

**Implementation**:
```dart
class AIUsageTracker {
  Future<bool> canMakeRequest(String userId) async {
    final usage = await getUsage(userId);
    return usage.dailyCalls < 50 && usage.monthlyCalls < 1000;
  }
  
  Future<void> trackRequest(String userId, int tokensUsed) async {
    // Increment counters, log for analytics
  }
}
```

**Graceful Degradation**:
- Show "Daily limit reached" message
- Offer upgrade to premium (higher limits)
- Critical features (plan generation) get priority over chat

---

### 5. Prompt Optimization

**Keep prompts concise**:
- ❌ 500-word personality essay
- ✅ 100-token focused instructions

**Example**:
```text
You are Ash, a supportive running coach. Be concise, encouraging, and science-based.
Prioritize long-term consistency over short-term intensity.
If user reports pain, recommend rest or modification.
```

**Token Savings**: 500 tokens → 50 tokens = 90% reduction

---

## Observability & Logging

### What to Log

```dart
class AIRequestLog {
  final String userId;
  final String requestType; // "plan_generation", "chat", etc.
  final int tokensUsed;
  final Duration latency;
  final bool success;
  final String? errorType;
  final DateTime timestamp;
}
```

### Analytics Dashboard

Track:
- **Token usage per user** (identify heavy users)
- **Cost per feature** (which features are expensive?)
- **Error rates** (which failures are common?)
- **Latency** (is AI fast enough?)

### Flagging for Review

Auto-flag:
- Responses with safety blocks
- Unusually high token usage (>10K tokens)
- Repeated failures for same user

---

## Security & Privacy

### Data Handling

- **No PII in prompts**: Use user IDs, not names/emails
- **Anonymize health data**: "User reports knee pain" not "John Smith reports..."
- **Local storage**: Conversation history stays on-device
- **No training on user data**: Gemini doesn't train on API calls

### API Key Management

- **Server-side proxy**: Don't embed API keys in app
- **Environment variables**: Never commit keys to Git
- **Key rotation**: Rotate every 90 days

---

## Testing Strategy

### Unit Tests

```dart
test('AIService generates valid training plan', () async {
  final mockGemini = MockGeminiClient();
  final aiService = AIServiceImpl(mockGemini);
  
  final plan = await aiService.generatePlan(
    goal: testGoal,
    user: testUser,
    trainingHistory: [],
  );
  
  expect(plan.workouts.length, greaterThan(0));
  expect(plan.mesocycles.length, greaterThan(0));
});
```

### Integration Tests

```dart
test('End-to-end plan generation flow', () async {
  // Real Gemini API call (use test API key)
  final aiService = AIServiceImpl(GeminiClient(apiKey: testApiKey));
  
  final plan = await aiService.generatePlan(
    goal: Goal(type: GoalType.distanceMilestone, target: "10K"),
    user: User(age: 30, experience: "beginner"),
    trainingHistory: [],
  );
  
  expect(plan.workouts.length, inRange(30, 90)); // 6-12 week plan
});
```

### Mock Responses

For UI testing, mock AI responses:

```dart
class MockAIService implements AIService {
  @override
  Future<TrainingPlan> generatePlan(...) async {
    return TrainingPlan.fromJson(mockPlanJson);
  }
}
```

---

## Related Documentation

- **[Interfaces](interfaces.md)** - AIService interface definition
- **[Prompts](../ai/prompts/)** - Prompt templates and personality
- **[Coaching](../ux/product_spec/training/coaching.md)** - Coaching feature spec
- **[Training Plans](../ux/product_spec/training/running/training_plans.md)** - Plan generation logic
- **[Error Handling](error_handling.md)** - Failure types and recovery

---

**Last Updated**: 2025-12-29
