import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebase {
  final FirebaseAuth fireAuth = FirebaseAuth.instance;

  Future<bool> CREATEuser(String email, String password) async {
    try {
      final UserCredential = await fireAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserCredential.user!.sendEmailVerification();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      final UserCredential = await fireAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (UserCredential.user!.emailVerified) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
