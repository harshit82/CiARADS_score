import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class FileStorage {
  // static Future<String> get _localPath async {
  //   // final directory = await getApplicationDocumentsDirectory();
  //   // return directory.path;
  //   // To get the external path from device of download folder
  //   final String directory = await getExternalDocumentPath();
  //   return directory;
  // }

  static Future<File> saveImage(String path, String bytes, String name) async {
    // Create a file for the path of
    // device and file name with extension
    File file = File('$path/$name');

    if (kDebugMode) {
      print("Save file");
    }

    // Write the data in the file you have created
    return file.writeAsString(bytes);
  }

  Future<String> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    var imageBytes = await pickedImage!.readAsBytes();
    if (kDebugMode) {
      print("Image Picked: $imageBytes");
    }
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  Future<File?> saveImageToLocalStorage(XFile? image, String imageName) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return null;

    try {
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        return File(pickedImage.path).copy('${directory.path}/$imageName.png');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }
}
