---
description: Full lifecycle for iterating on your database schema with robust verification using Drift.
---

Follow this workflow to safely update your database schema and ensure migrations are valid. This replaces "guessing" with "verifying".

### 1. Snapshot Current State (Baseline)
Before making ANY changes, ensure you have a snapshot of the *current* valid schema.
If `schemas/drift_schema_v<CURRENT_VERSION>.json` does not exist, run:
// turbo
```bash
dart run drift_dev schema export lib/data/datasources/local/drift_database.dart schemas/
```

### 2. Implement Changes
1. Modify your entity classes (Tables) or DAOs in `lib/data/datasources/local/tables/`.
2. Run code generation to update the database class:
// turbo
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Generate New Snapshot (Target)
1. Open `lib/data/datasources/local/drift_database.dart` and increment `schemaVersion`.
2. Export the *new* schema (this represents your target state):
// turbo
```bash
dart run drift_dev schema export lib/data/datasources/local/drift_database.dart schemas/
```

### 4. Create/Update Migration Test
The "better way" to handle migrations is to **test them**. Do not rely solely on visual inspection of the `if` statements.

1. Create or update `test/generated_migrations_test.dart`.
2. Add a test case that verifies the upgrade from `OLD_VERSION` to `NEW_VERSION`.

**Example Test Template:**
```dart
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations.dart';
import 'package:flutter_test/flutter_test.dart';
// content of your database file, to access the table classes
import 'package:ash_trainer/data/datasources/local/drift_database.dart';

void main() {
  late SchemaVerifier verifier;

  setUpAll(() {
    // GeneratedHelper can be created by drift_dev if configured, but typically we point to the schema folder
    verifier = SchemaVerifier(DriftSchemaHelper());
  });

  test('upgrade from v1 to v2', () async {
    final connection = await verifier.startAt(1);
    final db = AppDatabase.connect(connection);

    // Validate initial state if needed
    // ...

    // Run migration
    await verifier.migrateAndValidate(db, 2);
    
    // Validate data integrity
    // ...
    await db.close();
  });
}
```
*Note: You might need to add `drift_dev` and `drift` to your dev_dependencies if not fully set up for testing.*

### 5. Implement Migration Logic
Now write the `if` statements in `drift_database.dart` inside the `migration` getter.
```dart
MigrationStrategy get migration => MigrationStrategy(
  onUpgrade: (m, from, to) async {
    if (from < 2) {
       await m.addColumn(users, users.age);
    }
    // ...
  }
);
```

### 6. Verify & Commit
1. Run your test: `flutter test test/generated_migrations_test.dart`.
2. If it passes, you have **proven** your `if` statements are correct.
3. Commit both the `schemas/*.json` files and your code changes.
