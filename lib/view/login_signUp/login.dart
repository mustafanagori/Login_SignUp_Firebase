import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/compnent/otherWidget/CustomButton.dart';
import 'package:signup_login/controller/login_controller.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPasswordVisible = false;
  LoginController loginController = Get.put(LoginController());

  bool showProgress = false;
  bool visible = false;
  bool confrimPass = false;
  bool _isObscure = true;

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //text
                  const Text(
                    "Log in",
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
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: h * 0.40,
                      width: w * 0.90,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.09),
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
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Image(
                                      height: h * 0.06,
                                      image: const AssetImage(
                                          "assets/profile.jpg"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: w * 0.05,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Email",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        loginController
                                            .loginEmailController.text,
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: h * 0.04,
                              ),
                              // password filed
                              Form(
                                key: loginController.loginPasswordFormKey,
                                child: TextFormField(
                                  cursorColor: Colors.green.shade500,
                                  obscureText: _isObscure,
                                  controller:
                                      loginController.loginPasswordController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
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
                                    if (value!.isEmpty && value.length < 6) {
                                      return "Maximun length 6";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),

                              SizedBox(
                                height: h * 0.04,
                              ),
                              CustomButton(
                                onPressed: () {
                                  loginController.signIn();
                                },
                                text: "Continue",
                              ),
                              SizedBox(
                                height: h * 0.04,
                              ),

                              Center(
                                child: Text(
                                  "Forgot your password?",
                                  style: TextStyle(
                                      letterSpacing: 1.0,
                                      fontSize: 15,
                                      color: Colors.green.shade200),
                                ),
                              ),
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
    );
  }
}
