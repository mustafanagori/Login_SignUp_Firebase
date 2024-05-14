import 'package:flutter/material.dart';

class NearStation extends StatelessWidget {
  final String stationName;
  final String path;
  const NearStation({
    super.key,
    required this.stationName,
    required this.path,
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
            // column 1 -> image
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(10), // You can adjust the radius here
                child: Stack(
                  children: [
                    Image.asset(
                      path,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green.shade600,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Open",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // station name
                  Text(
                    stationName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  //station address
                  const Text(
                    maxLines: 2,
                    "B 420 Broom charging staion, New york NY 0031",
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black54,
                    ),
                  ),
                  // row -> time , location and rating
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
                            " 27*7hr",
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
                  // Row -> connection and button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //connection text
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
                      // button
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
                          onPressed: () {},
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
