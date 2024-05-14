import 'package:get/get.dart';

class FavrouiteController extends GetxController {
  // list of map for add favrouite item
  final List<Map<String, String>> favrouite = [];
  // List of stations
  final List<Map<String, String>> favrouiteStation = [
    {
      "name": "Broome Charging Station",
      "path": "assets/station/1.jpeg",
    },
    {
      "name": "Albany Charging Station",
      "path": "assets/station/2.png",
    },
    {
      "name": "Cortland Charging Station",
      "path": "assets/station/3.jpg",
    },
    {
      "name": "Broome Charging Station",
      "path": "assets/station/4.jpg",
    },
    {
      "name": "Albany Charging Station",
      "path": "assets/station/5.jpg",
    },
    {
      "name": "Cortland Charging Station",
      "path": "assets/station/6.jpg",
    },
    {
      "name": "Albany Charging Station",
      "path": "assets/station/7.jpeg",
    },
    {
      "name": "Cortland Charging Station",
      "path": "assets/station/8.jpeg",
    },
    {
      "name": "Cortland Charging Station",
      "path": "assets/station/9.jpeg",
    },
  ];

  void removeFromFavrouite() {}
}
