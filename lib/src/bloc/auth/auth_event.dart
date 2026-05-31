sealed class AuthEvent {
  const AuthEvent();
}

final class GenerateTokenAndSendConfirmationEmail extends AuthEvent {
  const GenerateTokenAndSendConfirmationEmail({
    required this.ea,
    required this.gcrServerUrl,
    required this.appName,
  });
  final String ea;
  final String gcrServerUrl;
  final String appName;
}

// Internal event fired by the Firestore stream when the token doc appears.
final class TokenConfirmed extends AuthEvent {
  const TokenConfirmed({required this.ea});
  final String ea;
}

final class SignOutRequested extends AuthEvent {
  const SignOutRequested();
}
