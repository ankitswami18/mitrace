import 'package:flutter/material.dart';

class CustomerPaymentCard extends StatefulWidget {
  const CustomerPaymentCard({Key? key}) : super(key: key);

  @override
  State<CustomerPaymentCard> createState() => _CustomerPaymentCardState();
}

class _CustomerPaymentCardState extends State<CustomerPaymentCard> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Text('Payment Options will be displayed here'),
      ),
    );
  }
}
