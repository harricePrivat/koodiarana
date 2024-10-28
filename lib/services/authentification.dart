import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServiceCustomer {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Connexion avec Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      print('Démarrage de la connexion Google');
      // Déclencher le flux d'authentification
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Vérifiez si l'utilisateur a annulé la connexion
      if (googleUser == null) {
        print('Utilisateur a annulé la connexion');
        return null;
      }

      print('Utilisateur Google signé : ${googleUser.email}');

      // Obtenir les détails de l'autorisation de la demande
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print('Authentification réussie, ID Token : ${googleAuth.idToken}');

      // Créer un nouvel identifiant
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      // Renvoyez l'identifiant de l'utilisateur une fois connecté
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      print('Connexion réussie, utilisateur : ${userCredential.user?.email}');

      return userCredential;
    } catch (e) {
      print('Erreur lors de la connexion avec Google: $e');
      return null;
    }
  }

  // L'état de l'utilisateur en temps réel
  Stream<User?> get userCustomer => _auth.authStateChanges();
}

class AuthServiceWork {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Connexion avec Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      print('Démarrage de la connexion Google');
      // Déclencher le flux d'authentification
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Vérifiez si l'utilisateur a annulé la connexion
      if (googleUser == null) {
        print('Utilisateur a annulé la connexion');
        return null;
      }

      print('Utilisateur Google signé : ${googleUser.email}');

      // Obtenir les détails de l'autorisation de la demande
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print('Authentification réussie, ID Token : ${googleAuth.idToken}');

      // Créer un nouvel identifiant
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      // Renvoyez l'identifiant de l'utilisateur une fois connecté
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      print('Connexion réussie, utilisateur : ${userCredential.user?.email}');

      return userCredential;
    } catch (e) {
      print('Erreur lors de la connexion avec Google: $e');
      return null;
    }
  }

  // L'état de l'utilisateur en temps réel
  Stream<User?> get userWork => _auth.authStateChanges();
}
