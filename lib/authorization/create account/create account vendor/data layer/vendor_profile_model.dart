import 'package:cloud_firestore/cloud_firestore.dart';

class VendorProfileModel {
  VendorProfileModel(
      {required this.id,
      this.name,
      this.profilePhoto,
      this.operatorid,
      this.accountCreatedDate,
      this.qrcodePhoto});

  final String id;
  final String? name;
  String? profilePhoto;
  final String? operatorid;
  final Timestamp? accountCreatedDate;
  String? qrcodePhoto;

  factory VendorProfileModel.fromDocument(
      DocumentSnapshot<Map<String, dynamic>>? document) {
    Map<String, dynamic>? maps = document!.data();
    if (maps != null) {
      return VendorProfileModel(
        accountCreatedDate: maps['timeStamp'],
        operatorid: maps['operatorid'],
        id: maps['id'],
        name: maps['name'],
        profilePhoto: maps['profilephoto'],
        qrcodePhoto: maps['qrcodephoto'],
      );
    } else {
      return VendorProfileModel(id: maps!['id']);
    }
  }
}
