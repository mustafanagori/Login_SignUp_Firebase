import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:signup_login/compnent/Enroute/nearstation.dart';
import 'package:signup_login/controller/stationContoller.dart';
import 'package:signup_login/model/station_model.dart';

class Enroute extends StatefulWidget {
  const Enroute({Key? key}) : super(key: key);

  @override
  _EnrouteState createState() => _EnrouteState();
}

class _EnrouteState extends State<Enroute> {
  final StationController stationController = Get.find();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(24.857286878376392, 67.01812779063066),
    zoom: 15,
  );

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    stationController.loadCurrentLocation();
    stationController.fetchStations();
  }

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
                // Google Map and Distance/Duration Display
                Obx(() {
                  if (stationController.stations.isEmpty) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  }

                  return Stack(
                    children: [
                      // Google Map
                      GoogleMap(
                        mapType: MapType.hybrid,
                        initialCameraPosition: _initialPosition,
                        onMapCreated: (GoogleMapController controller) {
                          stationController.controller.complete(controller);
                        },
                        markers: Set<Marker>.of(stationController.marker),
                        polylines: {
                          if (stationController.polylineCoordinates.isNotEmpty)
                            Polyline(
                              polylineId: const PolylineId('route'),
                              points: stationController.polylineCoordinates,
                              color: Colors.blue,
                              width: 5,
                            ),
                        },
                      ),
                      // Distance and duration display
                      Positioned(
                        child: Visibility(
                          visible:
                              stationController.distance.value.isNotEmpty &&
                                  stationController.duration.value.isNotEmpty,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(top: h * 0.06),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      Border.all(color: Colors.blue, width: 1),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Distance: ${stationController.distance.value}',
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Duration: ${stationController.duration.value}',
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                // Current location button
                Positioned(
                  top: h * 0.6,
                  right: w * 0.04,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      onPressed: () {
                        stationController.polylineCoordinates.clear();
                        stationController.distance.value = '';
                        stationController.duration.value = '';
                        stationController.loadCurrentLocation();
                      },
                      icon: const Icon(
                        Icons.my_location_rounded,
                        color: Colors.black54,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                // List of stations
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
                      child: Obx(
                        () {
                          if (stationController.stations.isEmpty) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: stationController.stations.length,
                              itemBuilder: (context, index) {
                                Station station =
                                    stationController.stations[index];
                                return NearStation(
                                  path: station.image,
                                  stationName: station.name,
                                  status: station.status,
                                  address: station.address,
                                  connectionPoint: station.connectionPoint,
                                  serviceTime: station.serviceTime,
                                  rating: station.rating,
                                  latitude: station.map.latitude,
                                  longitude: station.map.longitude,
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
