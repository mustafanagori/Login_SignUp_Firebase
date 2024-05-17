import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/login_signUp/wellcome.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    required this.h,
    required this.w,
  });

  // ignore: empty_constructor_bodies
  final double h;
  final double w;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: h * 0.05,
        width: w * 0.25,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade500,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () async {
              Get.off(() => Wellcome());

              Get.snackbar("Logout", "Your are Sucessfully logout ");
            },
            child: const Text(
              "Logout",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
            )),
      ),
    );
  }
}
