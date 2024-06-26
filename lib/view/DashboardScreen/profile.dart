import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/controller/login_controller.dart';
import 'package:signup_login/controller/profile_controller.dart';
import 'package:signup_login/controller/signup_controller.dart';
import 'package:signup_login/controller/stationContoller.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileController profileController = Get.find();

  LoginController loginController = Get.find();

  SignupController signUpController = Get.find();

  StationController stationController = Get.find();

  @override
  void initState() {
    super.initState();
    profileController.fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  BgImage(h: h),
                  SizedBox(
                    height: h * 0.10,
                  ),
                  Obx(
                    () => Text(
                      profileController.name.value,
                      style: const TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Obx(
                    () => Text(
                      profileController.email.value,
                      style: const TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white24,
                      ),
                      height: h * 0.35,
                      width: w * 0.98,
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
                            text: "Setting",
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
                  Obx(
                    () => loginController.isLoadingSignOut.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          )
                        : SizedBox(
                            height: h * 0.06,
                            width: w * 0.8,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor: Colors.blue,
                              ),
                              onPressed: () async {
                                stationController.resetTracking();
                                // loginController.loginEmailController.clear();
                                loginController.passwordController.clear();
                                await loginController.signOutUser();
                              },
                              child: const Text(
                                "Logout",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: w * 0.3,
              top: h * 0.12,
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
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        image: DecorationImage(
          image: AssetImage('assets/ev.jpeg'),
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
        style: const TextStyle(color: Colors.black, fontSize: 14),
      ),
      leading: Icon(
        icon1,
        size: 18,
        color: Colors.blue,
      ),
      trailing: Icon(
        icon2,
        color: Colors.blue,
        size: 18,
      ),
    );
  }
}
