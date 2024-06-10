import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/Api/notification.dart';
import 'package:signup_login/controller/login_controller.dart';
import 'package:signup_login/controller/navigation_controller.dart';
import 'package:signup_login/view/DashboardScreen/Enroute.dart';
import 'package:signup_login/view/DashboardScreen/booking.dart';
import 'package:signup_login/view/DashboardScreen/favourite.dart';
import 'package:signup_login/view/DashboardScreen/profile.dart';

class Navigation extends StatefulWidget {
  Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  HomeNavigation bottomNavigationContoller = Get.find();
  LoginController loginController = Get.find();
  NotificationService notificationServices = NotificationService();
  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit();
    notificationServices.getDeviceToken().then((value) {
      print("device toke");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: IndexedStack(
            index: bottomNavigationContoller.selectedIndex.value,
            children: [
              Enroute(),
              Booking(),
              Favourite(),
              Profile(),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.all(6),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black54,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            currentIndex: bottomNavigationContoller.selectedIndex.value,
            onTap: bottomNavigationContoller.changeIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.route_outlined),
                label: "En route",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.schedule),
                label: "Booking",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Favrouite",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
