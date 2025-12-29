# Injury Management & Prevention

Ash acts as a first line of defense, not a doctor. We modify training to work around pain, but we do not diagnose.

## 1. Post-Training Pain Check-In

After each training session, Ash asks the user about pain and discomfort to catch issues early:

*   **Pain Point Identification**: "Any areas feeling sore or painful after that workout?"
    *   User can select body areas (knee, ankle, hip, lower back, etc.)
    *   Rate pain severity (1-10 scale)
*   **Pain Progression Tracking**: For previously reported pain points:
    *   "How's your [knee] feeling after today's run?"
    *   Options: **Better** | **Same** | **Worse**
*   **AI Response**:
    *   **New Pain (1-3/10)**: Monitor, continue training with awareness
    *   **New Pain (4+/10)**: Trigger "Compensate" logic (see below)
    *   **Existing Pain - Worse**: Escalate to more conservative protocol
    *   **Existing Pain - Better**: Continue current approach
    *   **Existing Pain - Same for 3+ sessions**: Consider modification or escalation

This data feeds into the injury tracking system and informs future workout planning.

## 2. The "Compensate" Logic

When a user reports pain, we **Adjust**, we don't just Quit.

**Scenario**: "My knee hurts when I run."
*   **Ash Action**:
    1.  **Cut High Impact**: Remove the run.
    2.  **Add Low Impact**: detailed below.
    3.  **Flag**: Mark user as "Injured Status" for 48h check-in.

## 3. Low-Impact Swaps (Injury Mode Only)

Ash does not prescribe cycling/swimming regularly, but suggests them when running is painful.

*   **Running Replacement**: Cycling, Elliptical (Zone 2 Heart Rate).
*   **Strength Replacement**: "Knee-Friendly" lower body (Glute bridges) or shift focus to Upper Body.
*   **Mobility Focus**: Isolate the area (e.g., Hip mobility for runner's knee).

## 4. Escalation Protocol

| Duration of Pain | Protocol | Advice |
|------------------|----------|--------|
| **1-3 Days** | Reduce Intensity & Volume. | "Let's take it easy and loosen up." |
| **3-5 Days** | **Force Rest** or Cross-Train only. | "Time to rest the legs completely." |
| **5+ Days** | **Medical Referral**. Pause Plan. | "Please see a doctor. We pause here." |

## 5. Medical Disclaimer
> "I'm here to help you train, not diagnose injuries. If something hurts for more than a few days, it's time to see a pro."

Ash will **never** attempt to diagnose based on symptoms.

## 🛠️ Technical Logic

| Feature | Logic Engine |
|---------|--------------|
| Swap Logic | [pillar_logic.md](../../../architecture/data_processing/pillar_logic.md) |
| Safety Calculations | [load_mgmt.md](../../../architecture/data_processing/load_mgmt.md) |
