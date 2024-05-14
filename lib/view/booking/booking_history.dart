import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/compnent/booking/bookingHistoryvCard.dart';
import 'package:signup_login/controller/bookingHistoryController.dart';

class BookingHistory extends StatelessWidget {
  const BookingHistory({super.key});

  @override
  Widget build(BuildContext context) {
    BookingHistoryController bookingController =
        Get.put(BookingHistoryController());
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: h * 0.01,
        horizontal: w * 0.03,
      ),
      child: ListView.builder(
        itemCount: bookingController.bookingHistory.length,
        itemBuilder: (context, index) {
          final station = bookingController.bookingHistory[index];
          return BookingHistoryCard(
            path: station['path']!,
            stationName: station['name']!,
          );
        },
      ),
    );
  }
}
