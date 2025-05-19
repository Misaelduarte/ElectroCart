import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repo;
  late final StreamSubscription<User?> _userSub;

  AuthBloc(this._repo) : super(AuthInitial()) {
    _userSub = _repo.userChanges.listen((user) {
      add(AuthUserChanged(user));
    });

    on<AuthUserChanged>((event, emit) {
      final user = event.user;
      if (user != null) {
        emit(AuthAuthenticated(user.uid));
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<AuthSignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _repo.signIn(email: event.email, pass: event.pass);
        if (user != null) {
          print('user: ${user.toString()}');
          emit(AuthAuthenticated(user.uid));
        } else {
          emit(AuthUnauthenticated());
        }
      } catch (e) {
        print(e.toString());
        emit(AuthError(e.toString()));
        emit(AuthUnauthenticated());
      }
    });

    on<AuthSignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _repo.signUp(email: event.email, pass: event.pass);
        if (user != null) {
          emit(AuthAuthenticated(user.uid));
        } else {
          emit(AuthUnauthenticated());
        }
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(AuthUnauthenticated());
      }
    });

    on<AuthSignOutRequested>((event, emit) async {
      emit(AuthLoading());
      await _repo.signOut();
      emit(AuthUnauthenticated());
    });

    on<AuthTokenRequested>((event, emit) async {
      final current = state;
      if (current is AuthAuthenticated) {
        try {
          final token = await _repo.getIdToken(refresh: false);
          emit(current.copyWith(token: token));
        } catch (_) {}
      }
    });
  }

  @override
  Future<void> close() {
    _userSub.cancel();
    return super.close();
  }
}
