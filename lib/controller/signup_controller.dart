import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/view/login_signUp/wellcome.dart';

class SignupController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void signUp() {
    Get.snackbar("Sucessfully", "You are registered ", colorText: Colors.white);
    Get.to(Wellcome());
  }
}
