import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/view/login_signUp/login.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  void navigateToLogin() {
    // Check if the entered email is registered
    //String email = loginEmailController.text;
    //bool isRegistered = false;
    if (loginEmailController.text.isNotEmpty) {
      signIn();
    } else {
      Get.snackbar(
          'User Not Registered', 'You are not registered. Please sign up.',
          snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
  }

  void signIn() {
    Get.to(Login());
  }

  void clear() {
    loginEmailController.clear();
    loginPasswordController.clear();
  }
}
