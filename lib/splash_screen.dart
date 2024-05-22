import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/view/login_signUp/wellcome.dart';
import 'package:signup_login/view/navigation.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    await Future.delayed(const Duration(seconds: 3));
    if (user != null) {
      Get.off(() => Navigation());
    } else {
      Get.off(() => Wellcome());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 238, 238),
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
