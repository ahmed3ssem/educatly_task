import 'dart:async';
import 'package:educatly_task/config/PrefHelper/prefs.dart';
import 'package:educatly_task/config/routes/app_routes.dart';
import 'package:educatly_task/core/utils/app_strings.dart';
import 'package:educatly_task/core/utils/assets_manager.dart';
import 'package:educatly_task/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late Timer _timer;
  double _opacity = 0.0;
  double _scale = 0.5;

  startTimer() {
    _timer = Timer(const Duration(milliseconds: 200), () {
      moveToNextScreen();
    });
  }

  moveToNextScreen()=>Prefs.getBool(AppStrings.login) ? moveToHomeScreen() : moveToLoginScreen();

  moveToHomeScreen() {
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (Route<dynamic> route) => false);
    });
  }

  void moveToLoginScreen() {
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();

    // Start the fade-in and scale animations
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0;
        _scale = 1.0;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget buildLogo(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(seconds: 1),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.5, end: _scale),
          duration: const Duration(seconds: 1),
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: Image.asset(
                AssetsManager.logo,
                width: 150.w,
                height: 150.h,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: FractionalOffset.center,
        child: buildLogo(context),
      ),
    );
  }
}
