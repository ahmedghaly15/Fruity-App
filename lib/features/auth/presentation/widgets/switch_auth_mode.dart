import 'package:flutter/material.dart';

import '../../../../core/global/app_styles.dart';
import '../../../../core/widgets/default_text_button.dart';
import '../manager/auth_view_cubit.dart';

class SwitchAuthMode extends StatelessWidget {
  const SwitchAuthMode({
    super.key,
    required this.authMode,
    required this.switchAuthMode,
  });

  final AuthMode authMode;
  final void Function() switchAuthMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          authMode == AuthMode.signIn
              ? "Don't have an account?"
              : "Already have an account?",
          style: AppStyles.textStyle15,
        ),
        DefaultTextButton(
          onPressed: switchAuthMode,
          title: authMode == AuthMode.signIn ? "Sign Up" : "Sign In",
        ),
      ],
    );
  }
}
