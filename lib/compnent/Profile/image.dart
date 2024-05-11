import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      maxRadius: 70,
      backgroundImage: AssetImage('assets/101.jpg'),
    );
  }
}
