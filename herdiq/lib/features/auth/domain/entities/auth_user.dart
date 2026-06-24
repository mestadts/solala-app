/// Core auth user entity — returned by auth operations.
/// Populated from firebase_auth.User; presentation layer uses this.
class AuthUser {
  final String uid;
  final String? phoneNumber;
  final String? displayName;
  final String? email;
  final bool emailVerified;

  const AuthUser({
    required this.uid,
    this.phoneNumber,
    this.displayName,
    this.email,
    this.emailVerified = false,
  });
}
