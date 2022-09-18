import 'package:flutter/material.dart';
import 'package:mitrace/authentication/ui/auth_initial_screen.dart';
import 'package:mitrace/authorization/create%20account/create%20account%20customer/data%20layer/customer_profile_model.dart';
import 'package:mitrace/authorization/create%20account/create%20account%20customer/ui%20layer/create_customer_profile.dart';
import 'package:mitrace/authorization/create%20account/create%20account%20vendor/data%20layer/vendor_profile_model.dart';
import 'package:mitrace/authorization/main%20app/ui%20layer/profile%20ui/vendor_profile_screen.dart';
import 'package:mitrace/authorization/main%20app/ui%20layer/shop%20ui/widgets/category.dart';
import 'package:mitrace/authorization/main%20app/ui%20layer/shop%20ui/widgets/current_location_widget.dart';
import 'package:provider/provider.dart';
import '../../business layer/shop bloc/select location bloc/location_bloc.dart';
import 'laptop section/laptops_screen.dart';
import 'widgets/location_options.dart';

late VendorProfileModel? vendorProfileModel;
late CustomerProfileModel? customerProfileModel;
late AuthType authType;

class ShopMainScreen extends StatefulWidget {
  const ShopMainScreen(
      {this.vendorMdl, this.customerMdl, required this.blocObject, Key? key})
      : super(key: key);
  final VendorProfileModel? vendorMdl;
  final CustomerProfileModel? customerMdl;
  final LocationBloc blocObject;

  // CREATE METHOD.
  static Widget create(
      {VendorProfileModel? venderMdl, CustomerProfileModel? customerMdl}) {
    return Provider<LocationBloc>(
      create: (context) => LocationBloc(),
      dispose: (context, blocObject) => blocObject.dispose(),
      child: Consumer(
        // Consumer widget is used to create object of the class
        builder: (context, LocationBloc blocObject, _) {
          return ShopMainScreen(
            vendorMdl: venderMdl,
            customerMdl: customerMdl,
            blocObject: blocObject,
          );
        },
      ),
    );
  }

  @override
  State<ShopMainScreen> createState() => _ShopMainScreenState();
}

class _ShopMainScreenState extends State<ShopMainScreen> {
  @override
  void initState() {
    if (widget.vendorMdl != null) {
      vendorProfileModel = widget.vendorMdl!;
      authType = AuthType.vendor;
    } else if (widget.customerMdl != null) {
      customerProfileModel = widget.customerMdl!;
      authType = AuthType.customer;
    } else {
      authType = AuthType.none;
    }
    super.initState();
  }

  Widget profileHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 6, 34, 56),
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const LocationOptions(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: const [
                    Text(
                      'WELCOME TO',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'THE XIAOMI WORLD',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.add_shopping_cart_sharp,
                  color: Colors.white,
                ),
              ),
              if (widget.vendorMdl != null)
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VendorProfileScreen(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundImage: vendorProfileModel!.profilePhoto == null
                        ? null
                        : NetworkImage(
                            vendorProfileModel!.profilePhoto as String),
                    backgroundColor: const Color.fromARGB(255, 4, 52, 92),
                    radius: 21,
                  ),
                ),
              if ((widget.customerMdl != null))
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CreateCustomerProfileScreen.create(),
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 4, 52, 92),
                    radius: 21,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 9, 70, 119),
        body: Column(
          children: [
            const CurrentLocationWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    profileHeader(),
                    // const VenderHeader(),
                    Category(
                      networkImage:
                          'https://www.91-cdn.com/hub/wp-content/uploads/2022/07/Top-laptop-brands-in-India.jpg',
                      categoryName: 'Laptops',
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LaptopsScreen(),
                          ),
                        );
                      },
                    ),
                    Category(
                      networkImage:
                          'https://cdn.mos.cms.futurecdn.net/ZpQSZtJ7XcfhFMLiiRd3rj-1200-80.jpg',
                      categoryName: 'Mobiles',
                      onPress: () {},
                    ),
                    Category(
                      networkImage:
                          'https://www.gizmochina.com/wp-content/uploads/2021/05/Xiaomi-Mi-TV-P1-Series-Featured.jpg',
                      categoryName: 'T.V.',
                      onPress: () {},
                    ),
                    Category(
                      networkImage:
                          'https://i01.appmifile.com/webfile/globalimg/7/9412A361-4F8F-2C44-C1CD-9BB6D117E39A.jpeg',
                      categoryName: 'CCTV',
                      onPress: () {},
                    ),
                    Category(
                      networkImage:
                          'https://www.notebookcheck.net/fileadmin/Notebooks/News/_nc3/M_Mix_3_Mi_Pad_4_Plus_Xiaomi_drd.jpg',
                      categoryName: 'Tablets',
                      onPress: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
