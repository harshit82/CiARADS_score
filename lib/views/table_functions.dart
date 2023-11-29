import 'package:CiARADS/database/database_export.dart';
import 'package:CiARADS/views/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TableFunctions extends StatefulWidget {
  const TableFunctions({super.key});

  @override
  State<TableFunctions> createState() => _TableFunctionsState();
}

class _TableFunctionsState extends State<TableFunctions> {
  bool isButtonActive = false;
  late TextEditingController patientIdController;

  @override
  void initState() {
    super.initState();
    patientIdController = TextEditingController();
    patientIdController.addListener(() {
      final isButtonActive = patientIdController.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    patientIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Additional functions"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: patientIdController,
                decoration: InputDecoration(
                    label: const Text("Enter Patient Id"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: isButtonActive
                    ? () {
                        showChoiceDialog(
                          context: context,
                          title: "Are you sure?",
                          description: "This action cannot be undone",
                          button1Text: 'Cancel',
                          button2Text: 'Delete',
                          button1OnPressed: () {
                            patientIdController.clear();
                            Navigator.of(context).pop();
                          },
                          button2OnPressed: () {
                            PatientTable.removePatientData(
                                patientId: patientIdController.text);
                            Fluttertoast.showToast(
                                msg:
                                    "Deleted, patient id: ${patientIdController.text}");
                            patientIdController.clear();
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: null,
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0))),
                child: const Text("Delete patient"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showChoiceDialog(
                    context: context,
                    title: "Are you sure?",
                    description: "This action cannot be undone",
                    button1Text: 'Cancel',
                    button2Text: 'Delete',
                    button1OnPressed: () {
                      Navigator.of(context).pop();
                    },
                    button2OnPressed: () {
                      PatientTable.deleteTable();
                      Fluttertoast.showToast(msg: "Deleted all patient data");
                      Navigator.of(context).pop();
                    },
                  );
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)))),
                child: const Text("Delete all patient data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
