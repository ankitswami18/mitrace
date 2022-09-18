import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mitrace/authorization/create%20account/create%20account%20vendor/data%20layer/vendor_account_repository.dart';
import 'package:provider/provider.dart';
import 'create_account_vendor_bloc_model.dart';

class CreateAccountVendorBloc {
  CreateAccountVendorBloc();

  CreateAccountVendorBlocModel _model = CreateAccountVendorBlocModel();

  // STEP 1: CREATE THE STREAM-CONTROLLER
  final StreamController<CreateAccountVendorBlocModel> _streamController =
      StreamController<CreateAccountVendorBlocModel>();

  // Step 2: CLOSING THE STREAM-CONTROLLER
  dispose() {
    _streamController.close();
  }

  // Step 3: STREAM (GET THE VALUES FROM STREAM)
  Stream<CreateAccountVendorBlocModel> get getModelStream =>
      _streamController.stream;

  // Step 4: ADDING VALUES TO THE STREAM
  void updateWith({
    String? name,
    String? operatorid,
    bool? isLoading,
  }) {
    _model = _model.copyWith(
      name: name,
      operatorid: operatorid,
      isLoading: isLoading,
    );
    _streamController.sink.add(_model);
  }

  // BACKEND CODE:
  submit({required BuildContext context, required String userId}) {
    final repObj = Provider.of<VendorAccountRepository>(context, listen: false);
    repObj.submitUserDetails(
      id: userId,
      name: _model.name,
      operatorid: _model.operatorid,
    );
  }
}
