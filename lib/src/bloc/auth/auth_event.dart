sealed class AuthEvent {
  const AuthEvent();
}

final class GenerateTokenAndSendConfirmationEmail extends AuthEvent {
  const GenerateTokenAndSendConfirmationEmail({required this.ea});
  final String ea;
}

final class SignOutRequested extends AuthEvent {
  const SignOutRequested();
}
