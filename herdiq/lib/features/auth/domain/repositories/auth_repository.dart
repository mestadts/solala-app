import 'package:firebase_auth/firebase_auth.dart';
import '../entities/auth_user.dart';

/// Abstract auth repository — implemented by FirebaseAuthRepository.
abstract class AuthRepository {
  // ── Auth state ──────────────────────────────────────────────────────────────
  Stream<AuthUser?> get authStateChanges;
  AuthUser? get currentUser;

  // ── Phone + password login (phone stored as email: phone@herdiq.app) ───────
  Future<void> signInWithPhonePassword(String phone, String password);

  // ── Phone OTP (used for registration + forgot-password flow) ───────────────
  /// Returns true if auto-verified (OTP screen can be skipped).
  Future<bool> verifyPhone({
    required String phone,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required Future<void> Function(PhoneAuthCredential credential) onAutoVerified,
    required void Function(FirebaseAuthException error) onFailed,
    void Function()? onBrowserVerification,
  });

  Future<UserCredential> signInWithOtp({
    required String verificationId,
    required String smsCode,
  });

  // ── Registration (after OTP verified: create Email/Password account) ────────
  Future<void> createAccount({
    required String phone,
    required String password,
    required String displayName,
  });

  // ── Social sign-in ──────────────────────────────────────────────────────────
  Future<UserCredential> signInWithGoogle();
  Future<UserCredential> signInWithApple();

  // ── Password reset ──────────────────────────────────────────────────────────
  Future<void> updatePassword(String newPassword);

  // ── Sign out ─────────────────────────────────────────────────────────────────
  Future<void> signOut();
}

/// Converts a phone number to the internal "email" used for Email/Password auth.
/// e.g. +966501234567 → p966501234567@herdiq.app
String phoneToEmail(String phone) {
  final digits = phone.replaceAll(RegExp(r'[^\d]'), '');
  return 'p$digits@herdiq.app';
}
