import 'package:firebase_auth/firebase_auth.dart';

class VerifyMail {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> registerUser(String mail, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: mail, password: password);
      await userCredential.user?.sendEmailVerification();
      print("Email envoye");
    } catch (e) {
      print("Erreur $e");
    }
  }

  Future<bool> isEmailVerified() async {
    User? user = firebaseAuth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }
}
