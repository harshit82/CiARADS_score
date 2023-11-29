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

    Page page1 = Page(
      build: (context) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                Table(
                  children: [
                    TableRow(children: [
                      Text("Patient name:"),
                      Text(patient.patient_name.toString())
                    ]),
                    TableRow(children: [
                      Text("Patient age:"),
                      Text(patient.patient_age.toString())
                    ]),
                    TableRow(children: [
                      Text("Doctor name:"),
                      Text(patient.doctor_name.toString())
                    ]),
                    TableRow(children: [
                      Text("Hospital name:"),
                      Text(patient.hospital_name.toString())
                    ]),
                    TableRow(children: [
                      Text("Margin and Surface:"),
                      Text(patient.margin_and_surface.toString())
                    ]),
                    TableRow(children: [
                      Text("Vessel:"),
                      Text(patient.vessel.toString())
                    ]),
                    TableRow(children: [
                      Text("Lesion Size:"),
                      Text(patient.lesion_size.toString())
                    ]),
                    TableRow(children: [
                      Text("Acetic Acid:"),
                      Text(patient.acetic_acid.toString())
                    ]),
                    TableRow(children: [
                      Text("Lugol Iodine:"),
                      Text(patient.lugol_iodine.toString())
                    ]),
                    TableRow(children: [
                      Text("Total Score:"),
                      Text(patient.total_score.toString())
                    ]),
                    TableRow(children: [
                      Text("Biopsy Taken:"),
                      Text(patient.biopsy_taken.toString())
                    ]),
                    TableRow(children: [
                      Text("Histopathology Report:"),
                      Text(patient.histopathology_report.toString())
                    ]),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    final aceticAcidImage = MemoryImage(
        File(patient.acetic_acid_img_path.toString()).readAsBytesSync());
    final lugolAcidImage = MemoryImage(
        File(patient.lugol_iodine_img_path.toString()).readAsBytesSync());
    final greenFilterImage = MemoryImage(
        File(patient.green_filter_img_path.toString()).readAsBytesSync());
    final normalIodineImage = MemoryImage(
        File(patient.normal_saline_img_path.toString()).readAsBytesSync());

    Page page2 = Page(build: (context) {
      return Center(
          child: Column(children: [
        Text("Acetic acid image"),
        SizedBox(height: 100),
        patient.acetic_acid_img_path != null
            ? Image(aceticAcidImage, width: 500, height: 500)
            : SizedBox(),
      ]));
    });
    Page page3 = Page(build: (context) {
      return Center(
          child: Column(children: [
        Text("Lugol acid image"),
        SizedBox(height: 100),
        patient.lugol_iodine_img_path != null
            ? Image(lugolAcidImage, width: 500, height: 500)
            : SizedBox(width: 500, height: 500),
      ]));
    });
    Page page4 = Page(build: (context) {
      return Center(
          child: Column(children: [
        Text("Normal saline image"),
        SizedBox(height: 100),
        patient.normal_saline_img_path != null
            ? Image(normalIodineImage, width: 500, height: 500)
            : SizedBox(width: 500, height: 500),
      ]));
    });
    Page page5 = Page(build: (context) {
      return Center(
          child: Column(children: [
        Text("Green filter image"),
        SizedBox(height: 100),
        patient.green_filter_img_path != null
            ? Image(greenFilterImage, width: 500, height: 500)
            : SizedBox(width: 500, height: 500),
      ]));
    });

    pdf.addPage(page1);
    pdf.addPage(page2);
    pdf.addPage(page3);
    pdf.addPage(page4);
    pdf.addPage(page5);

    return saveDocument(
        name: "${patient.patient_id}_${patient.patient_name}",
        pdf: pdf,
        extension: '.pdf');
  }

  static Future<File> saveDocument(
      {required String name,
      required Document pdf,
      required String extension}) async {
    Uint8List bytes = await pdf.save();
    String dir = await Global().imageFolderPath;
    String newPath = join(dir, '$name$extension');
    File pdfFile = File(newPath);
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
