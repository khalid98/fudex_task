import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class MediaPicker {
  static Future<String?> pickImage({bool isCamera = false}) async {
    try {
      XFile? file = await ImagePicker().pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery);
      if (file == null) return null;
      List<int> imageBytes = await file.readAsBytes();
      String base64String = base64Encode(imageBytes);
      return base64String;
    } catch (e) {}
    return null;
  }
}
