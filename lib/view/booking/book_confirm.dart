import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/controller/booksolt_controller.dart';
import 'package:signup_login/view/navigation.dart';

class BookConfirm extends StatefulWidget {
  const BookConfirm({super.key});
  @override
  State<BookConfirm> createState() => _BookConfirmState();
}

class _BookConfirmState extends State<BookConfirm> {
  final BookController bookController = Get.find();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: const Text("Confirm Booking"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.02,
          vertical: h * 0.01,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: h * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  15,
                ),
                border: Border.all(
                  color: Colors.black45,
                  width: 0.5,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(
                      16.0,
                    ),
                    width: double.infinity,
                    height: h * 0.12,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            14,
                          ),
                          child: Image(
                            height: double.infinity,
                            width: w * 0.4,
                            fit: BoxFit.cover,
                            image: const AssetImage(
                              "assets/car.jpeg",
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Obx(
                              () => Text(
                                bookController.vehicleModelvar.value,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Text(
                              "4 Wheeler",
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const DottedLine(
                    direction: Axis.horizontal,
                    lineLength: double.infinity,
                    lineThickness: 1.0,
                    dashLength: 6.0,
                    dashColor: Colors.black54,
                    dashRadius: 0.0,
                    dashGapLength: 4.0,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Obx(
                        () => Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Date",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  bookController.selectedDate.value != null
                                      ? '${bookController.selectedDate.value!.day}-${bookController.selectedDate.value!.month}-${bookController.selectedDate.value!.year}'
                                      : 'No date selected',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: h * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Slot Time",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  bookController.selectedTime.value != null
                                      ? bookController.selectedTime.value!
                                          .format(context)
                                      : 'No time selected',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: h * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Connection Type",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  bookController.connectionTypevar.value,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: h * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Charger Type",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  bookController.chargerTypevar.value,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: h * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Price",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "\$ ${bookController.price.value} kw",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: h * 0.01,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Total Pay ",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Obx(
                  () => Text(
                    "\$ ${bookController.price.value} kw",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h * 0.05,
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: h * 0.02,
              ),
              child: SizedBox(
                width: double.infinity,
                height: h * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () async {
                    await bookController.bookSlot();
                    bookController.clearAll();

                    Get.snackbar("Successfully", "Slot booked successfully");
                    Get.to(
                      () => Navigation(),
                    );
                  },
                  child: const Text(
                    "Make Payment",
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
