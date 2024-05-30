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
  RxList<Station> stations = <Station>[].obs;
  RxList<Marker> marker = <Marker>[].obs;
  Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  RxString distance = ''.obs;
  RxString duration = ''.obs;

  Rxn<StreamSubscription<Position>> positionStreamSubscription =
      Rxn<StreamSubscription<Position>>();

  @override
  void onInit() {
    super.onInit();
    fetchStations();
    loadCurrentLocation();
  }

  void startLiveTracking(double destinationLat, double destinationLng) {
    positionStreamSubscription.value = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      updateCurrentLocationMarker(position);
      updatePolyline(position, destinationLat, destinationLng);
      updateDistanceAndDuration(position.latitude, position.longitude,
          destinationLat, destinationLng);
    });
  }

  void stopLiveTracking() {
    positionStreamSubscription.value?.cancel();
  }

  void resetTracking() {
    stopLiveTracking();
    polylineCoordinates.clear();
    distance.value = '';
    duration.value = '';
    update();
  }

  loadCurrentLocation() async {
    try {
      Position value = await getLocationPermission();
      BitmapDescriptor customIcon = await getResizedIcon('assets/car.png', 12);
      print("load current location");
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
      update();
    } catch (e) {
      print("Error fetching location: $e");
      Get.snackbar("Alert", "Unable to get current location");
    }
  }

  Future<void> drawPolyline(double endLat, double endLng) async {
    try {
      Position currentPosition = await getLocationPermission();
      PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
        MyGoogleApiKey.googleAPIKey,
        PointLatLng(currentPosition.latitude, currentPosition.longitude),
        PointLatLng(endLat, endLng),
        travelMode: TravelMode.driving,
      );
      if (result.points.isNotEmpty) {
        polylineCoordinates.clear();
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }

        final GoogleMapController mapController = await controller.future;
        CameraPosition cameraPosition = CameraPosition(
          zoom: 12,
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
        );
        await mapController
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        updateDistanceAndDuration(currentPosition.latitude,
            currentPosition.longitude, endLat, endLng);
      }
    } catch (e) {
      Get.snackbar(
          "Alert", "Invalid Route, you are too far from your location");
      print('Error drawing polyline: $e');
    }
  }

  Future<void> updateDistanceAndDuration(double originLat, double originLng,
      double destinationLat, double destinationLng) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$originLat,$originLng&destination=$destinationLat,$destinationLng&key=${MyGoogleApiKey.googleAPIKey}';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse['routes'].isNotEmpty) {
        String distanceText =
            jsonResponse['routes'][0]['legs'][0]['distance']['text'];
        String durationText =
            jsonResponse['routes'][0]['legs'][0]['duration']['text'];
        distance.value = distanceText;
        duration.value = durationText;
        update();
      } else {
        throw Exception(
            'Failed to fetch directions: ${jsonResponse['status']}');
      }
    } else {
      throw Exception('Failed to fetch directions');
    }
  }

  Future<void> updatePolyline(
      Position position, double destinationLat, double destinationLng) async {
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      MyGoogleApiKey.googleAPIKey,
      PointLatLng(position.latitude, position.longitude),
      PointLatLng(destinationLat, destinationLng),
    );
    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      final GoogleMapController mapController = await controller.future;
      CameraPosition cameraPosition = CameraPosition(
        zoom: 15,
        target: LatLng(position.latitude, position.longitude),
      );
      mapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      update();
    }
  }

  Future<void> fetchStations() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('stations').get();
      if (snapshot.docs.isNotEmpty) {
        stations.assignAll(
            snapshot.docs.map((doc) => Station.fromFirestore(doc)).toList());
        for (var station in stations) {
          BitmapDescriptor customIcon =
              await getResizedIcon('assets/stationIcon.png', 12);
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

  Future<void> animateToStation(double latitude, double longitude) async {
    final GoogleMapController mapController = await controller.future;
    CameraPosition cameraPosition = CameraPosition(
      zoom: 15,
      target: LatLng(latitude, longitude),
    );
    await mapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

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
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<BitmapDescriptor> getResizedIcon(
      String assetPath, double scale) async {
    ByteData data = await rootBundle.load(assetPath);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: (scale * 12).toInt(),
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    final Uint8List resizedData =
        (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List();
    return BitmapDescriptor.fromBytes(resizedData);
  }

  void updateCurrentLocationMarker(Position position) {
    marker.removeWhere((marker) => marker.markerId.value == 'Your Location');
    marker.add(
      Marker(
        markerId: const MarkerId('Your Location'),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: const InfoWindow(title: "Your Location"),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    update();
  }
}
