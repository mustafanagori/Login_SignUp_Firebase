import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/view/login_signUp/signup.dart';

class DonthaveAccount extends StatelessWidget {
  const DonthaveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account ?",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: w * 0.04,
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => SignUp());
          },
          child: Text(
            "Sign Up ",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: Colors.green.shade600,
            ),
          ),
        ),
      ],
    );
  }
}
