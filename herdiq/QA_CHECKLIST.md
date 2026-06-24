# HerdIQ — Phase 14 QA Checklist

## Pre-Requisites
- [ ] Real `google-services.json` placed at `android/app/google-services.json`
- [ ] Real `GoogleService-Info.plist` placed at `ios/Runner/GoogleService-Info.plist`
- [ ] Firebase Console: Phone Auth + Email/Password Auth enabled
- [ ] Firebase Console: Test phone numbers added for OTP testing

---

## 1. Authentication

| Test | Expected | Pass |
|------|----------|------|
| Register with new phone number | OTP sent, account created, lands on onboarding | ☐ |
| Login with phone + password | Navigates to Dashboard | ☐ |
| Login with wrong password | Error message shown in Arabic | ☐ |
| Forgot password → OTP → reset | New password works | ☐ |
| Google Sign-In | Account created/linked, lands on Dashboard | ☐ |
| Apple Sign-In | Account created/linked, lands on Dashboard | ☐ |
| Logout | Returns to Login screen, providers reset | ☐ |
| Token persists across restart | No re-login required | ☐ |

---

## 2. Offline Mode (Airplane Mode)

| Test | Expected | Pass |
|------|----------|------|
| Add animal while offline | Saved locally, appears in list immediately | ☐ |
| Edit animal while offline | Changes reflected locally | ☐ |
| Add health record while offline | Saved locally, visible in timeline | ☐ |
| Add weight record while offline | Saved locally, appears in chart | ☐ |
| Reconnect → animals synced | Animals appear in Firestore | ☐ |
| Reconnect → health records synced | Records appear in Firestore | ☐ |
| Reconnect → weight records synced | Records appear in Firestore | ☐ |
| Reconnect → breeding records synced | Records appear in Firestore | ☐ |
| Offline banner shown | Yellow banner visible when no connection | ☐ |

---

## 3. Security Rules — systemAnimalId Immutability

| Test | Expected | Pass |
|------|----------|------|
| Edit animal → systemAnimalId field | Field is read-only in UI | ☐ |
| Firestore: attempt to change systemAnimalId | Rejected by security rules | ☐ |
| New animal gets correct HQ-YYYY-NNNNNN format | Yes | ☐ |

---

## 4. Ownership Transfer — Immutable Chain

| Test | Expected | Pass |
|------|----------|------|
| Transfer animal to new owner | Ownership record created | ☐ |
| View transfer history | All transfers shown in chronological order | ☐ |
| Firestore: attempt to delete ownership record | Rejected by security rules | ☐ |
| Firestore: attempt to update ownership record | Rejected by security rules | ☐ |

---

## 5. Role-Based Access (Worker vs Owner)

| Test | Expected | Pass |
|------|----------|------|
| Worker can add animals | Yes | ☐ |
| Worker can add health records | Yes | ☐ |
| Worker can transfer ownership | Blocked (owner only) | ☐ |
| Worker can delete animal | Blocked (owner only) | ☐ |
| Owner can delete animal | Yes, with confirmation | ☐ |
| Owner can manage pens | Yes | ☐ |
| Owner can invite/remove workers | Yes | ☐ |

---

## 6. Two-Device Sync

| Test | Expected | Pass |
|------|----------|------|
| Device A adds animal → Device B sees it | Yes (within seconds online) | ☐ |
| Device A edits animal → Device B sees update | Yes | ☐ |
| Device A adds health record → Device B sees it | Yes | ☐ |

---

## 7. Animal Lifecycle Features

| Test | Expected | Pass |
|------|----------|------|
| Add sheep → age class auto-sets to بهم | Yes (if DOB < 12mo ago) | ☐ |
| Select age class chip → DOB field fills | Yes (midpoint of class range) | ☐ |
| Add pregnancy → expected delivery auto-calculated | +150 days for sheep/goat | ☐ |
| Add deworming → next due auto-calculated | +90 days for sheep | ☐ |
| Weaning badge appears on card | Yes, when within weaning window | ☐ |
| Udhiya eligibility badge (when toggle ON) | Green if eligible, red if not | ☐ |

---

## 8. QR Scanner

| Test | Expected | Pass |
|------|----------|------|
| Tap QR tab → camera opens | Yes | ☐ |
| Scan animal QR code → Animal Detail opens | Yes | ☐ |
| Scan invalid QR → error shown | Yes, graceful message | ☐ |

---

## 9. Photo Handling

| Test | Expected | Pass |
|------|----------|------|
| Take photo during add animal | Photo shown in preview | ☐ |
| Pick from gallery | Photo shown in preview | ☐ |
| Add animal with photo while offline | Photo queued, uploads on reconnect | ☐ |
| Photo shows on Animal Detail | Yes | ☐ |

---

## 10. Performance

| Test | Expected | Pass |
|------|----------|------|
| Load animals list with 50+ animals | <500ms, no jank | ☐ |
| Scroll through 200 animals | Smooth scrolling, no dropped frames | ☐ |
| Dashboard loads with full herd | <1 second | ☐ |
| Search in animals list | Real-time filtering, no lag | ☐ |

---

## 11. Arabic RTL UI

| Test | Expected | Pass |
|------|----------|------|
| All text in Arabic mode is Arabic | No English strings visible | ☐ |
| RTL layout on all screens | Text right-aligned, icons flipped | ☐ |
| Breed dropdown in Arabic | Arabic breed names shown | ☐ |
| Species names in Arabic | أغنام، ماعز، إبل، أبقار، خيول | ☐ |
| Status labels in Arabic | نشط، مباع، نافق، etc. | ☐ |
| Navigation tabs in Arabic | Dashboard، الحيوانات، الصحة، etc. | ☐ |

---

## 12. Breeding Features

| Test | Expected | Pass |
|------|----------|------|
| Add breeding record (5-step wizard) | All steps work | ☐ |
| Dam/sire shown in Breeding tab | Yes | ☐ |
| Offspring list populated | Yes | ☐ |
| Active pregnancy countdown shown | "X days until delivery" banner | ☐ |

---

## 13. CSV Import

| Test | Expected | Pass |
|------|----------|------|
| Pick CSV file | File loads, columns detected | ☐ |
| Map Mqane columns automatically | Auto-mapping applies | ☐ |
| Preview shows first 10 rows | Correct data displayed | ☐ |
| Import 20-row CSV | All animals created with systemAnimalId | ☐ |
| Invalid rows flagged | Error shown per row | ☐ |

---

## 14. Settings

| Test | Expected | Pass |
|------|----------|------|
| Language toggle: Arabic ↔ English | App switches language, persists on restart | ☐ |
| Hijri toggle ON → dates show Hijri | Yes, e.g. "15/8/1446هـ" | ☐ |
| Hijri toggle OFF → dates show Gregorian | Yes | ☐ |
| Udhiya toggle → dashboard shortcut appears | Yes | ☐ |
| Farm name saved → shows on Dashboard | Yes | ☐ |
| Pen management → add/delete pens | Pens available in add animal form | ☐ |
| Notification settings → toggles work | Yes | ☐ |

---

## Sign-Off

| Item | Status |
|------|--------|
| `flutter analyze` → 0 errors | ☐ |
| `flutter build apk --release` succeeds | ☐ |
| APK size < 100 MB | ☐ |
| Full QA pass on real device | ☐ |
| Client final review sign-off | ☐ |
