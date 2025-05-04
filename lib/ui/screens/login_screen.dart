import 'package:assignment_task_manager/data/models/login_model.dart';
import 'package:assignment_task_manager/data/service/network_client.dart';
import 'package:assignment_task_manager/data/utils/urls.dart';
import 'package:assignment_task_manager/ui/controllers/auth_controller.dart';
import 'package:assignment_task_manager/ui/widgets/screen_Background.dart';
import 'package:assignment_task_manager/ui/widgets/validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool isIncorrectPassword = false;
  bool visiblePassword = false;
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 150),
                  Text(
                    'Get Started with',
                    style: TextTheme.of(context).headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border:
                      isIncorrectPassword == true
                          ? OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      )
                          : OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      return validator(
                        value!,
                        regExp: RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        ),
                        isEmptyTitle: 'Enter your mail address',
                        alertTitle: 'Enter a valid mail',
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: visiblePassword,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(onPressed: _onTapPasswordVisibilityChange, icon: visiblePassword== true? Icon(Icons.visibility_off): Icon(Icons.visibility) ),
                      hintText: 'Password',
                      border:
                      isIncorrectPassword == true
                          ? OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      )
                          : OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value!.length < 6) {
                        return 'Password min 6 char';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Visibility(
                    visible: isLoading == false,
                    replacement: Center(child:  CircularProgressIndicator(),),
                    child: ElevatedButton(
                      onPressed: _onTapSignInButton,
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),

                  SizedBox(height: 20),

                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: _onTapForgotPasswordButton,
                          child: Text('Forget Password'),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(text: 'Dont\'t Have account?'),
                              TextSpan(
                                text: ' Sign up',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer:
                                TapGestureRecognizer()
                                  ..onTap = _onTapSignUpButton,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onTapSignInButton() {
    _logIn();
  }

  _onTapSignUpButton() {
    Navigator.pushNamed(context, '/register');
  }

  _onTapForgotPasswordButton() {
    Navigator.pushNamed(context, '/forgetPasswordEmail');
  }

  _onTapPasswordVisibilityChange(){
    setState(() {
      visiblePassword = !visiblePassword;
    });
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
