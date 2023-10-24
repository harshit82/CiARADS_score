import 'package:flutter/material.dart';

class SearchPatient extends StatefulWidget {
  const SearchPatient({super.key});

  @override
  State<SearchPatient> createState() => _SearchPatientState();
}

class _SearchPatientState extends State<SearchPatient> {
  TextEditingController patientIdController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    patientIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Patient"),
      ),
      body: Column(children: [
        TextField(
          controller: patientIdController,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              // TODO: Search for patient in the db
              // redirect to new page; if found show patient details else not found
            },
            child: const Text("Search"))
      ]),
    );
  }
}
