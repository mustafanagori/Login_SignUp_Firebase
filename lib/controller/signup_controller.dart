import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/view/login_signUp/wellcome.dart';

class SignupController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formkey2 = GlobalKey<FormState>();

  void registerUser() async {
    if (formkey2.currentState!.validate()) {
      print(emailController.text);
      print(passwordController.text);
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (FirebaseAuth.instance.currentUser != null) {
          await saveUserDataToFirestore(FirebaseAuth.instance.currentUser!.uid);
        } else {
          Get.snackbar("Error", "Please sign in first",
              colorText: Colors.white);
        }
        Get.snackbar("Success", "You are registered", colorText: Colors.white);
        Get.to(() => Wellcome());
        clear();
      } on FirebaseAuthException catch (e) {
        Get.snackbar("Error", "${e.message}", colorText: Colors.white);
      }
    }
  }

  Future<void> saveUserDataToFirestore(String uid) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      await users.doc(uid).set({
        'email': emailController.text,
      });
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
  }
}
