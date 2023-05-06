import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruity_app/core/global/app_colors.dart';
import 'package:fruity_app/core/global/app_styles.dart';

import '../../../../core/global/app_assets.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    setSystemUIOverlayStyle();

    initFadingAnimation();

    // navigateToHome();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppLogoBuilder(opacityAnimation: opacityAnimation),
        const SizedBox(height: 20),
        SplashTextBuilder(slideAnimation: slideAnimation),
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

    opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.ease,
      ),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 20),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    animationController.forward();
  }

  // void navigateToHome() {
  //   Future.delayed(
  //     const Duration(milliseconds: 3500),
  //     () => AppNavigator.navigateAndFinish(),
  //   );
  // }
}

class SplashTextBuilder extends StatelessWidget {
  const SplashTextBuilder({
    super.key,
    required this.slideAnimation,
  });

  final Animation<Offset> slideAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slideAnimation,
      builder: (context, _) => SlideTransition(
        position: slideAnimation,
        child: Text(
          "Fruitylicious delights await!",
          style: AppStyles.textStyle16.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class AppLogoBuilder extends StatelessWidget {
  const AppLogoBuilder({
    super.key,
    required this.opacityAnimation,
  });

  final Animation<double> opacityAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: opacityAnimation,
      builder: (context, _) => FadeTransition(
        opacity: opacityAnimation,
        child: Image.asset(AppAssets.splashLogo),
      ),
    );
  }
}
