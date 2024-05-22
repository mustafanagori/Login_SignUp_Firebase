import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/controller/bookingController.dart';
import 'package:signup_login/controller/booksolt_controller.dart';
import 'package:signup_login/controller/favrouite_controller.dart';
import 'package:signup_login/controller/login_controller.dart';
import 'package:signup_login/controller/navigation_controller.dart';
import 'package:signup_login/controller/profile_controller.dart';
import 'package:signup_login/controller/signup_controller.dart';
import 'package:signup_login/controller/stationContoller.dart';
import 'package:signup_login/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(BookingController());
    Get.put(BookController());
    Get.put(LoginController());
    Get.put(HomeNavigation());
    Get.put(SignupController());
    Get.put(StationController());
    Get.put(FavrouiteController());
    Get.put(ProfileController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
