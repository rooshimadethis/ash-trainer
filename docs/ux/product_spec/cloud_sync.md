# Cloud Sync & Data Backup

Ash ensures users never lose their training data through automatic cloud synchronization and backup.

## 1. Automatic Cloud Sync

### Sync Strategy
- **Local-First Architecture**: All data is stored locally on-device (Drift DB) for instant access and offline functionality
- **Background Sync**: Changes automatically sync to cloud when connected to internet
- **Conflict Resolution**: Last-write-wins with timestamp-based merging for concurrent edits

### What Gets Synced
- **User Profile**: Training history, preferences, constraints
- **Goals**: All goal types and progress data
- **Workouts**: Planned and completed workouts, including RPE and feedback
- **Health Data**: Biomarkers, recovery metrics, injury records
- **Training Plans**: Generated plans and training blocks
- **Pillar Priorities**: Running, Strength, Mobility configurations

### Sync Frequency
- **Real-time**: Critical data (workout completions, goal changes) syncs immediately
- **Batched**: Less critical data (biomarker updates) syncs every 15 minutes
- **On-demand**: User can manually trigger sync via Settings

### Offline Support
- **Full Functionality**: All core features work offline
- **Queued Changes**: Edits made offline are queued and synced when connection restored
- **Conflict Handling**: If data conflicts occur (e.g., editing on two devices), show user a resolution dialog

---

## 2. Multi-Device Support

### Device Sync
Users can access their data from multiple devices:
- **Seamless Switching**: Start workout on phone, view progress on tablet
- **Real-time Updates**: Changes on one device appear on others within seconds
- **Device Management**: View and manage connected devices in Settings

### Cross-Platform
- **Android ↔ iOS**: Full sync between Android and iOS devices
- **Web Dashboard** (Future): View training data and plans on web

---

## 3. Account Management

### Sign-In Methods
- **Email/Password**: Traditional account creation
- **Google Sign-In**: Quick authentication with Google account
- **Apple Sign-In**: Required for iOS, privacy-focused

### Account Recovery
- **Forgot Password**: Email-based password reset
- **Account Verification**: Email verification on signup
- **Two-Factor Authentication** (Future): Optional 2FA for enhanced security

### User Session Cycle & Credentials
- **Local-First (Phase 1)**: 
    - Single implicit user (ID: 1).
    - No login/logout functionality.
    - "New User" or "Reset" requires wiping local database.
- **Cloud Transition (Phase 2+)**:
    - **Sign Up/Login**: 
        - Hybrid flow: Local data is preserved and associated with the new account.
        - Authenticates with cloud provider typically via OAuth (Google/Apple) or Email.
        - Returns Auth Token (JWT) -> Stored in device Secure Storage.
    - **Data Migration**: 
        - Upon first sign-up, any existing local "guest" data is automatically uploaded to the cloud.
    - **Logout**: 
        - Auth Token removed from Secure Storage.
        - **Critical**: Local database (Drift) is **wiped** to ensure privacy.
        - App state resets to "Onboarding/Welcome".
    - **Account Switching**: 
        - Equivalent to Logout -> Login.
        - Wipes previous user's local data -> Syncs new user's data from cloud.

---

## 4. Data Backup & Export

### Automatic Backups
- **Daily Backups**: Full data backup every 24 hours
- **Retention**: Keep last 30 days of backups
- **Restoration**: Users can restore from backup if needed

### Data Export
Users can export their data at any time:
- **Formats**: JSON, CSV
- **What's Included**: All workouts, goals, biomarkers, and training history
- **GDPR Compliance**: "Download my data" option in Settings

### Data Deletion
- **Account Deletion**: Users can permanently delete their account and all data
- **Confirmation**: Require confirmation and password re-entry
- **Grace Period**: 30-day grace period before permanent deletion (can cancel deletion)
- **GDPR Right to Erasure**: Full compliance with data deletion requests

---

## 5. Privacy & Security

### Data Encryption
- **At Rest**: All cloud data encrypted using AES-256
- **In Transit**: TLS 1.3 for all network communication
- **End-to-End**: Health data encrypted end-to-end (only user can decrypt)

### Data Ownership
- **User Owns Data**: Users retain full ownership of their training data
- **No Selling**: We never sell user data to third parties
- **Minimal Collection**: Only collect data necessary for app functionality

### Compliance
- **GDPR**: Full compliance with EU data protection regulations
- **HIPAA**: Health data handled per HIPAA guidelines (if applicable)
- **CCPA**: California Consumer Privacy Act compliance

---

## 6. Sync Status & Indicators

### Visual Feedback
Users always know their sync status:
- **Synced**: Green checkmark icon "All changes saved"
- **Syncing**: Animated spinner "Syncing..."
- **Offline**: Gray cloud icon "Offline - changes will sync when connected"
- **Error**: Red warning icon "Sync failed - tap to retry"

### Sync Settings
- **Auto-Sync Toggle**: Enable/disable automatic sync
- **Sync on WiFi Only**: Option to sync only on WiFi (save cellular data)
- **Last Synced**: Display timestamp of last successful sync
- **Manual Sync Button**: Force immediate sync

---

## 7. Onboarding Integration

### First Launch (New User)
1. **Welcome Screen**: "Meet Ash, your AI running coach"
2. **Account Creation**: Sign up with email or social login
3. **Profile Setup**: Training history, availability, constraints
4. **Goal Selection**: Choose first goal
5. **Cloud Sync Enabled**: Automatically enabled after account creation

### Existing User (New Device)
1. **Sign In Screen**: "Welcome back! Sign in to sync your data"
2. **Authentication**: Email/password or social login
3. **Data Download**: "Downloading your training data..."
4. **Sync Complete**: "You're all set! Your data is up to date"

### Guest Mode (Optional - Future)
- **Try Without Account**: Limited functionality, no cloud sync
- **Upgrade Prompt**: "Create account to save your data and sync across devices"
- **Data Migration**: Convert guest data to account when user signs up

---

## 8. Error Handling

### Sync Failures
- **Network Timeout**: Retry with exponential backoff
- **Server Error**: Show error message, queue changes for retry
- **Authentication Error**: Prompt user to re-authenticate
- **Storage Quota Exceeded**: Notify user, offer data cleanup options

### Conflict Resolution
When same data is edited on multiple devices:
1. **Detect Conflict**: Compare timestamps and data versions
2. **Auto-Resolve**: Use last-write-wins for most data
3. **User Resolution**: For critical conflicts (e.g., goal changes), show dialog:
   - "Your goal was changed on another device. Which version do you want to keep?"
   - Option A: Keep this device's version
   - Option B: Keep other device's version
   - Option C: Merge both (if applicable)

---

## 9. Implementation Phases

### Phase 1: MVP (Core Sync)
- **Google Sign-In**: Quick authentication with Google account (simplest for users)
- **Apple Sign-In**: Required for iOS App Store approval
- Basic cloud sync (workouts, goals, user profile)
- Offline support with queued changes
- Manual sync button
- Sync status indicators

### Phase 2: Enhanced Auth & Multi-Device
- **Email/password authentication**: Traditional account creation for users without Google/Apple accounts
- **Real-time sync**: WebSocket-based for instant updates
- **Multi-device support**: Seamless switching between devices
- **Conflict resolution UI**: Handle concurrent edits gracefully
- **Data export** (JSON, CSV): GDPR compliance and user data ownership

### Phase 3: Advanced Features
- **Two-factor authentication**: Optional 2FA for enhanced security
- **Web dashboard**: View training data and plans on web
- **Guest mode**: Try app without account, migrate data on signup

### Phase 4: Enterprise & Disaster Recovery
- **Automatic backups with restoration**: Server-side daily snapshots of entire database for disaster recovery (e.g., if cloud database is corrupted or accidentally deleted)
- **Team/coach accounts**: Multi-user access and permissions
- **Data sharing with coaches**: Share training data with certified coaches
- **Advanced analytics**: Aggregate insights across users

---

## 🛠️ Technical Implementation

### Backend Stack (Recommended)
- **Firebase Authentication**: User auth and account management
- **Cloud Firestore**: Real-time database with offline support
- **Cloud Storage**: File storage for exports and backups
- **Cloud Functions**: Serverless functions for sync logic

### Alternative Stack
- **Supabase**: Open-source Firebase alternative
- **PostgreSQL**: Relational database with row-level security
- **Supabase Auth**: Built-in authentication
- **Supabase Storage**: File storage

### Local Storage
- **Drift (SQLite)**: Local database for offline-first architecture
- **Shared Preferences**: User settings and preferences
- **Secure Storage**: Encrypted storage for auth tokens

---

## 🎯 User Benefits

1. **Peace of Mind**: Never lose training data, even if device is lost or broken
2. **Flexibility**: Switch between devices seamlessly
3. **Offline Training**: Full functionality without internet connection
4. **Data Ownership**: Export and delete data at any time
5. **Privacy**: End-to-end encryption for sensitive health data

---

## 📝 User Journeys Affected

This feature impacts several existing journeys:

- **Journey #1 (Onboarding)**: Add account creation step
- **Journey #2 (Daily Check-In)**: Sync workout adjustments
- **Journey #3 (Workout Logging)**: Sync completed workouts
- **Journey #4 (Calendar View)**: Sync plan changes across devices
- **Journey #5 (Goal Progress)**: Sync confidence updates

**New Journeys Required** (Document now, implement Phase 2+):
- **Journey #16: Account Setup & Sign-In (Google/Apple)** - Phase 1 implementation
- **Journey #17: Email/Password Authentication** - Phase 2 implementation  
- **Journey #18: Multi-Device Sync & Conflict Resolution** - Phase 2 implementation

---

**Last Updated**: 2025-12-29
