# AI-Specific Data Models

**Purpose**: Define all data structures used for AI integration, including context classes, request/response types, and conversation entities.

**Last Updated**: 2025-12-29

---

## Overview

This document defines the **data models** needed to support AI integration. These are separate from the core domain entities and are specifically designed for:

- Building context for AI calls
- Structuring AI requests and responses
- Managing conversation history
- Defining function calls (tool use)

---

## Context Classes

### PlanGenerationContext

**Purpose**: Aggregated context for training plan generation

**Location**: `lib/features/shared/domain/entities/ai/plan_generation_context.dart`

```dart
class PlanGenerationContext {
  final UserContext user;
  final GoalContext goal;
  final List<WorkoutSummary> trainingHistory;
  final String trainingPhilosophy;
  
  const PlanGenerationContext({
    required this.user,
    required this.goal,
    required this.trainingHistory,
    required this.trainingPhilosophy,
  });
  
  /// Convert to JSON for AI consumption
  Map<String, dynamic> toJson() => {
    'user': user.toJson(),
    'goal': goal.toJson(),
    'training_history': trainingHistory.map((w) => w.toJson()).toList(),
    'training_philosophy': trainingPhilosophy,
  };
}
```

**Fields**:
- `user`: User profile and constraints
- `goal`: Goal details and special instructions
- `trainingHistory`: Past 90 days of workouts (summarized)
- `trainingPhilosophy`: Goal-specific training approach (from `training_plans.md`)

---

### UserContext

**Purpose**: User profile information for AI context

```dart
class UserContext {
  final int age;
  final String gender;
  final String experienceLevel; // 'beginner', 'intermediate', 'advanced'
  final List<String> availableDays; // ['Monday', 'Wednesday', ...]
  final Map<String, int> timeConstraints; // {'weekday': 60, 'weekend': 90}
  final List<String> injuryHistory; // ['IT band syndrome (2023)', ...]
  final double? weeklyMileageBase; // Average weekly km
  
  const UserContext({
    required this.age,
    required this.gender,
    required this.experienceLevel,
    required this.availableDays,
    required this.timeConstraints,
    required this.injuryHistory,
    this.weeklyMileageBase,
  });
  
  Map<String, dynamic> toJson() => {
    'age': age,
    'gender': gender,
    'experience_level': experienceLevel,
    'available_days': availableDays,
    'time_constraints': timeConstraints,
    'injury_history': injuryHistory,
    if (weeklyMileageBase != null) 'weekly_mileage_base': weeklyMileageBase,
  };
}
```

---

### GoalContext

**Purpose**: Goal information for AI context

```dart
class GoalContext {
  final String type; // 'distance_milestone', 'time_performance', 'event', 'maintenance'
  final String target; // 'Sub-30 5K', 'Complete 10K', etc.
  final DateTime deadline;
  final double confidence; // Current confidence score (0-100)
  final List<String> specialInstructions; // ['First workout must be benchmark run', ...]
  final String? currentPace; // '6:30/km' (if applicable)
  
  const GoalContext({
    required this.type,
    required this.target,
    required this.deadline,
    required this.confidence,
    required this.specialInstructions,
    this.currentPace,
  });
  
  Map<String, dynamic> toJson() => {
    'type': type,
    'target': target,
    'deadline': deadline.toIso8601String(),
    'confidence': confidence,
    'special_instructions': specialInstructions,
    if (currentPace != null) 'current_pace': currentPace,
  };
}
```

---

### WorkoutSummary

**Purpose**: Condensed workout information for context (not full Workout entity)

```dart
class WorkoutSummary {
  final DateTime date;
  final String type; // 'easy', 'long', 'tempo', 'intervals', etc.
  final int duration; // minutes
  final double? distance; // km
  final int? rpe; // 1-10
  final bool completed;
  
  const WorkoutSummary({
    required this.date,
    required this.type,
    required this.duration,
    this.distance,
    this.rpe,
    required this.completed,
  });
  
  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'type': type,
    'duration': duration,
    if (distance != null) 'distance': distance,
    if (rpe != null) 'rpe': rpe,
    'completed': completed,
  };
}
```

---

### CoachingChatContext

**Purpose**: Context for coaching chat interactions

```dart
class CoachingChatContext {
  final LongTermContext longTerm;
  final MediumTermContext mediumTerm;
  final ShortTermContext shortTerm;
  
  const CoachingChatContext({
    required this.longTerm,
    required this.mediumTerm,
    required this.shortTerm,
  });
  
  Map<String, dynamic> toJson() => {
    'long_term': longTerm.toJson(),
    'medium_term': mediumTerm.toJson(),
    'short_term': shortTerm.toJson(),
  };
}
```

---

### LongTermContext

**Purpose**: Stable user/goal context (cached)

```dart
class LongTermContext {
  final UserContext user;
  final GoalContext goal;
  final String trainingPhilosophy;
  final double overallAdherence; // From plan start to 14 days ago
  final List<DateTime> raceDays; // All past and future race dates
  
  const LongTermContext({
    required this.user,
    required this.goal,
    required this.trainingPhilosophy,
    required this.overallAdherence,
    required this.raceDays,
  });
  
  Map<String, dynamic> toJson() => {
    'user': user.toJson(),
    'goal': goal.toJson(),
    'training_philosophy': trainingPhilosophy,
    'overall_adherence': overallAdherence,
    'race_days': raceDays.map((d) => d.toIso8601String()).toList(),
  };
}
```

---

### MediumTermContext

**Purpose**: Recent training trends (last 7-14 days, locally aggregated)

```dart
class MediumTermContext {
  final DateTime periodStart;
  final DateTime periodEnd;
  final int workoutsCompleted;
  final int workoutsPlanned;
  final double adherenceRate; // workoutsCompleted / workoutsPlanned
  final double averageRPE;
  final double totalDistance; // km
  final List<String> concerns; // ['Knee pain during long runs', ...]
  final List<String> achievements; // ['Longest run: 12km', ...]
  
  const MediumTermContext({
    required this.periodStart,
    required this.periodEnd,
    required this.workoutsCompleted,
    required this.workoutsPlanned,
    required this.adherenceRate,
    required this.averageRPE,
    required this.totalDistance,
    required this.concerns,
    required this.achievements,
  });
  
  Map<String, dynamic> toJson() => {
    'period': '${periodStart.toIso8601String()} to ${periodEnd.toIso8601String()}',
    'workouts_completed': workoutsCompleted,
    'workouts_planned': workoutsPlanned,
    'adherence_rate': adherenceRate,
    'average_rpe': averageRPE,
    'total_distance': totalDistance,
    'concerns': concerns,
    'achievements': achievements,
  };
}
```

---

### ShortTermContext

**Purpose**: Real-time context for current interaction

```dart
class ShortTermContext {
  final WorkoutSummary? todayWorkout;
  final List<WorkoutSummary> next7Days;
  final List<ConversationMessage> conversationHistory; // Last 20 messages
  final int? currentPainLevel; // 1-10
  final String? sleepQuality; // 'poor', 'fair', 'good', 'excellent'
  final String? weather; // 'Sunny, 20°C', etc.
  
  const ShortTermContext({
    this.todayWorkout,
    required this.next7Days,
    required this.conversationHistory,
    this.currentPainLevel,
    this.sleepQuality,
    this.weather,
  });
  
  Map<String, dynamic> toJson() => {
    if (todayWorkout != null) 'today_workout': todayWorkout!.toJson(),
    'next_7_days': next7Days.map((w) => w.toJson()).toList(),
    'conversation_history': conversationHistory.map((m) => m.toJson()).toList(),
    if (currentPainLevel != null) 'current_pain_level': currentPainLevel,
    if (sleepQuality != null) 'sleep_quality': sleepQuality,
    if (weather != null) 'weather': weather,
  };
}
```

---

## Conversation Entities

### ConversationMessage

**Purpose**: Single message in a chat conversation

**Database Table**: `conversation_messages`

```dart
class ConversationMessage {
  final String id;
  final String conversationId; // Groups messages into sessions
  final String role; // 'user' or 'assistant'
  final String content;
  final DateTime timestamp;
  final FunctionCall? functionCall; // If AI called a function
  
  const ConversationMessage({
    required this.id,
    required this.conversationId,
    required this.role,
    required this.content,
    required this.timestamp,
    this.functionCall,
  });
  
  Map<String, dynamic> toJson() => {
    'role': role,
    'content': content,
    'timestamp': timestamp.toIso8601String(),
    if (functionCall != null) 'function_call': functionCall!.toJson(),
  };
}
```

**Fields**:
- `id`: Unique message ID
- `conversationId`: Groups messages into chat sessions
- `role`: 'user' or 'assistant'
- `content`: Message text
- `timestamp`: When message was sent
- `functionCall`: If AI called a function (optional)

---

### Conversation

**Purpose**: Chat session grouping messages

**Database Table**: `conversations`

```dart
class Conversation {
  final String id;
  final String userId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int messageCount;
  
  const Conversation({
    required this.id,
    required this.userId,
    required this.startedAt,
    this.endedAt,
    required this.messageCount,
  });
}
```

**Usage**: Conversations are created when user opens chat, ended when they close it. This allows limiting to "last 20 messages in current chat session".

---

## AI Request/Response Types

### AIRequest

**Purpose**: Standard structure for all AI API calls

```dart
class AIRequest {
  final String systemPrompt;
  final String taskPrompt;
  final Map<String, dynamic> context;
  final Map<String, dynamic>? responseSchema; // For structured output
  final List<FunctionDeclaration>? tools; // For function calling
  
  const AIRequest({
    required this.systemPrompt,
    required this.taskPrompt,
    required this.context,
    this.responseSchema,
    this.tools,
  });
  
  Map<String, dynamic> toJson() => {
    'system_prompt': systemPrompt,
    'task_prompt': taskPrompt,
    'context': context,
    if (responseSchema != null) 'response_schema': responseSchema,
    if (tools != null) 'tools': tools!.map((t) => t.toJson()).toList(),
  };
}
```

---

### AIResponse

**Purpose**: Standard structure for AI API responses

```dart
class AIResponse<T> {
  final T? data; // Parsed response (TrainingPlan, Workout, String, etc.)
  final String? text; // Text response (if no structured data)
  final FunctionCall? functionCall; // If AI decided to call a function
  final int tokensUsed;
  final DateTime timestamp;
  
  const AIResponse({
    this.data,
    this.text,
    this.functionCall,
    required this.tokensUsed,
    required this.timestamp,
  });
  
  bool get hasFunctionCall => functionCall != null;
  bool get hasText => text != null;
  bool get hasData => data != null;
}
```

---

### FunctionCall

**Purpose**: Represents an AI function call (tool use)

```dart
class FunctionCall {
  final String name; // Function name (e.g., 'reschedule_workouts')
  final Map<String, dynamic> arguments; // Function arguments
  
  const FunctionCall({
    required this.name,
    required this.arguments,
  });
  
  Map<String, dynamic> toJson() => {
    'name': name,
    'arguments': arguments,
  };
  
  factory FunctionCall.fromJson(Map<String, dynamic> json) {
    return FunctionCall(
      name: json['name'] as String,
      arguments: json['arguments'] as Map<String, dynamic>,
    );
  }
}
```

---

### FunctionDeclaration

**Purpose**: Defines a function (tool) that AI can call

```dart
class FunctionDeclaration {
  final String name;
  final String description;
  final Map<String, dynamic> parameters; // JSON schema
  
  const FunctionDeclaration({
    required this.name,
    required this.description,
    required this.parameters,
  });
  
  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'parameters': parameters,
  };
}
```

**Example**:
```dart
final rescheduleWorkouts = FunctionDeclaration(
  name: 'reschedule_workouts',
  description: 'Move workouts to different dates within the training plan',
  parameters: {
    'type': 'object',
    'properties': {
      'workout_ids': {
        'type': 'array',
        'items': {'type': 'string'},
        'description': 'IDs of workouts to reschedule',
      },
      'new_dates': {
        'type': 'array',
        'items': {'type': 'string', 'format': 'date'},
        'description': 'New dates for the workouts',
      },
      'reason': {
        'type': 'string',
        'description': 'Why the user wants to reschedule',
      },
    },
    'required': ['workout_ids', 'reason'],
  },
);
```

---

## Training Plan Response Types

### TrainingPlan

**Purpose**: Complete training plan skeleton returned by AI

```dart
class TrainingPlan {
  final List<PhaseSkeleton> phases;
  final List<TrainingBlockSkeleton> blocks;
  final List<WorkoutSkeleton> workouts;
  final PlanRationale rationale;
  
  const TrainingPlan({
    required this.phases,
    required this.blocks,
    required this.workouts,
    required this.rationale,
  });
  
  factory TrainingPlan.fromJson(Map<String, dynamic> json) {
    return TrainingPlan(
      phases: (json['phases'] as List)
          .map((m) => PhaseSkeleton.fromJson(m))
          .toList(),
      blocks: (json['blocks'] as List)
          .map((m) => TrainingBlockSkeleton.fromJson(m))
          .toList(),
      workouts: (json['workouts'] as List)
          .map((w) => WorkoutSkeleton.fromJson(w))
          .toList(),
      rationale: PlanRationale.fromJson(json['rationale']),
    );
  }
}
```

**Note**: AI returns "Skeletons" with relative offsets and durations. The App "hydrates" these into the core domain entities with absolute dates.

---

### PlanRationale

**Purpose**: AI's explanation of training plan decisions

```dart
class PlanRationale {
  final String overallApproach;
  final String intensityDistribution;
  final String keyWorkouts;
  final String recoveryStrategy;
  
  const PlanRationale({
    required this.overallApproach,
    required this.intensityDistribution,
    required this.keyWorkouts,
    required this.recoveryStrategy,
  });
  
  factory PlanRationale.fromJson(Map<String, dynamic> json) {
    return PlanRationale(
      overallApproach: json['overall_approach'] as String,
      intensityDistribution: json['intensity_distribution'] as String,
      keyWorkouts: json['key_workouts'] as String,
      recoveryStrategy: json['recovery_strategy'] as String,
    );
  }
}
```

---

## Database Tables

### conversation_messages

```sql
CREATE TABLE conversation_messages (
  id TEXT PRIMARY KEY,
  conversation_id TEXT NOT NULL,
  role TEXT NOT NULL, -- 'user' or 'assistant'
  content TEXT NOT NULL,
  timestamp INTEGER NOT NULL,
  function_call_name TEXT,
  function_call_arguments TEXT, -- JSON
  FOREIGN KEY (conversation_id) REFERENCES conversations(id)
);
```

---

### conversations

```sql
CREATE TABLE conversations (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  started_at INTEGER NOT NULL,
  ended_at INTEGER,
  message_count INTEGER NOT NULL DEFAULT 0,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

---

### long_term_context

```sql
CREATE TABLE long_term_context (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  goal_id TEXT NOT NULL,
  context_json TEXT NOT NULL, -- Serialized LongTermContext
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (goal_id) REFERENCES goals(id)
);
```

**Note**: Long-term context is regenerated when goal changes, so it's tied to a specific goal.

---

### medium_term_context

```sql
CREATE TABLE medium_term_context (
  id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  period_start INTEGER NOT NULL,
  period_end INTEGER NOT NULL,
  context_json TEXT NOT NULL, -- Serialized MediumTermContext
  created_at INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

**Note**: Medium-term context is regenerated weekly or on major events.

---

## Usage Examples

### Building Plan Generation Context

```dart
class BuildPlanGenerationContext {
  final UserRepository _userRepo;
  final GoalRepository _goalRepo;
  final WorkoutRepository _workoutRepo;
  
  Future<PlanGenerationContext> execute(String goalId) async {
    final goal = await _goalRepo.getGoal(goalId);
    final user = await _userRepo.getCurrentUser();
    final workouts = await _workoutRepo.getWorkoutsForDateRange(
      startDate: DateTime.now().subtract(Duration(days: 90)),
      endDate: DateTime.now(),
    );
    
    return PlanGenerationContext(
      user: UserContext(
        age: user.age,
        gender: user.gender,
        experienceLevel: user.experienceLevel,
        availableDays: user.availableDays,
        timeConstraints: user.timeConstraints,
        injuryHistory: user.injuryHistory,
        weeklyMileageBase: user.weeklyMileageBase,
      ),
      goal: GoalContext(
        type: goal.type.toString(),
        target: goal.target,
        deadline: goal.deadline,
        confidence: goal.confidence,
        specialInstructions: [
          'First workout MUST be a 20min benchmark run for calibration',
        ],
        currentPace: goal.currentPace,
      ),
      trainingHistory: workouts.map((w) => WorkoutSummary(
        date: w.date,
        type: w.type.toString(),
        duration: w.duration,
        distance: w.distance,
        rpe: w.rpe,
        completed: w.status == WorkoutStatus.completed,
      )).toList(),
      trainingPhilosophy: _getTrainingPhilosophy(goal.type),
    );
  }
}
```

---

### Building Coaching Chat Context

```dart
class BuildCoachingChatContext {
  final UserRepository _userRepo;
  final GoalRepository _goalRepo;
  final WorkoutRepository _workoutRepo;
  final ConversationRepository _conversationRepo;
  final ContextRepository _contextRepo;
  
  Future<CoachingChatContext> execute(String conversationId) async {
    final longTerm = await _contextRepo.getLongTermContext();
    final mediumTerm = await _contextRepo.getMediumTermContext();
    
    final todayWorkout = await _workoutRepo.getWorkoutForDate(DateTime.now());
    final next7Days = await _workoutRepo.getWorkoutsForDateRange(
      startDate: DateTime.now().add(Duration(days: 1)),
      endDate: DateTime.now().add(Duration(days: 7)),
    );
    final history = await _conversationRepo.getRecentMessages(
      conversationId: conversationId,
      limit: 20,
    );
    
    return CoachingChatContext(
      longTerm: longTerm,
      mediumTerm: mediumTerm,
      shortTerm: ShortTermContext(
        todayWorkout: todayWorkout != null ? WorkoutSummary(...) : null,
        next7Days: next7Days.map((w) => WorkoutSummary(...)).toList(),
        conversationHistory: history,
        currentPainLevel: null, // Fetch from user input if available
        sleepQuality: null,
        weather: null,
      ),
    );
  }
}
```

---

## Related Documentation

- **[AI Integration Architecture](../ai_integration.md)** - Overall AI architecture
- **[Core Entities](entities.md)** - Core domain entities (User, Goal, Workout, etc.)
- **[Interfaces](../interfaces.md)** - Repository and service interfaces
- **[MCP Tools](../../ai/mcp_tools.md)** - Function declarations for AI tool use

---

**Last Updated**: 2025-12-29
