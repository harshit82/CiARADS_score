import 'dart:io';
import 'package:CiARADS/pdf/pdf.dart';
import 'package:CiARADS/views/views_export.dart';
import 'package:flutter/material.dart';
import 'package:CiARADS/model/patient.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PatientView extends StatelessWidget {
  final Patient patient;
  const PatientView({
    Key? key,
    required this.patient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              Fluttertoast.showToast(msg: "Generating PDF");
              File pdfFile = await PdfApi.generatePdf(patient);
              PdfApi.openFile(pdfFile);
            },
            child: const Icon(Icons.picture_as_pdf)),
        appBar: AppBar(
          title: Text(patient.patient_name),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(children: [
              Table(
                border: TableBorder.all(color: Colors.grey),
                children: [
                  TableRow(children: [
                    const Text("Patient name:"),
                    Text(patient.patient_name)
                  ]),
                  TableRow(children: [
                    const Text("Patient age:"),
                    Text(patient.patient_age.toString())
                  ]),
                  TableRow(children: [
                    const Text("Doctor name:"),
                    Text(patient.doctor_name)
                  ]),
                  TableRow(children: [
                    const Text("Hospital name:"),
                    Text(patient.hospital_name)
                  ]),
                  TableRow(children: [
                    const Text("Margin and Surface:"),
                    Text(patient.margin_and_surface.toString())
                  ]),
                  TableRow(children: [
                    const Text("Vessel:"),
                    Text(patient.vessel.toString())
                  ]),
                  TableRow(children: [
                    const Text("Lesion Size:"),
                    Text(patient.lesion_size.toString())
                  ]),
                  TableRow(children: [
                    const Text("Acetic Acid:"),
                    Text(patient.acetic_acid.toString())
                  ]),
                  TableRow(children: [
                    const Text("Lugol Iodine:"),
                    Text(patient.lugol_iodine.toString())
                  ]),
                  TableRow(children: [
                    const Text("Total Score:"),
                    Text(patient.total_score.toString())
                  ]),
                  TableRow(children: [
                    const Text("Biopsy Taken:"),
                    Text(patient.biopsy_taken)
                  ]),
                  TableRow(children: [
                    const Text("Histopathology Report:"),
                    Text(patient.histopathology_report)
                  ]),
                ],
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Acetic acid image"),
                      const SizedBox(width: 8),
                      Image.file(
                        File(patient.acetic_acid_img_path),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Green filter image"),
                      const SizedBox(width: 8),
                      Image.file(
                        File(patient.green_filter_img_path),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Lugol iodine image"),
                      const SizedBox(width: 8),
                      Image.file(
                        File(patient.lugol_iodine_img_path),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Normal saline image"),
                      const SizedBox(width: 8),
                      Image.file(
                        File(patient.normal_saline_img_path),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
              const Align(alignment: Alignment.bottomCenter, child: Credits()),
            ]),
          ),
        ),
      ),
    );
  }
}
