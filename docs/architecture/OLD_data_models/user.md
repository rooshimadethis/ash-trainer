# User Profile Model

Stores user identity, preferences, and current fitness baseline.

## Schema Definition

```dart
@DataClassName('UserProfile')
class UserProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  // Identity
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get email => text().nullable()();
  
  // Biometric Data
  IntColumn get age => integer().nullable()();
  RealColumn get heightCm => real().nullable()();
  RealColumn get weightKg => real().nullable()();
  
  // Onboarding Data
  TextColumn get activityLevel => text()(); // 'beginner', 'casual', 'regular', 'very_active'
  TextColumn get primaryGoalType => text()(); // 'distance', 'performance', 'maintenance', 'event'
  
  // Pillar Priorities (Flexible JSON structure)
  TextColumn get pillarPriorities => text(); // JSON: {"running": "high", "strength": "medium", "mobility": "low"}
  
  // Training Availability
  IntColumn get daysPerWeek => integer().withDefault(const Constant(4))();
  TextColumn get preferredRestDays => text().nullable()(); // JSON array: ["Sunday"]
  
  // Equipment Access
  TextColumn get equipmentAccess => text()(); // JSON array: ["gym", "dumbbells", "bodyweight"]
  
  // Limitations
  TextColumn get injuries => text().nullable()(); // JSON array of injury objects
  TextColumn get movementRestrictions => text().nullable()(); // JSON array: ["no_overhead_press"]
  
  // Calculated Baselines (updated by Training Engine)
  RealColumn get chronicLoad => real().withDefault(const Constant(0.0))(); // 4-week average load
  RealColumn get acuteLoad => real().withDefault(const Constant(0.0))(); // 7-day load
  RealColumn get currentACWR => real().withDefault(const Constant(0.0))(); // Acute:Chronic ratio
  RealColumn get estimatedVO2Max => real().nullable()();
  RealColumn get maxHeartRate => real().nullable()();
  
  // Metadata
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
```

## Field Details

**Biometric Data Usage:**
- **Age**: Max heart rate calculation (220 - age), age-graded performance
- **Height**: Stride length estimates, body composition context
- **Weight**: Calorie burn estimation, power-to-weight ratios

**Pillar Priorities JSON Example:**
```json
{
  "running": "high",
  "strength": "medium",
  "mobility": "low"
}
```

> [!NOTE]
> Pillar priorities use a flexible JSON structure to allow adding new training pillars (yoga, etc.) without schema changes. **Cycling and swimming are NOT regular pillars**—they are only used as low-impact alternatives during injury recovery (see training_philosophy.md).

**ACWR (Acute:Chronic Workload Ratio) Calculation:**

The Training Engine recalculates ACWR after every workout log. See [Load Management](../data_processing/load_mgmt.md) for the detailed formula and zones.

**Key Relationships:**
- One user → Many goals
- One user → Many training plans
- One user → Many workout logs
