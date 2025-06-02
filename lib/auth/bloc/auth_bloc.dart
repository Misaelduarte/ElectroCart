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
          emit(AuthAuthenticated(user.uid));
        } else {
          emit(AuthUnauthenticated());
        }
      } on FirebaseAuthException catch (e) {
        final msg = _mapFirebaseAuthErrorToMessage(e.code);
        emit(AuthSignError(msg));
        emit(AuthUnauthenticated());
      } catch (_) {
        emit(AuthSignError('Unknown authentication error.'));
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
      } on FirebaseAuthException catch (e) {
        final msg = _mapFirebaseAuthErrorToMessage(e.code);
        emit(AuthSignupError(msg));
        emit(AuthUnauthenticated());
      } catch (_) {
        emit(AuthSignupError('Unknown signup error.'));
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

  String _mapFirebaseAuthErrorToMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'Invalid email address.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'user-not-found':
        return 'No user found with that email.';
      case 'user-disabled':
        return 'User account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'email-already-in-use':
        return 'This email is already in use.';
      case 'operation-not-allowed':
        return 'This operation is not allowed.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'invalid-credential':
        return 'The provided credentials are invalid or have expired.';
      default:
        return 'Authentication error: $code';
    }
  }

  @override
  Future<void> close() {
    _userSub.cancel();
    return super.close();
  }
}
