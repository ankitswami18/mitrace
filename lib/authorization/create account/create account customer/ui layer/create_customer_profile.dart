import 'package:flutter/material.dart';
import 'package:mitrace/authentication/auth.dart';
import 'package:mitrace/authorization/create%20account/create%20account%20customer/data%20layer/create_account_repository.dart';
import 'package:provider/provider.dart';
import '../business layer/create_account_bloc.dart';
import '../business layer/create_customer_account_bloc_model.dart';
import '../data layer/customer_profile_model.dart';

class CreateCustomerProfileScreen extends StatefulWidget {
  const CreateCustomerProfileScreen({required this.blocObject, Key? key})
      : super(key: key);
  final CreateCustomerAccountBloc blocObject;

  // CREATE METHOD.
  static Widget create() {
    return Provider<CreateCustomerAccountBloc>(
      create: (context) => CreateCustomerAccountBloc(),
      dispose: (context, blocObject) => blocObject.dispose(),
      child: Consumer(
        // Consumer widget is used to create object of the class
        builder: (context, CreateCustomerAccountBloc blocObject, _) {
          return CreateCustomerProfileScreen(
            blocObject: blocObject,
          );
        },
      ),
    );
  }

  @override
  State<CreateCustomerProfileScreen> createState() =>
      _CreateCustomerProfileScreenState();
}

class _CreateCustomerProfileScreenState
    extends State<CreateCustomerProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController numberController;
  late TextEditingController locationController;
  late TextEditingController emailontroller;

  logoutPopup(BuildContext parentContext) {
    final auth = Provider.of<FirebaseAuthApi>(context, listen: false);
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              child: const Text("Logout"),
              onPressed: () {
                auth.signOut();
                Navigator.of(context).pop(true);
                Navigator.pop(parentContext);
              },
            ),
            SimpleDialogOption(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        );
      },
    );
  }

  getLabels() {}

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
        widget.blocObject.updateWith(name: val);
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
        widget.blocObject.updateWith(location: val);
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
        widget.blocObject.updateWith(number: int.parse(val));
      },
    );
  }

  Widget getEmailField() {
    return TextField(
      controller: emailontroller,
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
        widget.blocObject.updateWith(email: val);
      },
    );
  }

  Widget submitButton(CreateCustomerAccountBlocModel? createAccountBlocModel) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      ),
      onPressed: () {
        FirebaseAuthApi authProvider =
            Provider.of<FirebaseAuthApi>(context, listen: false);
        widget.blocObject.submit(
          context: context,
          userId: authProvider.currentUser() as String,
        );
      },
      child: const Text('SUBMIT'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final repObj =
        Provider.of<CustomerAccountRepository>(context, listen: false);
    FirebaseAuthApi authProvider =
        Provider.of<FirebaseAuthApi>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<CustomerProfileModel>(
          stream: repObj.streamCustomerProfileModel(
              userId: authProvider.currentUser() as String),
          builder: ((context,
              AsyncSnapshot<CustomerProfileModel> customerProfileMdlSnapshot) {
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
            return StreamBuilder<CreateCustomerAccountBlocModel>(
              stream: widget.blocObject.getModelStream,
              initialData: CreateCustomerAccountBlocModel(),
              builder: (context,
                  AsyncSnapshot<CreateCustomerAccountBlocModel> snapshot) {
                final createAccountModel = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  logoutPopup(context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Icon(Icons.exit_to_app),
                                    Padding(
                                      padding: EdgeInsets.all(18.0),
                                      child: Text(
                                        'Logout',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Icon(Icons.keyboard_arrow_right),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      getNameField(),
                      const SizedBox(height: 16),
                      getEmailField(),
                      const SizedBox(height: 16),
                      getMobileNumberField(),
                      const SizedBox(height: 16),
                      getLocationField(),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: submitButton(createAccountModel),
                      )
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
