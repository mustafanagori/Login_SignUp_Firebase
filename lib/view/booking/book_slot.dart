import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:signup_login/controller/booksolt_controller.dart';
import 'package:signup_login/view/booking/book_confirm.dart';

class BookSlot extends StatefulWidget {
  const BookSlot({super.key});

  @override
  State<BookSlot> createState() => _BookSlotState();
}

class _BookSlotState extends State<BookSlot> {
  final BookController _bookSlotController = Get.find();
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
        actions: [
          TextButton(
              onPressed: () {
                _bookSlotController.clearAll();
              },
              child: Text(
                "Clear",
                style: TextStyle(fontSize: 16, color: Colors.black),
                selectionColor: Colors.blue,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: h * 0.1,
              ),
              GestureDetector(
                onTap: () => _bookSlotController.showVehicleModel(context),
                child: SelectionBox(
                  text: '${_bookSlotController.vehicleModelvar}',
                ),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              GestureDetector(
                onTap: () => _bookSlotController.connectionType(context),
                child: SelectionBox(
                  text: '${_bookSlotController.connectionTypevar}',
                ),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              GestureDetector(
                onTap: () => _bookSlotController.showTime(context),
                child: SelectionBox(
                  text: _bookSlotController.selectedTime.value != null
                      ? _bookSlotController.selectedTime.value!.format(context)
                      : 'No time selected',
                ),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              GestureDetector(
                onTap: () => _bookSlotController.showDate(context),
                child: SelectionBox(
                  text: _bookSlotController.selectedDate.value != null
                      ? DateFormat('yyyy-MM-dd')
                          .format(_bookSlotController.selectedDate.value!)
                      : 'No date selected',
                ),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              GestureDetector(
                onTap: () => _bookSlotController.chargerType(context),
                child: SelectionBox(
                  text: '${_bookSlotController.chargerTypevar}',
                ),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              GestureDetector(
                // onTap: () => _bookSlotController.chargerType(context),
                child: SelectionBox(
                  text: '${_bookSlotController.price}',
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
                      _bookSlotController.printAll();
                      if (_bookSlotController.selectedTime.value != null &&
                          _bookSlotController.selectedDate.value != null &&
                          _bookSlotController.vehicleModelvar.value !=
                              'Select Vehicle Model' &&
                          _bookSlotController.connectionTypevar.value !=
                              'Select Connection Type' &&
                          _bookSlotController.chargerTypevar.value !=
                              'Select Charger Type') {
                        Get.to(const BookConfirm());
                      } else {
                        Get.snackbar(
                          'Missing Fields',
                          'Please select all fields',
                        );
                      }
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
      ),
    );
  }
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
