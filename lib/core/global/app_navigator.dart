import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNavigator {
  static void navigateTo({
    required Widget screen,
    Transition transition = Transition.rightToLeftWithFade,
  }) {
    Get.to(screen, transition: transition);
  }

  static void getBack() {
    Get.back();
  }

  static void navigateAndFinish({
    required Widget screen,
    Transition transition = Transition.rightToLeft,
  }) {
    Get.off(screen, transition: transition);
  }

  static void navigateAndFinishAll({
    required Widget screen,
  }) {
    Get.offAll(
      screen,
      transition: Transition.rightToLeft,
    );
  }
}
