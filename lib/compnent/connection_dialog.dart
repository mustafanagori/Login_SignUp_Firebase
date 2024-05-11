import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/compnent/otherWidget/simple_Text.dart';


class InternetConnectionDialog {
  static void show() {
    Get.defaultDialog(
      title: "Check Connection",
      titleStyle: TextStyle(color: Colors.black54),
      content: Column(
        children: [
          SimpleText(
            text: "Please check your Internet Connection",
            textColor: Colors.black54,
            size: 13,
            fontWeight: FontWeight.normal,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
              ),
              onPressed: () {
                Get.back();
              },
              child: SimpleText(
                text: "Ok",
                size: 12,
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
