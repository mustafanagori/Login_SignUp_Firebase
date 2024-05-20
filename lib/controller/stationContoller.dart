import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:signup_login/model/station_model.dart';

class StationController extends GetxController {
  RxList<Station> stations = <Station>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStations();
  }

  void fetchStations() async {
    print("call -------------------0");
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('stations').get();
      print(snapshot.docs.toList().length);
      if (snapshot.docs.isNotEmpty) {
        stations.assignAll(
            snapshot.docs.map((doc) => Station.fromFirestore(doc)).toList());
      }
    } catch (e) {
      print('Error fetching stations: $e');
    }
  }
}
