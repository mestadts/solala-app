# HerdIQ — Build & Publish Guide

## Project Overview

| Property | Value |
|----------|-------|
| App Name | HerdIQ |
| Package ID (Android) | `com.solala.app` |
| Version | 1.0.0+2 (versionCode 2) |
| Stack | Flutter 3.x + Firebase + Riverpod + Isar |
| Min Android SDK | 21 (Android 5.0) |
| Target Android SDK | 35 |

---

## Repository Structure

```
A03 App/
├── herdiq/          → Flutter mobile app (Android + iOS)
├── admin/           → React 18 admin panel (Vite + TailwindCSS)
├── functions/       → Firebase Cloud Functions (Node.js)
├── _delivery/       → Pre-built APK + AAB for direct distribution
├── firebase.json    → Firebase project config
└── .firebaserc      → Firebase project alias
```

---

## Prerequisites

Install these tools before building:

| Tool | Version | Install |
|------|---------|---------|
| Flutter SDK | 3.24+ | https://docs.flutter.dev/get-started/install |
| Android Studio | Latest | https://developer.android.com/studio |
| Xcode (iOS only) | 15+ | Mac App Store |
| Node.js | 18+ | https://nodejs.org |
| Firebase CLI | Latest | `npm install -g firebase-tools` |

---

## Firebase Setup (Required Before First Build)

The app connects to a Firebase project. You need to place the real Firebase config files (included in this repo under `herdiq/android/app/` and `herdiq/ios/Runner/`).

### Firebase Console Steps
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select project `herdiq-prod`
3. Enable the following under **Authentication → Sign-in methods**:
   - Email/Password
   - Phone
   - Google
   - Apple
4. Under **Authentication → Settings → Authorized domains**, add your domain
5. Add test phone numbers under **Authentication → Phone → Test phone numbers** (for testing OTP)

### Firestore
- Rules file: `herdiq/firestore.rules` — deploy with: `firebase deploy --only firestore:rules`
- Indexes file: `herdiq/firestore.indexes.json` — deploy with: `firebase deploy --only firestore:indexes`

### Storage
- Rules file: `herdiq/storage.rules` — deploy with: `firebase deploy --only storage`

---

## Android Build

### Signing Credentials

The keystore and credentials are included in this repository:

| File | Location |
|------|----------|
| Keystore file | `herdiq/android/app/release-keystore.jks` |
| Key properties | `herdiq/android/key.properties` |

**Keystore Credentials (keep private):**

```
Store Password : HerdIQ@2026!
Key Password   : HerdIQ@2026!
Key Alias      : herdiq-release
```

> ⚠️ Store these credentials securely. Anyone with the keystore + passwords can sign and publish updates to your app.

### Build Commands

```bash
cd herdiq

# Install dependencies
flutter pub get

# Regenerate Isar schema files (only needed after schema changes)
dart run build_runner build --delete-conflicting-outputs

# Build release APK (for direct distribution / sideloading)
flutter build apk --release

# Build release AAB (for Google Play Store — preferred)
flutter build appbundle --release
```

Output locations:
- APK → `herdiq/build/app/outputs/flutter-apk/app-release.apk`
- AAB → `herdiq/build/app/outputs/bundle/release/app-release.aab`

Pre-built versions (v1.0.0+2) are also in the `_delivery/` folder.

### Android Build Troubleshooting

**Isar build issue on new machines:**

Isar 3.x requires a namespace patch. After running `flutter pub get`, patch this file:

```
~/.pub-cache/hosted/pub.dev/isar_flutter_libs-3.1.0+1/android/build.gradle
```

Add inside the `android {}` block:
```groovy
namespace 'dev.isar.isar_flutter_libs'
```

And change:
```groovy
compileSdkVersion 30  →  compileSdkVersion 35
```

Re-apply this patch after `flutter pub cache clean` or on new machines.

---

## iOS Build

### Firebase Config
`herdiq/ios/Runner/GoogleService-Info.plist` is included in this repository.

### Build Steps

```bash
cd herdiq/ios
pod install   # Install CocoaPods dependencies

# Then open Runner.xcworkspace in Xcode:
open Runner.xcworkspace
```

In Xcode:
1. Select **Runner** target
2. Under **Signing & Capabilities**, set your Apple Developer Team
3. Change Bundle ID if needed (currently `com.solala.app`)
4. **Product → Archive** to build for App Store

---

## Incrementing the Version

Edit `herdiq/pubspec.yaml`, line 5:

```yaml
version: 1.0.0+2
#        ^^^^^  ← versionName shown to users
#              ^ ← versionCode (must increment with every Play Store upload)
```

Example for next release: `version: 1.0.1+3`

---

## Google Play Store Publishing

1. Open [Google Play Console](https://play.google.com/console)
2. Create a new app (or use existing)
3. Set up **Internal Testing** track first
4. Upload the AAB from `_delivery/herdiq-v1.0.0+2-release.aab`
5. Fill in store listing: title, description, screenshots, icon
6. Submit for review

**Important:** Every new upload to Play Store requires a higher `versionCode` in `pubspec.yaml`.

---

## Admin Panel

The React admin panel is at `admin/`.

```bash
cd admin
npm install
npm run dev      # Local development (http://localhost:5173)
npm run build    # Produces admin/dist/ folder
```

Deploy the `dist/` folder to your web hosting (e.g., Hostinger `public_html/admin/`).

Admin panel uses the same Firebase project. Set authorized admin UIDs in:
`admin/src/hooks/useAuth.ts` → `ADMIN_UIDS` array.

---

## Firebase Cloud Functions

```bash
cd functions
npm install
firebase deploy --only functions
```

---

## Deploy Everything at Once

```bash
# From project root
firebase deploy
# Deploys: Firestore rules + indexes, Storage rules, Cloud Functions
```

---

## Key Credentials Summary

| Item | Value / Location |
|------|-----------------|
| Android keystore | `herdiq/android/app/release-keystore.jks` |
| Store password | `HerdIQ@2026!` |
| Key password | `HerdIQ@2026!` |
| Key alias | `herdiq-release` |
| Android package ID | `com.solala.app` |
| Firebase project ID | `herdiq-prod` (see `.firebaserc`) |
| Android Firebase config | `herdiq/android/app/google-services.json` |
| iOS Firebase config | `herdiq/ios/Runner/GoogleService-Info.plist` |
| Pre-built APK | `_delivery/herdiq-v1.0.0+2-release.apk` |
| Pre-built AAB | `_delivery/herdiq-v1.0.0+2-release.aab` |

---

## Support

For technical questions about the codebase, contact the development team.
