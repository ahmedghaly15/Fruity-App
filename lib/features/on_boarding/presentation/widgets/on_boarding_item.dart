import 'package:flutter/material.dart';
import 'package:fruity_app/core/global/app_styles.dart';

import '../../../../core/models/on_boarding_model.dart';

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.model,
  });

  final double screenWidth;
  final double screenHeight;
  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Image(
            image: AssetImage(model.imgPath),
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Text(
          model.title,
          style: AppStyles.textStyle30,
        ),
        SizedBox(height: screenHeight * 0.02),
        Text(
          model.body,
          style: AppStyles.textStyle15,
        ),
        SizedBox(height: screenHeight * 0.02),
      ],
    );
  }
}
