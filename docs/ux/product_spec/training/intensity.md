# Intensity & Autoregulation

Ash uses **Rate of Perceived Exertion (RPE)** as the primary integrity metric, allowing users to autoregulate based on daily readiness.

## 1. RPE Definitions

### Running Zones
| RPE | Zone | Feeling | Talk Test |
|-----|------|---------|-----------|
| **1-2** | Recovery | Very Light | Effortless singing |
| **3-4** | **Aerobic / Easy** | Light | Full sentences, conversational |
| **5-6** | **Moderate** | Somewhat Hard | Short sentences, broken conversation |
| **7-8** | **Threshold / Tempo** | Hard | A few words at a time |
| **9** | **VO2 Max** | Very Hard | One or two words only |
| **10** | Max Effort | All Out | Gasping for air |

### Strength Training (Reps In Reserve)
We use **RIR** (Reps In Reserve) to prescribe strength intensity.
*   **Easy (3-4 RIR)**: Warm-ups, technique work.
*   **Moderate (2-3 RIR)**: Working sets. Sustainable.
*   **Hard (0-1 RIR)**: Key strength sets. Near failure.

## 2. Autoregulation Philosophy

**"Hit the RPE, not the pace."**

We prescribe effort, not rigid numbers. This prevents injury and burnout.
*   **Feeling Strong?** Push the pace/weight while staying in the target RPE zone.
*   **Feeling Tired?** Slow down/reduce weight to stay in the zone.
*   **Result:** The physiological stimulus (Heart Rate, Stress) remains correct regardless of external performance.

## 3. Weather Adaptations

Ash automatically adjusts RPE targets or suggests modifications based on environment.

| Condition | Adaptation |
|-----------|------------|
| **Heat** | Reduce intensity targets by 1 RPE level. Suggest indoor options. |
| **Extreme Cold** | Suggest extended warm-up. Cap intensity to avoid lung irritation. |
| **Poor Air Quality** | **Override**: Suggest indoor workout or rest day. |

## 🛠️ Technical Logic

| Feature | Logic Engine |
|---------|--------------|
| Load Calculations | [load_mgmt.md](../../../architecture/data_processing/load_mgmt.md) |
| Context Engine | [context_engine.md](../../../architecture/data_processing/context_engine.md) |
