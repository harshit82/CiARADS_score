import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';

class FilesFolders {
  static String patientFolderPath = "";

  // The return type is actually Future<String>
  Future<void> createFolder(String folderName) async {
    final dir = Directory(
        '${(Platform.isAndroid ? await getExternalStorageDirectory() //FOR ANDROID
                : await getApplicationSupportDirectory() //FOR IOS
            )!.path}/$folderName');

    PermissionStatus status = await Permission.storage.status;

    if (status.isGranted) {
      await Permission.storage.request();
    }

    if (await dir.exists()) {
      patientFolderPath = dir.path;
      if (kDebugMode) {
        print("Directory path = $patientFolderPath");
      }
    } else {
      dir.create();
      patientFolderPath = dir.path;
      if (kDebugMode) {
        print("Directory path = $patientFolderPath");
      }
    }
  }

  void saveToFolder(XFile image, String imageName) async {
    String newPath = join(patientFolderPath, imageName);
    Uint8List bytes = await image.readAsBytes();
    File imageFile = File(newPath);
    File newImage = await imageFile.writeAsBytes(bytes);
    if (kDebugMode) {
      print("Saved image at = ${newImage.path}");
    }
  }
}
