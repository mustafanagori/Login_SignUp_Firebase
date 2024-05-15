import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final int start;
  final double width;
  final int count;
  final double width2;

  const RatingBar({
    super.key,
    required this.start,
    required this.width,
    required this.count,
    required this.width2,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      child: Row(
        children: [
          Text(
            "Star : $start",
            style: const TextStyle(
              color: Colors.black45,
            ),
          ),
          SizedBox(
            width: w * 0.03,
          ),
          // rating bar line
          Container(
            width: h * width,
            decoration: BoxDecoration(
              color: Colors.black54, // Black background
              borderRadius: BorderRadius.circular(5),
            ),
            child: Stack(
              children: [
                Container(
                  height: h * 0.007,
                  decoration: BoxDecoration(
                    color: Colors.blue, // Blue fill color
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: w * width2,
                ),
              ],
            ),
          ),
          SizedBox(
            width: w * 0.03,
          ),

          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                "$count",
                style: const TextStyle(color: Colors.black45),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
