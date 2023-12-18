import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class StatusContextProvider extends ChangeNotifier {
  BluetoothDevice? _device;
  BluetoothDevice? get getDevice => _device;
  void setDevice(BluetoothDevice? deviceReceived) {
    _device = deviceReceived;
  }
}
