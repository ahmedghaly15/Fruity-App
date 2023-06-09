import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruity_app/core/utils/service_locator.dart';

import '../../domain/repositries/auth_repo.dart';
import '../manager/auth_view_cubit.dart';
import '../widgets/auth_view_body.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with TickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey();
  AuthMode authMode = AuthMode.signIn;

  //============ TextFormFields Controllers ============
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Animations
  late AnimationController _slidecontroller;
  late Animation<Offset> _slideAnimation;
  late AnimationController _backgroundImgcontroller;
  late Animation<Offset> _backgroundImgAnimation;

  @override
  void initState() {
    initSlidingAnimation();

    initbackgroundImgSlideAnimation();

    super.initState();
  }

  @override
  void dispose() {
    // Destroying The Controllers
    _slidecontroller.dispose();
    _backgroundImgcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          AuthViewCubit(servicesLocator.get<AuthRepo>()),
      child: GestureDetector(
        // For Closing The Keyboard When The View Is Tapped
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: AuthViewBody(
            slideAnimation: _slideAnimation,
            backgroundImgAnimation: _backgroundImgAnimation,
            authMode: authMode,
            switchAuthMode: switchAuthMode,
            formKey: formKey,
            emailController: emailController,
            usernameController: usernameController,
            passwordController: passwordController,
            confirmPassController: confirmPassController,
            addressController: addressController,
            phoneController: phoneController,
          ),
        ),
      ),
    );
  }

  void initSlidingAnimation() {
    _slidecontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.15),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _slidecontroller, curve: Curves.fastOutSlowIn),
    );
  }

  void initbackgroundImgSlideAnimation() {
    _backgroundImgcontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 2),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _backgroundImgcontroller.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          _backgroundImgcontroller.forward();
        }
      });

    _backgroundImgAnimation = Tween<Offset>(
      begin: const Offset(0, -0.02),
      end: const Offset(0, 0.04),
    ).animate(_backgroundImgcontroller);

    _backgroundImgcontroller.forward();
  }

  //=========== For Switching Between Auth Modes ===========
  void switchAuthMode() {
    if (authMode == AuthMode.signIn) {
      setState(() {
        authMode = AuthMode.signUp;
      });

      _slidecontroller.forward();
    } else {
      setState(() {
        authMode = AuthMode.signIn;
      });
      _slidecontroller.reverse();
    }
  }
}
