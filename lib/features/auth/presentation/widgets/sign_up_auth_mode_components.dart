import 'package:flutter/material.dart';

import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/input_field.dart';
import '../manager/auth_view_cubit.dart';

class SignUpAuthModeComponents extends StatelessWidget {
  const SignUpAuthModeComponents({
    super.key,
    required this.confirmPassController,
    required this.addressController,
    required this.authMode,
    required this.cubit,
    required this.slideAnimation,
    required this.passwordController,
    required this.phoneController,
    required this.formKey,
    required this.signUpFormValidation,
  });

  final GlobalKey<FormState> formKey;
  final void Function(BuildContext context) signUpFormValidation;
  final TextEditingController passwordController;
  final TextEditingController confirmPassController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final AuthMode authMode;
  final AuthViewCubit cubit;
  final Animation<Offset> slideAnimation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedContainer(
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
          child: SlideTransition(
            position: slideAnimation,
            child: InputField(
              key: const ValueKey("confirm_password"),
              hint: "Confirm Password",
              controller: confirmPassController,
              obsecure: cubit.confirmPassVisiblity,
              keyboardType: TextInputType.visiblePassword,
              textCapitalization: TextCapitalization.none,
              icon: IconButton(
                onPressed: () {
                  cubit.switchConfirmPassVisibility();
                },
                icon: Icon(
                  cubit.confirmPassVisiblity
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                ),
              ),
              validating: (val) {
                if (val! != passwordController.text || val.isEmpty) {
                  return "Password doesn't match";
                }
                return null;
              },
            ),
          ),
        ),
        //======== Phone Input Field ========
        if (authMode == AuthMode.signUp)
          //======= For Adding Some Space =======
          SizedBox(height: SizeConfig.screenHeight! * 0.02),
        if (authMode == AuthMode.signUp)
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.easeIn,
            child: SlideTransition(
              position: slideAnimation,
              child: InputField(
                key: const ValueKey("phone"),
                hint: "Phone number",
                controller: phoneController,
                obsecure: false,
                keyboardType: TextInputType.phone,
                textCapitalization: TextCapitalization.none,
                validating: (val) {
                  if (val!.isEmpty) {
                    return "Phone can't be blank";
                  }
                  return null;
                },
              ),
            ),
          ),
        if (authMode == AuthMode.signUp)
          //======= For Adding Some Space =======
          SizedBox(height: SizeConfig.screenHeight! * 0.02),
        if (authMode == AuthMode.signUp)
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.easeIn,
            child: SlideTransition(
              position: slideAnimation,
              child: InputField(
                key: const ValueKey("address"),
                hint: "Address",
                controller: addressController,
                obsecure: false,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                validating: (val) {
                  if (val!.isEmpty) {
                    return "Address can't be blank";
                  }
                  return null;
                },
                onSubmit: (String value) {
                  if (formKey.currentState!.validate()) {
                    signUpFormValidation(context);
                  }
                },
              ),
            ),
          )
      ],
    );
  }
}
