# Plan: Calendar Block & Phase Visualization

## Objective
Make training blocks and phases visible in the calendar views (Weekly & Monthly) so users can visually identify related groups of workouts and the broader training context.

## 1. Visual Design Strategy

### A. Color Coding for Blocks
We need a consistent color scheme for training blocks based on their **Intent**.
We will add these to `AppColors` and `TrainingBlockSkeleton` logic.

| Block Intent | Concept | Color |
| :--- | :--- | :--- |
| **Base / Foundation** | Building capacity, safe | `Teal` / `Cyan` |
| **Build / Accumulation** | Increasing load, hard work | `Orange` / `Amber` |
| **Peak / Intensity** | Max effort, sharp | `Red` / `Pink` |
| **Taper / Recovery** | Restoring energy, fresh | `Blue` / `Indigo` |
| **Race** | The event | `Gold` |

### B. UI Implementation

#### Monthly View
*   **Concept**: similar to "Multi-day events" in standard calendars.
*   **Implementation**:
    *   Apply a subtle **background tint** (`opacity 0.05` - `0.1`) to the day cells belonging to a block.
    *   Add a **colored strip** (3-4px height) at the bottom or top of the day cell representing the phase/block color.
    *   If a block transitions mid-week, the colors change accordingly.

#### Weekly View
*   **Concept**: Grouping columns.
*   **Header approach**: Add a row *above* the day columns that shows "Block 1: Base" spanning the relevant days.
*   **Background approach**: Tint the background of the day columns `DayColumn` container.
*   **Recommendation**:
    *   **Background Tint**: Subtle, full-height tint behind the day column.
    *   **Label**: Add a small label in the UI header (e.g., "Week 3 of 12 (Base Block)") - *Already partially implemented, need to make dynamic.*

## 2. Technical Architecture

### A. Data Layer (`TrainingPlanDao` & `WorkoutRepository`)
*   **Current State**: Repository only fetches `Workouts`.
*   **Requirement**: Need to fetch `TrainingBlock`s that intersect with a given date range.
*   **Dao Method**: `getBlocksForDateRange(DateTime start, DateTime end)`.
*   **Repository Method**: `getBlocksForDateRange(...)`.

### B. State Management (`CalendarProvider`)
*   **Current State**: `weeklyWorkoutsProvider` returns `List<Workout>`.
*   **Change**: We need a composite state object or a parallel provider.
*   **New Provider**: `calendarBlocksProvider(range)` returns `List<TrainingBlock>`.
*   **Refactor**: Create a `CalendarViewData` class containing both workouts and active blocks to prevent waterfall loading.

## 3. Implementation Steps

1.  **Define Colors**: Add Block semantic colors to `lib/core/theme/colors.dart`.
2.  **Update DAO**: Implement `getBlocksForDateRange` in `TrainingPlanDao`.
3.  **Update Repository**: Expose block fetching in `WorkoutRepository`.
4.  **Update Providers**: Update `CalendarProvider` to fetch blocks alongside workouts.
5.  **UI - Weekly View**:
    *   Subscribe to block data.
    *   Map days to blocks.
    *   Render background tint and/or "Block Name" label.
6.  **UI - Monthly View**:
    *   Subscribe to block data.
    *   Render subtle background tint for day cells.

## 4. Open Questions
*   **Phases**: Should we visualize Phases distinct from Blocks?
    *   *Suggestion*: Phases are usually just containers for blocks (e.g., Phase 1 contains Base 1, Base 2). Visualizing *Blocks* is usually sufficient for the "mesocycle" view. We can display the Phase Name in the header text instead of coloring the grid.
