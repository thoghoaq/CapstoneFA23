import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageHelper {
  static Future<String?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return uploadImageToFirebase(pickedFile.path);
    }
    return null;
  }

  static Future<String?> uploadImageToFirebase(String filePath) async {
    File file = File(filePath);
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName');
    await storageReference.putFile(file);
    String? imageUrl = await storageReference.getDownloadURL();
    return imageUrl;
  }
}
