import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:signup_login/Api/google_api.dart';
import 'package:signup_login/model/station_model.dart';

class StationController extends GetxController {
  // station list where store all station detail came from firebase
  RxList<Station> stations = <Station>[].obs;
  // make a list of marker to add the dataion marker detail
  RxList<Marker> marker = <Marker>[].obs;
  // google map controller to use in Google MAP
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  // list of poly line corrinate to store latitude and longitude
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  // variable for store distance and duration to reach at location
  RxString distance = ''.obs;
  RxString duration = ''.obs;

  // init function to call load the date when controller initlize
  @override
  void onInit() {
    super.onInit();
    fetchStations();
    goToGivenPosition();
  }

  // fetch all station from firebase
  void fetchStations() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('stations').get();
      print("Number of documents fetched: ${snapshot.docs.length}");
      if (snapshot.docs.isNotEmpty) {
        stations.assignAll(
          snapshot.docs.map((doc) => Station.fromFirestore(doc)).toList(),
        );
        // Add markers for stations
        for (var station in stations) {
          marker.add(
            Marker(
              markerId: MarkerId(station.id),
              position: LatLng(station.map.latitude, station.map.longitude),
              infoWindow: InfoWindow(
                title: station.name,
              ),
              onTap: () {
                animateToStation(station.map.latitude, station.map.longitude);
              },
            ),
          );
        }
      }
    } catch (e) {
      print('Error fetching stations: $e');
    }
  }

  // go to give postion in google map accoriding to defined cordinates
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

  // get user current location to move the map camera position
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

  // load the current user location
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

  Future<Map<String, dynamic>> getRoute(
      double startLat, double startLng, double endLat, double endLng) async {
    String url =
        'https://api.mapbox.com/directions/v5/mapbox/driving/$startLng,$startLat;$endLng,$endLat?steps=true&geometries=geojson&access_token=${MyGoogleApiKey.googleAPIKey}';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return {
        'data': jsonDecode(response.body),
        'error': false,
      };
    } else {
      return {
        'data': null,
        'error': true,
        'message': 'Failed to retrieve route'
      };
    }
  }

// Usage in a controller or view model
  Future<void> fetchRoute() async {
    var route = await getRoute(37.7749, -122.4194, 34.0522, -118.2437);
    if (!route['error']) {
      print('Route data: ${route['data']}');
      // Process route data for navigation or display on the map
    } else {
      print('Error fetching route: ${route['message']}');
    }
  }
}

  // Method to create a route and calculate distance and duration
  //
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

