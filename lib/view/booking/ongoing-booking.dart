import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signup_login/compnent/booking/ongooingBookingCard.dart';
import 'package:signup_login/controller/bookingController.dart';

class OngoingBooking extends StatelessWidget {
  const OngoingBooking({super.key});

  @override
  Widget build(BuildContext context) {
    BookingController bookingController = Get.find();
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: h * 0.01,
        horizontal: w * 0.03,
      ),
      child: ListView.builder(
        itemCount: bookingController.booking.length,
        itemBuilder: (context, index) {
          final station = bookingController.booking[index];
          return OngoingBookingCard(
            path: station['path']!,
            stationName: station['name']!,
          );
        },
      ),
    );
  }
}
