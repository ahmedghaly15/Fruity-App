import 'package:flutter/material.dart';
import 'package:fruity_app/core/global/app_theme.dart';
import 'package:fruity_app/features/splash/presentation/views/splash_view.dart';
import 'package:get/get.dart';

void main() {
  runApp(const Fruity());
}

class Fruity extends StatelessWidget {
  const Fruity({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme(),
      home: const SplashView(),
    );
  }
}
