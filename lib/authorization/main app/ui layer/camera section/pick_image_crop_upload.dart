import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mitrace/authorization/main%20app/api/camera_api.dart';
import 'package:mitrace/authorization/main%20app/api/image_cropper_api.dart';
import '../shop ui/shop_main_screen.dart';

enum ImageFor {
  scanner,
  profileImage,
  none,
}

class PickImageCropUpload {
  // ignore: body_might_complete_normally_nullable
  static Future<List?> imageProcessing(
    String chooseFrom,
    BuildContext context,
    ImageFor imageFor,
    Function uploadImageCallback,
  ) async {
    late File? croppedFile;
    late Map<String, dynamic>? camApiMap;
    // PICK IMAGE FROM GALLERY/CAMERA.
    if (chooseFrom == 'Gallery') {
      camApiMap = await CameraApi().handleChooseFromGallery();
    } else {
      camApiMap = await CameraApi().handleTakePhoto();
    }
    // CROP THE IMAGE
    if (camApiMap['compressedImageFile'] != null) {
      croppedFile = await ImageCropperApi().cropSquareImage(
        imageFile: camApiMap['compressedImageFile'],
        context: context,
      );
    }
    // RETURN THE CROPPED IMAGE
    if (croppedFile != null && camApiMap['imageId'] != null) {
      if (imageFor == ImageFor.scanner) {
        uploadImageCallback(croppedFile, camApiMap['imageId']);
      } else if (imageFor == ImageFor.profileImage) {
        uploadImageCallback(
            croppedFile, '${DateTime.now()}_${vendorProfileModel!.id}');
      }
    }
  }

  static chooseImagePopup({
    required BuildContext context,
    required ImageFor imageFor,
    required Function uploadImageCallback,
  }) {
    return showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return Theme(
          data: ThemeData(
              dialogBackgroundColor: Colors.white,
              dialogTheme: const DialogTheme(backgroundColor: Colors.white)),
          child: CupertinoAlertDialog(
            title: const Text('Update Profile Photo From Galery'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Ok'),
                onPressed: () async {
                  imageProcessing(
                      'Gallery', context, imageFor, uploadImageCallback);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
