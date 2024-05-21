import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:signup_login/model/station_model.dart';

class StationController extends GetxController {
  RxList<Station> stations = <Station>[].obs;
  RxList<Marker> marker = <Marker>[].obs;
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();

  @override
  void onInit() {
    super.onInit();
    fetchStations();
    goToGivenPosition();
  }

  void fetchStations() async {
    print("Fetching station details from Firestore...");
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('stations').get();
      print("Number of documents fetched: ${snapshot.docs.length}");
      for (var doc in snapshot.docs) {
        print("Document data: ${doc.data()}");
      }
      if (snapshot.docs.isNotEmpty) {
        stations.assignAll(
          snapshot.docs.map((doc) => Station.fromFirestore(doc)).toList(),
        );
      }
    } catch (e) {
      print('Error fetching stations: $e');
    }
  }

  Future<void> goToGivenPosition() async {
    final GoogleMapController mapController = await controller.future;
    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: LatLng(24.87272715408785, 67.0130402530065),
          zoom: 15,
        ),
      ),
    );
  }

  Future<Position> getUserCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get the current position.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  loadCurrentLocation() async {
    try {
      Position value = await getUserCurrentLocation();
      print("${value.latitude}, ${value.longitude}");

      marker.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: "Current Location"),
        ),
      );

      CameraPosition cameraPosition = CameraPosition(
        zoom: 15,
        target: LatLng(value.latitude, value.longitude),
      );

      final GoogleMapController mapController = await controller.future;
      mapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    } catch (e) {
      print("Error fetching location: $e");
    }
  }
}
