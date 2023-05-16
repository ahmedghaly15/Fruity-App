import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<UserCredential> userSignIn({
    required String email,
    required String password,
  });

  Future<UserCredential> userSignUp({
    required String email,
    required String password,
  });

  Future<void> firestoreCreateUSer({
    required String email,
    required String username,
    required String phone,
    required String uId,
    required String address,
  });

  Future<UserCredential> signInWithGoogle();

  // Future<UserCredential> signInWithFacebook();
}
