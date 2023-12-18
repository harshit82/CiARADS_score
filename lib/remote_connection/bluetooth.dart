// import 'dart:convert';
// import 'package:CiARADS/remote_connection/status_context_provider.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';

// class Bluetooth extends StatefulWidget {
//   const Bluetooth({super.key});

//   @override
//   State<Bluetooth> createState() => _BluetoothState();
// }

// class _BluetoothState extends State<Bluetooth> {
//   // Initializing the Bluetooth connection state to be unknown
//   BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
//   // Get the instance of the Bluetooth
//   final FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
//   // Track the Bluetooth connection with the remote device
//   BluetoothConnection? connection;
//   // To track whether the device is still connected to Bluetooth
//   bool get isConnected => connection != null && connection!.isConnected;

//   int? _deviceState;
//   bool isDisconnecting = false;

//   List<BluetoothDevice> _devicesList = [];
//   BluetoothDevice? _device;
//   bool _connected = false;
//   bool _isButtonUnavailable = false;

//   Map<String, Color> colors = {
//     'onBorderColor': Colors.green,
//     'offBorderColor': Colors.red,
//     'neutralBorderColor': Colors.transparent,
//     'onTextColor': Colors.green.shade700,
//     'offTextColor': Colors.red.shade700,
//     'neutralTextColor': Colors.blue,
//   };

//   @override
//   void initState() {
//     super.initState();

//     // Get current state
//     _bluetooth.state.then((state) {
//       setState(() {
//         _bluetoothState = state;
//       });
//     });

//     _deviceState = 0; // neutral

//     // If the bluetooth of the device is not enabled,
//     // then request permission to turn on bluetooth
//     // as the app starts up
//     _enableBluetooth();
//     _stateChangeListener();
//   }

//   _stateChangeListener() {
//     // Listen for further state changes
//     _bluetooth.onStateChanged().listen((BluetoothState state) {
//       setState(() {
//         _bluetoothState = state;
//         if (_bluetoothState == BluetoothState.STATE_OFF) {
//           _isButtonUnavailable = true;
//         }
//       });
//     });
//   }

//   @override
//   void dispose() {
//     // Avoid memory leak and disconnect
//     if (isConnected) {
//       isDisconnecting = true;
//       connection!.dispose();
//       connection = null;
//     }

//     super.dispose();
//   }

//   Future<bool> _enableBluetooth() async {
//     // Retrieving the current Bluetooth state
//     _bluetoothState = await _bluetooth.state;

//     // If the bluetooth is off, then turn it on first
//     // and then retrieve the devices that are paired.
//     if (_bluetoothState == BluetoothState.STATE_OFF) {
//       await _bluetooth.requestEnable();
//       await getPairedDevices();
//       return true;
//     } else {
//       await getPairedDevices();
//     }
//     return false;
//   }

//   Future<void> getPairedDevices() async {
//     List<BluetoothDevice> devices = [];
//     // To get the list of paired devices
//     try {
//       devices = await _bluetooth.getBondedDevices();
//     } on PlatformException {
//       if (kDebugMode) {
//         print("Error");
//       }
//     }

//     // It is an error to call [setState] unless [mounted] is true.
//     if (!mounted) {
//       return;
//     }

//     // Store the [devices] list in the [_devicesList] for accessing
//     // the list outside this class
//     setState(() {
//       _devicesList = devices;
//     });
//   }

//   // Create the List of devices to be shown in Dropdown Menu
//   List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
//     List<DropdownMenuItem<BluetoothDevice>> items = [];
//     if (_devicesList.isEmpty) {
//       items.add(const DropdownMenuItem(
//         child: Text('NONE'),
//       ));
//     } else {
//       for (var device in _devicesList) {
//         items.add(DropdownMenuItem(
//           value: device,
//           child: Text(device.name.toString()),
//         ));
//       }
//     }
//     return items;
//   }

//   // Method to connect to bluetooth
//   void _connect() async {
//     setState(() {
//       _isButtonUnavailable = true;
//     });
//     if (_device == null) {
//       Fluttertoast.showToast(msg: 'No device selected');
//     } else {
//       if (!isConnected) {
//         await BluetoothConnection.toAddress(_device?.address)
//             .then((connection) {
//           if (kDebugMode) {
//             print('Connected to the device');
//           }
//           connection = connection;
//           setState(() {
//             _connected = true;
//           });

//           connection.input?.listen(null).onDone(() {
//             if (isDisconnecting) {
//               if (kDebugMode) {
//                 print('Disconnecting locally!');
//               }
//             } else {
//               if (kDebugMode) {
//                 print('Disconnected remotely!');
//               }
//             }
//             if (mounted) {
//               setState(() {});
//             }
//           });
//         }).catchError((error) {
//           if (kDebugMode) {
//             print('Cannot connect, exception occurred');
//           }
//           if (kDebugMode) {
//             print(error);
//           }
//         });
//         Fluttertoast.showToast(msg: 'Device connected');
//         setState(() => _isButtonUnavailable = false);
//       }
//     }
//   }

//   // Method to disconnect bluetooth
//   void _disconnect() async {
//     setState(() {
//       _isButtonUnavailable = true;
//       _deviceState = 0;
//     });

//     await connection!.close();
//     Fluttertoast.showToast(msg: 'Device disconnected');
//     if (!connection!.isConnected) {
//       setState(() {
//         _connected = false;
//         _isButtonUnavailable = false;
//       });
//     }
//   }

//   // Method to send message,
//   // for turning the Bluetooth device on
//   _sendOnMessageToBluetooth() async {
//     connection?.output.add(ascii.encode('1'));
//     await connection?.output.allSent;
//     Fluttertoast.showToast(msg: 'Device Turned On');
//     setState(() {
//       _deviceState = 1; // device on
//     });
//   }

//   // Method to send message,
//   // for turning the Bluetooth device off
//   _sendOffMessageToBluetooth() async {
//     connection?.output.add(ascii.encode('0'));
//     await connection?.output.allSent;
//     Fluttertoast.showToast(msg: 'Device Turned Off');
//     setState(() {
//       _deviceState = -1; // device off
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           actions: [
//             IconButton(
//               onPressed: () async {
//                 await getPairedDevices().then((_) =>
//                     Fluttertoast.showToast(msg: "Device list refreshed"));
//               },
//               icon: const Icon(Icons.refresh),
//             ),
//           ],
//         ),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text("Enable bluetooth"),
//                   Switch(
//                       value: _bluetoothState.isEnabled,
//                       onChanged: (bool value) async {
//                         if (value) {
//                           await _bluetooth.requestEnable();
//                         } else {
//                           await _bluetooth.requestDisable();
//                         }
//                         await getPairedDevices();
//                         _isButtonUnavailable = false;
//                         if (_connected) {
//                           _disconnect();
//                         }
//                         setState(() {});
//                       }),
//                 ],
//               ),
//             ),
//             const Text("Paired Devices"),
//             const SizedBox(
//               height: 20,
//             ),
//             Consumer<StatusContextProvider>(
//                 builder: (context, StatusContextProvider, widget)
//                 return (StatusContextProvider.device == null ? Row() : Column()) ),
//             // Padding(
//             //   padding: const EdgeInsets.all(8.0),
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             //     children: [
//             //       const Text("Device"),
//             //       DropdownButton(
//             //         items: _getDeviceItems(),
//             //         onChanged: (value) {
//             //           setState(() {
//             //             _device = value;
//             //           });
//             //         },
//             //         value: _devicesList.isNotEmpty ? _device : null,
//             //       ),
//             //       Padding(
//             //         padding: const EdgeInsets.all(8.0),
//             //         child: Card(
//             //           shape: RoundedRectangleBorder(
//             //             side: BorderSide(
//             //               color: _deviceState == 0
//             //                   ? colors['neutralBorderColor'] as Color
//             //                   : _deviceState == 1
//             //                       ? colors['onBorderColor'] as Color
//             //                       : colors['offBorderColor'] as Color,
//             //               width: 3,
//             //             ),
//             //             borderRadius: BorderRadius.circular(4.0),
//             //           ),
//             //         ),
//             //       ),
//             //       TextButton(
//             //           onPressed:
//             //               _connected ? _sendOnMessageToBluetooth() : null,
//             //           child: const Text("ON")),
//             //       TextButton(
//             //           onPressed:
//             //               _connected ? _sendOffMessageToBluetooth() : null,
//             //           child: const Text("OFF")),
//             //     ],
//             //   ),
//             // ),
//             // ElevatedButton(
//             //   onPressed: _isButtonUnavailable
//             //       ? null
//             //       : _connected
//             //           ? _disconnect
//             //           : _connect,
//             //   child: Text(_connected ? "Disconnect" : "Connect"),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
