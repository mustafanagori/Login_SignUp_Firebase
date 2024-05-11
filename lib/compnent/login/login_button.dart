import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/controller/login_controller.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required GlobalKey<FormState> formkey,
    required this.loginController,
  }) : _formkey = formkey;

  final GlobalKey<FormState> _formkey;
  final LoginController loginController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      width: double.infinity,
      child: Obx(() {
        // Use Obx to observe isLoading from LoginController
        return loginController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: Colors.green.shade500,
                ),
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade500,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        loginController.isLoading.value ? 0.0 : 20.0),
                  ),
                ),
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    // loginController.isLoading.value =
                    //     true; // Set isLoading to true
                    // loginController.Login().then((_) {
                    //   loginController.isLoading.value =
                    //       false; // Set isLoading back to false
                    // });
                  }
                },
                child: const FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Login ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ),
              );
      }),
    );
  }
}
