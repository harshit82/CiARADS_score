import 'package:flutter/services.dart';

class UsbCamera {
  static const MethodChannel _channel = MethodChannel('usb_camera');

  static Future<String?> startCamera() async {
    try {
      return await _channel.invokeMethod('onStart');
    } on PlatformException catch (e) {
      return e.toString();
    }
  }
}
