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
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(children: [
              Text("Patient Name: ${patient.patient_name}"),
              const SizedBox(height: 2),
              Text("Patient ID: ${patient.patient_id}"),
              const SizedBox(height: 2),
              Text("Patient Age: ${patient.patient_age}"),
              const SizedBox(height: 2),
              Text("Doctor's Name: ${patient.doctor_name}"),
              const SizedBox(height: 2),
              Text("Hospital Name: ${patient.hospital_name}"),
              const SizedBox(height: 2),
              Text("Margin and Surface: ${patient.margin_and_surface}"),
              const SizedBox(height: 2),
              Text("Vessel: ${patient.vessel}"),
              const SizedBox(height: 2),
              Text("Lesion Size: ${patient.lesion_size}"),
              const SizedBox(height: 2),
              Text("Acetic Acid: ${patient.acetic_acid}"),
              const SizedBox(height: 2),
              Text("Lugol Iodine: ${patient.lugol_iodine}"),
              const SizedBox(height: 2),
              Text("Total Score: ${patient.total_score}"),
              const SizedBox(height: 2),
              Text("Biopsy Taken: ${patient.biopsy_taken}"),
              const SizedBox(height: 2),
              Text("Histopathology Report: ${patient.histopathology_report}"),
              const SizedBox(height: 2),
              //const Text("Acetic acid images"),
              // Image.memory(DatabaseService().loadImage(aceticAcidImagesPath),
              //     width: 50, height: 50, fit: BoxFit.cover),
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

              const Align(alignment: Alignment.bottomCenter, child: Credits()),
            ]),
          ),
        ),
      ),
    );
  }
}
