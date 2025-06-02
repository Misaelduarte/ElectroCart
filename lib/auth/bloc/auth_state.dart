abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String uid;
  final String? token;
  AuthAuthenticated(this.uid, [this.token]);

  AuthAuthenticated copyWith({String? token}) {
    return AuthAuthenticated(uid, token ?? this.token);
  }
}

class AuthUnauthenticated extends AuthState {}

class AuthSignError extends AuthState {
  final String message;
  AuthSignError(this.message);
}

class AuthSignupError extends AuthState {
  final String message;
  AuthSignupError(this.message);
}
