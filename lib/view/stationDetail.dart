import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/compnent/Station_Details/rating.dart';
import 'package:signup_login/view/booking/book_slot.dart';

class StationDetails extends StatelessWidget {
  const StationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Container(
                    color: Colors.black,
                    child: Image.asset(
                      "assets/station/5.jpg",
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 6,
                    left: 6,
                    child: IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 44, 149, 47),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                            )),
                        width: w * 0.2,
                        height: h * 0.04,
                        child: const Center(
                          child: Text(
                            "Open",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: h * 0.02,
                    ),
                    const Text(
                      "B 420 Broom charging staion, New york NY 0031",
                      style: TextStyle(color: Colors.black45),
                    ),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    const Text(
                      "Connection Type",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: h * 0.01,
                    ),

                    // connection type
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ConnectionType(
                          type: "CCS2",
                          kw: "150 KW",
                          price: "(0.05/kw)",
                          icon: Icons.electrical_services_outlined,
                        ),
                        ConnectionType(
                          type: "CS45",
                          kw: "200 KW",
                          price: "(0.15/kw)",
                          icon: Icons.electric_scooter_sharp,
                        ),
                        ConnectionType(
                          type: "CV25",
                          kw: "300 KW",
                          price: "(0.20/kw)",
                          icon: Icons.electric_car,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    const Text(
                      "Review",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    Container(
                      height: h * 0.25,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black45,
                          width: 0.5,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("4.5"),
                                Text(
                                  "*****",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 25,
                                      letterSpacing: 2),
                                ),
                                Text(
                                  "(25 review)",
                                  style: TextStyle(
                                    color: Colors.black45,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.all(6.0),
                                    child: Text(
                                      "Rating",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  // rating bar line
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      RatingBar(
                                        count: 101,
                                        start: 5,
                                        width: 0.17,
                                        width2: 0.3,
                                      ),
                                      RatingBar(
                                        count: 12,
                                        start: 4,
                                        width: 0.17,
                                        width2: 0.25,
                                      ),
                                      RatingBar(
                                        count: 7,
                                        start: 3,
                                        width: 0.17,
                                        width2: 0.20,
                                      ),
                                      RatingBar(
                                        count: 4,
                                        start: 2,
                                        width: 0.17,
                                        width2: 0.15,
                                      ),
                                      RatingBar(
                                        count: 2,
                                        start: 1,
                                        width: 0.17,
                                        width2: 0.1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),

                    // cancel and booking Button
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BookButton(),
                        GetDirectionButton(),
                      ],
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GetDirectionButton extends StatelessWidget {
  const GetDirectionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w * 0.45,
      height: h * 0.06,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.blue),
        onPressed: () {},
        child: const Text(
          "Get Direction",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class BookButton extends StatelessWidget {
  const BookButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SizedBox(
      width: w * 0.4,
      height: h * 0.06,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.blue,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white),
        onPressed: () {
          Get.to(const BookSlot());
        },
        child: const Text(
          "Book Sot",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

class ConnectionType extends StatelessWidget {
  final String type;
  final String kw;
  final String price;
  final IconData icon;

  const ConnectionType({
    super.key,
    required this.type,
    required this.kw,
    required this.price,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.05,
        ),
        boxShadow: [
          const BoxShadow(
            color: Colors.white70, // Black shadow
            offset: Offset(1, 0),
            blurRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      height: h * 0.13,
      width: w * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon as IconData?,
            size: 25,
            color: Colors.blue,
          ),
          Text(
            type,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 15,
            ),
          ),
          Text(
            kw,
            style: const TextStyle(fontSize: 12),
          ),
          Text(
            price,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
