import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mitrace/authentication/ui/auth_initial_screen.dart';
import 'package:mitrace/authorization/main%20app/api/laptop_api_model.dart';
import 'package:mitrace/authorization/main%20app/ui%20layer/shop%20ui/laptop%20section/widgets/product_details_widget.dart';
import 'package:mitrace/authorization/main%20app/ui%20layer/shop%20ui/purchase%20section/customer%20section/customer_payment_screen.dart';
import 'package:mitrace/authorization/main%20app/ui%20layer/shop%20ui/purchase%20section/vendor%20section/vendor_payment_screen.dart';
import 'package:mitrace/authorization/main%20app/ui%20layer/shop%20ui/shop_main_screen.dart';

class LaptopScreen extends StatefulWidget {
  const LaptopScreen({required this.model, Key? key}) : super(key: key);
  final LaptopApiModel model;
  @override
  State<LaptopScreen> createState() => _LaptopScreenState();
}

class _LaptopScreenState extends State<LaptopScreen> {
  Widget getSlidingImages() {
    return CarouselSlider.builder(
      itemCount: widget.model.images!.length,
      itemBuilder: ((context, index, realIndex) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 6, 34, 56),
              border: Border.all(),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.network(widget.model.images![index]),
            ),
          ),
        );
      }),
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
      ),
    );
  }

  Widget addToCart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('Add To Cart'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buyIt() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                if (authType == AuthType.vendor) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VendorPaymentScreen.create(
                        model: widget.model,
                      ),
                    ),
                  );
                } else if (authType == AuthType.customer) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerPaymentScreen.create(
                        productApiModel: widget.model,
                      ),
                    ),
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('Get It Now'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 9, 70, 119),
        body: SingleChildScrollView(
          child: Column(
            children: [
              getSlidingImages(),
              ProductDetailsWidget(model: widget.model),
              if (authType != AuthType.none) addToCart(),
              if (authType != AuthType.none) buyIt(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'More About this item: ${widget.model.more}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
