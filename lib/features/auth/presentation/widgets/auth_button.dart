import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fruity_app/features/auth/presentation/manager/auth_view_states.dart';

import '../../../../core/global/app_colors.dart';
import '../../../../core/widgets/default_button.dart';
import '../manager/auth_view_cubit.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.state,
    required this.authMode,
    required this.signInOrSignUp,
  });

  final AuthViewStates state;
  final AuthMode authMode;
  final void Function(BuildContext context) signInOrSignUp;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ConditionalBuilder(
        condition: state is! SignInLoadingState && state is! SignUpLoadingState,
        builder: (context) => DefaultButton(
          buttonText: authMode == AuthMode.signIn ? "Sign In" : "Sign Up",
          onPressed: () => signInOrSignUp(context),
          width: 120,
        ),
        fallback: (context) => const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            backgroundColor: AppColors.kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
