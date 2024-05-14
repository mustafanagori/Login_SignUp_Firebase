import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/controller/login_controller.dart';
import 'package:signup_login/controller/signup_controller.dart';
import 'package:signup_login/view/login_signUp/wellcome.dart';
import 'package:signup_login/view/navigation.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LoginController loginController = Get.put(LoginController());
  final SignupController signupController = Get.put(SignupController());

  @override
  void initState() {
    super.initState();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    await Future.delayed(
        const Duration(seconds: 3)); // Simulate a splash screen delay

    if (user != null) {
      Get.off(() => Navigation());
    } else {
      Get.off(() => const Wellcome());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 238, 238),
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Image.asset(
            'assets/ev2.jpeg',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
