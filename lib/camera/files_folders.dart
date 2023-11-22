import 'dart:io';
import 'package:CiARADS/database/db_keys.dart';
import 'package:CiARADS/database/patients_table.dart';
import 'package:CiARADS/global.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';

class FilesFolders {
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
      Global.patientFolderPath = dir.path;
      if (kDebugMode) {
        print("Directory path = ${Global.patientFolderPath}");
      }
    } else {
      dir.create();
      Global.patientFolderPath = dir.path;
      if (kDebugMode) {
        print("Directory path = ${Global.patientFolderPath}");
      }
    }
  }

  void saveToFolder(XFile image, String imageName) async {
    String newPath = join(Global.patientFolderPath, imageName);
    Uint8List bytes = await image.readAsBytes();
    File imageFile = File(newPath);
    File newImage = await imageFile.writeAsBytes(bytes);
    _fillMap(newImage.path);
    if (kDebugMode) {
      print("Saved image at = ${newImage.path}");
    }
  }

  /// @func{_fillMap} is used to fill the map containing image paths with the correct key
  /// the function provides the correct key to the {@map imagePaths} based on the {@var testName}
  void _fillMap(String imagePath) {
    if (kDebugMode) {
      print("Populating map");
    }

    String key = "";

    switch (Global.testName) {
      case lugolIodine:
        key = lugolIodineImagesPath;
        break;
      case aceticAcid:
        key = aceticAcidImagesPath;
        break;
      case greenFilter:
        key = greenFilterImagesPath;
        break;
      case normalSaline:
        key = normalSalineImagesPath;
        break;
      default:
        if (kDebugMode) {
          print("Invalid test");
        }
        break;
    }

    Global.imagePaths.addAll({key: imagePath});
  }

  void saveImagePathsToDB(String patientId) async {
    await PatientTable()
        .addImagesPaths(patientId: patientId, imagePaths: Global.imagePaths);
  }
}
