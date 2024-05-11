import 'package:flutter/material.dart';

class SimpleText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double size;
  final FontWeight fontWeight;

  const SimpleText({
    required this.text,
    this.textColor = Colors.black54,
    this.size = 16.0,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text, // Use the 'text' parameter
      style: TextStyle(
        color: textColor, // Use the 'color' parameter
        fontSize: size, // Use the 'size' parameter
        fontWeight: fontWeight,
        // You can customize other text styles here if needed
      ),
    );
  }
}
