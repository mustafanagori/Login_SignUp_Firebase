import 'package:flutter/material.dart';

class SocialButtom extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String imagePath; // Path to the image asset

  const SocialButtom({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.06,
      width: w * 0.8,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 30, // Adjust the height as needed
              width: 30, // Adjust the width as needed
            ),
            SizedBox(width: 10), // Add spacing between image and text
            Text(
              text,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class SocialButtom extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final IconData icon;

//   const SocialButtom({
//     Key? key,
//     required this.text,
//     required this.onPressed,
//     required this.icon,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;
//     return Container(
//       height: h * 0.06,
//       width: w * 0.8,
//       child: ElevatedButton.icon(
//         onPressed: onPressed,
//         style: ButtonStyle(
//           foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//           backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
//           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//           ),
//         ),
//         icon: Icon(
//           icon,
//           color: Colors.black,
//           size: 30,
//         ), // Use Icon widget here
//         label: Text(
//           text,
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
//         ),
//       ),
//     );
//   }
// }
