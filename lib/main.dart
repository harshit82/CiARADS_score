import 'package:calposcopy/camera.dart';
import 'package:calposcopy/views/diagnostic_data.dart';
import 'package:calposcopy/views/enter_patient_details.dart';
import 'package:calposcopy/views/home.dart';
import 'package:calposcopy/views/show_patient_details.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calposcopy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
