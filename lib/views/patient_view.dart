import 'dart:io';
import 'package:CiARADS/pdf/pdf.dart';
import 'package:CiARADS/views/views_export.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:CiARADS/model/patient.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PatientView extends StatefulWidget {
  final Patient? patient;
  const PatientView({
    Key? key,
    required this.patient,
  }) : super(key: key);

  @override
  State<PatientView> createState() => _PatientViewState();
}

class _PatientViewState extends State<PatientView>
    with SingleTickerProviderStateMixin {
  late TransformationController transformationController;
  TapDownDetails? tapDownDetails;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  @override
  void initState() {
    super.initState();
    transformationController = TransformationController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 300),
    )..addListener(() {
        transformationController.value = animation!.value;
      });
  }

  @override
  void dispose() {
    transformationController.dispose();
    animationController.dispose();
    super.dispose();
  }

  Widget buildImage(String path) => GestureDetector(
        onDoubleTapDown: (details) => tapDownDetails = details,
        onDoubleTap: () {
          final position = tapDownDetails!.localPosition;
          const double scale = 3;
          final x = -position.dx * (scale - 1);
          final y = -position.dy * (scale - 1);
          final zoomed = Matrix4.identity()
            ..translate(x, y)
            ..scale(scale);
          final end = transformationController.value.isIdentity()
              ? zoomed
              : Matrix4.identity();
          animation = Matrix4Tween(
            begin: transformationController.value,
            end: end,
          ).animate(
              CurveTween(curve: Curves.easeOut).animate(animationController));
          animationController.forward(from: 0);
        },
        child: InteractiveViewer(
          transformationController: transformationController,
          clipBehavior: Clip.none,
          panEnabled: false,
          scaleEnabled: false,
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.file(
              File(path),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              Fluttertoast.showToast(msg: "Generating PDF");
              File pdfFile = await PdfApi.generatePdf(widget.patient);
              PdfApi.openFile(pdfFile);
            },
            child: const Icon(Icons.picture_as_pdf)),
        appBar: AppBar(
          title: Text(widget.patient!.patient_name.toString()),
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
                    Text(widget.patient!.patient_name.toString())
                  ]),
                  TableRow(children: [
                    const Text("Patient age:"),
                    Text(widget.patient!.patient_age.toString())
                  ]),
                  TableRow(children: [
                    const Text("Doctor name:"),
                    Text(widget.patient!.doctor_name.toString())
                  ]),
                  TableRow(children: [
                    const Text("Hospital name:"),
                    Text(widget.patient!.hospital_name.toString())
                  ]),
                  TableRow(children: [
                    const Text("Margin and Surface:"),
                    Text(widget.patient!.margin_and_surface.toString())
                  ]),
                  TableRow(children: [
                    const Text("Vessel:"),
                    Text(widget.patient!.vessel.toString())
                  ]),
                  TableRow(children: [
                    const Text("Lesion Size:"),
                    Text(widget.patient!.lesion_size.toString())
                  ]),
                  TableRow(children: [
                    const Text("Acetic Acid:"),
                    Text(widget.patient!.acetic_acid.toString())
                  ]),
                  TableRow(children: [
                    const Text("Lugol Iodine:"),
                    Text(widget.patient!.lugol_iodine.toString())
                  ]),
                  TableRow(children: [
                    const Text("Total Score:"),
                    Text(widget.patient!.total_score.toString())
                  ]),
                  TableRow(children: [
                    const Text("Biopsy Taken:"),
                    Text(widget.patient!.biopsy_taken.toString())
                  ]),
                  TableRow(children: [
                    const Text("Histopathology Report:"),
                    Text(widget.patient!.histopathology_report.toString())
                  ]),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  widget.patient!.acetic_acid_img_path != null
                      ? const SizedBox()
                      : Fluttertoast.showToast(msg: "Image does not exist");
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Acetic acid image"),
                        widget.patient!.acetic_acid_img_path != null
                            ? _loadImage(
                                widget.patient!.acetic_acid_img_path.toString())
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  widget.patient!.green_filter_img_path != null
                      ? const SizedBox()
                      : Fluttertoast.showToast(msg: "Image does not exist");
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Green filter image"),
                        widget.patient!.green_filter_img_path != null
                            ? _loadImage(widget.patient!.green_filter_img_path
                                .toString())
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  widget.patient!.lugol_iodine_img_path != null
                      ? const SizedBox()
                      : Fluttertoast.showToast(msg: "Image does not exist");
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Lugol iodine image"),
                        widget.patient!.lugol_iodine_img_path != null
                            ? InteractiveViewer(
                                clipBehavior: Clip.none,
                                panEnabled: false,
                                scaleEnabled: false,
                                child: _loadImage(widget
                                    .patient!.lugol_iodine_img_path
                                    .toString()))
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // TODO: replace sizedbox with animation code
                  widget.patient!.normal_saline_img_path != null
                      ? const SizedBox()
                      : Fluttertoast.showToast(msg: "Image does not exist");
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Normal saline image"),
                        widget.patient!.normal_saline_img_path != null
                            ? _loadImage(widget.patient!.normal_saline_img_path
                                .toString())
                            : const SizedBox(),
                      ],
                    ),
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

Widget _loadImage(String path) {
  try {
    File imageFile = File(path);
    if (imageFile.existsSync()) {
      return Image.file(
        imageFile,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    } else {
      return const Text("Image not found");
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error loading image: $e');
    }
    return const Text('Error loading image');
  }
}
