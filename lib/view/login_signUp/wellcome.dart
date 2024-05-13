import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/compnent/login/dont_have_account.dart';
import 'package:signup_login/compnent/login/forget_password_text.dart';
import 'package:signup_login/compnent/otherWidget/CustomButton.dart';
import 'package:signup_login/compnent/otherWidget/SocialButton.dart';

import '../../controller/login_controller.dart';

class Wellcome extends StatefulWidget {
  const Wellcome({Key? key}) : super(key: key);

  @override
  State<Wellcome> createState() => _WellcomeState();
}

class _WellcomeState extends State<Wellcome> {
  bool isPasswordVisible = false;
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/black.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const Text(
                  "Hi !",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  // Clipping the BackdropFilter
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: h * 0.62,
                    width: w * 0.90,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Form(
                        key: loginController.formkey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: h * 0.03,
                            ),
                            SizedBox(
                              height: h * 0.088,
                              width: w * 0.80,
                              child: TextFormField(
                                cursorColor: Colors.green.shade500,
                                controller:
                                    loginController.loginEmailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFe7edeb),
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
                                  return null; // Return null if the input is valid
                                },
                              ),
                            ),
                            SizedBox(
                              height: h * 0.01,
                            ),
                            CustomButton(
                              onPressed: () {
                                loginController.checkUserEmailExists();
                              },
                              text: "Agree and Continue",
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
    );
  }
}
