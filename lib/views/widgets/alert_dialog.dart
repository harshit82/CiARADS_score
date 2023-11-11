import 'package:flutter/material.dart';

Future<void> showChoiceDialog(
    {required BuildContext context,
    required String title,
    required String description,
    required String button1Text,
    required String button2Text,
    required VoidCallback button1OnPressed,
    required VoidCallback button2OnPressed}) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(onPressed: button1OnPressed, child: Text(button1Text)),
            TextButton(onPressed: button2OnPressed, child: Text(button2Text)),
          ],
        );
      });
}

Future<void> showAlertDialog(
    {required BuildContext context,
    required String title,
    required String description}) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK")),
          ],
        );
      });
}
