import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruity_app/core/global/app_colors.dart';

import '../../../../core/global/app_styles.dart';
import '../../../../core/widgets/default_text_button.dart';
import '../manager/on_boarding_cubit.dart';
import '../manager/on_boarding_states.dart';
import '../widgets/on_boarding_view_body.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  @override
  void initState() {
    super.initState();
    setSystemUIOverlayStyle();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => OnBoardingScreenCubit(),
      child: BlocConsumer<OnBoardingScreenCubit, OnBoardingStates>(
        listener: (context, state) {},
        builder: (context, state) {
          OnBoardingScreenCubit cubit =
              OnBoardingScreenCubit.getObject(context);
          return Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                Visibility(
                  visible: cubit.isLastBoarding ? false : true,
                  child: DefaultTextButton(
                    onPressed: () =>
                        cubit.navigateDirectlyToAuthScreen(context),
                    title: "SKIP",
                    textStyle: AppStyles.textStyle20.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
            body: OnBoardingViewBody(
              cubit: cubit,
            ),
          );
        },
      ),
    );
  }

  void setSystemUIOverlayStyle() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }
}
