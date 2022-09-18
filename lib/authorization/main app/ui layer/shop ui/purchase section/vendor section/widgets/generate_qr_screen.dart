import 'package:flutter/material.dart';
import 'package:mitrace/authorization/main%20app/api/laptop_api_model.dart';
import 'package:upi_payment_qrcode_generator/upi_payment_qrcode_generator.dart';

class GenerateQR extends StatelessWidget {
  const GenerateQR({required this.laptopModelApi, Key? key}) : super(key: key);
  final LaptopApiModel laptopModelApi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SCAN Q.R. TO PAY'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UPIPaymentQRCode(
            upiDetails: UPIDetails(
              upiID: "7036990126@axisbank",
              payeeName: "MI-TRACE",
              amount: laptopModelApi.price,
              transactionNote: laptopModelApi.id,
            ),
            size: 300,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Scan QR to Pay",
                style: TextStyle(
                  color: Colors.grey[600],
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Done'),
            ),
          ),
        ],
      ),
    );
  }
}
