import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var uid = ''.obs;
  var email = ''.obs;
  var name = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  void fetchUser() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid.value = user.uid;
      fetchUserData(user.uid);
    }
  }

  Future<void> fetchUserData(String uid) async {
    try {
      final documentSnapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      if (documentSnapshot.exists) {
        email.value = documentSnapshot.data()?['email'] ?? '';
        name.value = documentSnapshot.data()?['name'] ?? 'no name';
        print('Name: ${name.value}'); // Add this line for debugging
      } else {
        print('User document does not exist in Firestore');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}
