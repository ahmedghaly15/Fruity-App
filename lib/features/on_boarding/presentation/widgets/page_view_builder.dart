import 'package:flutter/material.dart';

import '../../../../core/models/on_boarding_model.dart';
import '../../../../core/utils/size_config.dart';
import '../manager/on_boarding_cubit.dart';
import 'on_boarding_item.dart';

class PageViewBuilder extends StatelessWidget {
  const PageViewBuilder({
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
    return Expanded(
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: boardPageController,
        itemBuilder: (context, index) => OnBoardingItem(
          screenWidth: SizeConfig.screenWidth!,
          screenHeight: SizeConfig.screenHeight!,
          model: boarding[index],
        ),
        itemCount: boarding.length,
        onPageChanged: (int index) => cubit.onChangePageIndex(index, boarding),
      ),
    );
  }
}
