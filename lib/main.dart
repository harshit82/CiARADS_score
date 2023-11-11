import 'package:CiARADS/camera/camera.dart';
import 'package:CiARADS/constants/routes.dart';
import 'package:CiARADS/view_model/view_model.dart';
import 'package:CiARADS/views/views_export.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ViewModel()),
      ],
      child: MaterialApp(
        title: 'CiARADS',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Lato',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: home,
        routes: {
          home: (context) => const Home(),
          showPatientDetails: (context) => const ShowPatientDetails(),
          camera: (context) => const CameraApp(
                id: '',
                test: '',
                cameras: [],
              ),
          enterPatientDetails: (context) => const EnterPatientDetails(),
          enterDiagnosticData: (context) => const DiagnosticData(patientId: ''),
          tableFunctions: (context) => const TableFunctions(),
        },
      ),
    );
  }
}
