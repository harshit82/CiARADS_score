import 'package:CiARADS/camera.dart';
import 'package:CiARADS/routes.dart';
import 'package:CiARADS/widgets/dropdown_menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:CiARADS/database/database_export.dart';
import '../constants.dart';

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
  bool isLugolIodineFilled = false;
  bool isNormalSalineFilled = false;
  bool isGreenFilterFilled = false;
  bool isAceticAcidFilled = false;
  bool areAllFilled = false;

  bool _checkForAllFilled() {
    if (isLugolIodineFilled == false ||
        isNormalSalineFilled == false ||
        isGreenFilterFilled == false ||
        isAceticAcidFilled == false) return false;
    return true;
  }

  // TODO: Make the buttons inactive when the values are not filled, see home for ref

  int calculateScore(int marginAndSurfaceValue, int lesionSizeValue,
      int aceticAcidValue, int vesselValue, int lugolIodineValue) {
    return marginAndSurfaceValue +
        lesionSizeValue +
        aceticAcidValue +
        vesselValue +
        lugolIodineValue;
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
      final isLugolIodineFilled = lugolIodineController.text.isNotEmpty;
      setState(() {
        this.isLugolIodineFilled = isLugolIodineFilled;
      });
    });

    aceticAcidController.addListener(() {
      final isAceticAcidFilled = aceticAcidController.text.isNotEmpty;
      setState(() {
        this.isAceticAcidFilled = isAceticAcidFilled;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

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
      marginAndSurface: marginAndSurfaceController.text,
      vessel: vesselController.text,
      lesionSize: lesionSizeController.text,
      aceticAcid: aceticAcidController.text,
      lugolIodine: lugolIodineController.text,
      totalScore: totalScoreController.text,
      biopsyTaken: biopsyTakenController.text,
      histopathologyReport: histopathologyReportController.text,
    };

    if (kDebugMode) {
      print(diagnosisData);
    }

    /// saving diagnostic data for the given patient to the DB
    PatientDB().addDiagnosisData(
        patientId: widget.patientId, diagnosisData: diagnosisData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    Row(
                      children: [
                        DropDownMenu(
                          items: const ['0', '1', '2'],
                          initialValue: '0',
                          label: 'Margin And Surface',
                          controller: marginAndSurfaceController,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DropDownMenu(
                          items: const ['0', '1', '2'],
                          initialValue: '0',
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
                          items: const ['0', '1', '2'],
                          initialValue: '0',
                          label: 'Lesion Size',
                          controller: lesionSizeController,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DropDownMenu(
                          items: const ['0', '1', '2'],
                          initialValue: '0',
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
                          items: const ['0', '1', '2'],
                          initialValue: '0',
                          label: 'Lugol Iodine',
                          controller: lugolIodineController,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DropDownMenu(
                          items: const ['Required', 'Not required'],
                          initialValue: 'Not required',
                          label: 'Biopsy taken',
                          controller: biopsyTakenController,
                        ),
                      ],
                    ),

                    // TODO: add a calculate score widget
                    // Fix: type 'String' is not a subtype of type 'int' in type cast
                    // Text(calculateScore(
                    //         marginAndSurfaceController.text,
                    //         lesionSizeController.text,
                    //         aceticAcidController.text,
                    //         vesselController.text,
                    //         lugolIodineController.text)
                    //     .toString()),

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
                      height: 20,
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    const Text(
                      "Click to capture images:\n",
                      style: TextStyle(fontSize: 20),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: isLugolIodineFilled
                                ? () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => CameraApp(
                                                id: patientId,
                                                test: lugolIodine,
                                                cameras: cameras)));
                                  }
                                : null,
                            child: const Text("Lugol Iodine")),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: isNormalSalineFilled
                                ? () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => CameraApp(
                                                id: patientId,
                                                test: normalSaline,
                                                cameras: cameras)));
                                  }
                                : null,
                            child: const Text("Normal Saline")),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: isGreenFilterFilled
                                ? () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => CameraApp(
                                                id: patientId,
                                                test: greenFilter,
                                                cameras: cameras)));
                                  }
                                : null,
                            child: const Text("Green Filter")),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: isAceticAcidFilled
                                ? () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => CameraApp(
                                                id: patientId,
                                                test: aceticAcid,
                                                cameras: cameras)));
                                  }
                                : null,
                            child: const Text("Acetic acid")),
                      ],
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
                        onPressed: areAllFilled
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _formKey.currentState?.save();

                                    Fluttertoast.showToast(
                                        msg: "Saving diagnostic data");

                                    _saveToDB();
                                  });
                                  Navigator.of(context)
                                      .pushReplacementNamed(home);
                                }
                              }
                            : null,
                        child: const Text("Save")),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
