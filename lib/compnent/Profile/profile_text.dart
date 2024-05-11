import 'package:flutter/material.dart';

class ProfileText extends StatelessWidget {
  final String name;
  const ProfileText({
    Key? key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Text(
        name,
        style: TextStyle(color: Colors.black38, fontSize: 15),
      ),
    );
  }
}
