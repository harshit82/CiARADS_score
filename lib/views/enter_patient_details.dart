import 'package:CiARADS/constants/constants_export.dart';
import 'package:CiARADS/views/diagnostic_data.dart';
import 'package:CiARADS/views/widgets/credits.dart';
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
  bool isNameFilled = false;
  bool isAgeFilled = false;
  bool isHospitalNameFilled = false;
  bool isPatientIdFilled = false;
  bool isDoctorNameFilled = false;

  bool _areAllFilled() {
    if (isNameFilled == false ||
        isAgeFilled == false ||
        isHospitalNameFilled == false ||
        isPatientIdFilled == false ||
        isDoctorNameFilled == false) return false;
    return true;
  }

  late TextEditingController patientNameController;
  late TextEditingController ageController;
  late TextEditingController hospitalNameController;
  late TextEditingController patientIdController;
  late TextEditingController doctorNameController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    patientNameController = TextEditingController();
    ageController = TextEditingController();
    hospitalNameController = TextEditingController();
    patientIdController = TextEditingController();
    doctorNameController = TextEditingController();

    patientNameController.addListener(() {
      final isNameFilled = patientNameController.text.isNotEmpty;
      setState(() {
        this.isNameFilled = isNameFilled;
      });
    });

    ageController.addListener(() {
      final isAgeFilled = ageController.text.isNotEmpty;
      setState(() {
        this.isAgeFilled = isAgeFilled;
      });
    });

    hospitalNameController.addListener(() {
      final isHospitalNameFilled = hospitalNameController.text.isNotEmpty;
      setState(() {
        this.isHospitalNameFilled = isHospitalNameFilled;
      });
    });

    patientIdController.addListener(() {
      final isPatientIdFilled = patientIdController.text.isNotEmpty;
      setState(() {
        this.isPatientIdFilled = isPatientIdFilled;
      });
    });

    doctorNameController.addListener(() {
      final isDoctorNameFilled = doctorNameController.text.isNotEmpty;
      setState(() {
        this.isDoctorNameFilled = isDoctorNameFilled;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    patientNameController.dispose();
    ageController.dispose();
    hospitalNameController.dispose();
    patientIdController.dispose();
    doctorNameController.dispose();
  }

  void _saveToDB() {
    Map<String, dynamic> patientDataMap = {
      patientName: patientNameController.text,
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
                    controller: patientNameController,
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
                        return "Please enter your age";
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
                        return "Please enter patient id";
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
                    onPressed: _areAllFilled()
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _formKey.currentState?.save();

                                Fluttertoast.showToast(
                                    msg: "Saving patient details");

                                _saveToDB();

                                // Creating folder using the name and the id of the patient
                                FilesFolders().createFolder(
                                    "${patientIdController.text}_${patientNameController.text}");
                              });

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => DiagnosticData(
                                          patientId:
                                              patientIdController.text)));
                            }
                          }
                        : null,
                    child: const Text("Save"),
                  ),
                  const Align(
                      alignment: Alignment.bottomCenter, child: Credits()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
