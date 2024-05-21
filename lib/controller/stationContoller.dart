import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_directions/google_maps_directions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:signup_login/model/station_model.dart';

class StationController extends GetxController {
  RxList<Station> stations = <Station>[].obs;
  RxList<Marker> marker = <Marker>[].obs;
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  RxString distance = ''.obs;
  RxString duration = ''.obs;

  static const String googleAPIKey =
      'AIzaSyCVe_DPn475Dimm7tlC9TA1gzjuk-Wrcy8'; //API key

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

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

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

  // Add this method to animate to a specific station
  Future<void> animateToStation(double latitude, double longitude) async {
    final GoogleMapController mapController = await controller.future;
    CameraPosition cameraPosition = CameraPosition(
      zoom: 15,
      target: LatLng(latitude, longitude),
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  // Method to create a route and calculate distance and duration
  // Future<void> createRoute(double startLatitude, double startLongitude,
  //     double endLatitude, double endLongitude) async {
  //   final GoogleMapsDirections directions =
  //       GoogleMapsDirections(apiKey: googleAPIKey);
  //   final DirectionsResponse response = await directions.directionsWithLocation(
  //     Location(startLatitude, startLongitude),
  //     Location(endLatitude, endLongitude),
  //   );

  //   if (response.isOkay) {
  //     distance.value = response.routes[0].legs[0].distance.text;
  //     duration.value = response.routes[0].legs[0].duration.text;
  //     polylineCoordinates.clear();
  //     PolylinePoints polylinePoints = PolylinePoints();
  //     response.routes[0].overviewPolyline.points.forEach((point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });
  //   } else {
  //     print('Error creating route: ${response.errorMessage}');
  //   }
  // }
}
