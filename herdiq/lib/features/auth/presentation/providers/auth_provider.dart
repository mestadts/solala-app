import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../data/datasources/firebase_auth_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/providers/firebase_provider.dart';
import '../../../../core/providers/locale_provider.dart';

// ── Repository provider ─────────────────────────────────────────────────────

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  final datasource = FirebaseAuthDatasource(firebaseAuth);
  return AuthRepositoryImpl(datasource);
});

// ── Auth state stream ────────────────────────────────────────────────────────

/// Emits the current [AuthUser] or null when signed out.
final authStateProvider = StreamProvider<AuthUser?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

/// True when a Firebase user is signed in.
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authStateProvider).maybeWhen(
        data: (user) => user != null,
        orElse: () => false,
      );
});

/// True while the initial auth state is still loading (splash screen).
final isAuthLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authStateProvider).isLoading;
});

// ── Pending OTP state (used across OTP + Register + Reset screens) ──────────

class OtpState {
  final String verificationId;
  final String phone;
  final int? resendToken;
  const OtpState({
    required this.verificationId,
    required this.phone,
    this.resendToken,
  });
}

/// Stores verification ID + phone between OTP screens so the UI can
/// access it after navigation.
final pendingOtpProvider = StateProvider<OtpState?>((ref) => null);

/// True while the user is mid-registration (OTP verified but password not yet
/// set). Prevents the router from redirecting to onboarding prematurely when
/// the phone-auth sign-in triggers [isAuthenticatedProvider].
final registrationInProgressProvider = StateProvider<bool>((ref) => false);

/// True while the user is in the forgot-password OTP → reset flow.
/// Prevents the router from redirecting to dashboard when OTP sign-in fires.
final passwordResetInProgressProvider = StateProvider<bool>((ref) => false);

// ── Auth error helper ─────────────────────────────────────────────────────────

/// Maps Firebase error codes to user-friendly messages in the current locale.
String _authError(FirebaseAuthException e, {bool isAr = true}) {
  switch (e.code) {
    case 'invalid-verification-code':
      return isAr
          ? 'رمز التحقق غير صحيح، يرجى المحاولة مجدداً'
          : 'Invalid verification code, please try again';
    case 'invalid-verification-id':
    case 'session-expired':
      return isAr
          ? 'انتهت صلاحية الرمز، أعد الإرسال'
          : 'Code expired, please resend';
    case 'too-many-requests':
      return isAr
          ? 'طلبات كثيرة جداً، يرجى الانتظار ساعة على الأقل ثم المحاولة مجدداً'
          : 'Too many attempts. Please wait at least 1 hour before trying again.';
    case 'phone-timeout':
      return isAr
          ? 'انتهت مهلة التحقق. يرجى المحاولة مجدداً'
          : 'Verification timed out. Please try again.';
    case 'missing-client-identifier':
      return isAr
          ? 'تعذّر إرسال رمز التحقق. إذا تكررت المشكلة، انتظر ساعة وأعد المحاولة'
          : 'Could not send verification code. If this keeps happening, wait an hour and try again.';
    case 'invalid-phone-number':
      return isAr ? 'رقم الهاتف غير صحيح' : 'Invalid phone number';
    case 'user-not-found':
      return isAr
          ? 'لم يتم العثور على هذا الحساب'
          : 'Account not found';
    case 'wrong-password':
    case 'invalid-credential':
    case 'INVALID_LOGIN_CREDENTIALS':
      return isAr ? 'رقم الهاتف أو كلمة المرور غير صحيحة' : 'Incorrect phone number or password';
    case 'weak-password':
      return isAr
          ? 'كلمة المرور ضعيفة جداً، اختر كلمة أقوى'
          : 'Password is too weak, choose a stronger one';
    case 'requires-recent-login':
      return isAr
          ? 'انتهت جلستك، يرجى تسجيل الخروج والدخول مجدداً'
          : 'Session expired, please log out and sign in again';
    case 'no-email-found':
      return isAr
          ? 'تعذّر تحديد الحساب، يرجى التواصل مع الدعم'
          : 'Could not determine account, please contact support';
    case 'user-disabled':
      return isAr ? 'تم تعطيل هذا الحساب' : 'This account has been disabled';
    case 'provider-already-linked':
    case 'credential-already-in-use':
    case 'email-already-in-use':
      return isAr
          ? 'هذا الرقم مسجّل بالفعل، يرجى تسجيل الدخول'
          : 'This number is already registered, please sign in';
    case 'missing-client-identifier':
      return isAr
          ? 'تعذّر التحقق من الهاتف. تأكد من اتصال الإنترنت وأن متصفح Chrome مثبّت، ثم حاول مجدداً'
          : 'Phone verification failed. Please ensure you have internet access and Chrome is installed, then try again';
    case 'network-request-failed':
      return isAr
          ? 'خطأ في الاتصال بالشبكة، تحقق من الإنترنت'
          : 'Network error, check your connection';
    default:
      return e.message?.isNotEmpty == true
          ? e.message!
          : isAr
              ? 'حدث خطأ غير متوقع، يرجى المحاولة مجدداً'
              : 'An unexpected error occurred, please try again';
  }
}

// ── Auth actions notifier ────────────────────────────────────────────────────

class AuthActions {
  final AuthRepository _repo;
  final Ref _ref;
  AuthActions(this._repo, this._ref);

  /// Sign in with phone + password (login screen).
  Future<void> signIn(String phone, String password) async {
    try {
      await _repo.signInWithPhonePassword(phone, password);
    } on FirebaseAuthException catch (e) {
      throw _authError(e, isAr: _isAr);
    }
  }

  bool get _isAr =>
      _ref.read(localeProvider).languageCode == 'ar';

  /// Start phone OTP verification. On success, updates [pendingOtpProvider].
  /// Returns true if Firebase auto-verified (user signed in, skip OTP screen).
  Future<bool> sendOtp({
    required String phone,
    required void Function(String error) onError,
    void Function()? onBrowserVerification,
  }) async {
    return _repo.verifyPhone(
      phone: phone,
      onCodeSent: (verificationId, resendToken) {
        _ref.read(pendingOtpProvider.notifier).state = OtpState(
          verificationId: verificationId,
          phone: phone,
          resendToken: resendToken,
        );
      },
      onAutoVerified: (credential) async {
        // Auto-verified (test numbers / instant verify on Android).
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      onFailed: (e) => onError(_authError(e, isAr: _isAr)),
      onBrowserVerification: onBrowserVerification,
    );
  }

  /// Verify OTP code entered by user.
  /// Returns true on success, false on failure.
  Future<bool> verifyOtp({
    required String smsCode,
    required void Function(String error) onError,
  }) async {
    final otpState = _ref.read(pendingOtpProvider);
    if (otpState == null) {
      onError(_isAr
          ? 'لا يوجد رمز معلّق، أعد الإرسال'
          : 'No pending code, please resend');
      return false;
    }
    try {
      await _repo.signInWithOtp(
        verificationId: otpState.verificationId,
        smsCode: smsCode,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      onError(_authError(e, isAr: _isAr));
      return false;
    }
  }

  /// Complete registration after OTP is verified.
  Future<void> completeRegistration({
    required String phone,
    required String password,
    required String displayName,
    required void Function(String error) onError,
  }) async {
    try {
      await _repo.createAccount(
          phone: phone, password: password, displayName: displayName);
      // Clear flag — router will now redirect to onboarding.
      _ref.read(registrationInProgressProvider.notifier).state = false;
    } on FirebaseAuthException catch (e) {
      // Sign out the phone-auth session and clear the flag so the user
      // can go back to login (e.g. number already registered).
      await _repo.signOut();
      _ref.read(registrationInProgressProvider.notifier).state = false;
      onError(_authError(e, isAr: _isAr));
    }
  }

  /// Update password (called from reset-password screen after OTP verified).
  /// Returns true on success, false on failure.
  Future<bool> resetPassword({
    required String newPassword,
    required void Function(String error) onError,
  }) async {
    try {
      await _repo.updatePassword(newPassword);
      return true;
    } on FirebaseAuthException catch (e) {
      onError(_authError(e, isAr: _isAr));
      return false;
    }
  }

  /// Sign in with Google. Router auto-redirects on success.
  Future<void> signInWithGoogle({
    required void Function(String error) onError,
  }) async {
    try {
      await _repo.signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'sign-in-cancelled') return;
      onError(_authError(e, isAr: _isAr));
    } catch (e) {
      final msg = e.toString().toLowerCase();
      if (msg.contains('cancel') || msg.contains('abort') || msg.contains('dismiss')) return;
      onError(_isAr
          ? 'تعذّر تسجيل الدخول بحساب Google، حاول مجدداً'
          : 'Google sign-in failed, please try again');
    }
  }

  /// Sign in with Apple (iOS only). Router auto-redirects on success.
  Future<void> signInWithApple({
    required void Function(String error) onError,
  }) async {
    try {
      await _repo.signInWithApple();
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) return;
      onError(_isAr
          ? 'تعذّر تسجيل الدخول بحساب Apple، حاول مجدداً'
          : 'Apple sign-in failed, please try again');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'apple-not-supported') {
        onError(_isAr
            ? 'تسجيل الدخول بـ Apple متاح على أجهزة iOS فقط'
            : 'Apple Sign-In is only available on iOS devices');
        return;
      }
      onError(_authError(e, isAr: _isAr));
    } catch (e) {
      final msg = e.toString().toLowerCase();
      if (msg.contains('cancel') || msg.contains('abort')) return;
      onError(_isAr
          ? 'تعذّر تسجيل الدخول بحساب Apple، حاول مجدداً'
          : 'Apple sign-in failed, please try again');
    }
  }

  /// Sign out the current user.
  Future<void> signOut() => _repo.signOut();
}

final authActionsProvider = Provider<AuthActions>((ref) {
  return AuthActions(ref.watch(authRepositoryProvider), ref);
});
