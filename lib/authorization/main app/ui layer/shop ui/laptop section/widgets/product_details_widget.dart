import 'package:flutter/material.dart';
import 'package:mitrace/authorization/main%20app/api/laptop_api_model.dart';

class ProductDetailsWidget extends StatefulWidget {
  const ProductDetailsWidget({required this.model, Key? key}) : super(key: key);
  final LaptopApiModel model;

  @override
  State<ProductDetailsWidget> createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 16, 85, 141),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                widget.model.id,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(
                'Model: ${widget.model.description}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Rating: ${widget.model.rating}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'This item costs ',
                children: <TextSpan>[
                  TextSpan(
                    text: 'M.R.P. ${widget.model.mrp}/-',
                    style: const TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  TextSpan(
                    text: '${widget.model.price}/-',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
