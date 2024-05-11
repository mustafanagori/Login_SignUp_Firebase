import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/compnent/otherWidget/simple_Text.dart';



class MyDialog {
  static void show(String title, String content) {
    Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(color: Colors.black54),
      content: Column(
        children: [
          SimpleText(
            text: content,
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
