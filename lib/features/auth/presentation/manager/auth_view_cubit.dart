import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/utils/cache_helper.dart';
import 'auth_view_states.dart';

enum AuthMode { signIn, signUp }

//==================== Auth View Cubit ====================
class AuthViewCubit extends Cubit<AuthViewStates> {
  AuthViewCubit() : super(AuthViewInitialState()) {
    passVisibility = true;
    confirmPassVisiblity = true;
  }

  //============ Getting An Object Of The Cubit ============
  static AuthViewCubit getObject(context) => BlocProvider.of(context);

  bool passVisibility = true;
  bool confirmPassVisiblity = true;

  //============ For Signing In A User ============
  void userSignIn({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    emit(SignInLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(SignInSuccessState(value.user!.uid));
      CacheHelper.saveData(key: 'uId', value: value.user!.uid);
    }).catchError((error) {
      if (error is FirebaseAuthException) {
        emit(SignInErrorState(error.code.toString()));
      }
    });
  }

  //============ For Signing Up A User ============
  void userSignUp({
    required String email,
    required String password,
    required String phone,
    required String address,
    required BuildContext context,
  }) {
    emit(SignUpLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      firestoreCreateUSer(
        email: email,
        phone: phone,
        uId: value.user!.uid,
        address: address,
      );
      CacheHelper.saveData(key: 'uId', value: value.user!.uid);
    }).catchError((error) {
      debugPrint(error.toString());
      if (error is FirebaseAuthException) {
        emit(SignUpErrorState(error.code.toString()));
      }
    });
  }

  void firestoreCreateUSer({
    required String email,
    required String phone,
    required String uId,
    required String address,
  }) {
    UserModel userModel = UserModel(
      email: email,
      phone: phone,
      uId: uId,
      address: address,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toJson())
        .then((value) {
      emit(CreateUserSuccessState());
      emit(SignUpSuccessState(uId));
    }).catchError((error) {
      debugPrint(error.toString());
      CreateUserErrorState(error.toString());
    });
  }

  void switchPassVisibility() {
    passVisibility = !passVisibility;
    emit(SwitchPassVisibleState());
  }

  void switchConfirmPassVisibility() {
    confirmPassVisiblity = !confirmPassVisiblity;
    emit(SwitchConfirmPassVisibleState());
  }
}
