import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/controller/login_controller.dart';
import 'package:signup_login/controller/signup_controller.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LoginController loginController = Get.put(LoginController());
  SignupController signupController = Get.put(SignupController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 238, 238),
        body: SizedBox(
          height: h,
          child: Image.asset(
            'assets/500.JPG',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
