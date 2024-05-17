import 'package:flutter/material.dart';

class BookingHistoryCard extends StatelessWidget {
  final String stationName;
  final String path;
  const BookingHistoryCard({
    super.key,
    required this.stationName,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: h * 0.01),
      child: Container(
        padding: const EdgeInsets.all(6),
        height: h * 0.16,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.blue,
              offset: Offset(0, 0.1),
            ),
          ],
        ),
        child: Row(
          children: [
            // column 1 -> image
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(10), // You can adjust the radius here
                child: Image.asset(
                  path,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),

            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // station name
                  Text(
                    stationName,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  const Text(
                    "6 OCt,2022 at 10:30 PM",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                  //station address
                  const Text(
                    maxLines: 2,
                    "B 420 Broom charging staion, New york NY 0031",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),

                  // Row ->  connection and button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //botton 1
                      SizedBox(
                        width: w * 0.35,
                        height: h * 0.04,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Go details",
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
    );
  }
}
