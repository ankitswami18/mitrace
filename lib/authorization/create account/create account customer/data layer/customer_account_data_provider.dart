import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mitrace/authorization/main%20app/data%20layer/refrences_objects.dart';

class CustomerAccountDataProvider {
  saveAccountDataToFirestore({
    required String userId,
    String? name,
    String? email,
    String? location,
    int? number,
  }) {
    customerProfileRef.doc(userId).update({
      'email': email,
      'id': userId,
      'name': name,
      'location': location,
      'timeStamp': DateTime.now(),
      'number': number,
    });
  }

  createCustomerInFirestore({required String userId}) {
    customerProfileRef.doc(userId).set({
      'id': userId,
    });
  }

  updateName({required String name, required String userId}) {
    customerProfileRef.doc(userId).update({
      'name': name,
    });
  }

  updateNumber({required int number, required String userId}) {
    customerProfileRef.doc(userId).update({
      'number': number,
    });
  }

  updateEmail({required String email, required String userId}) {
    customerProfileRef.doc(userId).update({
      'email': email,
    });
  }

  updateLocation({required String location, required String userId}) {
    customerProfileRef.doc(userId).update({
      'location': location,
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>
      getStreamUserDetailsFromFirestore(String userId) {
    Stream<DocumentSnapshot<Map<String, dynamic>>> docs =
        customerProfileRef.doc(userId).snapshots();
    return docs;
  }
}
