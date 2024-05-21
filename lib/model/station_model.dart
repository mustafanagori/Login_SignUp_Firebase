import 'package:cloud_firestore/cloud_firestore.dart';

class Station {
  final String id;
  final String name;
  final String address;
  final int connectionPoint;
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
      name: data['name'] as String? ?? '',
      address: data['address'] as String? ?? '',
      connectionPoint: data['connectionPoint'] is int
          ? data['connectionPoint'] as int
          : int.parse(data['connectionPoint'].toString()),
      image: data['image'] as String? ?? '',
      map: data['map'] as GeoPoint? ?? GeoPoint(0, 0),
      rating: data['rating'] is int
          ? data['rating'] as int
          : int.parse(data['rating'].toString()),
      serviceTime: data['serviceTime'] as String? ?? '',
      status: data['status'] as String? ?? '',
    );
  }
}
