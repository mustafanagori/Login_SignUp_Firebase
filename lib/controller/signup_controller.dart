import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/view/login_signUp/wellcome.dart';

class SignupController extends GetxController {
  //text editing controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  // form key
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  // check variable for loading
  RxBool isLoadingSignUp = false.obs;

  // user register function
  void registerUser() async {
    if (signupFormKey.currentState!.validate()) {
      isLoadingSignUp.value = true; // Set loading to true
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (FirebaseAuth.instance.currentUser != null) {
          await saveUserDataToFirestore(FirebaseAuth.instance.currentUser!.uid);
          Get.snackbar("Success", "You are registered",
              colorText: Colors.white);
          Get.to(() => const Wellcome());
          clear();
        } else {
          Get.snackbar("Error", "Please sign in first",
              colorText: Colors.white);
        }
      } on FirebaseAuthException catch (e) {
        Get.snackbar("Error", "${e.message}", colorText: Colors.white);
      } finally {
        isLoadingSignUp.value =
            false; // Set loading to false after async operations
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

  void clear() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
  }
}
