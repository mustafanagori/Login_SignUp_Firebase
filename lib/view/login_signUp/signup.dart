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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  SignupController signupController = Get.put(SignupController());

  bool showProgress = false;
  bool visible = false;
  bool confrimPass = false;
  bool _isObscure = true;
  @override
  void initState() {
    print("call recevied");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              onPressed: () {
                Get.to(Wellcome());
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            )),
        body: Container(
            height: h,
            width: double.infinity,
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
                  //text
                  const Text(
                    "Sign Up ",
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // glass container
                  ClipRRect(
                    // Clipping the BackdropFilter
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: h * 0.55,
                      width: w * 0.90,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: h * 0.03,
                              ),
                              TopText(h: h),
                              SizedBox(
                                height: h * 0.02,
                              ),
                              //text field
                              Form(
                                key: signupController.formkey2,
                                child: Column(
                                  children: [
                                    // sign email field
                                    SizedBox(
                                      height: h * 0.08,
                                      child: TextFormField(
                                        cursorColor: Colors.green.shade500,
                                        controller:
                                            signupController.emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: h * 0.002),
                                          fillColor: const Color(0xFFe7edeb),
                                          hintText: "Email",
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Colors.grey[600],
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // sign password fiel
                                    SizedBox(
                                      height: h * 0.08,
                                      child: TextFormField(
                                        cursorColor: Colors.green.shade500,
                                        obscureText: _isObscure,
                                        controller:
                                            signupController.passwordController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: h * 0.002),
                                          fillColor: const Color(0xFFe7edeb),
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
                                                  _isObscure = !_isObscure;
                                                });
                                              }),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty &&
                                              value.length < 6) {
                                            return "Maximun length 6";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // size box
                              SizedBox(
                                height: h * 0.01,
                              ),
                              const Text(
                                "By selecting Agree and continue below ,",
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: h * 0.005,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "I agree to ",
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontSize: 12,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "Term of Service and Privacy policy",
                                    style: TextStyle(
                                        letterSpacing: 1.0,
                                        fontSize: 12,
                                        color: Colors.green.shade500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: h * 0.04,
                              ),
                              CustomButton(
                                onPressed: () {
                                  signupController.registerUser();
                                },
                                text: "Agree and Continue",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}

class TopText extends StatelessWidget {
  const TopText({
    super.key,
    required this.h,
  });

  final double h;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Look Like you don't have an account.",
          style:
              TextStyle(letterSpacing: 0.1, fontSize: 14, color: Colors.white),
        ),
        SizedBox(
          height: h * 0.009,
        ),
        const Text(
          "Lets Create a new account for",
          style:
              TextStyle(letterSpacing: 0.1, fontSize: 14, color: Colors.white),
        ),
        SizedBox(
          height: h * 0.009,
        ),
        const Text(
          "mustafanagori89@gmail.com",
          style:
              TextStyle(letterSpacing: 0.1, fontSize: 14, color: Colors.white),
        ),
      ],
    );
  }
}
