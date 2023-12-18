import 'dart:async';
import 'package:CiARADS/remote_connection/bluetooth/device_list.dart';
import 'package:CiARADS/remote_connection/bluetooth/status_context_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';

class Selection extends StatefulWidget {
  final bool checkAvailability;
  const Selection({super.key, this.checkAvailability = true});

  @override
  State<Selection> createState() => _SelectionState();
}

enum DeviceAvailability { no, yes, maybe }

class DeviceWithAvailability extends BluetoothDevice {
  BluetoothDevice? device;
  DeviceAvailability? availability;
  int? rssi;

  DeviceWithAvailability(this.device, this.availability, [this.rssi])
      : super(address: device!.address);
}

class _SelectionState extends State<Selection> {
  List<DeviceWithAvailability> devices = <DeviceWithAvailability>[];

  // Availability
  StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
  bool? _isDiscovering;

  _SelectionState();

  @override
  void initState() {
    super.initState();
    _isDiscovering = widget.checkAvailability;
    if (_isDiscovering!) {
      _startDiscovery();
    }
    // Setup a list of the bonded devices
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices
            .map(
              (device) => DeviceWithAvailability(
                device,
                widget.checkAvailability
                    ? DeviceAvailability.maybe
                    : DeviceAvailability.yes,
              ),
            )
            .toList();
      });
    });
  }

  void _startDiscovery() {
    _discoveryStreamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        Iterator i = devices.iterator;
        while (i.moveNext()) {
          var _device = i.current;
          if (_device.device == r.device) {
            _device.availability = DeviceAvailability.yes;
            _device.rssi = r.rssi;
          }
        }
      });
    });

    _discoveryStreamSubscription!.onDone(() {
      setState(() {
        _isDiscovering = false;
      });
    });
  }

  void _restartDiscovery() {
    setState(() {
      _isDiscovering = true;
    });

    _startDiscovery();
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _discoveryStreamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<DeviceList> list = devices
        .map(
          (_device) => DeviceList(
            device: _device.device,
            rssi: _device.rssi,
            enabled: _device.availability == DeviceAvailability.yes,
            onTap: () {
              Provider.of<StatusContextProvider>(context, listen: false)
                  .setDevice(_device.device!);
              Navigator.of(context).pop(_device.device);
            },
          ),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select device'),
        actions: <Widget>[
          _isDiscovering!
              ? FittedBox(
                  child: Container(
                    margin: const EdgeInsets.all(16.0),
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.replay),
                  onPressed: _restartDiscovery,
                )
        ],
      ),
      body: ListView(children: list),
    );
  }
}
