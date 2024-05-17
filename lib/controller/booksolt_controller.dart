import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/compnent/book_slot/mychip.dart';

class BookController extends GetxController {
  var selectedTime = Rx<TimeOfDay?>(null);
  var selectedDate = Rx<DateTime?>(null);
  RxString vehicleModelvar = 'Select Vehicle Model'.obs;
  RxString connectionTypevar = 'Select Connection Type'.obs;
  RxString chargerTypevar = 'Select Charger Type'.obs;
  RxDouble price = 0.0.obs;

  void printAll() {
    print(selectedTime.toString());
    print(selectedDate.toString());
    print(connectionTypevar.toString());
    print(chargerTypevar.toString());
    print(price.toString());
  }

  void clearAll() {
    selectedTime.value = null;
    selectedDate.value = null;
    vehicleModelvar.value = 'Select Vehicle Model';
    connectionTypevar.value = 'Select Connection Type';
    chargerTypevar.value = 'Select Charger Type';
    price.value = 0.0;
  }

  // Method to update the price
  void updatePrice() {
    // Calculate the price based on the selected charger type and connection type
    double chargerRate = getChargerRate();
    double connectionRate = getConnectionRate();
    price.value = chargerRate * connectionRate;
  }

  // Method to get charger rate based on selected charger type
  double getChargerRate() {
    double chargerRate = 0.0;

    if (chargerTypevar.value == 'CSS2') {
      chargerRate = 200.0;
    } else if (chargerTypevar.value == 'CS567') {
      chargerRate = 250.0;
    } else if (chargerTypevar.value == 'CV25') {
      chargerRate = 300.0;
    }
    return chargerRate;
  }

  double getConnectionRate() {
    double connectionRate = 0.0;
    if (connectionTypevar.value == '120 watt') {
      connectionRate = 1.2;
    } else if (connectionTypevar.value == '200 watt') {
      connectionRate = 1.5;
    } else if (connectionTypevar.value == '300 watt') {
      connectionRate = 2.0;
    }
    return connectionRate;
  }

  void updateSelectedTime(TimeOfDay? time) {
    selectedTime.value = time;
  }

  void updateSelectedDate(DateTime? date) {
    selectedDate.value = date;
  }

  Future<void> showTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue.shade300,
            colorScheme: ColorScheme.light(
              primary: Colors.blue.shade300,
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.normal,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      updateSelectedTime(picked);
      selectedTime.refresh(); // Trigger UI update
    }
  }

  Future<void> showDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
            ),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      updateSelectedDate(pickedDate);
      selectedDate.refresh(); // Trigger UI update
    }
  }

  void showVehicleModel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        var h = MediaQuery.of(context).size.height;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(6.0),
          height: MediaQuery.of(context).size.height * 0.25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Vehicle Model',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Flexible(
                child: GridView.count(
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 1,
                  crossAxisCount: 5,
                  children: [
                    MyChip(
                      text: "BMW",
                      onTap: () {
                        vehicleModelvar.value = "BMW";
                        Get.back();
                      },
                    ),
                    MyChip(
                      text: "Civic",
                      onTap: () {
                        vehicleModelvar.value = "Civic";
                        Get.back();
                      },
                    ),
                    MyChip(
                      text: "City",
                      onTap: () {
                        vehicleModelvar.value = "City";
                        Get.back();
                      },
                    ),
                    MyChip(
                      text: "Meran",
                      onTap: () {
                        vehicleModelvar.value = "Meran";
                        Get.back();
                      },
                    ),
                    MyChip(
                      text: "Aqua",
                      onTap: () {
                        vehicleModelvar.value = "Aqua";
                        Get.back();
                      },
                    ),
                    MyChip(
                      text: "Vitz",
                      onTap: () {
                        vehicleModelvar.value = "Vitz";
                        Get.back();
                      },
                    ),
                    MyChip(
                      text: "Swift",
                      onTap: () {
                        vehicleModelvar.value = "Swift";
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void chargerType(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        var h = MediaQuery.of(context).size.height;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * 0.18,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Vehicle Charger Type',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyChip(
                    text: "CSS2",
                    onTap: () {
                      chargerTypevar.value = "CSS2"; // Update the variable
                      Get.back(); // Close the bottom sheet
                      updatePrice(); // Update the price
                    },
                  ),
                  MyChip(
                    text: "CS567",
                    onTap: () {
                      chargerTypevar.value = "CS567"; // Update the variable
                      Get.back(); // Close the bottom sheet
                      updatePrice(); // Update the price
                    },
                  ),
                  MyChip(
                    text: "CV25",
                    onTap: () {
                      chargerTypevar.value = "CV25"; // Update the variable
                      Get.back(); // Close the bottom sheet
                      updatePrice(); // Update the price
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void connectionType(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        var h = MediaQuery.of(context).size.height;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          height: MediaQuery.of(context).size.height * 0.15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Connection Type',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyChip(
                    text: "120 watt",
                    onTap: () {
                      connectionTypevar.value =
                          "120 watt"; // Update the variable
                      Get.back(); // Close the bottom sheet
                      updatePrice(); // Update the price
                    },
                  ),
                  MyChip(
                    text: "200 watt",
                    onTap: () {
                      connectionTypevar.value =
                          "200 watt"; // Update the variable
                      Get.back(); // Close the bottom sheet
                      updatePrice(); // Update the price
                    },
                  ),
                  MyChip(
                    text: "300 watt",
                    onTap: () {
                      connectionTypevar.value =
                          "300 watt"; // Update the variable
                      Get.back(); // Close the bottom sheet
                      updatePrice(); // Update the price
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
