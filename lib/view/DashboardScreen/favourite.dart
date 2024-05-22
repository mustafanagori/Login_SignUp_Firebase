import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/compnent/favrouite/favrouiteStationCard.dart';
import 'package:signup_login/controller/favrouite_controller.dart';

class Favourite extends StatelessWidget {
  const Favourite({super.key});

  @override
  Widget build(BuildContext context) {
    FavrouiteController favrouiteController = Get.find();
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Favourite"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: h * 0.01,
          horizontal: w * 0.03,
        ),
        child: ListView.builder(
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

// class Favourite extends StatelessWidget {
//   const Favourite({super.key});

//   @override
//   Widget build(BuildContext context) {

  
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         //iconTheme: const IconThemeData(color: Colors.white),k,
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: const Text("Favrouite"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           vertical: h * 0.01,
//           horizontal: w * 0.03,
//         ),
//         child: ListView(
//           children: const [
//             FavrouiteStationCard(
//               path: "assets/station/1.jpeg",
//               stationName: "Broome Charging Stataion",
//             ),
            
//           ],
//         ),
//       ),
//     );
//   }
// }
