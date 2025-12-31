# Time Off & Recovery Protocols

Ash acknowledges that life happens. We manage breaks proactively.

## 1. Time Off Mode

When a user submits time off (vacation, travel, etc.), Ash enters **Time Off Mode**:

*   **Scheduled Training**: All pre-planned workouts are removed for the time-off period.
*   **Notifications**: Completely suppressed during time off.
*   **Ad-Hoc Workouts**: Users can still request workouts at any time:
    *   *"Give me a 20-min hotel room circuit."*
    *   *"I want to run this morning, what should I do?"*
*   **AI Volume/Intensity Adjustment**: When fulfilling ad-hoc requests, the AI analyzes:
    *   Duration of current time off
    *   Recent activity history (pre-time-off training load)
    *   Any logged activities during time off
    *   To determine appropriate volume and intensity for the requested workout

## 2. Dealing with Sickness

We prioritize long-term health over short-term gains.

| Sickness Level | Protocol | Return Strategy |
|----------------|----------|-----------------|
| **Mild (Head cold)** | Reduce intensity to Zone 1/2. | Resume at 50% volume. |
| **Moderate (Fever/Chest)** | **Force Rest**. No training. | Wait for 72h symptom-free. Restart at 30% volume. |
| **Severe** | Consult doctor. | Rebuild from beginner base. |

## 3. Return-to-Training Logic

When a user returns after a break (Planned or Unplanned), Ash adjusts the volume:

*   **<1 week off**: Resume at 100% of previous volume (minimal detraining).
*   **1-2 weeks off**: Resume at 70-75% of previous volume.
*   **2-4 weeks off**: Resume at 50-60% of previous volume.
*   **4-8 weeks off**: Resume at 40-50% of previous volume, expect 2-3 weeks to return to baseline.
*   **2+ months off**: Restart with Base Building phase (walk/run intervals if needed).

## 🛠️ Technical Logic

| Feature | Logic Engine |
|---------|--------------|
| Time Off Calculations | [time_off.md](../../../architecture/data_processing/time_off.md) |
