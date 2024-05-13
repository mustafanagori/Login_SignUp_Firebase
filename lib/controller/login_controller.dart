import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/view/dashboard.dart';
import 'package:signup_login/view/login_signUp/login.dart';
import 'package:signup_login/view/login_signUp/wellcome.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  RxString email = ''.obs;
  Future<void> checkUserEmailExists() async {
    var usersCollection = FirebaseFirestore.instance.collection('Users');
    var email = await usersCollection
        .where('email', isEqualTo: loginEmailController.text)
        .get();
    if (email.docs.isEmpty) {
      Get.snackbar("Alert", "No account found, please register.",
          colorText: Colors.white);
    } else {
      Get.to(const Login());
    }
  }

  Future<void> signIn() async {
    print(loginEmailController.text);
    print(loginPasswordController.text);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      );
      clear();
      Get.off(const Dashboard());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        Get.snackbar("Alert", "Wrong password");
      }
    }
  }

  Future<void> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(const Wellcome());
    } catch (e) {
      Get.snackbar("Sign Out Error", "Failed to sign out: $e",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  void clear() {
    loginEmailController.clear();
    loginPasswordController.clear();
  }
}
