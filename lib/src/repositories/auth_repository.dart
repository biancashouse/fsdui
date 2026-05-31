import 'dart:async';

/// Simulates an authentication backend.
/// In a real app this would call your API / Firebase / etc.
class AuthRepository {
  // Fake credential store
  static const _validEmail = 'user@example.com';
  static const _validPassword = 'password123';

  /// Sign in with email + password.
  /// Throws [AuthException] on failure.
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    if (email == _validEmail && password == _validPassword) {
      return email;
    }
    throw AuthException('Invalid email or password.');
  }

  /// Sign out the current user.
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 400));
  }
}

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);

  @override
  String toString() => message;
}
