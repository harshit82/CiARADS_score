import 'package:CiARADS/utils.dart';
import 'package:CiARADS/views/diagnostic_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:CiARADS/database/database_export.dart';

class EnterPatientDetails extends StatefulWidget {
  const EnterPatientDetails({super.key});

  @override
  State<EnterPatientDetails> createState() => _EnterPatientDetailsState();
}

class _EnterPatientDetailsState extends State<EnterPatientDetails> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController hospitalNameController;
  late TextEditingController patientIdController;
  late TextEditingController doctorNameController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    ageController = TextEditingController();
    hospitalNameController = TextEditingController();
    patientIdController = TextEditingController();
    doctorNameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    ageController.dispose();
    hospitalNameController.dispose();
    patientIdController.dispose();
    doctorNameController.dispose();
  }

  void _saveToDB() {
    Map<String, dynamic> patientDataMap = {
      patientName: nameController.text,
      patientAge: ageController.text,
      patientId: patientIdController.text,
      hospitalName: hospitalNameController.text,
      doctorName: doctorNameController.text,
    };

    if (kDebugMode) {
      print(patientDataMap);
    }

    PatientDB().addPatientData(patientData: patientDataMap);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Patient Details"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Patient Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        errorStyle: const TextStyle(color: Colors.redAccent)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      if (isNumeric(value) == true) {
                        return "Please enter a valid name";
                      }
                      return null;
                    },
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Patient Age",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        errorStyle: const TextStyle(color: Colors.redAccent)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your age";
                      }
                      if (isNumeric(value) == false) {
                        return "Please enter a number";
                      }
                      return null;
                    },
                    controller: ageController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Patient ID",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        errorStyle: const TextStyle(color: Colors.redAccent)),
                    controller: patientIdController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter patient id";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Doctor's Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        errorStyle: const TextStyle(color: Colors.redAccent)),
                    controller: doctorNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the doctor's name";
                      }
                      if (isNumeric(value) == true) {
                        return "Please enter a valid name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Hospital Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        errorStyle: const TextStyle(color: Colors.redAccent)),
                    controller: hospitalNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter hospital name";
                      }
                      if (isNumeric(value) == true) {
                        return "Please enter a valid hospital name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _formKey.currentState?.save();

                          Fluttertoast.showToast(msg: "Saving patient details");

                          _saveToDB();
                        });
                        // TODO: Fix error: type 'String' is not a subtype of type 'int' in type cast
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => DiagnosticData(
                                patientId: patientIdController.text)));
                      }
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
