import 'package:CiARADS/constants/constants.dart';
import 'package:flutter/material.dart';

class Credits extends StatelessWidget {
  const Credits({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 10,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: const Text(
                " ~ Developed by $developerName at $labName $instituteName"),
          ),
        ),
      ],
    );
  }
}
