import 'package:CiARADS/constants/constants_export.dart';
import 'package:CiARADS/remote_connection/web_sockets.dart';
import 'package:CiARADS/view_model/view_model.dart';
import 'package:CiARADS/views/patient_view.dart';
import 'package:CiARADS/views/views_export.dart';
import 'package:CiARADS/views/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    ViewModel viewModel = context.watch<ViewModel>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("CiARADS score"),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const WebSocket())),
                icon: const Icon(Icons.device_unknown)),
            IconButton(
                onPressed: () => Navigator.of(context).pushNamed(bluetooth),
                icon: const Icon(Icons.bluetooth)),
            IconButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed(tableFunctions);
                },
                icon: const Icon(Icons.more_vert))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
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
                      const Text(applicationDescription),
                      const SizedBox(height: 10),
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
                        viewModel.setId('');
                        viewModel.getData();
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: isButtonActive
                      ? () async {
                          viewModel.setId(patientIdController.text);
                          await viewModel.getData();

                          viewModel.loading
                              ? const CircularProgressIndicator()
                              : (
                                  viewModel.patientModel != null
                                      ? {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback(
                                            (_) {
                                              var patient =
                                                  viewModel.patientModel;

                                              /// @dev setting the model to null so that the patient not found condition can be achieved
                                              viewModel.setPatientModel(null);
                                              // navigating to [patient view]
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      PatientView(
                                                          patient: patient),
                                                ),
                                              );
                                            },
                                          )
                                        }
                                      : {
                                          isButtonActive = false,
                                          patientIdController.clear(),
                                          WidgetsBinding.instance
                                              .addPostFrameCallback(
                                            (_) {
                                              /// showing alert dialog when patient not found
                                              showAlertDialog(
                                                context: context,
                                                title: "Patient not found",
                                                description: "",
                                              );
                                            },
                                          ),
                                        },
                                );
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
