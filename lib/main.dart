import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:signup_login/view/login_signUp/wellcome.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized(); // Add this line
    await Firebase.initializeApp();
    print('Firebase initialized');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(MyApp());
}

// Future<void> initFirebase() async {
//   await Firebase.initializeApp();
//   await FirebaseAuth.instance.userChanges().first;
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Wellcome(),
    );
  }
}
