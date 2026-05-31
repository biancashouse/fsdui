import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';
part 'auth_state.g.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    String? ea,
    String? token,
    // isLoading and errorMessage are transient — excluded from HydratedBloc serialisation.
    @Default(false) bool isLoading,
    @Default(false) bool verified,
    String? errorMessage,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
