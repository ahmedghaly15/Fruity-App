import 'package:flutter/material.dart';
import 'package:fruity_app/features/auth/presentation/manager/auth_view_cubit.dart';
import 'package:fruity_app/features/auth/presentation/widgets/sign_up_auth_mode_components.dart';

import '../../../../core/utils/size_config.dart';
import '../manager/auth_view_states.dart';
import 'auth_button.dart';
import 'sign_in_auth_mode_components.dart';
import 'switch_auth_mode.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({
    super.key,
    required this.cubit,
    required this.state,
    required this.slideAnimation,
    required this.switchAuthMode,
    required this.formKey,
    required this.authMode,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
    required this.confirmPassController,
    required this.addressController,
  });

  final AuthViewCubit cubit;
  final AuthViewStates state;
  final Animation<Offset> slideAnimation;
  final void Function() switchAuthMode;
  final GlobalKey<FormState> formKey;
  final AuthMode authMode;

  //============ TextFormFields Controllers ============
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
  final TextEditingController confirmPassController;
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
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
          //========= For Adding Some Space =========
          SizedBox(height: SizeConfig.screenHeight! * 0.02),
          SwitchAuthMode(
            authMode: authMode,
            switchAuthMode: switchAuthMode,
          ),
        ],
      ),
    );
  }

  void signUpFormValidation(BuildContext context) {
    FocusScope.of(context).unfocus();
    AuthViewCubit.getObject(context).userSignUp(
      context: context,
      email: emailController.text,
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
