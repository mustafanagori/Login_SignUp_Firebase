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
  final StationController stationController = Get.put(StationController());

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(24.857286878376392, 67.01812779063066),
    zoom: 14, // Adjusted zoom level for better visibility
  );

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    stationController.fetchStations();
    stationController.goToGivenPosition();
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
                Obx(() {
                  if (stationController.stations.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: _initialPosition,
                    onMapCreated: (GoogleMapController controller) {
                      stationController.controller.complete(controller);
                    },
                    markers: Set<Marker>.of(stationController.marker),
                    polylines: {
                      Polyline(
                        polylineId: const PolylineId('route'),
                        points: stationController.polylineCoordinates,
                        color: Colors.blue,
                        width: 5,
                      ),
                    },
                  );
                }),
                Positioned(
                  top: h * 0.6,
                  right: w * 0.04,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      onPressed: () {
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
                Positioned(
                  top: h * 0.53,
                  right: w * 0.04,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      onPressed: () {
                        stationController.fetchStations();
                      },
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.black54,
                        size: 25,
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
                Positioned(
                  top: h * 0.1,
                  left: w * 0.05,
                  child: Obx(() {
                    if (stationController.distance.value.isEmpty) {
                      return const SizedBox();
                    }
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Distance: ${stationController.distance.value}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Duration: ${stationController.duration.value}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
