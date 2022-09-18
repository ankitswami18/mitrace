import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mitrace/authorization/main%20app/api/email_api.dart';
import 'package:mitrace/authorization/main%20app/api/laptop_api_model.dart';
import 'package:mitrace/authorization/main%20app/api/pdf_api.dart';
import 'package:mitrace/authorization/main%20app/ui%20layer/shop%20ui/purchase%20section/vendor%20section/widgets/vendor_payment_option_widget.dart';
import 'package:provider/provider.dart';
import '../../../../business layer/shop bloc/collect payment details/payment_details_input_bloc.dart';
import '../../../../business layer/shop bloc/collect payment details/payment_details_input_bloc_model.dart';
import '../../laptop section/widgets/product_details_widget.dart';
import '../../shop_main_screen.dart';

class VendorPaymentScreen extends StatefulWidget {
  const VendorPaymentScreen({required this.model, Key? key}) : super(key: key);
  final LaptopApiModel model;

  // CREATE METHOD.
  static Widget create({required LaptopApiModel model}) {
    return Provider<PaymentDetailsInputBloc>(
      create: (context) => PaymentDetailsInputBloc(),
      dispose: (context, blocObject) => blocObject.dispose(),
      child: Consumer(
        // Consumer widget is used to create object of the class
        builder: (context, PaymentDetailsInputBloc blocObject, _) {
          return VendorPaymentScreen(
            model: model,
          );
        },
      ),
    );
  }

  @override
  State<VendorPaymentScreen> createState() => _VendorPaymentScreenState();
}

class _VendorPaymentScreenState extends State<VendorPaymentScreen> {
  Widget textBox({required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(title),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PaymentDetailsInputBloc blocObj =
        Provider.of<PaymentDetailsInputBloc>(context, listen: false);
    blocObj.updateWith(productId: widget.model.id);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Generate Bill'),
        ),
        body: StreamBuilder<PaymentDetailsInputBlocModel>(
          stream: blocObj.getModelStream,
          builder:
              (context, AsyncSnapshot<PaymentDetailsInputBlocModel> snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ProductDetailsWidget(model: widget.model),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (val) {
                        blocObj.updateWith(name: val);
                      },
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Customer Name',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        blocObj.updateWith(
                          number: int.parse(value),
                        );
                      },
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Customer Mobile Number',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        blocObj.updateWith(email: value);
                      },
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Customer Email ID',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  textBox(
                      title: 'Operator Id: ${vendorProfileModel!.operatorid}'),
                  VendorPaymentOptionWidget.create(
                    paymentDetailsInputBlocObj: blocObj,
                    laptopModelApi: widget.model,
                  ),
                  ElevatedButton(
                    onPressed: (snapshot.data != null &&
                            snapshot.data!.isEnabledSubmitButton())
                        ? () async {
                            blocObj.submit(
                              context: context,
                              vendorId: vendorProfileModel!.id,
                            );
                            Navigator.pop(context);
                            File file = await PdfApi.convertAndSavePdf(
                                [widget.model, snapshot.data]);
                            PdfApi.openFile(file);
                            EmailApi().sendBillViaEmail(
                              toId: snapshot.data!.email,
                              subject:
                                  'Congratulations for making ${widget.model.id} yours.',
                              toName: snapshot.data!.name,
                              moneyPaid: widget.model.price,
                              mrp: widget.model.mrp,
                              paymentMode: snapshot.data!.modeofpayment,
                              productDetails: widget.model.description,
                              productMoreDetails: widget.model.more,
                              productId: widget.model.id,
                            );
                          }
                        : null,
                    child: const Text('Mark Done'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
