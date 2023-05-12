import 'package:flutter/material.dart';
import 'package:fruity_app/features/auth/domain/repositries/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  @override
  Future facebookSignIn() {
    // TODO: implement facebookSignIn
    throw UnimplementedError();
  }

  @override
  Future googleSignIn() {
    // TODO: implement googleSignIn
    throw UnimplementedError();
  }

  @override
  Future<void> userSignIn({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    // TODO: implement userSignIn
    throw UnimplementedError();
  }

  @override
  Future<void> userSignUp({
    required String email,
    required String username,
    required String password,
    required String phone,
    required String address,
    required BuildContext context,
  }) {
    // TODO: implement userSignUp
    throw UnimplementedError();
  }
}
