import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/view/login_signUp/wellcome.dart';

class SignupController extends GetxController {
  // Text editing controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  // Form key
  final GlobalKey<FormState> userRegisterFormKey = GlobalKey<FormState>();

  // Loading state
  RxBool isLoadingSignUp = false.obs;

  // User register function
  void registerUser() async {
    if (userRegisterFormKey.currentState!.validate()) {
      isLoadingSignUp.value = true;
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (FirebaseAuth.instance.currentUser != null) {
          await saveUserDataToFirestore(FirebaseAuth.instance.currentUser!.uid);
          Get.snackbar("Success", "You are registered",
              colorText: Colors.white);
          Get.to(() => Wellcome());
        } else {
          Get.snackbar("Error", "Please sign in first",
              colorText: Colors.white);
        }
      } on FirebaseAuthException catch (e) {
        Get.snackbar("Error", "${e.message}", colorText: Colors.white);
      } finally {
        isLoadingSignUp.value = false;
      }
    }
  }

  Future<void> saveUserDataToFirestore(String uid) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      await users
          .doc(uid)
          .set({'email': emailController.text, 'name': nameController.text});
      print("User data saved to Firestore successfully");
    } catch (e) {
      print("Error saving user data to Firestore: $e");
      Get.snackbar("Error", "Failed to save user data",
          colorText: Colors.white);
    }
  }

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
