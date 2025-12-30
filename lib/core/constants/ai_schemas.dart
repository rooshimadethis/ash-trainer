class AISchemas {
  static const Map<String, dynamic> trainingPlan = {
    "type": "object",
    "properties": {
      "mesocycles": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "id": {"type": "string"},
            "name": {"type": "string"},
            "startDate": {"type": "string", "description": "ISO 8601 Date"},
            "endDate": {"type": "string", "description": "ISO 8601 Date"},
            "emphasis": {"type": "string"}
          },
          "required": ["id", "name", "startDate", "endDate", "emphasis"]
        }
      },
      "microcycles": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "id": {"type": "string"},
            "weekNumber": {"type": "integer"},
            "startDate": {"type": "string"},
            "endDate": {"type": "string"},
            "emphasis": {"type": "string"}
          },
          "required": ["id", "weekNumber", "startDate", "endDate", "emphasis"]
        }
      },
      "workouts": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "id": {"type": "string", "description": "Placeholder ID"},
            "scheduledDate": {"type": "string", "description": "ISO 8601 Date"},
            "type": {
              "type": "string",
              "enum": [
                "easy_run",
                "tempo",
                "interval",
                "long_run",
                "recovery",
                "rest"
              ]
            },
            "name": {"type": "string"},
            "plannedDuration": {"type": "integer", "description": "Seconds"},
            "plannedDistance": {"type": "number", "description": "Kilometers"},
            "intensity": {"type": "string"},
            "description": {"type": "string"},
            "status": {
              "type": "string",
              "enum": ["planned"]
            }
          },
          "required": [
            "id",
            "scheduledDate",
            "type",
            "name",
            "plannedDuration",
            "status"
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
    "required": ["mesocycles", "microcycles", "workouts", "rationale"]
  };
}
