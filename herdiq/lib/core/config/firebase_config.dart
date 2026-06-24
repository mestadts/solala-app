import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future<void> initFirebase() async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
    debugPrint('[Firebase] Initialized: ${Firebase.app().name}');
  } catch (e) {
    debugPrint('[Firebase] Init failed: $e');
    // App continues in offline/demo mode
  }
}
