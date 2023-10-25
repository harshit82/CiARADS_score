import 'package:flutter/material.dart';

class ShowPatientDetails extends StatelessWidget {
  final List<Map<String, dynamic>> dataList;
  const ShowPatientDetails({
    Key? key,
    required this.dataList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: dataList.length != 1
                ? const Text("Patient Report")
                : dataList[0]['patient_name']),
        body: dataList.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        child: Text(
                          "No data available",
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                          onPressed: () {}, child: const Text("Go back")),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: ((context, index) {
                      Map<String, dynamic> dataMap = dataList[index];
                      return Card(
                        child: Column(
                          children: [
                            Text("Patient Name: ${dataMap['patient_name']}"),
                            const SizedBox(height: 2),
                            Text("Patient ID: ${dataMap['patient_id']}"),
                            const SizedBox(height: 2),
                            Text("Patient Age: ${dataMap['patient_age']}"),
                            const SizedBox(height: 2),
                            Text("Doctor's Name: ${dataMap['doctor_name']}"),
                            const SizedBox(height: 2),
                            Text("Hospital ID: ${dataMap['hospital_id']}"),
                            const SizedBox(height: 2),
                            Text(
                                "Margin and Surface: ${dataMap['margin_and_surface']}"),
                            const SizedBox(height: 2),
                            Text("Vessel: ${dataMap['vessel']}"),
                            const SizedBox(height: 2),
                            Text("Lesion Size: ${dataMap['lesion_size']}"),
                            const SizedBox(height: 2),
                            Text("Acetic Acid: ${dataMap['acetic_acid']}"),
                            const SizedBox(height: 2),
                            Text("Lugol Iodine: ${dataMap['lugol_iodine']}"),
                            const SizedBox(height: 2),
                            Text("Total Score: ${dataMap['total_score']}"),
                            const SizedBox(height: 2),
                            Text("Biopsy Taken: ${dataMap['biopsy_taken']}"),
                            const SizedBox(height: 2),
                            Text(
                                "Histopathology Report: ${dataMap['histopathology_report']}"),
                          ],
                        ),
                      );
                    })),
              ),
      ),
    );
  }
}
