import 'package:CiARADS/database/patients_table.dart';
import 'package:CiARADS/model/patient.dart';
import 'package:flutter/foundation.dart';

class ViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Patient?>? _patientModelList = [];
  String _id = '';
  Patient? _patientModel;

  bool get loading => _loading;
  List<Patient?>? get patientModelList => _patientModelList;
  String get id => _id;
  Patient? get patientModel => _patientModel;

  ViewModel() {
    getData();
  }

  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void setPatientModelList(List<Patient?>? patientModel) {
    _patientModelList = patientModel;
    notifyListeners();
  }

  void setPatientModel(Patient? patient) {
    _patientModel = patient;
    notifyListeners();
  }

  void setId(String id) {
    _id = id;
    if (kDebugMode) {
      print("New id = $id");
    }
    notifyListeners();
  }

  Future<void> getData() async {
    setLoading(true);

    if (id == '') {
      List<Map<String, dynamic>> dataList =
          await PatientTable.getAllPatientData();

      if (kDebugMode) {
        print("Data List =\n");
        print(dataList);
      }

      _patientModelList = List.generate(
          dataList.length, (index) => Patient.fromMap(dataList[index]));

      if (kDebugMode) {
        print("Patient Model =\n");
        print(_patientModelList);
      }

      setPatientModelList(_patientModelList);
    } else {
      if (kDebugMode) {
        print("Id for searching = $id");
      }

      Map<String, dynamic> dataMap =
          await PatientTable.getPatientData(patientId: id);

      if (kDebugMode) {
        print("Data Map for $id =");
        print(dataMap);
      }

      if (dataMap.isNotEmpty) {
        Patient? patient = Patient.fromMap(dataMap);
        setPatientModel(patient);
      }
    }

    setLoading(false);
  }
}
