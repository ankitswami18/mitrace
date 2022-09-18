class PaymentDetailsInputBlocModel {
  PaymentDetailsInputBlocModel({
    this.name = '',
    this.email = '',
    this.modeofpayment = '',
    this.number = 0,
    this.productId = '',
  });
  final String name;
  final int number;
  final String email;
  final String modeofpayment;
  final String productId;

  PaymentDetailsInputBlocModel copyWith({
    String? name,
    String? email,
    String? modeofpayment,
    int? number,
    String? productId,
  }) {
    return PaymentDetailsInputBlocModel(
      name: name ?? this.name,
      email: email ?? this.email,
      modeofpayment: modeofpayment ?? this.modeofpayment,
      number: number ?? this.number,
      productId: productId ?? this.productId,
    );
  }

  // BUSINESS LOGIC:

  bool isEnabledSubmitButton() {
    bool isTrue = name.isNotEmpty &&
        email.isNotEmpty &&
        number != 0 &&
        modeofpayment.isNotEmpty &&
        productId.isNotEmpty;
    // print(name.isNotEmpty);
    // print(email.isNotEmpty);
    // print(number);
    // print(modeofpayment.isNotEmpty);
    if (isTrue) {
      return true;
    } else {
      return false;
    }
  }
}
