import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_task/ui/controller/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    bool isLoggedIn = await AuthController.checkIfUserLoggedIn();

    if (!mounted) return;
    // Navigator.pushNamedAndRemoveUntil(context, '/login',(routes)=>false);

    Navigator.pushNamedAndRemoveUntil(
      context,
      isLoggedIn ? '/MainBottomNavScreen' : '/login',
          (routes) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(child: SvgPicture.asset(AssetsPath.logoSvg, height: 200, width: 240)),
      ),
    );
  }
}