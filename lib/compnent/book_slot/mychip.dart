import 'package:flutter/material.dart';

class MyChip extends StatelessWidget {
  final String text;
  final Function()? onTap; // Function to be called when chip is tapped

  const MyChip({
    Key? key, // Corrected key parameter
    required this.text,
    this.onTap, // Added onTap parameter
  }) : super(key: key); // Call to superclass constructor

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Wrap the Chip with GestureDetector
      onTap: onTap, // Call the onTap function when chip is tapped
      child: Chip(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.blue, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        label: Text(text),
      ),
    );
  }
}
