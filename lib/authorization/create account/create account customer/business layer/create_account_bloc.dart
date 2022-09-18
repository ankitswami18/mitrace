import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mitrace/authorization/create%20account/create%20account%20customer/business%20layer/create_customer_account_bloc_model.dart';
import 'package:provider/provider.dart';
import '../data layer/create_account_repository.dart';

class CreateCustomerAccountBloc {
  CreateCustomerAccountBloc();

  CreateCustomerAccountBlocModel _model = CreateCustomerAccountBlocModel();

  // STEP 1: CREATE THE STREAM-CONTROLLER
  final StreamController<CreateCustomerAccountBlocModel> _streamController =
      StreamController<CreateCustomerAccountBlocModel>();

  // Step 2: CLOSING THE STREAM-CONTROLLER
  dispose() {
    _streamController.close();
  }

  // Step 3: STREAM (GET THE VALUES FROM STREAM)
  Stream<CreateCustomerAccountBlocModel> get getModelStream =>
      _streamController.stream;

  // Step 4: ADDING VALUES TO THE STREAM
  void updateWith({
    String? name,
    int? number,
    String? email,
    String? location,
  }) {
    _model = _model.copyWith(
      name: name,
      number: number,
      email: email,
      location: location,
    );
    _streamController.sink.add(_model);
  }

  // BACKEND CODE:
  submit({required BuildContext context, required String userId}) {
    final repObj =
        Provider.of<CustomerAccountRepository>(context, listen: false);
    repObj.submitUserDetails(
      id: userId,
      email: _model.email,
      location: _model.location,
      name: _model.name,
      number: _model.number,
    );
  }
}
