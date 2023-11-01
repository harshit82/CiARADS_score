import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class ErrorWidget extends StatelessWidget {
  final String errorMessage;
  const ErrorWidget({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PanaraInfoDialog.show(
      context,
      title: "Error",
      message: errorMessage,
      buttonText: "Okay",
      onTapDismiss: () => Navigator.pop(context),
      panaraDialogType: PanaraDialogType.error,
      barrierDismissible: false, // optional parameter (default is true)
    );
  }
}
