import 'package:flutter/material.dart';
import 'package:mitrace/authentication/auth.dart';
import 'package:provider/provider.dart';
import '../business layer/create_account_vendor_bloc.dart';
import '../business layer/create_account_vendor_bloc_model.dart';

class CreateVendorProfileScreen extends StatefulWidget {
  const CreateVendorProfileScreen({required this.blocObject, Key? key})
      : super(key: key);
  final CreateAccountVendorBloc blocObject;

  // CREATE METHOD.
  static Widget create() {
    return Provider<CreateAccountVendorBloc>(
      create: (context) => CreateAccountVendorBloc(),
      dispose: (context, blocObject) => blocObject.dispose(),
      child: Consumer(
        // Consumer widget is used to create object of the class
        builder: (context, CreateAccountVendorBloc blocObject, _) {
          return CreateVendorProfileScreen(
            blocObject: blocObject,
          );
        },
      ),
    );
  }

  @override
  State<CreateVendorProfileScreen> createState() =>
      _CreateVendorProfileScreenState();
}

class _CreateVendorProfileScreenState extends State<CreateVendorProfileScreen> {
  Widget getNameField() {
    return TextField(
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

  Widget getOperatorIdField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Operator ID',
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        hintText: 'Enter the Operator ID.',
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.grey.shade900),
        ),
      ),
      onChanged: (val) {
        widget.blocObject.updateWith(operatorid: val);
      },
    );
  }

  Widget submitButton(CreateAccountVendorBlocModel? createAccountBlocModel) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: ((createAccountBlocModel != null) &&
                createAccountBlocModel.operatorid.isNotEmpty &&
                createAccountBlocModel.name.isNotEmpty)
            ? MaterialStateProperty.all<Color>(Colors.blue)
            : MaterialStateProperty.all<Color>(Colors.grey),
      ),
      onPressed: () async {
        if ((createAccountBlocModel != null) &&
            createAccountBlocModel.operatorid.isNotEmpty &&
            createAccountBlocModel.name.isNotEmpty) {
          FirebaseAuthApi authProvider =
              Provider.of<FirebaseAuthApi>(context, listen: false);
          widget.blocObject.submit(
            context: context,
            userId: authProvider.currentUser() as String,
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return const SimpleDialog(
                children: <Widget>[
                  SimpleDialogOption(
                    child: Text("some data is missing."),
                  )
                ],
              );
            },
          );
        }
      },
      child: const Text('SUBMIT'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<CreateAccountVendorBlocModel>(
          stream: widget.blocObject.getModelStream,
          initialData: CreateAccountVendorBlocModel(),
          builder:
              (context, AsyncSnapshot<CreateAccountVendorBlocModel> snapshot) {
            final createAccountModel = snapshot.data!;
            return Column(
              children: [
                const SizedBox(height: 16),
                getNameField(),
                const SizedBox(height: 16),
                getOperatorIdField(),
                const SizedBox(height: 16),
                const Text(
                  'Other Data Of Vender will be collected here...',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: submitButton(createAccountModel),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
