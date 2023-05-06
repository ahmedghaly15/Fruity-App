import 'package:flutter/material.dart';

import '../../../../core/global/app_colors.dart';
import '../manager/on_boarding_cubit.dart';

class OnBoardingFloatingButton extends StatelessWidget {
  const OnBoardingFloatingButton({
    super.key,
    required this.cubit,
    required this.boardPageController,
  });

  final OnBoardingScreenCubit cubit;
  final PageController boardPageController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.kSplashBackgroundColor,
      onPressed: () => cubit.navigateToAuthScreen(
        context,
        boardPageController,
      ),
      child: const Icon(Icons.arrow_forward_ios),
    );
  }
}
