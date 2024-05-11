import 'package:flutter/material.dart';
import 'package:signup_login/controller/login_controller.dart';

class LoginField extends StatelessWidget {
  const LoginField({
    super.key,
    required this.loginController,
  });

  final LoginController loginController;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Container(
      height: h * 0.088,
      width: w * 0.80,
      child: TextFormField(
        cursorColor: Colors.green.shade500,
        controller: loginController.loginEmailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Color(0xFFe7edeb),
          hintText: "Email",
          prefixIcon: Icon(
            Icons.email,
            color: Colors.grey[600],
            size: 20,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please Enter the password";
          }
          if (value.length != 11 || !RegExp(r'^\d{11}$').hasMatch(value)) {
            return "Please enter valid  11-digit number";
          }
          return null; // Return null if the input is valid
        },
        onChanged: (value) {},
      ),
    );
  }
}
