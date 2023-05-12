import 'package:flutter/material.dart';

abstract class AuthRepo {
  Future<void> userSignIn({
    required String email,
    required String password,
    required BuildContext context,
  });

  Future<void> userSignUp({
    required String email,
    required String username,
    required String password,
    required String phone,
    required String address,
    required BuildContext context,
  });

  Future googleSignIn();

  Future facebookSignIn();
}
