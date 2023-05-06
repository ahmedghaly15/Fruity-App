import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNavigator {
  static void navigateTo(Widget screen) {
    Get.to(screen, transition: Transition.rightToLeftWithFade);
  }

  static void getBack() {
    Get.back();
  }

  static void navigateAndFinish(Widget screen) {
    Get.off(screen, transition: Transition.rightToLeftWithFade);
  }
}
