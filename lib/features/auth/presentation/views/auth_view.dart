import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/auth_view_cubit.dart';
import '../widgets/auth_view_body.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey();
  AuthMode authMode = AuthMode.signIn;

  //============ TextFormFields Controllers ============
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Animations
  late AnimationController _controller;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    //============ Controlling Animations ============
    initSlidingAnimation();

    super.initState();
  }

  @override
  void dispose() {
    // Destroying The Controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthViewCubit(),
      child: GestureDetector(
        // For Closing The Keyboard When The View Is Tapped
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: AuthViewBody(
            slideAnimation: slideAnimation,
            authMode: authMode,
            switchAuthMode: switchAuthMode,
            formKey: formKey,
            emailController: emailController,
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
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.15),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
    );
  }

  //=========== For Switching Between Auth Modes ===========
  void switchAuthMode() {
    if (authMode == AuthMode.signIn) {
      setState(() {
        authMode = AuthMode.signUp;
      });

      _controller.forward();
    } else {
      setState(() {
        authMode = AuthMode.signIn;
      });
      _controller.reverse();
    }
  }
}
