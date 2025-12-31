---
description: Full lifecycle for iterating on your database schema without losing data.
---

Follow these steps in order every time you want to change your database structure:

### 1. Define the Change
Update your table definition files in `lib/data/datasources/local/tables/` (e.g., add a new column).

### 2. Generate Code
Run build_runner to update the generated Drift code:
// turbo
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Implement Migration
Open `lib/data/datasources/local/drift_database.dart`:
1. Increment `schemaVersion` by 1.
2. Add a new `if (i == OLD_VERSION)` block inside the `onUpgrade` for-loop.
3. Use `await m.addColumn(table, table.column)` or `m.createTable(table)` for your changes.

### 4. Snapshot Schema (Optional but Recommended)
Export the new schema snapshot for future migration testing:
// turbo
```bash
dart run drift_dev schema export lib/data/datasources/local/drift_database.dart schemas/
```

### 5. Run the App
Launch the app. Drift will detect the version bump and execute your `onUpgrade` logic exactly once.
