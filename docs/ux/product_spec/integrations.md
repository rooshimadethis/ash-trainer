# Data Integration & Wearable Sync

## 1. Integration Strategy

Ash employs a multi-path strategy to maximize compatibility for MVP:

### Option 1: Health Connect (Primary)
- **Role**: Central hub for Android health data
- **Flow**: Wearable App (Suunto/Garmin) -> Health Sync -> Health Connect -> Ash
- **Pros**: Standardized, privacy-conscious, supports multiple sources
- **Cons**: Not real-time (periodic sync), requires Health Sync app for some watches

### Option 2: Manual/File Import
- **Role**: Fallback for deep data
- **Flow**: User exports FIT/GPX file -> Ash parses
- **Pros**: Full data fidelity
- **Cons**: Poor UX (manual steps)

## 2. Data Requirements

### Essential (MVP)
- **Distance**: Total km/miles
- **Duration**: Total time
- **Date/Time**: Timestamp
- **Pace**: Average pace
- **Type**: Activity type (Run, Walk, etc.)

### Advanced (Phase 2)
- **Heart Rate**: Avg/Max, continuous series
- **GPS Track**: Route visual
- **Elevation**: Gain/loss
- **Splits**: Per-km pacing

## 3. Screenshot Upload Feature

To bridge data gaps (e.g., proprietary "Training Load" scores not in Health Connect), Ash supports screenshot analysis:
1. User uploads screenshot of watch app stats
2. Ash uses Vision AI/OCR to extract metrics
3. Data is used for immediate coaching decisions (e.g., "Your Training Stress is high, take a rest day.")
4. Image is discarded (privacy first)

## 4. Privacy Principles
- **User Control**: Explicit permissions for all data access
- **Encryption**: Data encrypted at rest and transit
- **Transparency**: Clear explanation of data usage for coaching
- **Minimization**: Only store what is needed for the training engine
