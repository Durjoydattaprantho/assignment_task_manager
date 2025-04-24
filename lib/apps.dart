
import 'package:assignment_task_manager/controller_binder.dart';
import 'package:assignment_task_manager/ui/password/forgat_password_email.dart';
import 'package:assignment_task_manager/ui/password/forgat_password_otp.dart';
import 'package:assignment_task_manager/ui/screens/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:assignment_task_manager/ui/screens/add_new_task_screen.dart';
import 'package:assignment_task_manager/ui/screens/login_screen.dart';
import 'package:assignment_task_manager/ui/screens/main_bottom_nav_screen.dart';
import 'package:assignment_task_manager/ui/screens/register_screen.dart';
import 'package:assignment_task_manager/ui/screens/reset_password_screen.dart';
import 'package:assignment_task_manager/ui/screens/splash_screen.dart';
import 'package:get/get.dart';
class task_manager extends StatelessWidget {
  const task_manager({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: task_manager.navigatorKey,
      title: 'Task Manager',
      initialRoute:'/splash' ,
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/resetPassword': (context) => ResetPasswordScreen(),
        '/forgetPasswordEmail': (context) => ForgetPasswordEmail(),
        '/forgetPasswordPin': (context) => ForgetPasswordOtp(),
        '/MainBottomNavScreen': (context)=> MainBottomNavScreen(),
        '/AddNewTaskScreen': (context) =>AddNewTaskScreen(),
        '/UpdateProfileScreen': (context)=> UpdateProfileScreen(),

      },
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          labelLarge: TextStyle(color: Colors.grey),
          headlineMedium: TextStyle(fontWeight: FontWeight.w600),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          border: _getZeroBorder(),
          enabledBorder: _getZeroBorder(),
          errorBorder: _getZeroBorder(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(double.maxFinite),
            backgroundColor: Colors.green,
            foregroundColor: Colors.blue,
            iconColor: Colors.white,
            iconSize: 30,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
          home: SplashScreen(),

      initialBinding: ControllerBinder(),
    );
  }
}
//
_getZeroBorder() {
  return const OutlineInputBorder(borderSide: BorderSide.none);
}
