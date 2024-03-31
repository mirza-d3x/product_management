import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?>? imagePicker() async {
  final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery, preferredCameraDevice: CameraDevice.front);
  if (pickedImage != null) {
    return File(pickedImage.path);
  }
  return null;
}
