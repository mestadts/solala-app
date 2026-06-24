import 'package:flutter_riverpod/flutter_riverpod.dart';

// Simple mock auth state — toggle this to simulate logged-in / logged-out
// In Phase 8 this will be replaced with real Firebase Auth StreamProvider

class MockAuthNotifier extends Notifier<bool> {
  @override
  bool build() => false; // false = not logged in (shows auth screens)

  void login()  => state = true;
  void logout() => state = false;
}

final mockAuthProvider = NotifierProvider<MockAuthNotifier, bool>(
  MockAuthNotifier.new,
);

// Mock onboarding completion state
class MockOnboardingNotifier extends Notifier<bool> {
  @override
  bool build() => false; // false = has not completed onboarding

  void complete() => state = true;
  void reset()    => state = false;
}

final mockOnboardingProvider = NotifierProvider<MockOnboardingNotifier, bool>(
  MockOnboardingNotifier.new,
);
