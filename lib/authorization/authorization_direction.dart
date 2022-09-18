import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mitrace/authentication/auth.dart';
import 'package:mitrace/authentication/ui/auth_initial_screen.dart';
import 'package:mitrace/authorization/create%20account/create%20account%20customer/data%20layer/create_account_repository.dart';
import 'package:mitrace/authorization/create%20account/create%20account%20customer/ui%20layer/create_customer_profile.dart';
import 'package:mitrace/authorization/create%20account/create%20account%20vendor/data%20layer/vendor_account_repository.dart';
import 'package:mitrace/authorization/create%20account/create%20account%20vendor/ui%20layer/create_vendor_profile_screen.dart';
import 'package:provider/provider.dart';
import 'create account/create account customer/data layer/customer_profile_model.dart';
import 'create account/create account vendor/data layer/vendor_profile_model.dart';
import 'main app/data layer/refrences_objects.dart';
import 'main app/ui layer/shop ui/shop_main_screen.dart';

class AuthorisationDirection extends StatelessWidget {
  const AuthorisationDirection({Key? key}) : super(key: key);

  bool checkIfAccountCreated(VendorProfileModel proMdl) {
    bool isAllFieldsPresent = proMdl.name != null && proMdl.operatorid != null;
    return isAllFieldsPresent;
  }

  bool checkIfCustomerAccountCreated(CustomerProfileModel mdl) {
    bool isAFieldsPresent = mdl.email != null ||
        mdl.number != null ||
        mdl.name != null ||
        mdl.location != null;
    return isAFieldsPresent;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: userTypeRef.doc(FirebaseAuthApi().currentUser() as String).get(),
      builder: ((context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
              authTypeSnapshot) {
        if (authTypeSnapshot.connectionState == ConnectionState.done) {
          Future.delayed(const Duration(seconds: 3));
          AuthType authType =
              authTypeSnapshot.data!.data()!['type'] == 'customer'
                  ? AuthType.customer
                  : AuthType.vendor;

          if (authType == AuthType.vendor) {
            final vendorProfileRepObj =
                Provider.of<VendorAccountRepository>(context, listen: false);
            return StreamBuilder<VendorProfileModel?>(
              stream: vendorProfileRepObj.streamVendorProfileModel(
                userId: FirebaseAuthApi().currentUser() as String,
              ),
              builder: (BuildContext context,
                  AsyncSnapshot<VendorProfileModel?> snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data != null || snapshot.hasData) {
                    VendorProfileModel? proMdl = snapshot.data!;
                    bool x = checkIfAccountCreated(proMdl);
                    if (x) {
                      return ShopMainScreen.create(venderMdl: proMdl);
                    }
                  }
                  return CreateVendorProfileScreen.create();
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          }
          final customerProfileRepObj =
              Provider.of<CustomerAccountRepository>(context, listen: false);
          return StreamBuilder<CustomerProfileModel?>(
            stream: customerProfileRepObj.streamCustomerProfileModel(
              userId: FirebaseAuthApi().currentUser() as String,
            ),
            builder: (BuildContext context,
                AsyncSnapshot<CustomerProfileModel?> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.data != null || snapshot.hasData) {
                  CustomerProfileModel? proMdl = snapshot.data!;
                  bool x = checkIfCustomerAccountCreated(proMdl);
                  if (x) {
                    return ShopMainScreen.create(customerMdl: proMdl);
                  }
                }
                return CreateCustomerProfileScreen.create();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        }

        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }),
    );
  }
}
