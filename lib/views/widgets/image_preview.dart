import 'dart:io';
import 'package:CiARADS/global.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  final String testName;

  const ImagePreview({
    Key? key,
    required this.testName,
  }) : super(key: key);

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Global().imagePaths[widget.testName] != null
        ? _loadImage(Global().imagePaths[widget.testName])
        : Container(
            width: 40,
            height: 40,
            color: Colors.grey.shade400,
          );
  }
}

Widget _loadImage(String path) {
  try {
    File imageFile = File(path);
    if (imageFile.existsSync()) {
      return Image.file(
        imageFile,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    } else {
      return const Text("NF");
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error loading image: $e');
    }
    return const Text('Error loading image');
  }
}
