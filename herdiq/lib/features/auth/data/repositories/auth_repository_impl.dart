import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDatasource _datasource;

  AuthRepositoryImpl(this._datasource);

  @override
  Stream<AuthUser?> get authStateChanges => _datasource.authStateChanges;

  @override
  AuthUser? get currentUser => _datasource.currentUser;

  @override
  Future<void> signInWithPhonePassword(String phone, String password) =>
      _datasource.signInWithPhonePassword(phone, password);

  @override
  Future<bool> verifyPhone({
    required String phone,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required Future<void> Function(PhoneAuthCredential credential) onAutoVerified,
    required void Function(FirebaseAuthException error) onFailed,
    void Function()? onBrowserVerification,
  }) =>
      _datasource.verifyPhone(
        phone: phone,
        onCodeSent: onCodeSent,
        onAutoVerified: onAutoVerified,
        onFailed: onFailed,
        onBrowserVerification: onBrowserVerification,
      );

  @override
  Future<UserCredential> signInWithOtp({
    required String verificationId,
    required String smsCode,
  }) =>
      _datasource.signInWithOtp(
          verificationId: verificationId, smsCode: smsCode);

  @override
  Future<void> createAccount({
    required String phone,
    required String password,
    required String displayName,
  }) =>
      _datasource.createAccount(
          phone: phone, password: password, displayName: displayName);

  @override
  Future<UserCredential> signInWithGoogle() => _datasource.signInWithGoogle();

  @override
  Future<UserCredential> signInWithApple() => _datasource.signInWithApple();

  @override
  Future<void> updatePassword(String newPassword) =>
      _datasource.updatePassword(newPassword);

  @override
  Future<void> signOut() => _datasource.signOut();
}
