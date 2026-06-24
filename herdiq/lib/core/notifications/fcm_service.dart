import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ── Background handler (must be top-level, not inside a class) ────────────────

/// Called by FCM when a message arrives while the app is terminated or in
/// the background. Firebase is already initialized by the plugin at this point.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // The system notification is shown automatically by FCM.
  // Nothing extra needed here — the channel is declared in AndroidManifest.
}

// ── Notification channel constants ─────────────────────────────────────────────

const _kChannelId   = 'herdiq_alerts';
const _kChannelName = 'تنبيهات المزرعة';

// ── FCM Service ────────────────────────────────────────────────────────────────

class FcmService {
  final _fcm              = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // 1. Request system notification permission (Android 13+ / iOS)
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // 2. Set foreground presentation options (iOS)
    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // 3. Initialize flutter_local_notifications for foreground display on Android
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _localNotifications.initialize(
      const InitializationSettings(android: androidInit),
    );

    // 4. Create the Android notification channel (high importance = heads-up)
    const channel = AndroidNotificationChannel(
      _kChannelId,
      _kChannelName,
      importance: Importance.high,
      enableVibration: true,
    );
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // 5. Show local notification when message arrives in foreground
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);

    // 6. Save current token and listen for refresh
    final token = await _fcm.getToken();
    if (token != null) await _saveToken(token);
    _fcm.onTokenRefresh.listen(_saveToken);
  }

  void _onForegroundMessage(RemoteMessage message) {
    final n = message.notification;
    if (n == null) return;
    _localNotifications.show(
      message.hashCode,
      n.title,
      n.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _kChannelId,
          _kChannelName,
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  Future<void> _saveToken(String token) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set(
        {
          'fcmToken': token,
          'fcmTokenUpdatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
    } catch (_) {
      // Offline — token will be refreshed and saved on next connection
    }
  }

  /// Call after sign-in to ensure the token is saved for the new user.
  Future<void> refreshTokenForCurrentUser() => _fcm
      .getToken()
      .then((t) async => t != null ? await _saveToken(t) : null);
}

/// Singleton instance — initialized once in main() and shared across the app.
final fcmService = FcmService();
