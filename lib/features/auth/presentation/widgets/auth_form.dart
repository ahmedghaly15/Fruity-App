import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruity_app/features/auth/presentation/manager/auth_view_cubit.dart';
import 'package:fruity_app/features/auth/presentation/widgets/sign_up_auth_mode_components.dart';

import '../../../../core/global/app_colors.dart';
import '../../../../core/global/app_navigator.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/helper.dart';
import '../../../../core/utils/size_config.dart';
import '../../../home/presentation/views/home_view.dart';
import '../manager/auth_view_states.dart';
import 'auth_button.dart';
import 'custom_divider.dart';
import 'sign_in_auth_mode_components.dart';
import 'sign_in_with_google_buttons.dart';
import 'switch_auth_mode.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({
    super.key,
    required this.slideAnimation,
    required this.switchAuthMode,
    required this.formKey,
    required this.authMode,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.phoneController,
    required this.confirmPassController,
    required this.addressController,
  });

  final Animation<Offset> slideAnimation;
  final void Function() switchAuthMode;
  final GlobalKey<FormState> formKey;
  final AuthMode authMode;

  //============ TextFormFields Controllers ============
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
  final TextEditingController confirmPassController;
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthViewCubit, AuthViewStates>(
      listener: (context, state) {
        //=============== Controlling The States ===============
        controlAuthViewStates(state, context);
      },
      builder: (context, state) {
        final AuthViewCubit cubit = AuthViewCubit.getObject(context);
        return Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              SignInAuthModeComponents(
                cubit: cubit,
                formKey: formKey,
                emailController: emailController,
                passwordController: passwordController,
              ),
              //======== For Adding Some Space =========
              SizedBox(height: SizeConfig.screenHeight! * 0.02),

              if (authMode == AuthMode.signUp)
                SignUpAuthModeComponents(
                  cubit: cubit,
                  signUpFormValidation: signUpFormValidation,
                  slideAnimation: slideAnimation,
                  authMode: authMode,
                  formKey: formKey,
                  usernameController: usernameController,
                  passwordController: passwordController,
                  confirmPassController: confirmPassController,
                  addressController: addressController,
                  phoneController: phoneController,
                ),

              //======= For Adding Some Space =======
              SizedBox(height: SizeConfig.screenHeight! * 0.05),
              //=========== Sign In & Up Button ===========
              AuthButton(
                state: state,
                authMode: authMode,
                signInOrSignUp: signInOrSignUp,
              ),
              if (authMode == AuthMode.signIn) ...[
                SizedBox(height: SizeConfig.screenHeight! * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomDivider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Or",
                        style: TextStyle(color: AppColors.kDividerColor),
                      ),
                    ),
                    const CustomDivider(),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.025),
                const SignInWithGoogleButtons(),
              ],

              //========= For Adding Some Space =========
              SizedBox(height: SizeConfig.screenHeight! * 0.02),
              SwitchAuthMode(
                authMode: authMode,
                switchAuthMode: switchAuthMode,
              ),
            ],
          ),
        );
      },
    );
  }

  void controlAuthViewStates(AuthViewStates state, BuildContext context) {
    if (state is SignInErrorState) {
      if (state.error == 'user-not-found') {
        buildSnackBar(
          message: "No user found for that email",
          state: SnackBarStates.error,
          context: context,
        );
      } else if (state.error == 'wrong-password') {
        buildSnackBar(
          message: "Wrong Password",
          state: SnackBarStates.error,
          context: context,
        );
      }
    }

    if (state is SignUpErrorState) {
      if (state.error == 'weak-password') {
        buildSnackBar(
          message: "Password is too weak",
          state: SnackBarStates.error,
          context: context,
        );
      } else if (state.error == 'email-already-in-use') {
        buildSnackBar(
          message: "Account already exists",
          state: SnackBarStates.error,
          context: context,
        );
      }
    }

    if (state is SignInSuccessState) {
      CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
        AppNavigator.navigateAndFinish(screen: const HomeView());
      });
    }

    if (state is SignUpSuccessState) {
      CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
        AppNavigator.navigateAndFinish(screen: const HomeView());
      });
      buildSnackBar(
        message: "Account Created Successfully",
        state: SnackBarStates.success,
        context: context,
      );
    }

    if (state is CreateUserSuccessState) {
      AppNavigator.navigateAndFinish(screen: const HomeView());
    }

    if (state is SignInWithGoogleSuccessState) {
      AppNavigator.navigateAndFinish(screen: const HomeView());
    }
  }

  void signUpFormValidation(BuildContext context) {
    FocusScope.of(context).unfocus();
    AuthViewCubit.getObject(context).userSignUp(
      context: context,
      email: emailController.text,
      username: usernameController.text,
      password: passwordController.text,
      phone: phoneController.text,
      address: addressController.text,
    );
  }

  void signInOrSignUp(BuildContext ctx) {
    if (formKey.currentState!.validate()) {
      //======== Signing The User In ========
      if (authMode == AuthMode.signIn) {
        FocusScope.of(ctx).unfocus();
        AuthViewCubit.getObject(ctx).userSignIn(
          context: ctx,
          email: emailController.text.trim(),
          password: passwordController.text,
        );
      }
      //======== Signing The User Up ========
      else if (authMode == AuthMode.signUp) {
        signUpFormValidation(ctx);
      }
    }
  }
}
