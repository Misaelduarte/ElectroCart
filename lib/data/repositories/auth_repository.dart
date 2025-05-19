import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  AuthRepository({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  Stream<User?> get userChanges => _auth.userChanges();
  Future<User?> signIn({
    required String email,
    required String pass,
  }) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: pass,
    );
    return cred.user;
  }

  Future<User?> signUp({
    required String email,
    required String pass,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: pass,
    );
    return cred.user;
  }

  Future<void> signOut() => _auth.signOut();

  Future<String> getIdToken({bool refresh = false}) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Usuário não está autenticado');
    }
    return (await user.getIdToken(refresh))!;
  }
}
