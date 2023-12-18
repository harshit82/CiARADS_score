import 'dart:async';
import 'package:CiARADS/camera/camera.dart';
import 'package:CiARADS/global.dart';
import 'package:CiARADS/main.dart';
import 'package:CiARADS/remote_connection/socket_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class WebSocket extends StatefulWidget {
  const WebSocket({super.key});

  @override
  State<WebSocket> createState() => _WebSocketState();
}

class _WebSocketState extends State<WebSocket> {
  WebSocketChannel? channel;
  String message = '';
  final streamController = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(socketServerAddress);
    channel?.stream.listen(_onMessage);
  }

  @override
  void dispose() {
    channel?.sink.close();
    streamController.close();
    super.dispose();
  }

  void _onMessage(dynamic data) {
    // Handle incoming WebSocket messages
    setState(() {
      message = data;
      if (kDebugMode) {
        print("Socket messages =");
        print(message);
      }
      if (message == openCameraKey) {
        _openCamera();
        // TODO: Fix
        streamController.sink.add(message);
      }
    });
  }

  void _openCamera() {
    if (kDebugMode) {
      print('Opening camera...');
    }
    // open camera
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CameraApp(
          id: Global.patientId,
          test: Global.testName,
          cameras: cameras,
          stream: streamController.stream,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remote capture'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Received Message: $message'),
          ],
        ),
      ),
    );
  }
}
