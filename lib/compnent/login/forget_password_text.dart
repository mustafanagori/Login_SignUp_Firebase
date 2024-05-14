import 'package:flutter/material.dart';

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        //   Get.to(ForgetPassword());
      },
      child: Text(
        "Forget password?",
        style: TextStyle(color: Colors.green.shade100, fontSize: 16),
      ),
    );
  }
}
