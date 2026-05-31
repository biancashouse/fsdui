import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../model/auth_state_model.dart';
import '../../repositories/app_repository.dart';
import '../../repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// [AuthBloc] extends [HydratedBloc] so its state is automatically
/// written to disk and rehydrated on the next app launch.
///
/// Only the [AuthState] fields annotated with [JsonKey] (i.e. [user])
/// are persisted; transient UI fields like [isLoading] and [errorMessage]
/// are excluded from serialisation via [toJson] / [fromJson].
class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
    required AppRepository appRepository,
  }) : _authRepository = authRepository,
       _appRepository = appRepository,
       super(const AuthState()) {
    on<GenerateTokenAndSendConfirmationEmail>(
      _generateTokenAndSendConfirmationEmail,
    );
    on<SignOutRequested>(_onSignOutRequested);
    on<AppDescriptionUpdated>(_onAppDescriptionUpdated);
  }

  final AuthRepository _authRepository;
  final AppRepository _appRepository;

  // ---------------------------------------------------------------------------
  // Event handlers
  // ---------------------------------------------------------------------------

  Future<void> _generateTokenAndSendConfirmationEmail(
    GenerateTokenAndSendConfirmationEmail event,
    Emitter<AuthState> emit,
  ) async {

    try {
      final email = await _authRepository.signIn(
        email: event.ea,
        password: event.password,
      );

      // Update core user data.
      emit(
        state.copyWith(
          isLoading: false,
          user: state.user.copyWith(
            status: AuthStatus.authenticated,
            email: email,
          ),
        ),
      );

      // Fetch app description now that we're logged in.
      final description = await _appRepository.fetchAppDescription(email);
      add(AppDescriptionUpdated(description));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
          user: state.user.copyWith(status: AuthStatus.unauthenticated),
        ),
      );
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await _authRepository.signOut();
    emit(
      const AuthState(user: AuthStateModel(status: AuthStatus.unauthenticated)),
    );
  }

  void _onAppDescriptionUpdated(
    AppDescriptionUpdated event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        user: state.user.copyWith(appDescription: event.description),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // HydratedBloc – serialisation
  //
  // cannot use @jsonKey to exclude fields...
  // The @JsonKey annotation in json_annotation 4.8+ is restricted to actual fields/getters — freezed's factory constructor
  //   parameters don't count as fields from the analyzer's perspective.
  //
  //   A cleaner alternative: since AuthStateModel already holds exactly the data you want to persist, just serialize only that in the
  //    BLoC's toJson/fromJson pair:
  // ---------------------------------------------------------------------------

  @override
  Map<String, dynamic>? toJson(AuthState state) => state.user.toJson();

  @override
  AuthState? fromJson(Map<String, dynamic> json) =>
      AuthState(user: AuthStateModel.fromJson(json));
}
