import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/compnent/login/dont_have_account.dart';
import 'package:signup_login/compnent/login/forget_password_text.dart';
import 'package:signup_login/compnent/otherWidget/CustomButton.dart';
import 'package:signup_login/compnent/otherWidget/SocialButton.dart';
import 'package:signup_login/controller/login_controller.dart';
import 'package:signup_login/controller/wellcome_controller.dart';

class Wellcome extends StatelessWidget {
  final GlobalKey<FormState> wellcomeFormKey = GlobalKey<FormState>();
  final WellcomeController wellcomeController = Get.find();
  final LoginController loginController = Get.find();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/wellcome.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: h * 0.1,
                    ),
                    const Text(
                      "EV Charger!",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        height: h * 0.62,
                        width: w * 0.90,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Form(
                            key: wellcomeFormKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: h * 0.03,
                                ),
                                SizedBox(
                                  height: h * 0.088,
                                  width: w * 0.80,
                                  child: TextFormField(
                                    cursorColor: Colors.blue.shade500,
                                    controller: loginController.emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      fillColor: const Color.fromARGB(
                                          255, 234, 238, 237),
                                      hintText: "Email",
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.grey[600],
                                        size: 20,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter the Email";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: h * 0.01,
                                ),
                                Obx(
                                  () => loginController.isLoadingCheckUser.value
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.blue,
                                          ),
                                        )
                                      : CustomButton(
                                          onPressed: () {
                                            if (wellcomeFormKey.currentState!
                                                .validate()) {
                                              loginController
                                                  .checkUserEmailExists();
                                            }
                                          },
                                          text: "Agree and Continue",
                                        ),
                                ),
                                SizedBox(
                                  height: h * 0.015,
                                ),
                                const Text(
                                  "or",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  height: h * 0.015,
                                ),
                                SocialButtom(
                                  text: 'Continue With Facebook',
                                  onPressed: () {},
                                  imagePath: 'assets/facebook.png',
                                ),
                                SizedBox(
                                  height: h * 0.015,
                                ),
                                SocialButtom(
                                  text: 'Continue With Google',
                                  onPressed: () {},
                                  imagePath: 'assets/google.png',
                                ),
                                SizedBox(
                                  height: h * 0.015,
                                ),
                                SocialButtom(
                                  text: 'Continue With Apple',
                                  onPressed: () {},
                                  imagePath: 'assets/apple.png',
                                ),
                                SizedBox(
                                  height: h * 0.025,
                                ),
                                const DonthaveAccount(),
                                SizedBox(
                                  height: h * 0.015,
                                ),
                                const ForgetPasswordText(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
