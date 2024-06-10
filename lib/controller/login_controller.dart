// login_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_login/view/login_signUp/login.dart';
import 'package:signup_login/view/login_signUp/wellcome.dart';
import 'package:signup_login/view/navigation.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> loginEmailFormKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  // TextEditing Controller for login textField
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  Future<void> storeDeviceToSharedPrefernces() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    if (token != null) {
      print("Device Token: $token");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('device_token', token);
      String? deviceToken = prefs.getString('device_token');
      print("pref preferencd Device Token: $deviceToken");
      storeDeviceTokenToFirebase();
    }
  }

  Future<void> storeDeviceTokenToFirebase() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String? uid = auth.currentUser?.uid;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deviceToken = prefs.getString('device_token');
    print("Stored device token in pref $deviceToken");
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('Users').doc(uid).set({
      'token': deviceToken,
    });
  }

  // check user email in Firebase Firestore to see if user exists in Users collection
  RxBool isLoadingCheckUser = false.obs;
  Future<void> checkUserEmailExists() async {
    isLoadingCheckUser.value = true;
    var usersCollection = FirebaseFirestore.instance.collection('Users');
    var email = await usersCollection
        .where('email', isEqualTo: loginEmailController.text)
        .get();
    isLoadingCheckUser.value = false;
    if (email.docs.isEmpty) {
      Get.snackbar("Alert", "No account found, please register.",
          colorText: Colors.white);
    } else {
      Get.to(() => Login());
    }
  }

  // sign in the user using email and password
  RxBool isLoadingSignIn = false.obs;
  Future<void> signIn() async {
    isLoadingSignIn.value = true;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      );
      isLoadingSignIn.value = false;
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
      Get.offAll(() => Wellcome());
    } catch (e) {
      isLoadingSignOut.value = false;
      Get.snackbar("Sign Out Error", "Failed to sign out: $e",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  // clear the text fields
  @override
  void dispose() {
    loginEmailController.clear();
    loginPasswordController.clear();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }
}
