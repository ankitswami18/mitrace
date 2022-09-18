class CreateAccountVendorBlocModel {
  CreateAccountVendorBlocModel({
    this.name = '',
    this.isLoading = false,
    this.operatorid = '',
  });
  final String name;
  final bool isLoading;
  final String operatorid;

  CreateAccountVendorBlocModel copyWith({
    String? name,
    bool? isLoading,
    String? operatorid,
  }) {
    return CreateAccountVendorBlocModel(
      name: name ?? this.name,
      isLoading: isLoading ?? this.isLoading,
      operatorid: operatorid ?? this.operatorid,
    );
  }

  // BUSINESS LOGIC:

  bool isEnabledSubmitButton() {
    bool isTrue = name.isNotEmpty && operatorid.isNotEmpty;
    if (isTrue) {
      return true;
    } else {
      return false;
    }
  }
}
