import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:signup_login/compnent/Enroute/nearstation.dart';
import 'package:signup_login/controller/enroute_Controller.dart';

class Enroute extends StatefulWidget {
  const Enroute({Key? key}) : super(key: key);

  @override
  _EnrouteState createState() => _EnrouteState();
}

class _EnrouteState extends State<Enroute> {
  EnrouteController enrouteController = Get.put(EnrouteController());
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _currentPosition = CameraPosition(
    target: LatLng(24.881501200552584, 67.06379402729937),
    zoom: 14.4746,
  );
  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
      infoWindow: InfoWindow(title: 'Super store'),
      markerId: MarkerId('3'),
      position: LatLng(24.878263387790028, 67.06844918917231),
    ),
    Marker(
      infoWindow: InfoWindow(title: 'Kasshmir road'),
      markerId: MarkerId('4'),

      // starting point
      position: LatLng(24.88312578106687, 67.05482159331308),
    ),
  ];
  @override
  void initState() {
    super.initState();
    loadCurrentLocation();
    _marker.addAll(_list);
  }

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: _currentPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: Set<Marker>.of(_marker),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton.icon(
                      onPressed: () {
                        _goToGivenPosition();
                      },
                      icon: const Icon(
                        Icons.location_city_rounded,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Location",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    height: h * 0.2,
                    width: w,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: h * 0.005,
                          horizontal: w * 0.01,
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: enrouteController.nearStation.length,
                          itemBuilder: (context, index) {
                            final station =
                                enrouteController.nearStation[index];
                            return NearStation(
                              path: station['path'] ?? '',
                              stationName: station['name'] ?? 'Unknown',
                              status: station['status'] ?? 'Unknown',
                            );
                          },
                        )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToGivenPosition() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        const CameraPosition(
          target: LatLng(24.863081088941897, 67.02858036623955),
          zoom: 30,
        ),
      ),
    );
    setState(() {});
  }

  //postion are lat and lag of cuurent postion
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) => {})
        .onError((error, stackTrace) {
      return Future.error("The Error is :  ${error.toString()}");
    });
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  loadCurrentLocation() async {
    try {
      Position value = await getUserCurrentLocation();
      print("${value.latitude.toString()}, ${value.longitude.toString()}");

      _marker.add(
        Marker(
          markerId: MarkerId('6'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: "current location"),
        ),
      );

      CameraPosition cameraPosition = CameraPosition(
        zoom: 9,
        target: LatLng(value.latitude, value.longitude),
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {});
    } catch (e) {
      print("Error fetching location: $e");
    }
  }
}
