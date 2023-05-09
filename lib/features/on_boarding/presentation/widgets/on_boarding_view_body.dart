import 'package:flutter/material.dart';
import 'package:fruity_app/features/on_boarding/presentation/manager/on_boarding_cubit.dart';
import 'package:fruity_app/features/on_boarding/presentation/widgets/page_view_builder.dart';

import '../../../../core/models/on_boarding_model.dart';
import '../../../../core/utils/size_config.dart';
import 'on_boarding_floating_button.dart';
import 'page_view_indicator.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({
    super.key,
    required this.cubit,
  });

  final OnBoardingScreenCubit cubit;

  @override
  Widget build(BuildContext context) {
    PageController boardPageController = PageController();
    //======= OnBoarding Pages Content =======
    List<OnBoardingModel> boarding = [
      OnBoardingModel(
        imgPath: 'assets/images/onboarding/onboarding1.png',
        title: "E Shopping",
        body: "Explore top organic fruits & grab them",
      ),
      OnBoardingModel(
        imgPath: 'assets/images/onboarding/onboarding2.png',
        title: "Delivery On the Way",
        body: "Get your order by speed delivery",
      ),
      OnBoardingModel(
        imgPath: 'assets/images/onboarding/onboarding3.png',
        title: "Delivery Arrived",
        body: "Order is arrived at your place",
      ),
    ];
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth! * 0.06,
        vertical: SizeConfig.screenHeight! * 0.03,
      ),
      child: Column(
        children: <Widget>[
          PageViewBuilder(
            boardPageController: boardPageController,
            boarding: boarding,
            cubit: cubit,
          ),
          //======== For Adding Some Space ==========
          SizedBox(height: SizeConfig.screenHeight! * 0.02),
          Row(
            children: <Widget>[
              PageViewIndicator(
                boardPageController: boardPageController,
                boarding: boarding,
                cubit: cubit,
              ),
              const Spacer(),
              OnBoardingFloatingButton(
                cubit: cubit,
                boardPageController: boardPageController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
