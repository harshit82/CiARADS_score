import 'package:CiARADS/constants/constants_export.dart';
import 'package:CiARADS/view_model/view_model.dart';
import 'package:CiARADS/views/views_export.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isButtonActive = false;
  late TextEditingController patientIdController;

  @override
  void initState() {
    super.initState();
    patientIdController = TextEditingController();
    patientIdController.addListener(() {
      final isButtonActive = patientIdController.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    patientIdController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("CiARADS score"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            jipmerImage,
                            height: 50,
                            width: 50,
                          ),
                          Image.asset(
                            leapImage,
                            height: 50,
                            width: 50,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Expanded(
                          child: Center(child: Text(applicationDescription))),
                    ],
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(enterPatientDetails);
                      },
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(child: Text("New Patient")),
                      ),
                    ),
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(showPatientDetails);
                      },
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(child: Text("Show all Patients")),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: patientIdController,
                  decoration: InputDecoration(
                      label: const Text("Search by Patient Id"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)))),
                  onPressed: isButtonActive
                      ? () {
                          setState(() {
                            isButtonActive = false;
                            patientIdController.clear();
                          });
                          // TODO: Fix get data for a particular patient in the view_model as well
                          ViewModel().setId(patientIdController.text);
                          Navigator.of(context).pushNamed(showPatientDetails);
                        }
                      : null,
                  child: const Text("Search"),
                ),
                const Align(
                    alignment: Alignment.bottomCenter, child: Credits()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
