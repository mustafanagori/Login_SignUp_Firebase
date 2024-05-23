import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
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
  // Add a boolean variable to track whether to draw polyline
  RxBool shouldDrawPolyline = false.obs;

  // init function to call load the date when controller initlize

  @override
  void onInit() {
    super.onInit();
    fetchStations();

    loadCurrentLocation();
  }

  // Method to toggle polyline drawing
  void togglePolylineDrawing() {
    shouldDrawPolyline.value = !shouldDrawPolyline.value;
  }

  // Method to draw polyline based on boolean variable
  void handlePolylineDrawing(double endLat, double endLng) {
    if (shouldDrawPolyline.value) {
      drawPolyline(endLat, endLng);
    } else {
      // Clear the polyline coordinates
      polylineCoordinates.clear();
    }
  }

  void showInfoAndStartLiveTracking() async {
    if (polylineCoordinates.isNotEmpty) {
      // Show distance and duration
      // Example: Update distance and duration RxStrings here

      // Start live tracking
      startLiveLocationTracking();
    } else {
      // Handle case where polyline is not drawn yet
      Get.snackbar("Alert", "Please draw a polyline first.");
    }
  }

  // load the current user location
  loadCurrentLocation() async {
    print("getting current location");
    try {
      Position value = await getLocationPermission();
      BitmapDescriptor customIcon = await getResizedIcon(
        'assets/pin.png',
        12,
      );
      marker.add(
        Marker(
          markerId: const MarkerId('Your Location'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: "Your Location"),
          icon: customIcon,
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
      Get.snackbar("Alert", "Unable to get currecnt location");
    }
  }

  Future<BitmapDescriptor> getResizedIcon(
      String assetPath, double scale) async {
    ByteData data = await rootBundle.load(assetPath);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: (scale * 12).toInt(), // Adjust the scale to your needs
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    final Uint8List resizedData =
        (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List();
    return BitmapDescriptor.fromBytes(resizedData);
  }

  Future<void> drawPolyline(double endLat, double endLng) async {
    print("making polyline line ");
    try {
      Position currentPosition = await getLocationPermission();
      PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        MyGoogleApiKey.googleAPIKey,
        PointLatLng(currentPosition.latitude, currentPosition.longitude),
        PointLatLng(endLat, endLng),
        travelMode: TravelMode.driving,
        avoidHighways: true,
        avoidTolls: true,
      );
      // getRoute(
      //     currentPosition.altitude, currentPosition.longitude, endLat, endLng);
      if (result.points.isNotEmpty) {
        // Clear previous polylines
        polylineCoordinates.clear();

        // Add new polyline coordinates
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
        getDirections(currentPosition.latitude, currentPosition.longitude,
            endLat, endLng);
        print("get route call ");
        print(currentPosition.latitude);
        print(currentPosition.longitude);
        print(endLat);
        print(endLng);

        final GoogleMapController mapController = await controller.future;
        CameraPosition cameraPosition = CameraPosition(
          zoom: 12,
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
        );

        mapController
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        Position position = await getLocationPermission();
        print(position);
        update();
      }
    } catch (e) {
      Get.snackbar("Alert", "Invalid Route Your so far from your location");
      print('Error drawing polyline: $e');
    }
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
          BitmapDescriptor customIcon = await getResizedIcon(
            'assets/stationIcon.png',
            12,
          );
          marker.add(
            Marker(
              markerId: MarkerId(station.id),
              position: LatLng(station.map.latitude, station.map.longitude),
              icon: customIcon,
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

  // get permission for location
  Future<Position> getLocationPermission() async {
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

  // Add this method to animate to a specific station
  Future<void> animateToStation(double latitude, double longitude) async {
    // Draw polyline to the selected station

    final GoogleMapController mapController = await controller.future;

    CameraPosition cameraPosition = CameraPosition(
      zoom: 15,
      target: LatLng(latitude, longitude),
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future<void> getDirections(double originLat, double originLng,
      double destinationLat, double destinationLng) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$originLat,$originLng&destination=$destinationLat,$destinationLng&key=${MyGoogleApiKey.googleAPIKey}';
    var response = await http.get(Uri.parse(url));
    print("Get direction response : ${response.body}");
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      print(
          "print distace: ${jsonResponse['routes'][0]['legs'][0]['distance']['text']}");
      print(
          "print duration: ${jsonResponse['routes'][0]['legs'][0]['duration']['text']}");

      print(
          "print speed: ${jsonResponse['routes'][0]['legs'][0]['speed']['text']}");
      if (jsonResponse['geocoder_status'] == 'OK') {
        // Extract distance and duration
        String distanceText =
            jsonResponse['routes'][0]['legs'][0]['distance']['text'];

        String durationText =
            jsonResponse['routes'][0]['legs'][0]['duration']['text'];
        distance.value = distanceText;
        duration.value = durationText;
      } else {
        throw Exception(
            'Failed to fetch directions: ${jsonResponse['status']}');
      }
    } else {
      throw Exception('Failed to fetch directions');
    }
  }

  Future<String> calculateTime(String durationText) async {
    // Example duration text format: "1 hour 30 mins"
    // Split the duration text into individual components
    List<String> components = durationText.split(' ');

    int hours = 0;
    int minutes = 0;

    // Iterate over the components to extract hours and minutes
    for (int i = 0; i < components.length; i += 2) {
      int value = int.parse(components[i]);
      String unit = components[i + 1];

      if (unit.contains('hour')) {
        hours += value;
      } else if (unit.contains('min')) {
        minutes += value;
      }
    }

    // Calculate total time in seconds
    int totalTimeInSeconds = hours * 3600 + minutes * 60;

    // Convert total time to hours and minutes
    int calculatedHours = totalTimeInSeconds ~/ 3600;
    int calculatedMinutes = (totalTimeInSeconds % 3600) ~/ 60;

    // Format the calculated time
    String formattedTime =
        '$calculatedHours ${calculatedHours == 1 ? 'hour' : 'hours'} $calculatedMinutes ${calculatedMinutes == 1 ? 'min' : 'mins'}';

    return formattedTime;
  }

// // Usage in a controller or view model
//   Future<void> fetchRoute() async {
//     var route = await getDirections(37.7749, -122.4194, 34.0522, -118.2437);
//     if (!route['error']) {
//       print('Route data: ${route['data']}');
//       // Process route data for navigation or display on the map
//     } else {
//       print('Error fetching route: ${route['message']}');
//     }
//   }

  // for live tracking

  void startLiveLocationTracking() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update location every 10 meters
      ),
    ).listen((Position position) {
      updateCurrentLocationMarker(position);
      updatePolyline(position);
    });
  }

  void updateCurrentLocationMarker(Position position) {
    marker.removeWhere((marker) => marker.markerId.value == 'Your Location');
    marker.add(
      Marker(
        markerId: const MarkerId('Your Location'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(title: "Your Location"),
        icon: BitmapDescriptor
            .defaultMarker, // Use default marker or a custom one
      ),
    );
  }

  Future<void> updatePolyline(Position position) async {
    // Assuming you have the destination coordinates stored
    double destinationLat = position.altitude;
    double destinationLng = position.longitude;

    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      MyGoogleApiKey.googleAPIKey,
      PointLatLng(position.latitude, position.longitude),
      PointLatLng(destinationLat, destinationLng),
    );

    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      final GoogleMapController mapController = await controller.future;
      CameraPosition cameraPosition = CameraPosition(
        zoom: 15, // Keep the zoom level as needed
        target: LatLng(position.latitude, position.longitude),
      );
      mapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      update();
    }
  }
}

    // "geocoded_waypoints" : 
    // [
    //    {
    //       "geocoder_status" : "OK",
    //       "place_id" : "ChIJYRU3euw-sz4Rd4oaZrqFN74",
    //       "types" : 
    //       [
    //          "establishment",
    //          "health",
    //          "point_of_interest"
    //       ]
    //    },
    //    {
    //       "geocoder_status" : "OK",
    //       "place_id" : "ChIJxzC0ZqNAsz4RyAxUhJkNkBA",
    //       "types" : 
    //       [
    //          "premise"
    //       ]
    //    }
 
    // [
    //    {
    //       "bounds" : 
    //       {
    //          "northeast" : 
    //          {
    //             "lat" : 24.9572796,
    //             "lng" : 67.0899872
    //          },
    //          "southwest" : 
    //          {
    //             "lat" : 24.8795209,
    //             "lng" : 67.05568719999999
    //          }
    //       },
    //       "copyrights" : "Map data ©2024",
    //       "legs" : 
    //       [
    //          {
    //             "distance" : 
    //             {
    //                "text" : "14.0 km",
    //                "value" : 14022
    //             },
    