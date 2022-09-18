import 'dart:io';
import 'Package:image/image.dart' as im;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

// THIS CALSS WILL PICK IMAGE --> COMPRESS IT --> RETURN MAP (COMPRESSEDIMAGE, IMAGEID, &PATH)
class CameraApi {
  late File file;
  String imageId = const Uuid().v4();

  Future<Map<String, dynamic>> compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    im.Image? imageFile = im.decodeImage(file.readAsBytesSync());
    final File compressedImageFile = File('$path/img_$imageId.jpg')
      ..writeAsBytesSync(im.encodeJpg(imageFile!, quality: 90));
    Map<String, dynamic> camApiMap = {
      'compressedImageFile': compressedImageFile,
      'imageId': imageId,
      'path': path,
    };
    // camApiMap['compressedImageFile'] = compressedImageFile;
    // camApiMap['imageId'] = imageId;
    // camApiMap['path'] = path;
    return camApiMap;
  }

  Future<Map<String, dynamic>> handleTakePhoto() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    file = File(pickedFile!.path);
    return compressImage();
  }

  Future<Map<String, dynamic>> handleChooseFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    file = File(pickedFile!.path);
    return compressImage();
  }
}
