class AISchemas {
  static const Map<String, dynamic> trainingPlan = {
    "type": "object",
    "properties": {
      "phases": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "id": {"type": "string"},
            "phaseNumber": {"type": "integer"},
            "phaseType": {
              "type": "string",
              "enum": ["base", "build", "peak", "taper", "recovery"]
            },
            "durationWeeks": {"type": "integer"},
            "targetWeeklyVolume": {"type": "string"},
            "targetWeeklyDuration": {"type": "string"},
            "description": {"type": "string"}
          },
          "required": [
            "id",
            "phaseNumber",
            "phaseType",
            "durationWeeks",
            "targetWeeklyVolume",
            "targetWeeklyDuration"
          ]
        }
      },
      "blocks": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "id": {"type": "string"},
            "phaseId": {"type": "string"},
            "blockNumber": {"type": "integer"},
            "intent": {"type": "string"},
            "durationDays": {"type": "integer"}
          },
          "required": ["id", "phaseId", "blockNumber", "intent", "durationDays"]
        }
      },
      "workouts": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "id": {"type": "string", "description": "Placeholder ID"},
            "phaseId": {"type": "string"},
            "blockId": {"type": "string"},
            "dayNumber": {
              "type": "integer",
              "description":
                  "Day number relative to the start of the BLOCK (1-based)"
            },
            "type": {
              "type": "string",
              "enum": [
                "easy_run",
                "tempo",
                "interval",
                "long_run",
                "recovery",
                "rest",
                "strength",
                "mobility"
              ]
            },
            "name": {"type": "string"},
            "plannedDuration": {"type": "integer", "description": "Seconds"},
            "plannedDistance": {"type": "number", "description": "Kilometers"},
            "intensity": {
              "type": "integer",
              "description":
                  "Rate of Perceived Exertion (RPE) as a number from 1-10",
              "minimum": 1,
              "maximum": 10
            },
            "description": {"type": "string"},
            "isKey": {"type": "boolean", "default": false},
            "strengthExercises": {
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "name": {"type": "string"},
                  "sets": {"type": "integer"},
                  "reps": {"type": "string"},
                  "rpe": {"type": "integer"},
                  "notes": {"type": "string"}
                },
                "required": ["name", "sets", "reps", "rpe"]
              }
            },
            "mobilitySequence": {
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "exerciseName": {"type": "string"},
                  "targetJoint": {"type": "string"},
                  "setupInstructions": {"type": "string"},
                  "totalCycles": {"type": "integer"},
                  "phases": {
                    "type": "array",
                    "items": {
                      "type": "object",
                      "properties": {
                        "phaseType": {"type": "string"},
                        "durationSeconds": {"type": "integer"},
                        "intensityNotes": {"type": "string"},
                        "irradiationPct": {"type": "integer"},
                        "instruction": {"type": "string"},
                        "reps": {"type": "integer"},
                        "holdTimeSeconds": {"type": "integer"}
                      },
                      "required": ["phaseType"]
                    }
                  }
                },
                "required": [
                  "exerciseName",
                  "targetJoint",
                  "setupInstructions",
                  "phases",
                  "totalCycles"
                ]
              }
            }
          },
          "required": [
            "id",
            "phaseId",
            "blockId",
            "dayNumber",
            "type",
            "name",
            "plannedDuration",
            "intensity",
            "description"
          ]
        }
      },
      "rationale": {
        "type": "object",
        "properties": {
          "overallApproach": {"type": "string"},
          "intensityDistribution": {"type": "string"},
          "keyWorkouts": {"type": "string"},
          "recoveryStrategy": {"type": "string"}
        },
        "required": [
          "overallApproach",
          "intensityDistribution",
          "keyWorkouts",
          "recoveryStrategy"
        ]
      }
    },
    "required": ["phases", "blocks", "workouts", "rationale"]
  };

  static const Map<String, dynamic> adjustedWorkout = {
    "type": "object",
    "properties": {
      "id": {"type": "string"},
      "type": {"type": "string"},
      "name": {"type": "string"},
      "plannedDuration": {"type": "integer"},
      "plannedDistance": {"type": "number"},
      "intensity": {
        "type": "integer",
        "description": "Rate of Perceived Exertion (RPE) as a number from 1-10",
        "minimum": 1,
        "maximum": 10
      },
      "description": {"type": "string"}
    },
    "required": [
      "id",
      "type",
      "name",
      "plannedDuration",
      "intensity",
      "description"
    ]
  };

  static const Map<String, dynamic> rescheduleWorkouts = {
    "type": "array",
    "items": {
      "type": "object",
      "properties": {
        "id": {"type": "string"},
        "scheduledDate": {"type": "string"},
        "dayNumber": {"type": "integer"}
      },
      "required": ["id", "scheduledDate"]
    }
  };
}
