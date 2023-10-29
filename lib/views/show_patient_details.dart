import 'package:CiARADS/model/patient.dart';
import 'package:flutter/material.dart';
import 'package:CiARADS/database/database_export.dart';

class ShowPatientDetails extends StatefulWidget {
  const ShowPatientDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowPatientDetails> createState() => _ShowPatientDetailsState();
}

class _ShowPatientDetailsState extends State<ShowPatientDetails> {
  Future<List<Patient>> getPatientsList() async {
    // TODO: get data from db, make more flexible
    List<Map<String, dynamic>> dataMap = await PatientDB().getAllPatientData();
    return List.generate(
      dataMap.length,
      (index) => Patient(
        patient_name: dataMap[index][patientName],
        patient_id: dataMap[index][patientId],
        patient_age: dataMap[index][patientAge],
        doctor_name: dataMap[index][doctorName],
        hospital_name: dataMap[index][hospitalName],
        margin_and_surface: dataMap[index][marginAndSurface],
        vessel: vessel,
        lesion_size: dataMap[index][lesionSize],
        acetic_acid: dataMap[index][aceticAcid],
        lugol_iodine: dataMap[index][lugolIodine],
        total_score: dataMap[index][totalScore],
        biopsy_taken: dataMap[index][biopsyTaken],
        histopathology_report: dataMap[index][histopathologyReport],
        lugolIodineImagesPath: dataMap[index][lugolIodineImagesPath],
        greenFilterImagesPath: dataMap[index][greenFilterImagesPath],
        normalSalineImagesPath: dataMap[index][normalSalineImagesPath],
        aceticAcidImagesPath: dataMap[index][aceticAcidImagesPath],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Patient> dataList = getPatientsList() as List<Patient>;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Patient Report")),
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Go back")),
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: ListView.builder(
                      itemCount: dataList.length,
                      itemBuilder: ((context, index) {
                        return Card(
                          child: Column(
                            children: [
                              Text(
                                  "Patient Name: ${dataList[index].patient_name}"),
                              const SizedBox(height: 2),
                              Text("Patient ID: ${dataList[index].patient_id}"),
                              const SizedBox(height: 2),
                              Text(
                                  "Patient Age: ${dataList[index].patient_age}"),
                              const SizedBox(height: 2),
                              Text(
                                  "Doctor's Name: ${dataList[index].doctor_name}"),
                              const SizedBox(height: 2),
                              Text(
                                  "Hospital Name: ${dataList[index].hospital_name}"),
                              const SizedBox(height: 2),
                              Text(
                                  "Margin and Surface: ${dataList[index].margin_and_surface}"),
                              const SizedBox(height: 2),
                              Text("Vessel: ${dataList[index].vessel}"),
                              const SizedBox(height: 2),
                              Text(
                                  "Lesion Size: ${dataList[index].lesion_size}"),
                              const SizedBox(height: 2),
                              Text(
                                  "Acetic Acid: ${dataList[index].acetic_acid}"),
                              const SizedBox(height: 2),
                              Text(
                                  "Lugol Iodine: ${dataList[index].lugol_iodine}"),
                              const SizedBox(height: 2),
                              Text(
                                  "Total Score: ${dataList[index].total_score}"),
                              const SizedBox(height: 2),
                              Text(
                                  "Biopsy Taken: ${dataList[index].biopsy_taken}"),
                              const SizedBox(height: 2),
                              Text(
                                  "Histopathology Report: ${dataList[index].histopathology_report}"),
                              // const SizedBox(height: 2),
                              // const Text("Acetic acid images"),
                              // Image.memory(
                              //     DatabaseService()
                              //         .loadImage(aceticAcidImagesPath),
                              //     fit: BoxFit.cover),
                              // const SizedBox(height: 2),
                              // const Text("Normal saline images"),
                              // Image.memory(
                              //     DatabaseService()
                              //         .loadImage(normalSalineImagesPath),
                              //     fit: BoxFit.cover),
                              // const SizedBox(height: 2),
                              // const Text("Lugol acid images"),
                              // Image.memory(
                              //     DatabaseService()
                              //         .loadImage(lugolIodineImagesPath),
                              //     fit: BoxFit.cover),
                              // const SizedBox(height: 2),
                              // const Text("Green filter images"),
                              // Image.memory(
                              //     DatabaseService()
                              //         .loadImage(greenFilterImagesPath),
                              //     fit: BoxFit.cover),
                            ],
                          ),
                        );
                      })),
                ),
              ),
      ),
    );
  }
}
