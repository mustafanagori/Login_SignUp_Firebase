import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/compnent/book_slot/mychip.dart';
import 'package:signup_login/view/booking/book_confirm.dart';

class BookSlot extends StatefulWidget {
  const BookSlot({super.key});

  @override
  State<BookSlot> createState() => _BookSlotState();
}

class _BookSlotState extends State<BookSlot> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Book Slot"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            const Text(
              "Vehicle Type",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: h * 0.03,
            ),
            GestureDetector(
              onTap: () => vehicleType(context),
              child: SelectionBox(
                text: '4 Wheeler',
              ),
            ),
            SizedBox(
              height: h * 0.03,
            ),
            GestureDetector(
              onTap: () => showVehicleModel(context),
              child: SelectionBox(
                text: 'Select your Vehicle model',
              ),
            ),
            SizedBox(
              height: h * 0.03,
            ),
            GestureDetector(
              onTap: () => vehicleType(context),
              child: SelectionBox(
                text: 'Select your connection Type',
              ),
            ),
            SizedBox(
              height: h * 0.03,
            ),
            GestureDetector(
              onTap: () => showdate(context),
              child: SelectionBox(
                text: 'Select Date',
              ),
            ),
            SizedBox(
              height: h * 0.03,
            ),
            GestureDetector(
              onTap: () => showtime(context),
              child: SelectionBox(
                text: 'Select Time',
              ),
            ),
            SizedBox(
              height: h * 0.03,
            ),
            GestureDetector(
              onTap: () => chargerType(context),
              child: const SelectionBox(
                text: 'Charger Type',
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: h * 0.02),
              child: SizedBox(
                width: double.infinity,
                height: h * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    Get.to(BookConfirm());
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// bottom sheet for vehicle
void vehicleType(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      var h = MediaQuery.of(context).size.height;
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height * 0.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Select Vehicle Type',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyChip(text: "3 wheeler"),
                MyChip(text: "3 wheeler"),
                MyChip(text: "3 wheeler"),
              ],
            )
          ],
        ),
      );
    },
  );
}

// charger type
void chargerType(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      var h = MediaQuery.of(context).size.height;
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height * 0.15,
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyChip(text: "CSS2"),
                MyChip(text: "CS567"),
                MyChip(text: "CV25"),
              ],
            )
          ],
        ),
      );
    },
  );
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
                crossAxisCount: 4,
                children: const [
                  MyChip(text: "BMW"),
                  MyChip(text: "Civic"),
                  MyChip(text: "City"),
                  MyChip(text: "Corolla"),
                  MyChip(text: "Aqua"),
                  MyChip(text: "Vitz"),
                  MyChip(text: "Swift"),
                  MyChip(text: "Aqua"),
                  MyChip(text: "Vitz"),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

class SelectionBox extends StatelessWidget {
  final String text;
  const SelectionBox({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.7,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      width: double.infinity,
      height: h * 0.07,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.black45, fontSize: 17),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black45,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}

void vehicleModel(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      var h = MediaQuery.of(context).size.height;
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height * 0.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Select Vehicle Model',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: h * 0.02,
            ),
            ListView(
              children: [
                MyChip(text: "3 wheeler"),
                MyChip(text: "3 wheeler"),
                MyChip(text: "3 wheeler"),
              ],
            )
          ],
        ),
      );
    },
  );
}

//time
void showtime(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height * 0.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Select Time',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyChip(text: "6:00"),
                MyChip(text: "8:00"),
                MyChip(text: "9:00"),
              ],
            )
          ],
        ),
      );
    },
  );
}

// show date
void showdate(BuildContext context) {
  print("date");
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height * 0.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Select Date',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyChip(text: "12 May"),
                MyChip(text: "16 May"),
                MyChip(text: "18 May"),
              ],
            )
          ],
        ),
      );
    },
  );
}
