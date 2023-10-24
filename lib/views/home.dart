import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              // TODO: Navigate to patient details page
            },
            child: const Card(
              child: Text("New Patient"),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              // TODO: Navigate to search patient page
            },
            child: const Card(
              child: Text("Search Patient"),
            ),
          ),
        ],
      ),
    );
  }
}
