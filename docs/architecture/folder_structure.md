# Folder Structure

Complete directory layout for the Ash Trainer app following Riverpod + Clean Architecture principles.

---

## Root Structure

```
lib/
├── main.dart                    # App entry point
├── app.dart                     # MaterialApp setup, theme, routing
│
├── core/                        # Shared utilities and constants
│   ├── constants/
│   │   ├── app_constants.dart
│   │   └── workout_types.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── colors.dart
│   ├── utils/
│   │   ├── date_utils.dart
│   │   └── validators.dart
│   └── errors/
│       ├── failures.dart
│       └── exceptions.dart
│
├── features/                    # Feature modules
├── data/                        # Data layer implementations
└── infrastructure/              # External services
```

---

## Features Directory

**Organization**: Feature-based with shared domain

```
features/
├── goal_setup/                  # Goal creation and reset flow
│   ├── presentation/
│   │   ├── screens/
│   │   │   ├── welcome_screen.dart
│   │   │   ├── availability_screen.dart
│   │   │   ├── constraints_screen.dart
│   │   │   ├── goal_type_selection_screen.dart
│   │   │   ├── distance_milestone_details_screen.dart
│   │   │   ├── time_performance_details_screen.dart
│   │   │   ├── event_details_screen.dart
│   │   │   ├── maintenance_details_screen.dart
│   │   │   ├── health_permissions_screen.dart
│   │   │   ├── plan_generation_screen.dart
│   │   │   ├── plan_review_screen.dart
│   │   │   ├── first_workout_prompt_screen.dart
│   │   │   ├── workout_tracking_screen.dart
│   │   │   └── post_workout_feedback_screen.dart
│   │   ├── widgets/
│   │   │   ├── goal_type_card.dart
│   │   │   ├── progress_indicator.dart
│   │   │   ├── day_selector.dart
│   │   │   ├── distance_picker.dart
│   │   │   └── time_picker.dart
│   │   └── providers/
│   │       └── goal_setup_provider.dart
│   └── application/
│       └── usecases/
│           ├── create_user_profile.dart
│           ├── create_goal.dart
│           ├── generate_training_plan.dart
│           └── create_baseline_workout.dart
│
├── calendar/                    # Calendar views and workout display
│   ├── presentation/
│   │   ├── screens/
│   │   │   ├── today_view.dart
│   │   │   ├── weekly_view.dart
│   │   │   ├── monthly_view.dart
│   │   │   └── workout_detail_modal.dart
│   │   ├── widgets/
│   │   │   ├── workout_card.dart
│   │   │   ├── recovery_widget.dart
│   │   │   ├── week_summary_card.dart
│   │   │   └── workout_badge.dart
│   │   └── providers/
│   │       └── calendar_provider.dart
│   └── application/
│       └── usecases/
│           ├── get_workouts_for_date.dart
│           ├── get_weekly_summary.dart
│           ├── get_monthly_summary.dart
│           └── get_latest_biomarkers.dart
│
├── goal_progress/               # Goal tracking and confidence
│   ├── presentation/
│   │   ├── screens/
│   │   │   ├── goal_progress_dashboard.dart
│   │   │   ├── factor_detail_screen.dart
│   │   │   ├── confidence_explanation_modal.dart
│   │   │   └── historical_trend_view.dart
│   │   ├── widgets/
│   │   │   ├── confidence_gauge.dart
│   │   │   ├── factor_breakdown_card.dart
│   │   │   ├── trend_graph.dart
│   │   │   └── action_item_card.dart
│   │   └── providers/
│   │       └── goal_progress_provider.dart
│   └── application/
│       └── usecases/
│           ├── calculate_confidence.dart
│           ├── get_confidence_history.dart
│           ├── get_adherence_stats.dart
│           └── get_acwr.dart
│
└── shared/                      # Shared across features
    ├── presentation/
    │   ├── widgets/
    │   │   ├── confidence_widget.dart    # Used by calendar + goal_progress
    │   │   ├── workout_card.dart         # Used by multiple features
    │   │   └── app_button.dart           # Used everywhere
    │   └── providers/
    │       └── goal_provider.dart        # Shared state
    └── domain/
        ├── entities/
        │   ├── user.dart
        │   ├── goal.dart
        │   ├── workout.dart
        │   ├── phase.dart
        │   ├── training_block.dart
        │   ├── biomarker.dart
        │   ├── injury_record.dart
        │   ├── acwr_record.dart
        │   └── goal_confidence_history.dart
        └── repositories/
            ├── user_repository.dart
            ├── goal_repository.dart
            ├── workout_repository.dart
            ├── phase_repository.dart
            ├── training_block_repository.dart
            ├── biomarker_repository.dart
            ├── injury_repository.dart
            └── acwr_repository.dart
```

---

## Data Directory

**Organization**: Repository implementations and data sources

```
data/
├── repositories/
│   ├── user_repository_impl.dart
│   ├── goal_repository_impl.dart
│   ├── workout_repository_impl.dart
│   ├── phase_repository_impl.dart
│   ├── training_block_repository_impl.dart
│   ├── biomarker_repository_impl.dart
│   ├── injury_repository_impl.dart
│   └── acwr_repository_impl.dart
│
├── datasources/
│   ├── local/
│   │   ├── drift_database.dart           # Main database file
│   │   ├── drift_database.g.dart         # Generated code
│   │   ├── tables/
│   │   │   ├── users_table.dart
│   │   │   ├── goals_table.dart
│   │   │   ├── phases_table.dart
│   │   │   ├── training_blocks_table.dart
│   │   │   ├── phases_table.dart
│   │   │   ├── training_blocks_table.dart
│   │   │   ├── biomarkers_table.dart
│   │   │   ├── injury_records_table.dart
│   │   │   ├── acwr_records_table.dart
│   │   │   └── goal_confidence_history_table.dart
│   │   └── daos/
│   │       ├── user_dao.dart
│   │       ├── goal_dao.dart
│   │       ├── workout_dao.dart
│   │       ├── phase_dao.dart
│   │       ├── training_block_dao.dart
│   │       ├── biomarker_dao.dart
│   │       ├── injury_dao.dart
│   │       └── acwr_dao.dart
│   ├── remote/
│   │   └── gemini_api_client.dart
│   └── health/
│       └── health_connect_datasource.dart
│
└── models/
    ├── user_dto.dart
    ├── goal_dto.dart
    ├── workout_dto.dart
    ├── phase_dto.dart
    ├── training_block_dto.dart
    ├── biomarker_dto.dart
    ├── injury_dto.dart
    └── acwr_dto.dart
```

---

## Infrastructure Directory

**Organization**: External services and providers

```
infrastructure/
├── services/
│   ├── ai_service.dart
│   ├── ai_service_impl.dart
│   ├── health_service.dart
│   ├── health_service_impl.dart
│   ├── analytics_service.dart
│   └── analytics_service_impl.dart
└── providers/
    └── service_providers.dart            # Riverpod setup for services
```

---

## Widget Sharing Strategy

### Rule of Thumb

1. **Start in feature folder** - Build widget where first needed
2. **Move to shared when reused** - Promote to `features/shared/presentation/widgets/` when another feature needs it
3. **Import from shared** - Both features import from shared location

### Example

```dart
// Initially: features/goal_progress/presentation/widgets/confidence_widget.dart
// After reuse: features/shared/presentation/widgets/confidence_widget.dart

// Import in calendar screen
import 'package:ash_trainer/features/shared/presentation/widgets/confidence_widget.dart';

// Import in goal progress screen
import 'package:ash_trainer/features/shared/presentation/widgets/confidence_widget.dart';
```

---

## File Naming Conventions

- **Screens**: `*_screen.dart` (e.g., `today_view.dart`, `goal_progress_dashboard.dart`)
- **Widgets**: `*_widget.dart` or descriptive name (e.g., `workout_card.dart`, `confidence_gauge.dart`)
- **Providers**: `*_provider.dart` (e.g., `calendar_provider.dart`)
- **Use Cases**: Descriptive verb phrase (e.g., `calculate_confidence.dart`, `get_workouts_for_date.dart`)
- **Repositories**: `*_repository.dart` for interface, `*_repository_impl.dart` for implementation
- **DAOs**: `*_dao.dart` (e.g., `goal_dao.dart`)
- **Tables**: `*_table.dart` (e.g., `goals_table.dart`)

---

## Import Organization

Follow Dart conventions:

```dart
// 1. Dart imports
import 'dart:async';

// 2. Flutter imports
import 'package:flutter/material.dart';

// 3. Package imports
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';

// 4. Relative imports (same package)
import '../../../domain/entities/goal.dart';
import '../../providers/goal_provider.dart';
```

---

**Last Updated**: 2025-12-29
