import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruity_app/core/global/app_colors.dart';
import 'package:fruity_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:get/get.dart';

import '../../../../core/global/app_assets.dart';
import '../../../../core/global/app_navigator.dart';
import '../../../../core/global/app_styles.dart';
import '../../../../core/utils/size_config.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();

    setSystemUIOverlayStyle();

    initFadingAnimation();

    navigateToHome();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        const Spacer(),
        Image.asset(AppAssets.splashLogo),
        const SizedBox(height: 20),
        SlideTransition(
          position: slideAnimation,
          child: Text(
            "Fruitylicious delights await!",
            style: AppStyles.textStyle16.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Image.asset(AppAssets.splashImage),
      ],
    );
  }

  void setSystemUIOverlayStyle() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.kSplashBackgroundColor,
        statusBarColor: AppColors.kSplashBackgroundColor,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  void initFadingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 10),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(milliseconds: 3500),
      () => AppNavigator.navigateAndFinish(
        screen: const OnBoardingView(),
        transition: Transition.fade,
      ),
    );
  }
}
