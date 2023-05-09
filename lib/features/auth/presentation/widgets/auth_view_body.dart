import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fruity_app/features/auth/presentation/manager/auth_view_cubit.dart';
import 'package:fruity_app/features/auth/presentation/manager/auth_view_states.dart';

import '../../../../core/global/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import 'auth_form.dart';

class AuthViewBody extends StatelessWidget {
  const AuthViewBody({
    super.key,
    required this.cubit,
    required this.slideAnimation,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
    required this.confirmPassController,
    required this.addressController,
    required this.switchAuthMode,
    required this.authMode,
    required this.state,
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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const CachedNetworkImageProvider(
            'https://img.freepik.com/free-vector/realistic-ftuiys-juice-splash-burst-composition-with-spray-images-ripe-tropical-fruits-blank_1284-29364.jpg?w=740&t=st=1683654680~exp=1683655280~hmac=eeb6136ca844a520733a8a85edc214401c460f709a867271a422c251ef7c3c51',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.7),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth! * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  authMode == AuthMode.signIn ? "SIGN IN" : "SIGN UP",
                  style: AppStyles.textStyle50,
                ),
                // For Adding Some Space
                SizedBox(height: SizeConfig.screenHeight! * 0.01),
                Text(
                  authMode == AuthMode.signIn
                      ? "Sign in to start your fruity journey"
                      : "Let's make a new account",
                  style: AppStyles.textStyle18,
                ),
                //======== For Adding Some Space ========
                SizedBox(height: SizeConfig.screenHeight! * 0.03),
                //======================= Auth Form =======================
                AuthForm(
                  cubit: cubit,
                  state: state,
                  slideAnimation: slideAnimation,
                  authMode: authMode,
                  switchAuthMode: switchAuthMode,
                  formKey: formKey,
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPassController: confirmPassController,
                  addressController: addressController,
                  phoneController: phoneController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
