import 'package:flutter/material.dart';
import 'package:signup_login/view/booking/booking_history.dart';
import 'package:signup_login/view/booking/ongoing-booking.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});
  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("My Booking"),
          bottom: const TabBar(
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.blue,
            labelColor: Colors.black,
            labelStyle: TextStyle(
              letterSpacing: 1,
              fontSize: 14,
            ),
            tabs: [
              Tab(text: "Ongoing booking"),
              Tab(text: "Booking History"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OngoingBooking(),
            BookingHistory(),
          ],
        ),
      ),
    );
  }
}
