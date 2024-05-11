import 'package:flutter/material.dart';
import 'package:signup_login/compnent/otherWidget/simple_Text.dart';



class ProfileAppbar extends StatelessWidget {
  const ProfileAppbar({super.key});

  get orderDetails => null;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: SimpleText(
        text: "My Profile",
        textColor: Colors.green.shade500,
        fontWeight: FontWeight.w700,
      ),
      actions: [
        IconButton(
          onPressed: () {
            orderDetails.makePhoneCall();
          },
          icon: Icon(
            Icons.call,
            color: Colors.green.shade500,
            size: 25,
          ),
        )
      ],
    );
  }
}
