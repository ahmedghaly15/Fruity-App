import 'package:flutter/material.dart';

import '../../../../core/global/app_assets.dart';
import '../../../../core/global/app_colors.dart';
import '../../../../core/global/app_styles.dart';
import '../../../../core/widgets/default_button.dart';
import '../manager/auth_view_cubit.dart';

class SignInWithGoogleButtons extends StatelessWidget {
  const SignInWithGoogleButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              AuthViewCubit.getObject(context).signInWithGoogle();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.kGoogleColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(
                AppAssets.googleImg,
                height: 35,
                width: 35,
              ),
            ),
          ),
          DefaultButton(
            textStyle: AppStyles.texStyle24.copyWith(fontSize: 20),
            height: 17,
            width: 30,
            buttonText: "Sign in with Google",
            onPressed: () {
              AuthViewCubit.getObject(context).signInWithGoogle();
            },
          ),
        ],
      ),
    );
  }
}
