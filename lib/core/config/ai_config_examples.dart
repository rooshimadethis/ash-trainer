/// Examples of how to use the AIConfig builder pattern.
///
/// This file demonstrates various ways to create custom AI configurations
/// for different use cases beyond the predefined task types.
library;

import 'package:google_generative_ai/google_generative_ai.dart';
import 'ai_config.dart';

class AIConfigExamples {
  /// Example 1: High-quality, creative content generation
  ///
  /// Use case: Generating motivational messages or creative workout descriptions
  static GenerationConfig creativeContent() {
    return AIConfig.custom()
        .maxOutputTokens(2000)
        .temperature(0.9) // High creativity
        .topP(0.95) // Consider diverse token options
        .build();
  }

  /// Example 2: Very deterministic, short responses
  ///
  /// Use case: Quick yes/no decisions or simple classifications
  static GenerationConfig deterministicShort() {
    return AIConfig.custom()
        .maxOutputTokens(500)
        .temperature(0.1) // Very deterministic
        .topK(10) // Only consider top 10 tokens
        .build();
  }

  /// Example 3: JSON output with custom token limit
  ///
  /// Use case: Generating smaller JSON structures like single workout adjustments
  static GenerationConfig compactJson() {
    return AIConfig.jsonBuilder()
        .maxOutputTokens(3000)
        .temperature(0.4)
        .build();
  }

  /// Example 4: Using stop sequences
  ///
  /// Use case: Controlling output format by stopping at specific markers
  static GenerationConfig withStopSequences() {
    return AIConfig.custom()
        .maxOutputTokens(5000)
        .temperature(0.6)
        .stopSequences(['END_RESPONSE', '---']).build();
  }

  /// Example 5: Multiple candidates for best-of-N selection
  ///
  /// Use case: Generate multiple workout suggestions and pick the best one
  /// Note: This increases API costs proportionally!
  static GenerationConfig multipleOptions() {
    return AIConfig.jsonBuilder()
        .maxOutputTokens(4000)
        .temperature(0.7)
        .candidateCount(3) // Generate 3 different responses
        .build();
  }

  /// Example 6: Override a predefined config
  ///
  /// Use case: Start with a task type config but customize it
  static GenerationConfig customizedPlanGeneration() {
    // You can't directly modify the result of getConfig(), but you can
    // recreate it with modifications using the builder pattern
    return AIConfig.jsonBuilder()
        .maxOutputTokens(15000) // Larger than default for complex plans
        .temperature(0.6) // Slightly less creative than default 0.7
        .topP(0.9)
        .build();
  }

  /// Example 7: Cost-optimized configuration
  ///
  /// Use case: When you want to minimize token usage for simple tasks
  static GenerationConfig costOptimized() {
    return AIConfig.custom()
        .maxOutputTokens(1000) // Much lower than default
        .temperature(0.3)
        .build();
  }
}
