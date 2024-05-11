import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  void navigateToLogin() {
    // Check if the entered email is registered
    //String email = loginEmailController.text;
    //bool isRegistered = false;
    if (loginEmailController.text.isNotEmpty) {
      // signIn();
    } else {
      Get.snackbar(
          'User Not Registered', 'You are not registered. Please sign up.',
          snackPosition: SnackPosition.TOP, colorText: Colors.white);
    }
  }

  Future<void> loginWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Error", "You are not Register");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Error", "Wrong password");
      }
    }
  }

  void clear() {
    loginEmailController.clear();
    loginPasswordController.clear();
  }
}
