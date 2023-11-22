import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:CiARADS/camera/files_folders.dart';

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

class _CameraAppState extends State<CameraApp> with WidgetsBindingObserver {
  // camera controller
  CameraController? _cameraController;
  bool isCapturing = false;
  // for flash light
  bool _isFlashOn = false;
  // for focusing
  Offset? _focusPoint;
  // for zoom
  double _currentZoom = 1.0;
  // captured image stored as an Xfile
  XFile? capturedImage;
  // for making capture sound
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  // to check if the camera controller is initialized
  bool _isReady = false;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      _initCamera();
    } else if (state == AppLifecycleState.paused) {
      _cameraController?.dispose();
    } else if (state == AppLifecycleState.inactive) {
      _cameraController?.dispose();
      _cameraController = null;
    }
  }

  /// {@_initCamera} initializes the camera for use
  Future<void> _initCamera() async {
    // // camera permission handling
    PermissionStatus status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    } else if (!status.isPermanentlyDenied) {
      Permission.camera.onPermanentlyDeniedCallback(() {
        ErrorWidget("Permanently Denied Camera Access");
        print("Permanently Denied Camera Access");
      });
    }
    // setting the camera controller to the default back camera
    _cameraController = CameraController(
        widget.cameras.first, ResolutionPreset.max,
        enableAudio: false);
    try {
      // checking if the controller has been initialized
      await _cameraController?.initialize().then((_) {
        _isReady = true;
        if (!mounted) {
          return;
        }
        setState(() {
          // locking orientation of the device in portrait mode
          _cameraController
              ?.lockCaptureOrientation(DeviceOrientation.portraitUp);
        });
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              if (kDebugMode) {
                print(e.code);
              }
              ErrorWidget("Camera Access Denied");
              break;
            default:
              {
                // Handle other errors here.
                if (kDebugMode) {
                  print(e.code);
                  print(e.description.toString());
                }
                ErrorWidget(e.description.toString());
                break;
              }
          }
        }
      });
    } catch (e) {
      ErrorWidget(e.toString());
      if (kDebugMode) {
        print("Error: ${e.toString()}");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    /// invoking the {@_initCamera} function in the initState
    _initCamera();
  }

  /// {@captureImage} captures the image
  void captureImage() async {
    if (_cameraController!.value.isTakingPicture) {
      return;
    }

    try {
      setState(() {
        isCapturing = true;
      });

      // invoking the {@takePicture} function defined under the controller of the camera package to capture the image
      capturedImage = await _cameraController?.takePicture();
      // using audio player to play the shutter sound on taking a picture
      audioPlayer.open(Audio('sound/camera_shutter.mp3'));
      audioPlayer.play();

      String imagePath = capturedImage!.path;
      Fluttertoast.showToast(msg: 'Saved image');

      if (kDebugMode) {
        print('Photo captured and saved');
      }

      // image name is a combination of patient_id and patient_name with the current date and time
      String imageName =
          "#${widget.id}%${widget.test}|${DateTime.now()}.${imagePath.split('.').last}";

      FilesFolders().saveToFolder(capturedImage!, imageName);
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
      _cameraController?.setFlashMode(FlashMode.off);
      setState(() {
        _isFlashOn = false;
      });
    } else {
      _cameraController?.setFlashMode(FlashMode.torch);
      setState(() {
        _isFlashOn = true;
      });
    }
  }

  /// allow the user to zoom in
  void zoomCamera(double value) {
    setState(() {
      _currentZoom = value;
      _cameraController?.setZoomLevel(value);
    });
  }

  // allows the user to focus at a specific point in on the camera screen
  Future<void> _setFocusPoint(Offset point) async {
    if (_cameraController!.value.isInitialized) {
      try {
        final double x = point.dx.clamp(0.0, 1.0);
        final double y = point.dy.clamp(0.0, 1.0);
        await _cameraController?.setFocusPoint(Offset(x, y));
        await _cameraController?.setFocusMode(FocusMode.auto);
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
    _cameraController?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
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
                  aspectRatio: _cameraController!.value.aspectRatio,
                  child: GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        final Offset tapPosition = details.localPosition;
                        final Offset relativeTapPosition = Offset(
                            tapPosition.dx / constraints.maxWidth,
                            tapPosition.dy / constraints.maxHeight);
                        _setFocusPoint(relativeTapPosition);
                      },
                      child: CameraPreview(_cameraController!)),
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
                        child: capturedImage == null
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
                                  File(capturedImage!.path),
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
