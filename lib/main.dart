import 'package:CiARADS/camera.dart';
import 'package:CiARADS/constants.dart';
import 'package:CiARADS/routes.dart';
import 'package:CiARADS/views/views_export.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CiARADS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Lato',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: enterDiagnosticData,
      routes: {
        home: (context) => const Home(),
        showPatientDetails: (context) => const ShowPatientDetails(),
        camera: (context) => CameraApp(
              cameras: cameras,
              id: '',
              test: '',
            ),
        enterPatientDetails: (context) => const EnterPatientDetails(),
        enterDiagnosticData: (context) => const DiagnosticData(patientId: ''),
      },
    );
  }
}
