import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/cache_helper.dart';
import '../../domain/repositries/auth_repo.dart';
import 'auth_view_states.dart';

enum AuthMode { signIn, signUp }

//==================== Auth View Cubit ====================
class AuthViewCubit extends Cubit<AuthViewStates> {
  AuthViewCubit(this.authRepo) : super(AuthViewInitialState()) {
    passVisibility = true;
    confirmPassVisiblity = true;
  }

  AuthRepo authRepo;

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
    authRepo.userSignIn(email: email, password: password).then((value) {
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
    required String username,
    required String password,
    required String phone,
    required String address,
    required BuildContext context,
  }) {
    emit(SignUpLoadingState());

    authRepo.userSignUp(email: email, password: password).then((value) {
      firestoreCreateUSer(
        email: email,
        username: username,
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
    required String username,
    required String phone,
    required String uId,
    required String address,
  }) {
    authRepo
        .firestoreCreateUSer(
      email: email,
      username: username,
      phone: phone,
      uId: uId,
      address: address,
    )
        .then((value) {
      emit(CreateUserSuccessState());
      emit(SignUpSuccessState(uId));
    }).catchError((error) {
      debugPrint(error.toString());
      CreateUserErrorState(error.toString());
    });
  }

  void signInWithGoogle() {
    authRepo.signInWithGoogle().then((value) {
      emit(SignInWithGoogleSuccessState(value.user!.uid));
      CacheHelper.saveData(key: 'uId', value: value.user!.uid);
    }).catchError((error) {
      debugPrint(error.toString());
      emit(SignInWithGoogleErrorState(error.toString()));
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
