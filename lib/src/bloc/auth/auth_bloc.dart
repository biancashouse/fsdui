import 'dart:async';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../capi/capi_bloc.dart';
import '../capi/capi_event.dart';
import '../../repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
    required CAPIBloC capiBloc,
  }) : _authRepository = authRepository,
       _capiBloc = capiBloc,
       super(const AuthState()) {
    on<GenerateTokenAndSendConfirmationEmail>(_onRequestToken);
    on<TokenConfirmed>(_onTokenConfirmed);
    on<SignOutRequested>(_onSignOut);
  }

  final AuthRepository _authRepository;
  final CAPIBloC _capiBloc;
  StreamSubscription<bool>? _tokenSub;

  Future<void> _onRequestToken(
    GenerateTokenAndSendConfirmationEmail event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final token = await _authRepository.requestToken(
        gcrServerUrl: event.gcrServerUrl,
        ea: event.ea,
        appName: event.appName,
      );
      if (token == null) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to send verification email.',
        ));
        return;
      }
      emit(state.copyWith(isLoading: false, ea: event.ea, token: token));
      _startListening(token: token, ea: event.ea);
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void _startListening({required String token, required String ea}) {
    _tokenSub?.cancel();
    _tokenSub = _authRepository
        .watchTokenConfirmation(token)
        .where((confirmed) => confirmed)
        .listen((_) => add(TokenConfirmed(ea: ea)));
  }

  void _onTokenConfirmed(TokenConfirmed event, Emitter<AuthState> emit) {
    _tokenSub?.cancel();
    _tokenSub = null;
    emit(state.copyWith(verified: true, ea: event.ea));
    _capiBloc.add(VerifiedEa(ea: event.ea));
  }

  void _onSignOut(SignOutRequested event, Emitter<AuthState> emit) {
    _tokenSub?.cancel();
    _tokenSub = null;
    emit(const AuthState());
  }

  @override
  Future<void> close() {
    _tokenSub?.cancel();
    return super.close();
  }

  // Only persist ea/token/verified — isLoading and errorMessage are transient.
  @override
  Map<String, dynamic>? toJson(AuthState state) => {
    'ea': state.ea,
    'token': state.token,
    'verified': state.verified,
  };

  @override
  AuthState? fromJson(Map<String, dynamic> json) => AuthState(
    ea: json['ea'] as String?,
    token: json['token'] as String?,
    verified: (json['verified'] as bool?) ?? false,
  );
}
