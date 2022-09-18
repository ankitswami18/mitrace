import 'package:flutter/material.dart';
import 'package:mitrace/authorization/main%20app/api/laptop_api_model.dart';
import 'package:mitrace/authorization/main%20app/ui%20layer/shop%20ui/laptop%20section/widgets/product_details_widget.dart';

class ProductDetailsPaymentWidget extends StatefulWidget {
  const ProductDetailsPaymentWidget({required this.model, Key? key})
      : super(key: key);
  final LaptopApiModel model;

  @override
  State<ProductDetailsPaymentWidget> createState() =>
      _ProductDetailsPaymentWidgetState();
}

class _ProductDetailsPaymentWidgetState
    extends State<ProductDetailsPaymentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductDetailsWidget(model: widget.model),
        Card(
          color: const Color.fromARGB(255, 16, 85, 141),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${widget.model.more}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
