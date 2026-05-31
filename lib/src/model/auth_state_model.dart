import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state_model.freezed.dart';
part 'auth_state_model.g.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

@freezed
class AuthStateModel with _$AuthStateModel {
  const factory AuthStateModel({
    @Default(AuthStatus.unknown) AuthStatus status,
     String? email,
    // if has a token && unauthenticated: means awaiting confirmation
    @Default('') String token,
  }) = _AuthStateModel;

  factory AuthStateModel.fromJson(Map<String, dynamic> json) =>
      _$AuthStateModelFromJson(json);
}
