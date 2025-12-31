# Onboarding Flow

The initial "interview" where Ash learns about the user to generate Week 1.

## 1. The Interview
*   **Goal**: "What are we training for?" (Select Goal Type)
*   **Goal Details**: Specific parameters based on goal type (distance, target time, event name, etc.)
*   **Training Context**: "How are you training?" (Training frequency, weekly volume, pillar priorities)
*   **Personal Details**: Age, gender, weight, height
*   **Availability**: "Which days can you train?" (Frequency)
*   **Constraint Check**: "Any injuries or time limits?"
*   **Health Permissions**: Connect to health data for automatic tracking

## 2. Plan Generation Logic
*   **Input**: Training Frequency & Weekly Volume (from Training Context)
*   **Output**: Starting Volume and intensity distribution (Pyramidal vs. Polarized)
*   **Input**: Goal Type (Example: "Time Performance")
*   **Output**: Phase structure and workout types
*   **Input**: Pillar Priorities (Running/Strength/Mobility)
*   **Output**: Coordinated workout scheduling across pillars

See [goal_types.md](../training/goal_types.md) for detailed mapping of Goal Type to Plan Structure.

## 3. The "First Date" Workout
*   **Description**: A low-pressure benchmark run (e.g., 20 min easy).
*   **Purpose**: Calibrate RPE and verify user's starting point.

## 🛠️ Technical Logic

| Feature | Logic Engine |
|---------|--------------|
| Profile Creation | [user.md](../../../architecture/data_models/user.md) |
