import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mitrace/authorization/main%20app/data%20layer/payment%20data%20layer/payment_details_repository.dart';
import 'package:provider/provider.dart';
import 'payment_details_input_bloc_model.dart';

class PaymentDetailsInputBloc {
  PaymentDetailsInputBloc();

  PaymentDetailsInputBlocModel _model = PaymentDetailsInputBlocModel();

  // STEP 1: CREATE THE STREAM-CONTROLLER
  final StreamController<PaymentDetailsInputBlocModel> _streamController =
      StreamController<PaymentDetailsInputBlocModel>();

  // Step 2: CLOSING THE STREAM-CONTROLLER
  dispose() {
    _streamController.close();
  }

  // Step 3: STREAM (GET THE VALUES FROM STREAM)
  Stream<PaymentDetailsInputBlocModel> get getModelStream =>
      _streamController.stream;

  // Step 4: ADDING VALUES TO THE STREAM
  void updateWith(
      {String? modeofpayment,
      String? name,
      String? email,
      String? productId,
      int? number}) {
    _model = _model.copyWith(
      name: name,
      email: email,
      modeofpayment: modeofpayment,
      number: number,
      productId: productId,
    );
    _streamController.sink.add(_model);
  }

  // BACKEND CODE:
  submit({required BuildContext context, required String vendorId}) {
    final repObj =
        Provider.of<PaymentDetailsRepository>(context, listen: false);
    repObj.submitUserDetails(
      email: _model.email,
      number: _model.number,
      name: _model.name,
      productId: _model.productId,
      modeofpayment: _model.modeofpayment,
      vendorId: vendorId,
    );
  }
}
