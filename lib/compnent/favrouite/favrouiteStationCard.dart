import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavrouiteStationCard extends StatelessWidget {
  final String stationName;
  final String path;
  const FavrouiteStationCard({
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
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(15)),
            color: Colors.red,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: w * 0.03),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        onDismissed: (direction) {
          Get.snackbar("Alert", "Item delete from favrioite");
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          height: h * 0.18,
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      10), // You can adjust the radius here
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
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // station name
                    Text(
                      stationName,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    //station address
                    const Text(
                      maxLines: 2,
                      "B 420 Broom charging staion, New york NY 0031",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
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
                            Text(" 27*7hr"),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 15,
                            ),
                            Text("2.5 Km"),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.blue,
                              size: 15,
                            ),
                            Text("4.5"),
                          ],
                        ),
                      ],
                    ),
                    // Row ->  connection and button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //conecction text
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Connection",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "8 Point",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        // button
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
                              "Get Direction",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
