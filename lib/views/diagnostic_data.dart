import 'dart:async';
import 'package:CiARADS/camera/usb_camera.dart';
import 'package:CiARADS/views/widgets/image_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:CiARADS/camera/camera.dart';
import 'package:CiARADS/camera/files_folders.dart';
import 'package:CiARADS/constants/routes.dart';
import 'package:CiARADS/database/database_export.dart';
import 'package:CiARADS/global.dart';
import 'package:CiARADS/main.dart';
import 'package:CiARADS/views/widgets/credits.dart';
import 'package:CiARADS/views/widgets/dropdown_menu.dart';

class DiagnosticData extends StatefulWidget {
  final String patientId;
  const DiagnosticData({
    Key? key,
    required this.patientId,
  }) : super(key: key);

  @override
  State<DiagnosticData> createState() => _DiagnosticDataState();
}

class _DiagnosticDataState extends State<DiagnosticData> {
  final streamController = StreamController.broadcast();

  bool isLugolIodineFilled = true;
  bool isNormalSalineFilled = true;
  bool isGreenFilterFilled = true;
  bool isAceticAcidFilled = true;

  /// checks is all fields are filled with values otherwise throws errors
  bool _checkForAllFilled() {
    if (isLugolIodineFilled == false ||
        isNormalSalineFilled == false ||
        isGreenFilterFilled == false ||
        isAceticAcidFilled == false) return false;
    return true;
  }

  void _calculateScore() {
    int score = 0;
    if (_checkForAllFilled()) {
      score = (int.parse(marginAndSurfaceController.text) +
          int.parse(lesionSizeController.text) +
          int.parse(aceticAcidController.text) +
          int.parse(vesselController.text) +
          int.parse(lugolIodineController.text));
    }
    totalScoreController.text = score.toString();
  }

  late TextEditingController marginAndSurfaceController;
  late TextEditingController vesselController;
  late TextEditingController lesionSizeController;
  late TextEditingController aceticAcidController;
  late TextEditingController lugolIodineController;
  late TextEditingController totalScoreController;
  late TextEditingController biopsyTakenController;
  late TextEditingController histopathologyReportController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    vesselController = TextEditingController();
    marginAndSurfaceController = TextEditingController();
    lesionSizeController = TextEditingController();
    lugolIodineController = TextEditingController();
    totalScoreController = TextEditingController();
    biopsyTakenController = TextEditingController();
    histopathologyReportController = TextEditingController();
    aceticAcidController = TextEditingController();

    lugolIodineController.addListener(() {
      final isLugolIodineFilled = lugolIodineController.text != 'NV';
      setState(() {
        this.isLugolIodineFilled = isLugolIodineFilled;
      });
    });

    aceticAcidController.addListener(() {
      final isAceticAcidFilled = aceticAcidController.text != 'NV';
      setState(() {
        this.isAceticAcidFilled = isAceticAcidFilled;
      });
    });

    totalScoreController.addListener(_calculateScore);
  }

  @override
  void dispose() {
    super.dispose();
    streamController.close();
    marginAndSurfaceController.dispose();
    vesselController.dispose();
    lesionSizeController.dispose();
    aceticAcidController.dispose();
    lugolIodineController.dispose();
    totalScoreController.dispose();
    biopsyTakenController.dispose();
    histopathologyReportController.dispose();
  }

  void _saveToDB() {
    Map<String, dynamic> diagnosisData = {
      marginAndSurface: int.parse(marginAndSurfaceController.text),
      vessel: int.parse(vesselController.text),
      lesionSize: int.parse(lesionSizeController.text),
      aceticAcid: int.parse(aceticAcidController.text),
      lugolIodine: int.parse(lugolIodineController.text),
      totalScore: int.parse(totalScoreController.text),
      biopsyTaken: biopsyTakenController.text,
      histopathologyReport: histopathologyReportController.text,
    };

    if (kDebugMode) {
      print("Diagnosis data map = ");
      print(diagnosisData);
    }

    /// saving diagnostic data for the given patient to the DB
    PatientTable.addDiagnosisData(
        patientId: widget.patientId, diagnosisData: diagnosisData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            UsbCamera.startCamera();
          },
          child: const Icon(Icons.switch_camera),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Diagnostic Data"),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Click to capture images:\n",
                      style: TextStyle(fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Global.testName = greenFilter;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CameraApp(
                                    cameras: cameras,
                                    id: widget.patientId,
                                    test: greenFilter,
                                    stream: streamController.stream,
                                  ),
                                ),
                              );
                            },
                            child: const Text("Green Filter")),
                        const SizedBox(
                          width: 10,
                        ),
                        const ImagePreview(testName: greenFilterImagesPath),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Global.testName = aceticAcid;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CameraApp(
                                    cameras: cameras,
                                    id: widget.patientId,
                                    test: aceticAcid,
                                    stream: streamController.stream,
                                  ),
                                ),
                              );
                            },
                            child: const Text("Acetic acid")),
                        const SizedBox(
                          width: 10,
                        ),
                        const ImagePreview(testName: aceticAcidImagesPath),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Global.testName = lugolIodine;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CameraApp(
                                    id: widget.patientId,
                                    test: lugolIodine,
                                    cameras: cameras,
                                    stream: streamController.stream,
                                  ),
                                ),
                              );
                            },
                            child: const Text("Lugol Iodine")),
                        const SizedBox(
                          width: 10,
                        ),
                        const ImagePreview(testName: lugolIodineImagesPath),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Global.testName = normalSaline;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CameraApp(
                                    id: widget.patientId,
                                    test: normalSaline,
                                    cameras: cameras,
                                    stream: streamController.stream,
                                  ),
                                ),
                              );
                            },
                            child: const Text("Normal Saline")),
                        const SizedBox(
                          width: 10,
                        ),
                        const ImagePreview(testName: normalSalineImagesPath),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        DropDownMenu(
                          items: const ['NV', '0', '1', '2'],
                          initialValue: 'NV',
                          label: 'Margin And Surface',
                          controller: marginAndSurfaceController,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 60,
                        ),
                        DropDownMenu(
                          items: const ['NV', '0', '1', '2'],
                          initialValue: 'NV',
                          label: 'Vessel',
                          controller: vesselController,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        DropDownMenu(
                          items: const ['NV', '0', '1', '2'],
                          initialValue: 'NV',
                          label: 'Lesion Size',
                          controller: lesionSizeController,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 60,
                        ),
                        DropDownMenu(
                          items: const ['NV', '0', '1', '2'],
                          initialValue: 'NV',
                          label: 'Acetic acid',
                          controller: aceticAcidController,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        DropDownMenu(
                          items: const ['NV', '0', '1', '2'],
                          initialValue: 'NV',
                          label: 'Lugol Iodine',
                          controller: lugolIodineController,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 60,
                        ),
                        DropDownMenu(
                          items: const ['NV', 'Required', 'Not required'],
                          initialValue: 'NV',
                          label: 'Biopsy taken',
                          controller: biopsyTakenController,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Total Score: "),
                        const SizedBox(height: 5),
                        TextFormField(
                          // TODO: Disable it till all values are not filled
                          onChanged: (value) {
                            setState(() {});
                          },
                          readOnly: true,
                          enableInteractiveSelection: false,
                          decoration: InputDecoration(
                              hintText: "Tap to see score",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              errorStyle:
                                  const TextStyle(color: Colors.redAccent)),
                          controller: totalScoreController,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Histopathology Report",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          errorStyle: const TextStyle(color: Colors.redAccent)),
                      controller: histopathologyReportController,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                        onPressed: _checkForAllFilled()
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _formKey.currentState?.save();

                                    Fluttertoast.showToast(
                                        msg: "Saving diagnostic data");

                                    _saveToDB();

                                    FilesFolders()
                                        .saveImagePathsToDB(widget.patientId);
                                  });
                                  Navigator.of(context)
                                      .pushReplacementNamed(home);
                                }
                              }
                            : null,
                        child: const Text("Save")),
                    const Align(
                        alignment: Alignment.bottomCenter, child: Credits()),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
