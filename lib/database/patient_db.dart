import 'package:sqflite/sqflite.dart' as sql;

class PatientDB {
  Future<void> createTable(sql.Database database) async {
    //await database.query(table);
    await database.execute(
        'CREATE TABLE New_Patient(patient_id INTEGER PRIMARY KEY, patient_name TEXT, patient_age INT, doctor_name TEXT, hospital_id TEXT)');
  }

  Future<void> addPatient(sql.Database database) async {}
  Future<void> removePatient(sql.Database database) async {}
}
