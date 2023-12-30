import 'package:CiARADS/camera/files_folders.dart';

class Global {
  static String _patientFolderPath = "";
  static final Map<String, dynamic> _imagePaths = {};
  static String testName = "";
  static String _patientFolderName = "";
  static String _imageFolderPath = "";
  static String patientId = "";

  Future<String> get patientFolderPath async {
    if (_patientFolderPath == "") {
      // create new folder path
      _patientFolderPath =
          await FilesFolders().createFolder(_patientFolderName);
    }
    return _patientFolderPath;
  }

  Future<String> get imageFolderPath async {
    if (_imageFolderPath == "") {
      _imageFolderPath = await FilesFolders().createFolder("PDF");
    }
    return _imageFolderPath;
  }

  void setFolderName(String name) {
    _patientFolderName = name;
  }

  Map<String, dynamic> get imagePaths => _imagePaths;

  void setImagePaths(String key, String path) {
    _imagePaths.addAll({key: path});
  }
}
