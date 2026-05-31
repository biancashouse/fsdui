import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/auth_state_model.dart';

part 'auth_state.freezed.dart';
part 'auth_state.g.dart';

/// The full BLoC state stored (and hydrated) by hydrated_bloc.
@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    String? ea,
    String? token,
    /// gets set in firestore when user tap the email's confirm button
    @Default(false) bool verified,
    /// Transient error message – not persisted.
    String? errorMessage,
  }) = _AuthState;

  // ---------------------------------------------------------------------------
  // hydrated_bloc serialisation
  // ---------------------------------------------------------------------------

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
