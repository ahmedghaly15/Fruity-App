import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/global/app_colors.dart';
import '../../../../core/models/on_boarding_model.dart';
import '../../../../core/utils/size_config.dart';
import '../manager/on_boarding_cubit.dart';

class PageViewIndicator extends StatelessWidget {
  const PageViewIndicator({
    super.key,
    required this.boardPageController,
    required this.boarding,
    required this.cubit,
  });

  final PageController boardPageController;
  final List<OnBoardingModel> boarding;
  final OnBoardingScreenCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: boardPageController,
      count: boarding.length,
      effect: ExpandingDotsEffect(
        dotColor: Colors.grey,
        activeDotColor: AppColors.kSplashBackgroundColor,
        dotHeight: SizeConfig.screenHeight! * 0.01,
        expansionFactor: SizeConfig.screenWidth! * 0.013,
        dotWidth: SizeConfig.screenWidth! * 0.02,
        spacing: SizeConfig.screenWidth! * 0.015,
      ),
    );
  }
}
