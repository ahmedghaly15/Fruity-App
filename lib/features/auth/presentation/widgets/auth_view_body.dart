import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fruity_app/core/global/app_assets.dart';
import 'package:fruity_app/core/global/app_network_images.dart';
import 'package:fruity_app/features/auth/presentation/manager/auth_view_cubit.dart';
import 'package:fruity_app/features/auth/presentation/widgets/image_button.dart';

import '../../../../core/global/app_styles.dart';
import '../../../../core/utils/size_config.dart';
import 'auth_form.dart';

class AuthViewBody extends StatelessWidget {
  const AuthViewBody({
    super.key,
    required this.slideAnimation,
    required this.formKey,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
    required this.phoneController,
    required this.confirmPassController,
    required this.addressController,
    required this.switchAuthMode,
    required this.authMode,
    required this.backgroundImgAnimation,
  });

  final Animation<Offset> slideAnimation;
  final Animation<Offset> backgroundImgAnimation;
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
    return Stack(
      alignment: Alignment.center,
      children: [
        SlideTransition(
          position: backgroundImgAnimation,
          child: CachedNetworkImage(
            imageUrl: AppNetworkImages.authViewBackground,
            errorWidget: (context, url, error) => Container(),
            height: SizeConfig.screenHeight! * 0.9,
            width: SizeConfig.screenWidth!,
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth! * 0.05,
                vertical: SizeConfig.screenHeight! * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: SizeConfig.screenHeight! * 0.03),
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
                    slideAnimation: slideAnimation,
                    authMode: authMode,
                    switchAuthMode: switchAuthMode,
                    formKey: formKey,
                    emailController: emailController,
                    usernameController: usernameController,
                    passwordController: passwordController,
                    confirmPassController: confirmPassController,
                    addressController: addressController,
                    phoneController: phoneController,
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.03),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ImageButton(image: AppAssets.googleImg),
                      ImageButton(image: AppAssets.facebookImg),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
