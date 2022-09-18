import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerProfileModel {
  CustomerProfileModel({
    required this.id,
    this.name,
    this.location,
    this.number,
    this.email,
  });

  final String id;
  final String? name;
  String? email;
  final String? location;
  int? number;

  factory CustomerProfileModel.fromDocument(
      DocumentSnapshot<Map<String, dynamic>>? document) {
    Map<String, dynamic>? maps = document!.data();
    if (maps != null) {
      return CustomerProfileModel(
        location: maps['location'],
        email: maps['email'],
        id: maps['id'],
        name: maps['name'],
        number: maps['number'],
      );
    } else {
      return CustomerProfileModel(id: maps!['id']);
    }
  }
}
