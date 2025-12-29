# Biomarkers & Recovery Tracking

Ash automatically collects health data to optimize recovery and detect early signs of overtraining or burnout. This data informs training adjustments without requiring manual input from the user.

## 1. Automated Health Data Collection

Ash integrates with platform health APIs to passively collect recovery and wellness metrics:

### **Android (Health Connect) (MVP)**
*   **Sleep Data**:
    *   Total sleep duration
    *   Sleep stages (deep, light, REM) if available
    *   Sleep quality score (if provided by tracking device)
*   **Heart Metrics**:
    *   Resting Heart Rate (RHR)
    *   Heart Rate Variability (HRV)
*   **Activity Data**:
    *   Steps
    *   Active calories
    *   Non-training physical activity

### **iOS (HealthKit) (Future)**
*   **Sleep Data**:
    *   Sleep analysis (in bed, asleep, awake)
    *   Sleep stages (if available from Apple Watch or third-party apps)
*   **Heart Metrics**:
    *   Resting Heart Rate (RHR)
    *   Heart Rate Variability (HRV)
    *   Respiratory Rate
*   **Activity Data**:
    *   Steps
    *   Active energy
    *   Stand hours

### **Data Sync Frequency**
*   **Passive sync**: Once daily (morning preferred, to inform that day's training)
*   **On-demand sync**: Before workout generation/plan updates

## 2. Recovery Indicators & Training Adjustments

Ash analyzes health data trends to detect recovery issues:

### **Sleep-Based Adjustments**
*   **Poor Sleep (<6 hours or significant drop from baseline)**:
    *   Reduce workout intensity by 1 zone
    *   Shorten duration by 15-20%
    *   Suggest: "Looks like you didn't sleep great. Let's keep it easy today."
*   **Consistently Poor Sleep (3+ nights)**:
    *   Flag for potential overtraining
    *   Trigger recovery week consideration

### **Heart Rate-Based Adjustments**
*   **Elevated RHR (+5-7 bpm above 7-day average)**:
    *   Reduce intensity, keep volume
    *   Suggest: "Your body might need more recovery time."
*   **Elevated RHR (+10+ bpm above baseline)**:
    *   Force easy day or rest
    *   Check for illness/stress
*   **Low HRV (significant drop from baseline)**:
    *   Indicator of stress/fatigue
    *   Reduce training load by 20-30%

### **Activity-Based Adjustments**
*   **High Non-Training Activity (e.g., 15k+ steps on rest day)**:
    *   Account for additional fatigue
    *   Slightly reduce next workout volume

## 3. Motivation & Burnout Tracking

Ash monitors behavioral patterns and self-reported data to detect mental fatigue and loss of motivation.

### **Behavioral Signals**
*   **Workout Skipping Patterns**:
    *   **1-2 skipped workouts**: Normal, no action
    *   **3+ skipped in 2 weeks**: Flag for motivation check-in
    *   **Skipping only hard workouts**: Potential sign of mental fatigue
*   **Workout Completion Trends**:
    *   Consistently cutting workouts short
    *   Reducing intensity without prompting
    *   Delaying workout start times

### **Daily Check-In (Optional, Minimal)**
Ash may ask a single, lightweight question during the daily check-in:

*   **"How are you feeling about training today?"**
    *   Options: **Excited** | **Ready** | **Meh** | **Exhausted** | **Dreading it**

### **Burnout Detection Logic**
When multiple signals align, Ash detects potential burnout:

| Signal Combination | Ash Response |
|-------------------|--------------|
| **3+ skipped workouts + "Exhausted" check-ins** | Suggest recovery week or reduced volume |
| **Consistently cutting workouts short + Low motivation** | "You seem tired. Want to dial things back for a bit?" |
| **Skipping hard workouts + Normal easy runs** | "Mental fatigue detected. Let's focus on fun runs this week." |
| **Poor sleep + Low HRV + "Dreading it" responses** | Force recovery week, check for overtraining |

### **Ash's Approach to Burnout**
*   **Empathetic, not judgmental**: "Training should be challenging, not miserable."
*   **Offer solutions**:
    *   Reduce volume by 30-40%
    *   Switch to "maintenance mode" temporarily
    *   Suggest a deload week
    *   Recommend time off if severe
*   **Reframe goals**: "Let's focus on consistency over intensity for a few weeks."

## 4. Privacy & Data Handling

*   **User Control**: Users can disable automatic health data sync at any time
*   **Transparency**: Show what data is being collected and how it's used
*   **No Sharing**: Health data is never shared with third parties
*   **Local Processing**: Recovery calculations happen on-device when possible

## 🛠️ Technical Logic

| Feature | Logic Engine |
|---------|--------------|
| Recovery Score Calculation | [secondary_markers.md](../../../architecture/data_processing/secondary_markers.md) |
| Burnout Detection | [motivation_tracking.md](../../../architecture/data_processing/motivation_tracking.md) |
| Health Data Integration | [health_apis.md](../../../architecture/integrations/health_apis.md) |
