import 'package:flutter/material.dart';
import 'package:mitrace/authorization/main%20app/api/laptop_api_model.dart';
import 'package:mitrace/authorization/main%20app/business%20layer/shop%20bloc/collect%20payment%20details/payment_details_input_bloc.dart';
import 'package:mitrace/authorization/main%20app/business%20layer/shop%20bloc/select%20payment%20method%20bloc/payment_method_bloc.dart';
import 'package:mitrace/authorization/main%20app/ui%20layer/shop%20ui/purchase%20section/vendor%20section/widgets/generate_qr_screen.dart';
import 'package:provider/provider.dart';

class VendorPaymentOptionWidget extends StatefulWidget {
  const VendorPaymentOptionWidget(
      {required this.paymentDetailsInputBlocObj,
      required this.laptopModelApi,
      Key? key})
      : super(key: key);
  final PaymentDetailsInputBloc paymentDetailsInputBlocObj;
  final LaptopApiModel laptopModelApi;
  // CREATE METHOD.
  static Widget create({
    required PaymentDetailsInputBloc paymentDetailsInputBlocObj,
    required LaptopApiModel laptopModelApi,
  }) {
    return Provider<PaymentMethodBloc>(
      create: (context) => PaymentMethodBloc(),
      dispose: (context, blocObject) => blocObject.dispose(),
      child: Consumer(
        // Consumer widget is used to create object of the class
        builder: (context, PaymentMethodBloc blocObject, _) {
          return VendorPaymentOptionWidget(
            paymentDetailsInputBlocObj: paymentDetailsInputBlocObj,
            laptopModelApi: laptopModelApi,
          );
        },
      ),
    );
  }

  @override
  State<VendorPaymentOptionWidget> createState() =>
      _VendorPaymentOptionWidgetState();
}

class _VendorPaymentOptionWidgetState extends State<VendorPaymentOptionWidget> {
  Widget paymentContainer({
    required String paymentText,
    required IconButton iconButton,
    required Color colour,
  }) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(0.5),
          decoration: BoxDecoration(
            border: Border.all(color: colour),
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          child: Card(child: iconButton),
        ),
        Text(paymentText),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    PaymentMethodBloc blocObj = Provider.of<PaymentMethodBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Mode of payment'),
            ),
            const Divider(thickness: 0.9, color: Colors.black),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<int>(
                stream: blocObj.streamBlocModel,
                initialData: 0,
                builder: (context, AsyncSnapshot<int> snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      paymentContainer(
                        paymentText: 'Cash',
                        iconButton: IconButton(
                          onPressed: () {
                            blocObj.updateWith(optionNumber: 1);
                            widget.paymentDetailsInputBlocObj
                                .updateWith(modeofpayment: 'Cash');
                          },
                          icon: const Icon(Icons.money),
                        ),
                        colour: snapshot.data == 1
                            ? Colors.blueAccent
                            : Colors.transparent,
                      ),
                      paymentContainer(
                        paymentText: 'Scan',
                        iconButton: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GenerateQR(
                                    laptopModelApi: widget.laptopModelApi),
                              ),
                            );
                            blocObj.updateWith(optionNumber: 2);
                            widget.paymentDetailsInputBlocObj
                                .updateWith(modeofpayment: 'Scan/UPI');
                          },
                          icon: const Icon(Icons.qr_code_2),
                        ),
                        colour: snapshot.data == 2
                            ? Colors.blueAccent
                            : Colors.transparent,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
