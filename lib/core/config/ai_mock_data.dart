import 'dart:convert';

class AIMockData {
  static String get planA => jsonEncode({
        "phases": [
          {
            "id": "phase_1",
            "phaseNumber": 1,
            "phaseType": "Base",
            "durationWeeks": 4,
            "targetWeeklyVolume": "20-25km",
            "targetWeeklyDuration": "180-240min",
            "description": "Building aerobic capacity."
          }
        ],
        "blocks": [
          {
            "id": "block_1",
            "phaseId": "phase_1",
            "blockNumber": 1,
            "name": "Base Foundation",
            "intent":
                "Focus on high volume, low intensity aerobic work to build your engine.",
            "durationDays": 28
          }
        ],
        "workouts": [
          {
            "id": "mock_w1",
            "phaseId": "phase_1",
            "blockId": "block_1",
            "dayNumber": 1,
            "name": "Easy Recovery Run",
            "description": "Slow and steady, stay in Zone 2.",
            "type": "running",
            "intensity": 2, // RPE
            "plannedDuration": 2400,
            "plannedDistance": 5.0,
            "isKey": false
          },
          {
            "id": "mock_w2",
            "phaseId": "phase_1",
            "blockId": "block_1",
            "dayNumber": 3,
            "name": "Long Aerobic Run",
            "description": "Build that endurance.",
            "type": "running",
            "intensity": 4, // RPE
            "plannedDuration": 5400,
            "plannedDistance": 12.0,
            "isKey": true
          }
        ],
        "rationale": {
          "overallApproach": "Gradual volume increase.",
          "intensityDistribution": "80/20 Polarized",
          "keyWorkouts": "Long runs on weekends.",
          "recoveryStrategy": "Active recovery on Mondays."
        }
      });

  static String get planB => jsonEncode({
        "phases": [
          {
            "id": "phase_2",
            "phaseNumber": 1,
            "phaseType": "Build",
            "durationWeeks": 4,
            "targetWeeklyVolume": "30km",
            "targetWeeklyDuration": "300min",
            "description": "Increasing intensity."
          }
        ],
        "blocks": [
          {
            "id": "block_2",
            "phaseId": "phase_2",
            "blockNumber": 1,
            "name": "Power Phase",
            "intent":
                "Intense intervals and heavy lifting to increase your peak performance.",
            "durationDays": 28
          }
        ],
        "workouts": [
          {
            "id": "mock_w3",
            "phaseId": "phase_2",
            "blockId": "block_2",
            "dayNumber": 1,
            "name": "VO2 Max Intervals",
            "description": "4x800m at max effort with 2 min rest.",
            "type": "running",
            "intensity": 9,
            "plannedDuration": 3600,
            "plannedDistance": 8.0,
            "isKey": true
          },
          {
            "id": "mock_w4",
            "phaseId": "phase_2",
            "blockId": "block_2",
            "dayNumber": 2,
            "name": "Full Body Power",
            "description": "Heavy squats, deadlifts, and presses.",
            "type": "strength",
            "intensity": 8,
            "plannedDuration": 3600,
            "isKey": false
          }
        ],
        "rationale": {
          "overallApproach": "Focus on power and speed.",
          "intensityDistribution": "Pyramidal",
          "keyWorkouts": "Intervals and Strength.",
          "recoveryStrategy": "Full rest days."
        }
      });
}
