import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingModel {
  String? id;
  String userId;
  String vehicleModel;
  String connectionType;
  DateTime date;
  TimeOfDay time;
  String chargerType;
  String status;
  double price;

  BookingModel({
    this.id,
    required this.userId,
    required this.vehicleModel,
    required this.connectionType,
    required this.date,
    required this.time,
    required this.chargerType,
    required this.status,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'vehicleModel': vehicleModel,
      'connectionType': connectionType,
      'date': date.toIso8601String(),
      'time': time.format(Get.context!),
      'chargerType': chargerType,
      'status': status,
      'price': price,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'],
      userId: map['userId'],
      vehicleModel: map['vehicleModel'],
      connectionType: map['connectionType'],
      date: DateTime.parse(map['date']),
      time: TimeOfDay(
        hour: int.parse(map['time'].split(":")[0]),
        minute: int.parse(map['time'].split(":")[1]),
      ),
      chargerType: map['chargerType'],
      status: map['status'],
      price: map['price'],
    );
  }
}
