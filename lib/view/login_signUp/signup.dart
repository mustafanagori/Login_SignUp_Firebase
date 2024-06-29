import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/compnent/otherWidget/CustomButton.dart';
import 'package:signup_login/controller/signup_controller.dart';
import 'package:signup_login/view/login_signUp/wellcome.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final SignupController signupController = Get.find();

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/wellcome.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: h * 0.1),
                          Align(
                            alignment: Alignment.center,
                            child: const Text(
                              "Register Now",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: h * 0.65,
                              width: w * 0.90,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Form(
                                    key: signUpFormKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: h * 0.03),
                                        TopText(h: h),
                                        SizedBox(height: h * 0.02),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: h * 0.08,
                                              child: TextFormField(
                                                cursorColor:
                                                    Colors.green.shade500,
                                                controller: signupController
                                                    .nameController,
                                                keyboardType:
                                                    TextInputType.name,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  filled: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: h * 0.002),
                                                  fillColor:
                                                      const Color(0xFFe7edeb),
                                                  hintText: "Name",
                                                  prefixIcon: Icon(
                                                    Icons.person,
                                                    color: Colors.grey[600],
                                                    size: 20,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Please enter a name";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.08,
                                              child: TextFormField(
                                                cursorColor:
                                                    Colors.green.shade500,
                                                controller: signupController
                                                    .emailController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  filled: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: h * 0.002),
                                                  fillColor:
                                                      const Color(0xFFe7edeb),
                                                  hintText: "Email",
                                                  prefixIcon: Icon(
                                                    Icons.email,
                                                    color: Colors.grey[600],
                                                    size: 20,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Please enter an email";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.08,
                                              child: TextFormField(
                                                cursorColor:
                                                    Colors.green.shade100,
                                                obscureText: _isObscure,
                                                controller: signupController
                                                    .passwordController,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  filled: true,
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: h * 0.002),
                                                  fillColor:
                                                      const Color(0xFFe7edeb),
                                                  hintText: "Password",
                                                  prefixIcon: Icon(
                                                    Icons.lock,
                                                    color: Colors.grey[600],
                                                    size: 20,
                                                  ),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      _isObscure
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                      color: Colors.grey[600],
                                                      size: 20,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isObscure =
                                                            !_isObscure;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Please enter a password";
                                                  } else if (value.length < 6) {
                                                    return "Password must be at least 6 characters";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: h * 0.01),
                                        const Text(
                                          "By selecting Agree and continue below,",
                                          style: TextStyle(
                                            letterSpacing: 1.0,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: h * 0.005),
                                        Row(
                                          children: [
                                            const Text(
                                              "I agree to ",
                                              style: TextStyle(
                                                letterSpacing: 1.0,
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "Terms of Service and Privacy Policy",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.green.shade200,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: h * 0.06),
                                        Obx(
                                          () => signupController
                                                  .isLoadingSignUp.value
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : CustomButton(
                                                  onPressed: () {
                                                    if (signUpFormKey
                                                        .currentState!
                                                        .validate()) {
                                                      signupController
                                                          .registerUser();
                                                    }
                                                  },
                                                  text: "Agree and Continue",
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      child: IconButton(
                        onPressed: () {
                          Get.to(() => Wellcome());
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 25,
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

class TopText extends StatelessWidget {
  const TopText({Key? key, required this.h})
      : super(key: key); // Ensure unique key for TopText widget
  final double h;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Looks like you don't have an account.",
          style:
              TextStyle(letterSpacing: 0.1, fontSize: 14, color: Colors.white),
        ),
        SizedBox(height: h * 0.009),
        const Text(
          "Let's create a new account for you.",
          style:
              TextStyle(letterSpacing: 0.1, fontSize: 14, color: Colors.white),
        ),
        SizedBox(height: h * 0.009),
      ],
    );
  }
}
