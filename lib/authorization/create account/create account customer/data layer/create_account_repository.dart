import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mitrace/authorization/create%20account/create%20account%20customer/data%20layer/customer_account_data_provider.dart';

import 'customer_profile_model.dart';

class CustomerAccountRepository {
  final CustomerAccountDataProvider _dataProvider =
      CustomerAccountDataProvider();
  submitUserDetails({
    required String id,
    String? name,
    String? email,
    String? location,
    int? number,
  }) {
    _dataProvider.saveAccountDataToFirestore(
      userId: id,
      name: name,
      email: email,
      location: location,
      number: number,
    );
  }

  createCustomer({required String id}) {
    _dataProvider.createCustomerInFirestore(
      userId: id,
    );
  }

  updateName({
    required String name,
    required String customerId,
  }) {
    _dataProvider.updateName(name: name, userId: customerId);
  }

  updateNumber({
    required int number,
    required String customerId,
  }) {
    _dataProvider.updateNumber(number: number, userId: customerId);
  }

  updateLocation({
    required String location,
    required String customerId,
  }) {
    _dataProvider.updateLocation(location: location, userId: customerId);
  }

  updateEmail({
    required String email,
    required String customerId,
  }) {
    _dataProvider.updateEmail(
      email: email,
      userId: customerId,
    );
  }

  Stream<CustomerProfileModel> streamCustomerProfileModel(
      {required String userId}) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> document =
        _dataProvider.getStreamUserDetailsFromFirestore(userId);
    return document.map((event) {
      CustomerProfileModel pro = CustomerProfileModel.fromDocument(event);
      return pro;
    });
  }
}
