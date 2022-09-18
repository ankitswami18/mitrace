import 'package:mitrace/authorization/main%20app/data%20layer/refrences_objects.dart';
import 'package:uuid/uuid.dart';

class PaymentDetailsFirebaseDataProvider {
  saveAccountDataToFirestore({
    required String productId,
    required String name,
    required String email,
    required int number,
    required String modeofpayment,
    required String vendorId,
  }) {
    var uuid = const Uuid();
    paymentRef
        .doc(vendorId)
        .collection('ProductsSoldByVendor')
        .doc(uuid.v1())
        .set({
      'productId': productId,
      'name': name,
      'email': email,
      'number': number,
      'modeofpayment': modeofpayment,
      'timeStamp': DateTime.now(),
    });
  }
}
