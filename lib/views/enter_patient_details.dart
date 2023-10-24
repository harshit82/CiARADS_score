import 'package:calposcopy/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EnterPatientDetails extends StatefulWidget {
  const EnterPatientDetails({super.key});

  @override
  State<EnterPatientDetails> createState() => _EnterPatientDetailsState();
}

class _EnterPatientDetailsState extends State<EnterPatientDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController hospitalNumberController = TextEditingController();
  TextEditingController patientIdController = TextEditingController();
  TextEditingController doctorNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    ageController.dispose();
    hospitalNumberController.dispose();
    patientIdController.dispose();
    doctorNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Patient Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
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
                controller: ageController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your age";
                  }
                  if (isNumeric(value) == false) {
                    return "Please enter a number";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Hospital Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    errorStyle: const TextStyle(color: Colors.redAccent)),
                controller: hospitalNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter hospital number";
                  }
                  if (isNumeric(value) == false) {
                    return "Please enter a number";
                  }
                  return null;
                },
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

                        Fluttertoast.showToast(msg: "Saving patient details");

                        Map<String, dynamic> patientDataMap = {
                          "Patient Name": nameController.text,
                          "Patient Age": ageController.text,
                          "Patient ID": patientIdController.text,
                          "Hospital Number": hospitalNumberController.text,
                          "Doctor Name": doctorNameController.text,
                        };

                        if (kDebugMode) {
                          print(patientDataMap);
                        }

                        // TODO: pass on the data map to store the data in the db
                      });
                    }
                  },
                  child: const Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
