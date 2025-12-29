# Goal Confidence Tracker

A predictive metric that tells users: *"Based on what you're doing, here is the likelihood of hitting your goal."*

The system shows both the confidence percentage **and the specific factors** that caused it to change (e.g., "Confidence dropped 5% due to missed workouts and low adherence").

## 1. Visual Indicator
*   **Percentage**: 0-100% confidence level.
*   **Color-Coded**:
    *   🟢 **90%+**: On Track (Green)
    *   🟡 **75-89%**: At Risk (Yellow)
    *   🟠 **60-74%**: Needs Attention (Orange)
    *   🔴 **<60%**: Critical (Red)
*   **Trend Graph**: Shows historical confidence over the last 4 weeks.

## 2. Calculation Factors
The confidence score is a weighted algorithm of:
1.  **Adherence (40%)**: Completed vs Planned workouts.
2.  **Quality (30%)**: Hitting target RPE/Distances.
3.  **Consistency (15%)**: Frequency of training (even if short).
4.  **Recovery Status (15%)**: ACWR status (Injury risk lowers confidence).

## 🛠️ Technical Logic

| Feature | Logic Engine |
|---------|--------------|
| Confidence Algorithm | [context_engine.md](../../../architecture/data_processing/context_engine.md) |
