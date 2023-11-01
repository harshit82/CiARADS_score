import 'package:CiARADS/database/patients_table.dart';
import 'package:CiARADS/model/patient.dart';
import 'package:flutter/foundation.dart';

class ViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Patient> _patientModel = [];
  String _id = '';

  bool get loading => _loading;
  List<Patient> get patientModel => _patientModel;
  String get id => _id;

  ViewModel() {
    getData();
  }

  void setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  void setPatientModel(List<Patient> patientModel) {
    _patientModel = patientModel;
  }

  void setId(String id) {
    _id = id;
  }

  void getData() async {
    setLoading(true);

    late List<Map<String, dynamic>> dataList;

    if (id.isEmpty) {
      dataList = await PatientDB.getAllPatientData();
    } else {
      dataList = await PatientDB.getPatientData(patientId: id);
    }

    if (kDebugMode) {
      print("Data List =\n");
      print(dataList);
    }

    _patientModel = List.generate(
        dataList.length, (index) => Patient.fromMap(dataList[index]));

    if (kDebugMode) {
      print("Patient Model =\n");
      print(_patientModel);
    }

    setPatientModel(_patientModel);

    setLoading(false);
  }
}
