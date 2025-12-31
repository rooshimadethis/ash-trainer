---
description: Export the current Drift database schema to a versioned JSON file.
---

1. Ensure your `AppDatabase` class in `lib/data/datasources/local/drift_database.dart` is saved.
2. Run the following command to export the schema of the current `schemaVersion`:
// turbo
```bash
dart run drift_dev schema export lib/data/datasources/local/drift_database.dart schemas/
```
3. This will create a file like `schemas/drift_schema_v2.json`. 
4. Check these into version control so you can generate migration tests later.
