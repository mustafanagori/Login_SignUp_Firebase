import 'package:flutter/material.dart';

class MyChip extends StatelessWidget {
  final String text;
  const MyChip({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.blue, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      label: Text(text),
    );
  }
}
