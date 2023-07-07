import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fruity_app/core/global/app_theme.dart';
import 'package:fruity_app/features/splash/presentation/views/splash_view.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/utils/cache_helper.dart';
import 'core/utils/firebase_options.dart';
import 'core/utils/my_bloc_observer.dart';
import 'core/utils/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  ServicesLocator().setupServiceLocator();

  runApp(const Fruity());
}

// TODO : Replcae BlocConsumer in OnBoardingView with BlocBuilder

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
