import 'dart:async';

/// Simulates a remote config / CMS that returns app-level data.
/// Here it just fetches an appDescription for the signed-in user.
class AppRepository {
  /// Returns an appDescription string for the given [email].
  Future<String> fetchAppDescription(String email) async {
    await Future.delayed(const Duration(milliseconds: 600));

    // In a real app this would be an API call.
    return 'Welcome, $email! This app demonstrates hydrated_bloc '
        'persisting state across restarts using freezed models. '
        'All BLoC state survives hot-restart ✨';
  }
}
