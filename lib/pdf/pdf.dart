import 'dart:io';
import 'package:CiARADS/global.dart';
import 'package:CiARADS/model/patient.dart';
import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> generatePdf(Patient patient) async {
    Document pdf = Document();
    Page page = Page(
      build: (context) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                Text("Patient Name: ${patient.patient_name}"),
                SizedBox(height: 2),
                Text("Patient ID: ${patient.patient_id}"),
                SizedBox(height: 2),
                Text("Patient Age: ${patient.patient_age}"),
                SizedBox(height: 2),
                Text("Doctor's Name: ${patient.doctor_name}"),
                SizedBox(height: 2),
                Text("Hospital Name: ${patient.hospital_name}"),
                SizedBox(height: 2),
                Text("Margin and Surface: ${patient.margin_and_surface}"),
                SizedBox(height: 2),
                Text("Vessel: ${patient.vessel}"),
                SizedBox(height: 2),
                Text("Lesion Size: ${patient.lesion_size}"),
                SizedBox(height: 2),
                Text("Acetic Acid: ${patient.acetic_acid}"),
                SizedBox(height: 2),
                Text("Lugol Iodine: ${patient.lugol_iodine}"),
                SizedBox(height: 2),
                Text("Total Score: ${patient.total_score}"),
                SizedBox(height: 2),
                Text("Biopsy Taken: ${patient.biopsy_taken}"),
                SizedBox(height: 2),
                Text("Histopathology Report: ${patient.histopathology_report}"),
                SizedBox(height: 2),
              ],
            ),
          ),
        );
      },
    );
    pdf.addPage(page);
    return saveDocument(
        name: "${patient.patient_id}_${patient.patient_name}", pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    Uint8List bytes = await pdf.save();
    // TODO: Allow the user to generate pdf after coming back to home page
    // save in the same folder in which images are saved
    // the global becomes empty
    String dir = Global.patientFolderPath;
    String newPath = join(dir, name);
    File pdfFile = File(newPath);
    // TODO: Fix not working
    File newFile = await pdfFile.writeAsBytes(bytes);
    if (kDebugMode) {
      print("File saved at: ${newFile.path}");
    }
    return pdfFile;
  }

  static Future openFile(File file) async {
    final filePath = file.path;
    await OpenFile.open(filePath);
  }
}
