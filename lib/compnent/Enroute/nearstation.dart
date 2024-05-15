import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/view/stationDetail.dart';

class NearStation extends StatelessWidget {
  final String stationName;
  final String path;
  final String status;

  const NearStation({
    super.key,
    required this.stationName,
    required this.path,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(right: h * 0.02),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: h * 0.15,
        width: w * 0.7,
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
                    Image.asset(
                      path,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    if (status.isNotEmpty)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: w * 0.15,
                          decoration: BoxDecoration(
                            color: status == 'open' ? Colors.green : Colors.red,
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
                  const Text(
                    "B 420 Broom charging station, New York NY 0031",
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black54,
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lock_clock_rounded,
                            size: 15,
                          ),
                          Text(
                            " 24*7hr",
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Row(
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
                          Icon(
                            Icons.star,
                            color: Colors.blue,
                            size: 15,
                          ),
                          Text(
                            "4.5",
                            style: TextStyle(
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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Connection",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "8 Point",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: w * 0.25,
                        height: h * 0.035,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Get.to(() => StationDetails());
                          },
                          child: const Text(
                            "Direction",
                            style: TextStyle(
                              fontSize: 12,
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
    );
  }
}
