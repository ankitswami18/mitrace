import 'package:flutter/material.dart';
import 'package:mitrace/authentication/auth.dart';
import 'package:mitrace/authorization/create%20account/create%20account%20vendor/data%20layer/vendor_account_repository.dart';
import 'package:mitrace/authorization/main%20app/ui%20layer/shop%20ui/shop_main_screen.dart';
import 'package:provider/provider.dart';
import '../camera section/pick_image_crop_upload.dart';

class VendorProfileScreen extends StatefulWidget {
  const VendorProfileScreen({Key? key}) : super(key: key);

  @override
  State<VendorProfileScreen> createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  TextEditingController nameContrller =
      TextEditingController(text: vendorProfileModel!.name);
  TextEditingController miidContrller =
      TextEditingController(text: vendorProfileModel!.id);
  TextEditingController operatorIdContrller =
      TextEditingController(text: vendorProfileModel!.operatorid);

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

  Widget displayQrCode() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: vendorProfileModel!.qrcodePhoto != null
            ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.network(vendorProfileModel!.qrcodePhoto as String),
              )
            : const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Upload Your Q.R. CODE here.'),
              ),
      ),
    );
  }

  Widget textBox({required String title}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(title),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.camera_alt_rounded,
            ),
            onPressed: () {
              PickImageCropUpload.chooseImagePopup(
                context: context,
                imageFor: ImageFor.scanner,
                uploadImageCallback: (croppedImage, imageId) {
                  final accountRepObj = Provider.of<VendorAccountRepository>(
                    context,
                    listen: false,
                  );
                  accountRepObj.updateScannerPhoto(
                    userId: vendorProfileModel!.id,
                    imageFile: croppedImage,
                  );
                },
              );
            },
          )
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8),
              child: Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[350],
                      child: CircleAvatar(
                        backgroundImage:
                            vendorProfileModel!.profilePhoto == null
                                ? null
                                : NetworkImage(
                                    vendorProfileModel!.profilePhoto as String,
                                  ),
                        backgroundColor: Colors.yellow,
                        radius: 50,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.photo_camera),
                      onPressed: () {
                        PickImageCropUpload.chooseImagePopup(
                          context: context,
                          imageFor: ImageFor.profileImage,
                          uploadImageCallback: (croppedImage, imageId) {
                            final accountRepObj =
                                Provider.of<VendorAccountRepository>(context,
                                    listen: false);
                            accountRepObj.updateProfilePhoto(
                              userId: vendorProfileModel!.id,
                              imageFile: croppedImage,
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: nameContrller,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Vendor Name',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.done,
                              ),
                              onPressed: () {
                                VendorAccountRepository repObj =
                                    Provider.of<VendorAccountRepository>(
                                        context,
                                        listen: false);
                                repObj.updateName(
                                  name: nameContrller.text,
                                  vendorId: vendorProfileModel!.id,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      textBox(
                          title:
                              'Operator Id: ${vendorProfileModel!.operatorid as String}'),
                      textBox(title: 'MI ID: ${vendorProfileModel!.id}'),
                    ],
                  ),
                ),
              ),
            ),
            displayQrCode(),
          ],
        ),
      ),
    );
  }
}
