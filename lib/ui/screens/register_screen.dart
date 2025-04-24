import 'package:assignment_task_manager/data/service/network_client.dart';
import 'package:assignment_task_manager/data/utils/urls.dart';
import 'package:assignment_task_manager/ui/widgets/pop_up_message.dart';
import 'package:assignment_task_manager/ui/widgets/screen_Background.dart';
import 'package:assignment_task_manager/ui/widgets/validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailTEContrller = TextEditingController();
  final TextEditingController _firstNameTEContrller = TextEditingController();
  final TextEditingController _lastNameTEContrller = TextEditingController();
  final TextEditingController _mobileTEContrller = TextEditingController();
  final TextEditingController _passwordlTEContrller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool passwordVisibility = true;




  static bool _isRegisterLoading = false;

  _passwordVisibilityStateControl() {
    setState(() {
      passwordVisibility = !passwordVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 150),
                  Text(
                    'Join with Us',
                    style: TextTheme.of(context).headlineMedium,
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: _emailTEContrller,
                    decoration: InputDecoration(hintText: 'Email'),
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (String? value) {
                      return validator(
                          value!,
                          isEmptyTitle: 'Enter your mail address',
                          alertTitle: 'Enter a valid mail',
                          regExp: RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                          )
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _firstNameTEContrller,
                    decoration: InputDecoration(hintText: 'First Name'),
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (String? value) {
                      return validator(
                        value!,
                        isEmptyTitle: 'Enter your First Name',
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _lastNameTEContrller,
                    decoration: InputDecoration(hintText: 'Last Name'),
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (String? value) {
                      return validator(
                        value!,
                        isEmptyTitle: 'Enter your Last Name',
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: _mobileTEContrller,
                    decoration: InputDecoration(hintText: 'Mobile'),
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (String? value) {
                      return validator(
                          value!,
                          regExp: RegExp(
                            r'^(?:\+8801|8801|01)[3-9]\d{8}$',
                          ),
                          isEmptyTitle: 'Enter your Mobile Number',
                          alertTitle: 'Enter a valid mobile number'
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (String ?value){
                      if(value!.isEmpty== true){
                        return "Enter your password";
                      }else if(value.length <6){
                        return 'Password min 6 char';
                      }
                      return null ;
                    },
                    obscureText: !passwordVisibility,
                    textInputAction: TextInputAction.next,
                    controller: _passwordlTEContrller,
                    decoration: InputDecoration(
                      suffix: IconButton(
                        onPressed: _passwordVisibilityStateControl,
                        icon:
                        passwordVisibility
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                      ),
                      hintText: 'Password',
                    ),
                  ),

                  SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: _onTapSubmit,
                    child: Visibility(
                      visible: _isRegisterLoading == false,
                      replacement: Center(
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),

                  SizedBox(height: 20),

                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(text: 'Already Have an Account?'),
                          TextSpan(
                            text: ' Sign in',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer:
                            TapGestureRecognizer()
                              ..onTap = _onTapSignInButton,
                          ),
                        ],
                      ),
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

  _onTapSubmit() {
    if(_formKey.currentState!.validate() == true){
      register();
    }
  }

  Future<void> register() async {
    _isRegisterLoading = true;
    setState(() {});
    Map<String, dynamic> body = {
      "email": _emailTEContrller.text.trim(),
      "firstName": _firstNameTEContrller.text.trim(),
      "lastName": _lastNameTEContrller.text.trim(),
      "mobile": _mobileTEContrller.text.trim(),
      "password": _passwordlTEContrller.text,
    };
    NetworkResponse response = await NetworkClient.postRequest(
      url: Urls.registerUrl,
      body: body,
    );
    if (response.statusCode == 200) {
      _clearAllTextField();
      if (!mounted) return;
      showPopUp(context, 'Registration Successfully');
    } else {
      if (!mounted) return;
      showPopUp(context, response.data!['data'] ?? "Something went wrong");
    }
    _isRegisterLoading = false;
    setState(() {
    });
  }

  _onTapSignInButton() {
    Navigator.pop(context);
  }

  void _clearAllTextField() {
    _emailTEContrller.clear();
    _firstNameTEContrller.clear();
    _lastNameTEContrller.clear();
    _mobileTEContrller.clear();
    _passwordlTEContrller.clear();

  }

  @override
  void dispose() {
    _emailTEContrller.dispose();
    _firstNameTEContrller.dispose();
    _lastNameTEContrller.dispose();
    _mobileTEContrller.dispose();
    _passwordlTEContrller.dispose();
    super.dispose();
  }
}
