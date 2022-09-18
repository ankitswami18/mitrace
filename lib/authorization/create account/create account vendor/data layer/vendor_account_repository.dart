import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'vendor_profile_model.dart';
import 'vendor_account_data_provider.dart';

class VendorAccountRepository {
  final VendorAccountDataProvider _dataProvider = VendorAccountDataProvider();
  submitUserDetails({
    required String id,
    required String name,
    required String operatorid,
  }) {
    _dataProvider.saveAccountDataToFirestore(
      userId: id,
      name: name,
      operatorid: operatorid,
    );
  }

  createVendor({required String id}) {
    _dataProvider.createVendorInFirestore(
      userId: id,
    );
  }

  updateProfilePhoto({
    required String userId,
    required File imageFile,
  }) {
    _dataProvider.updateProfilePhotoInFirestore(
      userId: userId,
      imageFile: imageFile,
    );
  }

  updateScannerPhoto({
    required String userId,
    required File imageFile,
  }) {
    _dataProvider.updateScannerPhotoInFirestore(
      userId: userId,
      imageFile: imageFile,
    );
  }

  updateName({
    required String name,
    required String vendorId,
  }) {
    _dataProvider.updateName(name: name, userId: vendorId);
  }

  Stream<VendorProfileModel> streamVendorProfileModel(
      {required String userId}) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> document =
        _dataProvider.getStreamUserDetailsFromFirestore(userId);
    return document.map((event) {
      VendorProfileModel pro = VendorProfileModel.fromDocument(event);
      return pro;
    });
  }
}
