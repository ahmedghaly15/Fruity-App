import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/global/app_navigator.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/helper.dart';
import '../../../home/presentation/views/home_view.dart';
import '../manager/auth_view_cubit.dart';
import '../manager/auth_view_states.dart';
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
      child: BlocConsumer<AuthViewCubit, AuthViewStates>(
        listener: (context, state) {
          //=============== Controlling The States ===============
          controlAuthViewStates(state, context);
        },
        builder: (context, state) {
          final AuthViewCubit cubit = AuthViewCubit.getObject(context);
          return GestureDetector(
            // For Closing The Keyboard When The View Is Tapped
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: AuthViewBody(
                cubit: cubit,
                state: state,
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
          );
        },
      ),
    );
  }

  void controlAuthViewStates(AuthViewStates state, BuildContext context) {
    if (state is SignInErrorState) {
      if (state.error == 'user-not-found') {
        buildSnackBar(
          message: "No user found for that email",
          state: SnackBarStates.error,
          context: context,
        );
      } else if (state.error == 'wrong-password') {
        buildSnackBar(
          message: "Wrong Password",
          state: SnackBarStates.error,
          context: context,
        );
      }
    }

    if (state is SignUpErrorState) {
      if (state.error == 'weak-password') {
        buildSnackBar(
          message: "Password is too weak",
          state: SnackBarStates.error,
          context: context,
        );
      } else if (state.error == 'email-already-in-use') {
        buildSnackBar(
          message: "Account already exists",
          state: SnackBarStates.error,
          context: context,
        );
      }
    }

    if (state is SignInSuccessState) {
      CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
        AppNavigator.navigateAndFinish(screen: const HomeView());
      });
    }

    if (state is SignUpSuccessState) {
      CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
        AppNavigator.navigateAndFinish(screen: const HomeView());
      });
      buildSnackBar(
        message: "Account Created Successfully",
        state: SnackBarStates.success,
        context: context,
      );
    }

    if (state is CreateUserSuccessState) {
      AppNavigator.navigateAndFinish(screen: const HomeView());
    }
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
