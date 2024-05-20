import 'package:cloud_firestore/cloud_firestore.dart';

class Station {
  final String id;
  final String name;
  final String address;
  final String connectionPoint;
  final String image;
  final GeoPoint map;
  final int rating;
  final String serviceTime;
  final String status;

  Station({
    required this.id,
    required this.name,
    required this.address,
    required this.connectionPoint,
    required this.image,
    required this.map,
    required this.rating,
    required this.serviceTime,
    required this.status,
  });

  factory Station.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Station(
      id: doc.id,
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      connectionPoint: data['connectionPoint'] ?? '',
      image: data['image'] ?? '',
      map: data['map'] ?? GeoPoint(0, 0),
      rating: (data['rating'] ?? 0).toInt(), // Convert to integer
      serviceTime: data['serviceTime'] ?? '',
      status: data['status'] ?? '',
    );
  }
}
