import 'dart:convert';

class AIMockData {
  static String get planA => jsonEncode({
        "plan_name": "Marathon Base Builder A",
        "blocks": [
          {
            "id": "block_1",
            "name": "Base Foundation",
            "intent":
                "Focus on high volume, low intensity aerobic work to build your engine.",
            "start_date": "2026-01-05T00:00:00Z",
            "end_date": "2026-02-01T00:00:00Z"
          }
        ],
        "workouts": [
          {
            "id": "mock_w1",
            "name": "Easy Recovery Run",
            "description": "Slow and steady, stay in Zone 2.",
            "scheduled_date": "2026-01-05T08:00:00Z",
            "workout_type": "running",
            "intensity": "low",
            "status": "planned",
            "target_duration_seconds": 2400,
            "target_distance_km": 5.0
          },
          {
            "id": "mock_w2",
            "name": "Long Aerobic Run",
            "description": "Build that endurance.",
            "scheduled_date": "2026-01-07T08:00:00Z",
            "workout_type": "running",
            "intensity": "medium",
            "status": "planned",
            "target_duration_seconds": 5400,
            "target_distance_km": 12.0
          }
        ]
      });

  static String get planB => jsonEncode({
        "plan_name": "Speed & Strength Plan B",
        "blocks": [
          {
            "id": "block_2",
            "name": "Power Phase",
            "intent":
                "Intense intervals and heavy lifting to increase your peak performance.",
            "start_date": "2026-01-05T00:00:00Z",
            "end_date": "2026-02-01T00:00:00Z"
          }
        ],
        "workouts": [
          {
            "id": "mock_w3",
            "name": "VO2 Max Intervals",
            "description": "4x800m at max effort with 2 min rest.",
            "scheduled_date": "2026-01-05T08:00:00Z",
            "workout_type": "running",
            "intensity": "high",
            "status": "planned",
            "target_duration_seconds": 3600,
            "target_distance_km": 8.0
          },
          {
            "id": "mock_w4",
            "name": "Full Body Power",
            "description": "Heavy squats, deadlifts, and presses.",
            "scheduled_date": "2026-01-06T17:00:00Z",
            "workout_type": "strength",
            "intensity": "high",
            "status": "planned",
            "target_duration_seconds": 3600
          }
        ]
      });
}
