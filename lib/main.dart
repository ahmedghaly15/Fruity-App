import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fruity_app/core/global/app_theme.dart';
import 'package:fruity_app/features/splash/presentation/views/splash_view.dart';
import 'package:get/get.dart';

import 'core/utils/cache_helper.dart';
import 'core/utils/my_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //===================== Observing My Bloc =====================
  Bloc.observer = MyBlocObserver();

  //===================== Initializing SharedPref =====================
  await CacheHelper.init();

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
