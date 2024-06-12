import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/controller/bookingController.dart';
import 'package:signup_login/controller/bookingHistoryController.dart';
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
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

// for background flutter notification
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print(message.notification!.title.toString());
    print(message.notification!.body.toString());
  }
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
    Get.put(BookingHistoryController());
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
