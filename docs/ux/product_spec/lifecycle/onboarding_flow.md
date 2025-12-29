# Onboarding Flow

The initial "interview" where Ash learns about the user to generate Week 1.

## 1. The Interview
*   **Goal**: "What are we training for?" (Select Goal Type)
*   **History**: "How much have you run in the last month?" (Determines Base Volume)
*   **Availability**: "Which days can you train?" (Frequency)
*   **Constraint Check**: "Any injuries or time limits?"

## 2. Plan Generation Logic
*   **Input**: Activity Level (Example: "Casually Active")
*   **Output**: Starting Volume (Example: 20km/week)
*   **Input**: Goal Type (Example: "Time Performance")
*   **Output**: Intensity Distribution (Polarized 80/20)

See [goal_types.md](../training/goal_types.md) for detailed mapping of Goal Type to Plan Structure.

## 3. The "First Date" Workout
*   **Description**: A low-pressure benchmark run (e.g., 20 min easy).
*   **Purpose**: Calibrate RPE and verify user's starting point.

## 🛠️ Technical Logic

| Feature | Logic Engine |
|---------|--------------|
| Profile Creation | [user.md](../../../architecture/data_models/user.md) |
