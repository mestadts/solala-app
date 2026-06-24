import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart' show AuthRepository, phoneToEmail;

/// Firebase implementation of auth operations.
class FirebaseAuthDatasource {
  final FirebaseAuth _auth;

  FirebaseAuthDatasource(this._auth);

  // ── Auth state ──────────────────────────────────────────────────────────────
  // userChanges() is a superset of authStateChanges() — it also fires when
  // the user's profile (displayName, email, photoURL) is updated.
  // This ensures the UI reflects the name set during registration immediately.
  Stream<AuthUser?> get authStateChanges =>
      _auth.userChanges().map(_fromFirebaseUser);

  AuthUser? get currentUser => _fromFirebaseUser(_auth.currentUser);

  AuthUser? _fromFirebaseUser(User? user) {
    if (user == null) return null;
    return AuthUser(
      uid: user.uid,
      phoneNumber: user.phoneNumber,
      displayName: user.displayName,
      email: user.email,
      emailVerified: user.emailVerified,
    );
  }

  // ── Phone + password login ──────────────────────────────────────────────────
  Future<void> signInWithPhonePassword(String phone, String password) async {
    final email = phoneToEmail(phone);
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // ── Phone OTP (registration + forgot-password) ──────────────────────────────
  /// Starts phone verification and waits until the first meaningful callback
  /// fires (codeSent OR verificationCompleted OR verificationFailed).
  /// Returns true if Firebase auto-verified (verificationCompleted), meaning
  /// the user is already signed in and no OTP entry is needed.
  Future<bool> verifyPhone({
    required String phone,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required Future<void> Function(PhoneAuthCredential credential) onAutoVerified,
    required void Function(FirebaseAuthException error) onFailed,
    void Function()? onBrowserVerification,
  }) async {
    final completer = Completer<bool>();
    try {
      _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credential) async {
          // Auto-verified (instant verify on real Android — NOT used for test numbers).
          try {
            await onAutoVerified(credential);
            if (!completer.isCompleted) completer.complete(true);
          } catch (e) {
            // signInWithCredential failed — treat as non-auto-verified.
            if (!completer.isCompleted) completer.complete(false);
          }
        },
        verificationFailed: (e) {
          // On Android sideloaded APKs, Play Integrity fails immediately with
          // 'internal-error' (code 39) WHILE Chrome is simultaneously opening
          // for reCAPTCHA web fallback. Don't fail here — wait for codeSent.
          if (!kIsWeb && Platform.isAndroid && e.code == 'internal-error') {
            onBrowserVerification?.call();
            return; // Stay loading — wait for codeSent or timeout
          }
          // 'missing-client-identifier' means Firebase could not start
          // reCAPTCHA at all (no browser available, or number rate-limited).
          // Fail immediately with a clear message rather than waiting.
          onFailed(e);
          if (!completer.isCompleted) completer.complete(false);
        },
        codeSent: (verificationId, resendToken) {
          onCodeSent(verificationId, resendToken);
          if (!completer.isCompleted) completer.complete(false);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          if (!completer.isCompleted) completer.complete(false);
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      // Catch any synchronous exception from verifyPhoneNumber itself.
      if (!completer.isCompleted) {
        onFailed(FirebaseAuthException(
          code: 'internal-error',
          message: e.toString(),
        ));
        completer.complete(false);
      }
    }
    // Hard timeout — gives enough time for reCAPTCHA to complete in browser.
    // reCAPTCHA flow: Chrome opens (~3s) + loads (~3s) + auto-verify (~5s) +
    // redirect back (~2s) = ~13s typical. 90s covers slow connections.
    return completer.future.timeout(
      const Duration(seconds: 90),
      onTimeout: () {
        onFailed(FirebaseAuthException(
          code: 'phone-timeout',
          message: 'Phone verification timed out.',
        ));
        return false;
      },
    );
  }

  Future<UserCredential> signInWithOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    return _auth.signInWithCredential(credential);
  }

  // ── Registration ─────────────────────────────────────────────────────────────
  /// Called after OTP verified. The user is already signed in with phone auth.
  /// Links an email/password credential so they can log in with phone+password.
  Future<void> createAccount({
    required String phone,
    required String password,
    required String displayName,
  }) async {
    final email = phoneToEmail(phone);
    final user = _auth.currentUser;
    if (user != null) {
      // User signed in via phone OTP — link email/password to same account.
      final emailCredential =
          EmailAuthProvider.credential(email: email, password: password);
      await user.linkWithCredential(emailCredential);
      await user.updateDisplayName(displayName);
    } else {
      // Fallback (should not normally reach here).
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _auth.currentUser?.updateDisplayName(displayName);
    }
  }

  // ── Password reset ──────────────────────────────────────────────────────────
  /// Resets the email/password credential after OTP verification.
  /// Uses unlink + re-link instead of updatePassword() to avoid
  /// `requires-recent-login` failures when signed in via phone OTP.
  Future<void> updatePassword(String newPassword) async {
    final user = _auth.currentUser;
    if (user == null) throw FirebaseAuthException(code: 'no-current-user');

    // Prefer the already-linked email; fall back to deriving from phone number.
    String? email = user.email;
    if ((email == null || email.isEmpty) && user.phoneNumber != null) {
      email = phoneToEmail(user.phoneNumber!);
    }
    if (email == null || email.isEmpty) {
      throw FirebaseAuthException(
        code: 'no-email-found',
        message: 'Cannot determine account email for password reset.',
      );
    }

    final hasEmailProvider = user.providerData
        .any((p) => p.providerId == EmailAuthProvider.PROVIDER_ID);

    if (hasEmailProvider) {
      // Email/password provider is already linked.
      // Unlink it first, then re-link with new password.
      // IMPORTANT: unlink() returns the updated User — use that for re-linking,
      // not the original reference which becomes stale after unlink.
      final updatedUser = await user.unlink(EmailAuthProvider.PROVIDER_ID);
      await updatedUser.linkWithCredential(
        EmailAuthProvider.credential(email: email, password: newPassword),
      );
    } else {
      // No email/password provider linked yet — link it fresh.
      await user.linkWithCredential(
        EmailAuthProvider.credential(email: email, password: newPassword),
      );
    }
  }

  // ── Google Sign-In ──────────────────────────────────────────────────────────
  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'sign-in-cancelled',
        message: 'Google sign-in was cancelled',
      );
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return _auth.signInWithCredential(credential);
  }

  // ── Apple Sign-In (iOS only) ─────────────────────────────────────────────────
  Future<UserCredential> signInWithApple() async {
    if (!Platform.isIOS && !Platform.isMacOS) {
      throw FirebaseAuthException(
        code: 'apple-not-supported',
        message: 'Apple Sign-In is only available on iOS devices',
      );
    }
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );
    return _auth.signInWithCredential(oauthCredential);
  }

  // ── Sign out ─────────────────────────────────────────────────────────────────
  Future<void> signOut() => _auth.signOut();
}
