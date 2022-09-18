import 'package:flutter/material.dart';
import 'package:mitrace/authentication/auth.dart';
import 'package:mitrace/authorization/create%20account/create%20account%20customer/data%20layer/customer_profile_model.dart';
import 'package:mitrace/authorization/main%20app/api/laptop_api_model.dart';
import 'package:mitrace/authorization/main%20app/business%20layer/shop%20bloc/collect%20payment%20details/payment_details_input_bloc.dart';
import 'package:mitrace/authorization/main%20app/ui%20layer/shop%20ui/laptop%20section/widgets/product_details_widget.dart';
import 'package:mitrace/authorization/main%20app/ui%20layer/shop%20ui/purchase%20section/customer%20section/widgets/customer_payment_options_card.dart';
import 'package:provider/provider.dart';

import '../../../../../create account/create account customer/data layer/create_account_repository.dart';

class CustomerPaymentScreen extends StatefulWidget {
  const CustomerPaymentScreen({required this.productApiModel, Key? key})
      : super(key: key);
  final LaptopApiModel productApiModel;
  // CREATE METHOD.
  static Widget create({required LaptopApiModel productApiModel}) {
    return Provider<PaymentDetailsInputBloc>(
      create: (context) => PaymentDetailsInputBloc(),
      dispose: (context, blocObject) => blocObject.dispose(),
      child: Consumer(
        // Consumer widget is used to create object of the class
        builder: (context, PaymentDetailsInputBloc blocObject, _) {
          return CustomerPaymentScreen(
            productApiModel: productApiModel,
          );
        },
      ),
    );
  }

  @override
  State<CustomerPaymentScreen> createState() => _CustomerPaymentScreenState();
}

class _CustomerPaymentScreenState extends State<CustomerPaymentScreen> {
  late TextEditingController nameController;
  late TextEditingController numberController;
  late TextEditingController locationController;
  late TextEditingController emailontroller;

  Widget getNameField() {
    return TextField(
      controller: nameController,
      decoration: InputDecoration(
        labelText: 'Name',
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        hintText: 'Enter Your Name',
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey.shade900),
        ),
      ),
      onChanged: (val) {
        // widget.blocObject.updateWith(name: val);
      },
    );
  }

  Widget getLocationField() {
    return TextField(
      controller: locationController,
      decoration: InputDecoration(
        labelText: 'Location',
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        hintText: 'Enter Your location',
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey.shade900),
        ),
      ),
      maxLines: 3,
      onChanged: (val) {
        // widget.blocObject.updateWith(location: val);
      },
    );
  }

  Widget getMobileNumberField() {
    return TextField(
      controller: numberController,
      decoration: InputDecoration(
        labelText: 'Mobile Number',
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        hintText: 'Enter Your Number',
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey.shade900),
        ),
      ),
      onChanged: (val) {
        // widget.blocObject.updateWith(number: int.parse(val));
      },
    );
  }

  Widget getEmailField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Email Id',
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        hintText: 'Enter Your mail id',
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey.shade900),
        ),
      ),
      onChanged: (val) {
        // widget.blocObject.updateWith(email: val);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final repObj =
        Provider.of<CustomerAccountRepository>(context, listen: false);
    FirebaseAuthApi authProvider =
        Provider.of<FirebaseAuthApi>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<CustomerProfileModel>(
            stream: repObj.streamCustomerProfileModel(
                userId: authProvider.currentUser() as String),
            builder: (context, customerProfileMdlSnapshot) {
              if (customerProfileMdlSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              CustomerProfileModel cpmObj = customerProfileMdlSnapshot.data!;
              nameController = TextEditingController(text: cpmObj.name);
              numberController =
                  TextEditingController(text: cpmObj.number.toString());
              locationController = TextEditingController(text: cpmObj.location);
              emailontroller = TextEditingController(text: cpmObj.email);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ProductDetailsWidget(
                      model: widget.productApiModel,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          getNameField(),
                          const SizedBox(height: 16),
                          getEmailField(),
                          const SizedBox(height: 16),
                          getMobileNumberField(),
                          const SizedBox(height: 16),
                          getLocationField(),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    const CustomerPaymentCard(),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
