# AI Cost Saving & Optimization Strategy

This document outlines strategies to reduce AI inference costs and improve performance for Ash Trainer, specifically targeting the Google Gemini integration.

## 1. Eliminate Redundant Context Usage (High Impact)

**Problem:**
In the current `AIServiceImpl.chat` implementation, the conversation history is being sent to the model **twice** for every request, significantly doubling the token usage for history.

1.  It is passed to `startChat(history: history)`.
2.  It is included in the `systemInstruction` via `context.toJson()`, which contains `shortTerm.conversationHistory`.

**Solution:**
Remove `conversationHistory` from the context object before serializing it for the `systemInstruction`.

**Estimated Savings:**
~40-50% of input tokens for long conversations.

## 2. Optimize Context Data (Medium Impact)

**Problem:**
The `PlanGenerationContext` includes the full `trainingHistory` (list of `WorkoutSummary`). As the user logs more workouts (e.g., over a year), this list will grow linearly, consuming thousands of tokens per request.

**Solution:**
*   **Summarization**: Instead of sending raw logs, calculate and send aggregate metrics (e.g., "Weekly Average Mileage", "Avg RPE last month", "Last Long Run").
*   **Windowing**: Only send the last N weeks (e.g., 4-8 weeks) of detailed logs.
*   **Pruning**: Remove null or optional fields from the JSON context before sending (e.g., if `distance` is null, don't include the key).

## 3. Leverage Native Structured Outputs (Low to Medium Impact)

**Problem:**
The current implementation manually injects the `responseSchema` into the text prompt string. This consumes input tokens to describe the schema.

**Solution:**
Use the native `responseSchema` parameter in `gemini.GenerationConfig`. This offloads the schema enforcement to the model configuration (often handled more efficiently by the API) and removes the need to include the verbose schema JSON in the prompt text.

*Note: Requires ensuring the `google_generative_ai` SDK version supports `responseSchema`.*

## 4. Model Selection Strategy

**Current Status:**
The app is configured to use `gemini-3-flash-preview` (likely a placeholder or future model).

**Recommendation:**
*   **Primary Model**: Explicitly use `gemini-1.5-flash` for all high-frequency tasks (Chat, Workout Adjustment). It is significantly cheaper and faster than Pro models.
*   **Heavy Lifting**: Reserve `gemini-1.5-pro` only for the `generatePlan` task if complex reasoning is required (e.g., initial 12-week plan creation).
*   **Dynamic Selection**: Configure `AIConstants` to allow switching models based on the task type.

## 5. Implement Caching (Future Work)

**Strategy:**
*   **Plan Caching**: Store the generated Training Plan locally. Do not regenerate the plan unless the user explicitly requests a change or updates their goal/constraints.
*   **Context Caching**: If the user sends multiple messages in quick succession without state changes, previous context calculations could technically be reused, though Gemini Context Caching API is likely overkill for individual user sessions unless they are very long.

## 6. Token Usage Monitoring

**Action:**
Add logging for `response.usageMetadata.totalTokenCount` to an analytics service (e.g., Firebase Analytics) to track real-world costs per user and identify "heavy" users or features.

## 7. Handle Model Loops (Reliability & Cost)

**Problem:**
Generative models can occasionally get stuck in repetition loops (repeating the same word or phrase indefinitely), which not only degrades user experience but also consumes the maximum allowed output tokens, spiking costs.

**Solution:**
*   **`maxOutputTokens`**: Set a strict limit on `maxOutputTokens` in the `GenerationConfig`. For chat responses, this should be reasonable (e.g., 500-1000 tokens) to prevent runaway costs if a loop occurs.
*   **`stopSequences`**: If the prompt structure uses specific delimiters (e.g., "User:", "Model:"), add these to `stopSequences` to ensure the model stops generating if it hallucinates the start of a new turn.
*   **Detection**: Implement client-side logic to detect repetition in the stream (e.g., if the same substring appears X times in a row) and abort the connection `chatSession.sendMessage` early.
*   **Temperature**: Avoid setting `temperature` too low (near 0) for creative tasks, as it can sometimes increase the likelihood of repetitive loops. Keep it around 0.7-1.0 for chat.
