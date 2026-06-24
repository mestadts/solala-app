import 'package:firebase_core/firebase_core.dart';

Future<void> initFirebase() async {
  try {
    await Firebase.initializeApp();
  } catch (_) {
    // Firebase unavailable (placeholder config or no network) — app continues in offline/demo mode
  }
}
