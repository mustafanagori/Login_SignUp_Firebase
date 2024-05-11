import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/view/login_signUp/wellcome.dart';

class SignupController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void registerUser() async {
    if (formkey.currentState!.validate()) {
      print(emailController.text);
      print(passwordController.text);
      try {
        // Create user in Firebase Authentication
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Save user data to Firestore
        await saveUserDataToFirestore(userCredential.user!.uid);

        Get.snackbar("Success", "You are registered", colorText: Colors.white);
        Get.to(const Wellcome());
        clear();
      } on FirebaseAuthException catch (e) {
        Get.snackbar("Error", "${e.message}", colorText: Colors.white);
      }
    }
  }

  Future<void> saveUserDataToFirestore(String uid) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('user');

      await users.doc(uid).set({
        'email': emailController.text,
        // Add more user data fields as needed
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
