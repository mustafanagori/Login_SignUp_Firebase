import 'package:flutter/material.dart';

class DashboardDrawer extends StatelessWidget {
  final String userEmail;

  const DashboardDrawer({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Drawer(
      //shadowColor: Colors.white38,
      backgroundColor: Colors.black54,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Column(
            children: [
              BgImage(h: h),
              SizedBox(
                height: h * 0.10,
              ),
              Text(
                "Email : $userEmail",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: h * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white24,
                  ),
                  height: h * 0.4,
                  width: w * 0.7,
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
                height: h * 0.07,
              ),
              SizedBox(
                height: h * 0.06,
                width: w * 0.65,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.green.shade600,
                  ),
                  onPressed: () {
                    // Handle logout
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: w * 0.25,
            top: h * 0.14,
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
