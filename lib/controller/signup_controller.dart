import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/view/login_signUp/wellcome.dart';

class SignupController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void signUp() {
    Get.snackbar("Sucessfully", "You are registered ", colorText: Colors.white);
    Get.to(const Wellcome());
  }

  void registerUser() async {
    if (formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        Get.snackbar("Error", "User registered successfully");
      } on FirebaseAuthException catch (e) {
        Get.snackbar("Error", "${e.message}");
      }
    }
  }
}
