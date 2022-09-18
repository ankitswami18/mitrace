import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mitrace/authorization/main%20app/data%20layer/refrences_objects.dart';

class VendorAccountDataProvider {
  saveAccountDataToFirestore({
    required String userId,
    required String name,
    required String operatorid,
  }) {
    vendorProfileRef.doc(userId).update({
      'operatorid': operatorid,
      'id': userId,
      'name': name,
      'timeStamp': DateTime.now(),
      'profilephoto': null,
    });
  }

  createVendorInFirestore({required String userId}) {
    vendorProfileRef.doc(userId).set({
      'id': userId,
    });
  }

  updateProfilePhotoInFirestore({
    required String userId,
    required File imageFile,
  }) async {
    // UPDATING THE IMAGE
    UploadTask uploadTask =
        storageRef.child('profileImage_$userId.jpg').putFile(imageFile);
    String downloadUrl = await (await uploadTask).ref.getDownloadURL();
    // UPDATING IN LOCATION
    vendorProfileRef.doc(userId).update({
      'profilephoto': downloadUrl,
    });
  }

  updateScannerPhotoInFirestore({
    required String userId,
    required File imageFile,
  }) async {
    // UPDATING THE IMAGE
    UploadTask uploadTask =
        storageRef.child('scannerImage_$userId.jpg').putFile(imageFile);
    String downloadUrl = await (await uploadTask).ref.getDownloadURL();

    // UPDATING IN LOCATION
    vendorProfileRef.doc(userId).update({
      'qrcodephoto': downloadUrl,
    });
  }

  updateName({required String name, required String userId}) {
    vendorProfileRef.doc(userId).update({
      'name': name,
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>
      getStreamUserDetailsFromFirestore(String userId) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> docs =
        vendorProfileRef.doc(userId).snapshots();
    return docs;
  }
}
