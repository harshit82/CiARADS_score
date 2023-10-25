import 'package:calposcopy/database/patient_db.dart';
import 'package:calposcopy/views/show_patient_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 200,
                  color: Colors.transparent,
                  child: const Center(
                      child: Text("Details about the application")),
                ),
                InkWell(
                  onTap: () async {
                    // TODO: Navigate to enter patient details page
                  },
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(child: Text("New Patient")),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // TODO: Navigate to search patient page
                  },
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.limeAccent,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(child: Text("Search Patient")),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    var allPatientData = await PatientDB().getAllPatientData();
                    if (kDebugMode) {
                      print(allPatientData);
                    }
                    ShowPatientDetails(dataList: allPatientData);
                    // TODO: Navigate to show_patient_details page
                  },
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(child: Text("Show all patients")),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
