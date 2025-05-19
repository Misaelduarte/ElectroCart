import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent {}

class AuthUserChanged extends AuthEvent {
  final User? user;
  AuthUserChanged(this.user);
}

class AuthTokenRequested extends AuthEvent {}

class AuthSignInRequested extends AuthEvent {
  final String email, pass;
  AuthSignInRequested(this.email, this.pass);
}

class AuthSignUpRequested extends AuthEvent {
  final String email, pass;
  AuthSignUpRequested(this.email, this.pass);
}

class AuthSignOutRequested extends AuthEvent {
  AuthSignOutRequested();
}
