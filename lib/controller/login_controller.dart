// login_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/view/login_signUp/login.dart';
import 'package:signup_login/view/login_signUp/wellcome.dart';
import 'package:signup_login/view/navigation.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  RxBool isLoadingCheckUser = false.obs;

  Future<void> checkUserEmailExists() async {
    isLoadingCheckUser.value = true;
    try {
      var usersCollection = FirebaseFirestore.instance.collection('Users');
      var email = await usersCollection
          .where('email', isEqualTo: emailController.text)
          .get();
      isLoadingCheckUser.value = false;

      if (email.docs.isEmpty) {
        Get.snackbar("Alert", "No account found, please register.",
            colorText: Colors.white);
      } else {
        Get.to(() => Login());
      }
    } catch (e) {
      isLoadingCheckUser.value = false;
      print("Error checking user: $e");
      // Handle error as needed
    }
  }

  Future<void> storeDeviceTokenToFirebase(String uid) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    if (token != null) {
      print("Stored device token in pref $token");
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('Users').doc(uid).set({
        'token': token,
      }, SetOptions(merge: true));
    } else {
      print("Failed to get device token");
      Get.snackbar("Error", "Not got the device token");
    }
  }

  // sign in the user using email and password
  RxBool isLoadingSignIn = false.obs;
  Future<void> signIn() async {
    isLoadingSignIn.value = true;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      isLoadingSignIn.value = false;
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await storeDeviceTokenToFirebase(uid);
      Get.off(() => Navigation());
    } on FirebaseAuthException catch (e) {
      isLoadingSignIn.value = false;
      Get.snackbar("Alert", "Login failed: ${e.message}");
    }
  }

  // sign out the user from Firebase
  RxBool isLoadingSignOut = false.obs;
  Future<void> signOutUser() async {
    try {
      isLoadingSignOut.value = true;
      await FirebaseAuth.instance.signOut();
      isLoadingSignOut.value = false;
      Get.off(() => Wellcome());
    } catch (e) {
      isLoadingSignOut.value = false;
      Get.snackbar("Sign Out Error", "Failed to sign out: $e",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }
}
