# AI Implementation TODO

## 🚨 Potential Oversights / Missing Components

### 1. **No Prompt Engineering Strategy Documented**
You mention "specialized prompts" (see [Prompts](../ai/prompts.md)) but don't define:
- [x] 1.1 System prompts for the "Ash" personality
- [x] 1.2 How Ash maintains consistent voice/tone
- [x] 1.3 Guardrails to prevent unsafe exercise advice (e.g., overtraining warnings) - *See [Personality](../ai/prompts/personality.md) for safety protocol & [Planning](../ai/prompts/planning.md) for logic gates.*

### 2. **Missing: Context Summarization Pipeline**
Your 3-tier memory is great in theory, but you need:
- [ ] Define WHO generates the Long-Term and Medium-Term summaries
  - Is it the AI summarizing itself (could drift), or a separate summarization step?
- [ ] Define WHEN summarization runs (nightly cron job? after each session?)
- [ ] Implement summarization logic in the Training Engine

### 3. **No Rate-Limiting / Budget Controls**
What happens if a user chats 100x/day?
- [ ] Implement daily/monthly token limits per user
- [ ] Define fallback behavior when budget exceeded (graceful degradation)
- [ ] Add user-facing messaging for rate limits

### 4. **Screenshot OCR Complexity Underestimated**
Extracting "Training Load: 92" from a Suunto screenshot is non-trivial:
- [ ] Test multi-modal model accuracy with real screenshots
- [ ] Implement OCR failure handling (what if it can't parse?)
- [ ] Design UX for manual fallback when OCR fails
- [ ] Consider image token costs in budget

### 5. **No Observability/Logging Strategy**
For AI apps, you'll want:
- [ ] Log every AI request/response for debugging
- [ ] Track token usage per user
- [ ] Flag weird AI outputs for human review
- [ ] Implement analytics dashboard for AI performance

### 6. **Goal Confidence Calculation Undefined**
You list factors (adherence, workout quality, etc.) but haven't defined **the actual algorithm**:
- [ ] Define exact formula for confidence calculation
- [ ] Document weighting of each factor
- [ ] Implement unit tests for edge cases
- [ ] Make calculation transparent to users (tap to see breakdown)

---

## 🧠 AI Strategies to Consider

### 1. **Context Caching** (Critical!)
Both Gemini and Claude offer prompt caching. Since your Long-Term summary will be identical for many requests, cache it:
- [ ] Implement Gemini context caching ($0.0375/1M cached tokens vs $0.15 uncached)
- [ ] **Saves ~75% on repeated context**
- [ ] Design cache invalidation strategy (when to refresh?)

### 2. **Structured Output Mode**
Force the AI to return JSON (not free-form text) for tool calls:
- [ ] Use Gemini's structured output mode
- [ ] Define JSON schemas for all tool responses
- [ ] Prevents parsing errors and improves reliability

### 3. **Semantic Caching** (Advanced)
Before hitting the AI, check if a similar question was asked recently:
- [ ] Implement semantic similarity check (90% similar = return cached response)
- [ ] Consider tools like GPTCache
- [ ] Define cache TTL and storage strategy

### 4. **System Prompt Optimization**
Keep the Ash "personality" prompt minimal. Every token counts:
- [ ] Write concise system prompt (target: <100 tokens)
- [ ] Example: "You are Ash, a supportive running coach. Be concise, encouraging, and scientifically grounded."
- [ ] NOT a 500-word persona essay
- [ ] A/B test different prompt variations

### 5. **Streaming Responses**
For chat UX, stream tokens as they arrive:
- [ ] Implement streaming API calls
- [ ] Update UI progressively as tokens arrive
- [ ] Feels faster, even if total time is same

### 6. **Tiered Model Strategy**
Use cheap models for simple tasks, expensive for complex:
- [ ] Gemini 1.5 Flash for daily chat/motivation ($0.15 input / $0.60 output)
- [ ] Gemini 1.5 Pro for complex replanning ($1.25 input / $10.00 output)
- [ ] Define clear routing logic between models

---