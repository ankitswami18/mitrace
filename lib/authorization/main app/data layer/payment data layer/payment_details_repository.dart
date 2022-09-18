import 'payment_details_firebase_data_provider.dart';

class PaymentDetailsRepository {
  final PaymentDetailsFirebaseDataProvider _dataProvider =
      PaymentDetailsFirebaseDataProvider();
  submitUserDetails({
    required String productId,
    required String name,
    required String email,
    required int number,
    required String modeofpayment,
    required String vendorId,
  }) {
    _dataProvider.saveAccountDataToFirestore(
      name: name,
      email: email,
      modeofpayment: modeofpayment,
      number: number,
      productId: productId,
      vendorId: vendorId,
    );
  }
}
