import 'package:google_generative_ai/google_generative_ai.dart';

enum AITaskType {
  planGeneration,
  workoutAdjustment,
  rescheduling,
  chat,
  functionCall,
}

class AIConfig {
  static const int defaultMaxOutputTokens = 10000;

  static GenerationConfig getConfig(AITaskType taskType) {
    switch (taskType) {
      case AITaskType.planGeneration:
        return GenerationConfig(
          responseMimeType: 'application/json',
          maxOutputTokens: defaultMaxOutputTokens,
        );
      case AITaskType.workoutAdjustment:
        return GenerationConfig(
          responseMimeType: 'application/json',
          maxOutputTokens: defaultMaxOutputTokens,
        );
      case AITaskType.rescheduling:
        return GenerationConfig(
          responseMimeType: 'application/json',
          maxOutputTokens: defaultMaxOutputTokens,
        );
      case AITaskType.chat:
      case AITaskType.functionCall:
        // Chat tasks might not need JSON response type by default unless specified
        // But the current implementation seems to expect text, except for function calls which are handled by the SDK.
        // For standard chat, we usually want plain text.
        return GenerationConfig(
          maxOutputTokens: defaultMaxOutputTokens,
        );
    }
  }
}
