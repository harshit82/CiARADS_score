import 'package:CiARADS/model/patient.dart';
import 'package:CiARADS/views/patient_view.dart';
import 'package:CiARADS/views/widgets/credits.dart';
import 'package:flutter/material.dart';
import 'package:CiARADS/view_model/view_model.dart';
import 'package:provider/provider.dart';

class ShowPatientDetails extends StatelessWidget {
  const ShowPatientDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewModel viewModel = context.watch<ViewModel>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Patient Report")),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: viewModel.patientModel.isNotEmpty
              ? ListView.separated(
                  itemBuilder: ((context, index) {
                    Patient patient = viewModel.patientModel[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PatientView(
                                  patient: patient,
                                )));
                      },
                      child: Card(
                        child: ListTile(
                          title: Text("Patient Name: ${patient.patient_name}"),
                          leading: Text("Patient ID: ${patient.patient_id}"),
                          trailing: Text("Patient Age: ${patient.patient_age}"),
                        ),
                      ),
                    );
                  }),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: viewModel.patientModel.length,
                )
              : const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No data available",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(height: 40),
                      Credits(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
