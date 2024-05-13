import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/controller/login_controller.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String email = user!.email!;

    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Column(
              children: [
                BgImage(h: h),
                SizedBox(
                  height: h * 0.12,
                ),
                Text(
                  "Email : $email",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white24,
                    ),
                    height: h * 0.40,
                    width: double.infinity,
                    child: ListView(
                      children: const [
                        Tile(
                          text: "Account Information",
                          icon1: Icons.person_3_outlined,
                          icon2: Icons.arrow_forward_ios_sharp,
                        ),
                        Tile(
                          text: "Privacy & Policy",
                          icon1: Icons.privacy_tip_outlined,
                          icon2: Icons.arrow_forward_ios_sharp,
                        ),
                        Tile(
                          text: "Feedback",
                          icon1: Icons.feedback_outlined,
                          icon2: Icons.arrow_forward_ios_sharp,
                        ),
                        Tile(
                          text: "Help",
                          icon1: Icons.help_outline,
                          icon2: Icons.arrow_forward_ios_sharp,
                        ),
                        Tile(
                          text: "setting",
                          icon1: Icons.settings,
                          icon2: Icons.arrow_forward_ios_sharp,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.05,
                ),
                SizedBox(
                  height: 50,
                  width: w * 0.85,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Colors.green.shade600),
                      onPressed: () {
                        loginController.signOutUser();
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      )),
                )
              ],
            ),
            Positioned(
              left: w * 0.35,
              top: h * 0.10,
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/profile.jpg"),
                  ),
                  Positioned(
                    left: 100,
                    top: 78,
                    child: CircleAvatar(
                      backgroundColor: Colors.green.shade500,
                      radius: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BgImage extends StatelessWidget {
  const BgImage({
    super.key,
    required this.h,
  });

  final double h;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h * 0.2,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
        image: DecorationImage(
          image: AssetImage('assets/cover.avif'),
          fit: BoxFit.cover,
        ),
        color: Color.fromARGB(255, 149, 176, 223),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final String text;
  final IconData icon1;
  final IconData icon2;

  const Tile({
    Key? key,
    required this.text,
    required this.icon1,
    required this.icon2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      leading: Icon(
        icon1,
        size: 22,
        color: Colors.green.shade600,
      ),
      trailing: Icon(
        icon2,
        color: Colors.white,
        size: 18,
      ),
    );
  }
}
