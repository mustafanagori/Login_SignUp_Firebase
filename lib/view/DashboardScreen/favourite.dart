import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/compnent/favrouite/favrouiteStationCard.dart';
import 'package:signup_login/controller/favrouite_controller.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});
  @override
  Widget build(BuildContext context) {
    //
    FavrouiteController favrouiteController = Get.find();
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    //
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Favourite"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: h * 0.01,
          horizontal: w * 0.03,
        ),
        child: favrouiteController.favrouiteStation.isEmpty
            ? const Center(
                child: Text("No date"),
              )
            : ListView.builder(
                itemCount: favrouiteController.favrouiteStation.length,
                itemBuilder: (context, index) {
                  final station = favrouiteController.favrouiteStation[index];
                  return FavrouiteStationCard(
                    path: station['path']!,
                    stationName: station['name']!,
                  );
                },
              ),
      ),
    );
  }
}
