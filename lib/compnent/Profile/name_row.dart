import 'package:flutter/material.dart';
import 'package:signup_login/compnent/Profile/profile_text.dart';

class NameRow extends StatelessWidget {
  final String name;
  const NameRow({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ProfileText(name: 'User Name: '),
        ProfileText(
          name: "Mustafa",
        )
      ],
    );
  }
}
