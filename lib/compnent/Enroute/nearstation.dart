import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/controller/stationContoller.dart';
import 'package:signup_login/view/stationDetail.dart';

class NearStation extends StatelessWidget {
  final String stationName;
  final String path;
  final String status;
  final String address;
  final int connectionPoint;
  final String serviceTime;
  final int rating;
  final double latitude;
  final double longitude;

  const NearStation({
    super.key,
    required this.stationName,
    required this.path,
    required this.status,
    required this.address,
    required this.connectionPoint,
    required this.serviceTime,
    required this.rating,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    final StationController stationController = Get.find();

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(right: h * 0.01),
          child: Container(
            padding: const EdgeInsets.all(10),
            height: h * 0.17,
            width: w * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        Image.network(
                          path,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 25,
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            );
                          },
                        ),
                        if (status.isNotEmpty)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: w * 0.15,
                              decoration: BoxDecoration(
                                color: status == 'open'
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                  child: Text(
                                    status,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stationName,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        address,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.alarm,
                                size: 15,
                              ),
                              Text(
                                serviceTime,
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                size: 15,
                              ),
                              Text(
                                "2.5 Km",
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.green,
                                size: 15,
                              ),
                              Text(
                                rating.toString(),
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Connection",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                connectionPoint.toString(),
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: w * 0.22,
                            height: h * 0.035,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Get.to(() => const StationDetails());
                              },
                              child: const Text(
                                "book",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: -15,
          child: Container(
            height: h * 0.06,
            width: w * 0.2,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                stationController.drawPolyline(latitude, longitude);
                //stationController.startLiveTracking(latitude, longitude);
              },
              icon: const Icon(
                Icons.directions,
                color: Colors.red, // Set the icon color to red
                size: 35,
              ),
            ),
          ),
        ),
        // station location
        Positioned(
          top: -12,
          right: 16,
          child: Container(
            height: h * 0.08,
            width: w * 0.1,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () async {
                stationController.polylineCoordinates.clear();
                stationController.animateToStation(latitude, longitude);
              },
              icon: const Icon(
                Icons.my_location,
                color: Colors.green,
                size: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
