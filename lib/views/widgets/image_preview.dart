import 'dart:io';
import 'package:CiARADS/global.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final String imagePath;

  const ImagePreview({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Global.imagePaths[imagePath] != null
        ? Image.file(
            File(Global.imagePaths[imagePath]),
            width: 50,
            height: 50,
          )
        : Container(
            width: 50,
            height: 50,
            color: Colors.grey.shade400,
          );
  }
}
