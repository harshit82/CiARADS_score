import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DiagnosticData extends StatefulWidget {
  const DiagnosticData({super.key});

  @override
  State<DiagnosticData> createState() => _DiagnosticDataState();
}

class _DiagnosticDataState extends State<DiagnosticData> {
  TextEditingController marginAndSurfaceController = TextEditingController();
  TextEditingController vesselController = TextEditingController();
  TextEditingController lesionSizeController = TextEditingController();
  TextEditingController aceticAcidController = TextEditingController();
  TextEditingController lugolIodineController = TextEditingController();
  TextEditingController totalScoreController = TextEditingController();
  TextEditingController biopsyTakenController = TextEditingController();
  TextEditingController histopathologyReportController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Diagnostic Data"),
      ),
      body: Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            decoration: InputDecoration(
                labelText: "Patient ID",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                errorStyle: const TextStyle(color: Colors.redAccent)),
            controller: marginAndSurfaceController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Patient ID",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                errorStyle: const TextStyle(color: Colors.redAccent)),
            controller: vesselController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Patient ID",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                errorStyle: const TextStyle(color: Colors.redAccent)),
            controller: lesionSizeController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Patient ID",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                errorStyle: const TextStyle(color: Colors.redAccent)),
            controller: aceticAcidController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Patient ID",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                errorStyle: const TextStyle(color: Colors.redAccent)),
            controller: lugolIodineController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Patient ID",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                errorStyle: const TextStyle(color: Colors.redAccent)),
            controller: totalScoreController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Patient ID",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                errorStyle: const TextStyle(color: Colors.redAccent)),
            controller: biopsyTakenController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Patient ID",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                errorStyle: const TextStyle(color: Colors.redAccent)),
            controller: histopathologyReportController,
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _formKey.currentState?.save();

                    Fluttertoast.showToast(msg: "Saving diagnostic data");

                    Map<String, dynamic> diagnosticData = {
                      "Margin_and_Surface": marginAndSurfaceController.text,
                      "Vessel": vesselController.text,
                      "Lesion_size": lesionSizeController.text,
                      "Acetic_acid": aceticAcidController.text,
                      "Lugol_iodine": lugolIodineController.text,
                      "Total_score": totalScoreController.text,
                      "Biopsy_taken": biopsyTakenController.text,
                      "Histopathology_report":
                          histopathologyReportController.text,
                    };

                    if (kDebugMode) {
                      print(diagnosticData);
                    }

                    // TODO: save data to DB
                  });
                }
              },
              child: const Text("Save")),
        ]),
      ),
    );
  }
}
