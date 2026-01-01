import 'package:google_generative_ai/google_generative_ai.dart';

enum AITaskType {
  planGeneration,
  workoutAdjustment,
  rescheduling,
  chat,
  functionCall,
}

/// Builder class for creating GenerationConfig with sensible defaults.
///
/// Provides a fluent interface for configuring AI generation parameters.
/// All parameters are optional and will only be included if explicitly set.
///
/// Example usage:
/// ```dart
/// final config = AIConfigBuilder()
///     .maxOutputTokens(5000)
///     .temperature(0.7)
///     .topP(0.95)
///     .build();
/// ```
class AIConfigBuilder {
  int? _maxOutputTokens;
  String? _responseMimeType;
  double? _temperature;
  int? _topK;
  double? _topP;
  int? _candidateCount;
  List<String>? _stopSequences;

  AIConfigBuilder();

  /// Sets the maximum number of tokens to generate.
  ///
  /// Controls the length of the AI's response. Higher values allow longer responses
  /// but may increase latency and cost.
  AIConfigBuilder maxOutputTokens(int tokens) {
    _maxOutputTokens = tokens;
    return this;
  }

  /// Sets the response MIME type.
  ///
  /// Common values:
  /// - 'application/json' for structured JSON responses
  /// - 'text/plain' for plain text (default if not specified)
  AIConfigBuilder responseMimeType(String mimeType) {
    _responseMimeType = mimeType;
    return this;
  }

  /// Sets the temperature for response generation.
  ///
  /// Controls randomness in the output:
  /// - Lower values (0.0-0.3): More deterministic, focused responses
  /// - Medium values (0.4-0.7): Balanced creativity and consistency
  /// - Higher values (0.8-1.0): More creative, varied responses
  AIConfigBuilder temperature(double temp) {
    _temperature = temp;
    return this;
  }

  /// Sets the top-K sampling parameter.
  ///
  /// Limits the model to consider only the K most likely tokens at each step.
  /// Lower values make output more focused; higher values increase diversity.
  AIConfigBuilder topK(int k) {
    _topK = k;
    return this;
  }

  /// Sets the top-P (nucleus) sampling parameter.
  ///
  /// The model considers the smallest set of tokens whose cumulative probability
  /// exceeds P. Values between 0.9-0.95 are common for balanced outputs.
  AIConfigBuilder topP(double p) {
    _topP = p;
    return this;
  }

  /// Sets the number of response candidates to generate.
  ///
  /// The model will generate multiple responses and you can choose the best one.
  /// Note: This increases API costs proportionally.
  AIConfigBuilder candidateCount(int count) {
    _candidateCount = count;
    return this;
  }

  /// Sets stop sequences that will halt generation.
  ///
  /// When any of these sequences is encountered, generation stops immediately.
  /// Useful for controlling output format or preventing unwanted content.
  AIConfigBuilder stopSequences(List<String> sequences) {
    _stopSequences = sequences;
    return this;
  }

  /// Builds the final GenerationConfig.
  ///
  /// Only includes parameters that were explicitly set via builder methods.
  GenerationConfig build() {
    // Handle stopSequences separately since it requires a non-nullable List
    if (_stopSequences != null) {
      return GenerationConfig(
        maxOutputTokens: _maxOutputTokens,
        responseMimeType: _responseMimeType,
        temperature: _temperature,
        topK: _topK,
        topP: _topP,
        candidateCount: _candidateCount,
        stopSequences: _stopSequences!,
      );
    }

    return GenerationConfig(
      maxOutputTokens: _maxOutputTokens,
      responseMimeType: _responseMimeType,
      temperature: _temperature,
      topK: _topK,
      topP: _topP,
      candidateCount: _candidateCount,
    );
  }
}

/// Central configuration manager for AI generation settings.
///
/// Provides pre-configured settings for different task types and factory methods
/// for creating custom configurations.
class AIConfig {
  static const int defaultMaxOutputTokens = 10000;
  static const String jsonMimeType = 'application/json';

  /// Creates a builder with default max output tokens.
  static AIConfigBuilder defaultBuilder() {
    return AIConfigBuilder().maxOutputTokens(defaultMaxOutputTokens);
  }

  /// Creates a builder configured for JSON responses.
  ///
  /// Includes default max tokens and sets response MIME type to JSON.
  static AIConfigBuilder jsonBuilder() {
    return defaultBuilder().responseMimeType(jsonMimeType);
  }

  /// Gets the appropriate configuration for a specific AI task type.
  ///
  /// Each task type has optimized settings:
  /// - Plan Generation: JSON output, balanced creativity (temp: 0.7)
  /// - Workout Adjustment: JSON output, more deterministic (temp: 0.5)
  /// - Rescheduling: JSON output, very deterministic (temp: 0.3)
  /// - Chat: Plain text, creative responses (temp: 0.9)
  /// - Function Call: Plain text, very deterministic (temp: 0.2)
  static GenerationConfig getConfig(AITaskType taskType) {
    switch (taskType) {
      case AITaskType.planGeneration:
        return jsonBuilder()
            .temperature(
                0.7) // Balanced creativity for generating training plans
            .build();

      case AITaskType.workoutAdjustment:
        return jsonBuilder()
            .temperature(0.5) // More deterministic for workout modifications
            .build();

      case AITaskType.rescheduling:
        return jsonBuilder()
            .temperature(0.3) // Very deterministic for scheduling logic
            .build();

      case AITaskType.chat:
        return defaultBuilder()
            .temperature(0.9) // More creative for conversational responses
            .build();

      case AITaskType.functionCall:
        return defaultBuilder()
            .temperature(0.2) // Very deterministic for function calling
            .build();
    }
  }

  /// Creates a custom builder for one-off configurations.
  ///
  /// Use this when you need a configuration that doesn't match any predefined
  /// task type. Example:
  /// ```dart
  /// final config = AIConfig.custom()
  ///     .maxOutputTokens(5000)
  ///     .temperature(0.8)
  ///     .topP(0.95)
  ///     .build();
  /// ```
  static AIConfigBuilder custom() {
    return AIConfigBuilder();
  }
}
