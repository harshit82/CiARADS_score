import 'package:CiARADS/camera/camera.dart';
import 'package:CiARADS/global.dart';
import 'package:CiARADS/main.dart';
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

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect('ws://your_websocket_server_address');
    channel?.stream.listen(_onMessage);
  }

  void _onMessage(dynamic data) {
    // Handle incoming WebSocket messages
    setState(() {
      message = data;
    });

    // Check if the message is "CAPTURE"
    if (message == 'CAPTURE') {
      takePicture();
    }
  }

  // Example function to simulate capturing a picture
  void takePicture() {
    if (kDebugMode) {
      print('Taking a picture...');
    }
    // logic to capture a photo
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CameraApp(
          id: Global.patientId,
          test: Global.testName,
          cameras: cameras,
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
          children: <Widget>[
            Text('Received Message: $message'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    channel?.sink.close();
    super.dispose();
  }
}
