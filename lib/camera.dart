import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CameraApp extends StatefulWidget {
  final String id;
  final String test;
  final List<CameraDescription> cameras;
  const CameraApp({
    Key? key,
    required this.id,
    required this.test,
    required this.cameras,
  }) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  // camera controller
  late CameraController controller;
  bool isCapturing = false;
  // for switching camera
  final int _selectedCameraIndex = 0;
  // for flash light
  bool _isFlashOn = false;
  // for focusing
  Offset? _focusPoint;
  // for zoom
  double _currentZoom = 1.0;
  // captured image stored as an Xfile
  File? _capturedImage;
  // for making capture sound
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  /// {@_initCamera} initializes the camera for use
  Future<void> _initCamera(int cameraIndex) async {
    // setting the camera controller to the default back camera
    controller = CameraController(
        widget.cameras[_selectedCameraIndex], ResolutionPreset.max);
    try {
      // checking if the controller has been initialized
      await controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          // locking orientation of the device in portrait mode
          controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
        });
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              if (kDebugMode) {
                print(e.code);
              }
              Fluttertoast.showToast(msg: "Camera Access Denied");
              break;
            default:
              {
                // Handle other errors here.
                if (kDebugMode) {
                  print(e.code);
                }
                Fluttertoast.showToast(msg: e.code);
                break;
              }
          }
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error: ${e.toString()}");
      }
    }
  }

  @override
  void initState() {
    super.initState();

    /// invoking the {@_initCamera} function in the initState
    _initCamera(_selectedCameraIndex);
  }

  Future<Directory?> getExternalStorageDir() async {
    // To check whether permission is given for this app or not.
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    }
    Directory? directory = await getExternalStorageDirectory();
    // if (Platform.isAndroid) {
    //   // Redirects it to download folder in android
    //   directory = Directory("/storage/emulated/0/Pictures");
    // } else {
    //   directory = await getApplicationDocumentsDirectory();
    // }
    return directory;

    // final exPath = directory.path;
    // if (kDebugMode) {
    //   print("Saved Path: $exPath");
    // }
    // await Directory(exPath).create(recursive: true);
    // return exPath;
  }

  // Future<File?> changeFileName(File? file, String newFileName) async {
  //   var path = file!.path;
  //   var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
  //   var newPath = path.substring(0, lastSeparator + 1) + newFileName;
  //   return file.rename(newPath);
  // }

  Future<Directory> createNewImgDir({required String newDirName}) async {
    // using the path_provider plugin to get the application directory
    final Directory? appDir = await getExternalStorageDir();

    // creating new folder
    final newImgDir =
        await Directory('$appDir/$newDirName').create(recursive: true);
    return newImgDir;
    //saveImageToDisk(appDir!.path, newImgDir, widget.id, widget.test);
  }

  Future<File> saveImageToDisk(String path, Directory directory,
      String patientId, String testName) async {
    try {
      File tempFile = File(path);
      img.Image? image = img.decodeImage(tempFile.readAsBytesSync());
      img.Image mImage = img.copyResize(image!, width: 521);
      String imgType = path.split('.').last;
      // saving the path in the required format
      String mPath =
          '${directory.path}/${patientId}_$testName/${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}.$imgType';
      File dFile = File(mPath);
      if (imgType == 'jpg' || imgType == 'jpeg') {
        dFile.writeAsBytesSync(img.encodeJpg(mImage));
      } else {
        dFile.writeAsBytesSync(img.encodePng(mImage));
      }
      return dFile;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return File(path);
  }

  // Future<File?> saveImageToLocalStorage(XFile? image, String imageName) async {
  //   final pickedImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedImage == null) return null;

  //   try {
  //     final directory = await getExternalStorageDirectory();
  //     if (directory != null) {
  //       return File(pickedImage.path).copy('${directory.path}/$imageName.png');
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  //   return null;
  // }

  /// {@captureImage} captures the image
  void captureImage() async {
    if (controller.value.isTakingPicture) {
      return;
    }

    try {
      setState(() {
        isCapturing = true;
      });

      // invoking the {@takePicture} function defined under the controller of the camera package to capture the image
      final XFile capturedImage = await controller.takePicture();
      // using audio player to play the shutter sound on taking a picture
      audioPlayer.open(Audio('sound/camera_shutter.mp3'));
      audioPlayer.play();

      String imagePath = capturedImage.path;
      // saving the image to the galley using the GalleySaver plugin
      await GallerySaver.saveImage(imagePath);
      Fluttertoast.showToast(msg: 'Saved to gallery');

      if (kDebugMode) {
        print('Photo captured and saved to gallery');
      }

      // for image preview in camera
      _capturedImage = File(imagePath);

      // //saveImageToNewDir();
      // Directory newDir = await createNewImgDir(newDirName: 'patient_images');
      // saveImageToDisk(imagePath, newDir, widget.id, widget.test);

      //await FileSaver.instance
      //     .saveFile(name: "${widget.id}_${widget.test}", file: _capturedImage);

      // changeFileName(_capturedImage, appDir.path);
      // _capturedImage!.renameSync(appDir.path);
    } catch (e) {
      if (kDebugMode) {
        print("Error: ${e.toString()}");
      }
    } finally {
      setState(() {
        isCapturing = false;
      });
    }
  }

  /// {@_toggleFlashLight} turn on/off the flash light
  void _toggleFlashLight() {
    if (_isFlashOn == true) {
      controller.setFlashMode(FlashMode.off);
      setState(() {
        _isFlashOn = false;
      });
    } else {
      controller.setFlashMode(FlashMode.torch);
      setState(() {
        _isFlashOn = true;
      });
    }
  }

  /// allow the user to zoom in
  void zoomCamera(double value) {
    setState(() {
      _currentZoom = value;
      controller.setZoomLevel(value);
    });
  }

  // allows the user to focus at a specific point in on the camera screen
  Future<void> _setFocusPoint(Offset point) async {
    if (controller.value.isInitialized) {
      try {
        final double x = point.dx.clamp(0.0, 1.0);
        final double y = point.dy.clamp(0.0, 1.0);
        await controller.setFocusPoint(Offset(x, y));
        await controller.setFocusMode(FocusMode.auto);
        setState(() {
          _focusPoint = Offset(x, y);
        });

        // reset _focusPoint after a short delay
        await Future.delayed(const Duration(seconds: 2));
        setState(() {
          _focusPoint = null;
        });
      } catch (e) {
        if (kDebugMode) {
          print("Failed to set focus: $e");
        }
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return SafeArea(
      child: Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: () => _toggleFlashLight(),
                          child: _isFlashOn == false
                              ? const Icon(
                                  Icons.flash_off,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.flash_on,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                top: 50,
                bottom: 0,
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        final Offset tapPosition = details.localPosition;
                        final Offset relativeTapPosition = Offset(
                            tapPosition.dx / constraints.maxWidth,
                            tapPosition.dy / constraints.maxHeight);
                        _setFocusPoint(relativeTapPosition);
                      },
                      child: CameraPreview(controller)),
                ),
              ),
              Positioned(
                top: 50,
                right: 10,
                child: SfSlider.vertical(
                  max: 5.0,
                  min: 1.0,
                  value: _currentZoom,
                  activeColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      zoomCamera(value);
                    });
                  },
                ),
              ),
              if (_focusPoint != null)
                Positioned.fill(
                  top: 50,
                  child: Align(
                    alignment: Alignment(
                        _focusPoint!.dx * 2 - 1, _focusPoint!.dy * 2 - 1),
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.white,
                        width: 2,
                      )),
                    ),
                  ),
                ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 150,
                child: Container(
                  color: Colors.black45,
                ),
              ),
              Positioned(
                  bottom: 50,
                  left: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: _capturedImage == null
                            ? Container(
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                              )
                            : SizedBox(
                                height: 60,
                                width: 60,
                                child: Image.file(
                                  _capturedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 5.5,
                      ),
                      GestureDetector(
                          onTap: () => captureImage(),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                width: 3,
                                color: Colors.white,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          )),
                    ],
                  )),
            ],
          );
        },
      )),
    );
  }
}
