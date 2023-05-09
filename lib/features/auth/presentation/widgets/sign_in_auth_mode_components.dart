import 'package:flutter/material.dart';

import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/input_field.dart';
import '../manager/auth_view_cubit.dart';

class SignInAuthModeComponents extends StatelessWidget {
  const SignInAuthModeComponents({
    super.key,
    required this.cubit,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  final AuthViewCubit cubit;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InputField(
          key: const ValueKey("email"),
          hint: "Email",
          controller: emailController,
          obsecure: false,
          keyboardType: TextInputType.emailAddress,
          textCapitalization: TextCapitalization.none,
          validating: (val) {
            if (val!.isEmpty || !val.contains('@')) {
              return "Email can't be blank";
            }
            return null;
          },
        ),
        //======== For Adding Some Space ==========
        SizedBox(height: SizeConfig.screenHeight! * 0.02),
        //======== Password Input Field =========
        InputField(
          key: const ValueKey("password"),
          hint: "Password",
          controller: passwordController,
          obsecure: cubit.passVisibility,
          keyboardType: TextInputType.visiblePassword,
          textCapitalization: TextCapitalization.none,
          icon: IconButton(
            onPressed: () {
              cubit.switchPassVisibility();
            },
            icon: Icon(
              cubit.passVisibility
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
            ),
          ),
          validating: (val) {
            if (val!.isEmpty) {
              return "Enter a password";
            } else if (val.length < 8) {
              return "Too short pasword";
            }
            return null;
          },
          onSubmit: (String value) {
            if (formKey.currentState!.validate()) {
              FocusScope.of(context).unfocus();
              AuthViewCubit.getObject(context).userSignIn(
                context: context,
                email: emailController.text,
                password: passwordController.text,
              );
            }
          },
        )
      ],
    );
  }
}
