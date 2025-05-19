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

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
