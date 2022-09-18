class CreateCustomerAccountBlocModel {
  CreateCustomerAccountBlocModel({
    this.name = '',
    this.email = '',
    this.id = '',
    this.location = '',
    this.number = 0,
  });
  final String? name;
  final String? email;
  final String? id;
  final int? number;
  final String? location;

  CreateCustomerAccountBlocModel copyWith({
    String? name,
    String? email,
    String? id,
    int? number,
    String? location,
  }) {
    return CreateCustomerAccountBlocModel(
      name: name ?? this.name,
      id: id ?? this.id,
      email: email ?? this.email,
      location: location ?? this.location,
      number: number ?? this.number,
    );
  }
}
